`timescale	1ns/1ps
// =================================================================================================
// Copyright (C) 2010- Hirokatsu Sunakawa (hc16804@yahoo.co.jp)
//                                                              
//    This source code is free software; you can redistribute it
//    and/or modify it under the terms of the GNU Lesser General
//    Public License as published by the Free Software Foundation;
//    either version 2.1 of the License, or (at you option) any
//    later version.
//
//    This source is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program; if not, write to the Free Software
//    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
//
// =================================================================================================
// UART_RX
//
// [format]
//             ___ ___ ___ ___ ___ ___ ___ ___ ___ _____
// rxd ~~~\_s_x_0_x_1_x_2_x_3_x_4_x_5_x_6_x_7_x_p_x e 
//          
// *s = start bit, p = parity bit, e = stop bit
// 
// [i/f]
// 
// clk ..... ___/~~~\___/~~~\___/~~~\_........__/~~~\___/~~~\___/~~~\___/~~~\___/~
// 
// rx_vld .. ___/~~~~~~~\_____________........__________/~~~~~~~\_________________
//           ___ _____________________........__________ _________________________
// rx_data . ___X Valid ______________........__________X Valid __________________
//           ___ _____________________........__________ _________________________
// rx_xx_err ___X Valid ______________........__________X Valid __________________
//           ___ _____________________........__________ _________________________
// rx_brk  . ___X Valid ______________........__________X Valid __________________
// 
//  *. After detect a frame error, it cancel the receive operation until RXD 
//     maintain 1 during in frame period.
//  *. the rx_err is constructed by frame_error and parity_error.
//     Parity checking is performed on a normal frame.
//     Because signal parity_error is indicate result of parity check of
//     normal frame, it become 0 in case of frame error.
//     It means the frame_error and parity_error are not become 1 in same time.
// =================================================================================================
//
//  Mar 2013
//  module name : uart_rx -> uart_rx_a
//  added the countermeasure for the noise in the "rx state machine".
//
// =================================================================================================

module	uart_rx_a (
	clk,
	rst,
	rxd,
	rx_vld,
	rx_data,
	rx_frm_err,
	rx_prty_err,
	rx_brk,
	prtysel,
	stpsel,
	tc_ckdiv
);

//--------------------------------------------------------------------------------
// parameter define
//--------------------------------------------------------------------------------
parameter	UD  = 1;
parameter	DBN = 3;


parameter	DBW = 1 << DBN;
parameter	FRW = DBW + 4; // 2 stop bit + 1 parity bit + 8 data bit + 1 start bit
parameter	BCW = DBN + 1;

//--------------------------------------------------------------------------------
// port declaration
//--------------------------------------------------------------------------------
input			clk;
input			rst;

input 			rxd;
output			rx_vld;
output	[DBW-1:0]	rx_data;
output			rx_frm_err;  // framing error
output			rx_prty_err; // parity error

output			rx_brk; // rx break status
				// 0 ... normal
				// 1 ... break;

input	[ 1:0]		prtysel;// parity
				// 0x ... none
				// 10 ... even
				// 11 ... odd

input	      		stpsel; // stop bit
				// 0 ... 1bit
				// 1 ... 2bit

input	[12:0]		tc_ckdiv;
//--------------------------------------------------------------------------------
// reg,wire declaration
//--------------------------------------------------------------------------------
reg   			rx_vld;
reg   	[DBW-1:0]	rx_data;

reg	[ 2:0]		rxd_sync;
wire			rx_start;

reg			rx_done;

reg	[ 1:0]		st_rx;
parameter		ST_RX_IDLE  = 2'd0;
parameter		ST_RX_BUSY  = 2'd1;
parameter		ST_RX_BREAK = 2'd2;

reg	[12:0]		rx_ckdiv;
reg 			rx_cken;

reg	[BCW-1:0]	rx_bcnt;
wire	[BCW-1:0]	end_of_frame;
parameter		START_FLD  = 0;
parameter		LSB_FLD    = 1;
parameter		MSB_FLD    = DBW;
parameter		PARITY_FLD = FRW-3;
parameter		STOP1_FLD  = FRW-2;
parameter		STOP2_FLD  = FRW-1;

wire	      		stp1_bit;
wire	      		stp2_bit;

reg 	[FRW-1:0]	rx_frm;
parameter		START_BIT_VAL = 1'b0;
parameter		STOP_BIT_VAL  = 1'b1;

wire			rx_parity;
wire			parity_error;
wire			frame_error;
reg			rx_frm_err;
reg			rx_prty_err;

//--------------------------------------------------------------------------------
// circuit description
//--------------------------------------------------------------------------------
//
// clock divider for baud rate clock
//
always @(posedge clk)
begin
 if (rst) begin
   rx_ckdiv <= #UD 13'd0;
 end else if (st_rx == ST_RX_IDLE) begin
   rx_ckdiv <= #UD {1'b0,tc_ckdiv[12:1]};
 end else begin
   rx_ckdiv <= #UD (rx_ckdiv != 13'd0)? (rx_ckdiv - 1'b1):tc_ckdiv;
 end
end

always @(posedge clk)
begin
 if (rst) begin
   rx_cken <= #UD 1'b0;
 end else begin
   rx_cken <= #UD (((rx_ckdiv == 13'd1) & ((st_rx == ST_RX_BUSY) | (st_rx == ST_RX_BREAK)))
	         | ((rx_ckdiv == 13'd0) & rx_start)); // <- It necessary for case of baud rate 
		                                      //    is half of clk's frequency.
 end
end

//
// synchronizer and edge detecter for rxd
//
always @(posedge clk) 
begin
 rxd_sync <= #UD {rxd_sync[1:0],rxd};
end

assign rx_start = rxd_sync[2] & ~rxd_sync[1] & (st_rx == ST_RX_IDLE);

//
// rx state machine
//
assign	end_of_frame = (~prtysel[1] & ~stpsel)? PARITY_FLD:
		       (~prtysel[1] &  stpsel)? STOP1_FLD:
		       ( prtysel[1] & ~stpsel)? STOP1_FLD:STOP2_FLD;

always @(posedge clk)
begin
 if (rst) begin
   st_rx <= #UD ST_RX_IDLE;
 end else case (st_rx)
   ST_RX_IDLE : st_rx <= #UD (rx_done & frame_error)? ST_RX_BREAK:
   			     (rx_start)? ST_RX_BUSY:ST_RX_IDLE;
   ST_RX_BUSY : st_rx <= #UD ( (rx_cken & (rx_bcnt == {BCW{1'b0}}) & rxd_sync[1]) |
                               (rx_cken & (rx_bcnt == end_of_frame)) )? ST_RX_IDLE:ST_RX_BUSY;
// ST_RX_BUSY : st_rx <= #UD (rx_cken & (rx_bcnt == end_of_frame))? ST_RX_IDLE:ST_RX_BUSY;
   ST_RX_BREAK: st_rx <= #UD (rx_cken & (rx_bcnt == end_of_frame))? ST_RX_IDLE:ST_RX_BREAK;
   default    : st_rx <= #UD ST_RX_IDLE;
 endcase
end

//
// bit counter
//
always @(posedge clk)
begin
 if (rst) begin
   rx_bcnt  <= #UD {BCW{1'b0}};
 end else if (st_rx == ST_RX_IDLE) begin
   rx_bcnt  <= #UD {BCW{1'b0}};
 end else if ((st_rx == ST_RX_BUSY) & rx_cken) begin
   rx_bcnt  <= #UD rx_bcnt + 1'b1;
 end else if ((st_rx == ST_RX_BREAK) & rx_cken) begin
   rx_bcnt  <= #UD (rxd_sync[1])? rx_bcnt + 1'b1:{BCW{1'b0}};
 end
end

//
// rx_done
//
always @(posedge clk)
begin
 if (rst) begin
   rx_done <= #UD 1'b0;
 end else begin
   rx_done <= #UD ((st_rx == ST_RX_BUSY) & rx_cken & (rx_bcnt == end_of_frame));
 end
end

//
// rx register
//
always @(posedge clk)
begin
 if ((st_rx == ST_RX_BUSY) & rx_cken) begin
   rx_frm[rx_bcnt] <= #UD rxd_sync[1];
 end
end

//
// parity and frame checker
//
assign	stp1_bit = (~prtysel[1])? rx_frm[PARITY_FLD]:rx_frm[STOP1_FLD];
assign	stp2_bit = (~prtysel[1])? rx_frm[STOP1_FLD ]:rx_frm[STOP2_FLD];
assign	frame_error  = (stp1_bit ^ STOP_BIT_VAL) | (stpsel & (stp2_bit ^ STOP_BIT_VAL));

assign	rx_parity    = ^rx_frm[MSB_FLD:LSB_FLD] ^ prtysel[0];
assign	parity_error = ~frame_error & prtysel[1] & (rx_frm[PARITY_FLD] ^ rx_parity);

always @(posedge clk)
begin
 if (rst) begin
   rx_frm_err <= #UD 1'b0;
 end else if (rx_done) begin
   rx_frm_err <= #UD frame_error;
 end
end

always @(posedge clk)
begin
 if (rst) begin
   rx_prty_err <= #UD 1'b0;
 end else if (rx_done) begin
   rx_prty_err <= #UD parity_error;
 end
end

//
// break
//
assign rx_brk = (st_rx == ST_RX_BREAK);

//
// rx_vld and rx_data
//
always @(posedge clk)
begin
 if (rst) begin
   rx_vld <= #UD 1'b0;
 end else begin
   rx_vld <= #UD rx_done;
 end
end

always @(posedge clk)
begin
 if (rst) begin
   rx_data <= #UD {DBW{1'b0}};
 end else if (rx_done) begin
   rx_data <= #UD rx_frm[MSB_FLD:LSB_FLD];
 end
end

endmodule

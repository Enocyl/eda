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
// UART_TX
//
// [format]
//             ___ ___ ___ ___ ___ ___ ___ ___ ___ _____
// txd ~~~\_s_X_0_X_1_X_2_X_3_X_4_X_5_X_6_X_7_X_p_X e 
//          
// *s = start bit, p = parity bit, e = stop bit
//     
//  [tx i/f]
//  
//  clk ..... ___/~~~\___/~~~\___/~~~\_........__/~~~\___/~~~\___/~~~\___/~~~\___/~
//  
//  tx_vld .. ___/~~~~~~~\_____________........____________________________________
//                        
//  tx_brk .. ____________XXXXXXXXXXXXX........XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//                _______              ........
//  tx_data . xxxX_Valid_Xxxxxxxxxxxxxx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//                   :                                           
//  tx_busy . _______:___/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\_________________________
//                   +----------------------------------> _______
//  tx_done . _________________________........__________/       \_________________
// 
//  *. If you assert tx_vld when tx_busy and tx_brk is 0, tx_data is captured 
//     and constructed to a frame, and then transmitted to txd signal. 
//     tx_busy maintain 1 during of transmission and the tx_done is asserted 1 clock 
//     cycle at the end of transmission. 
//     And during transmission, tx_vld is ignored.
// 
//  <tx_brk>
// 
//  clk ..... ___/~~~\___/~~~\___/~~~\_........__/~~~\___/~~~\___/~~~\___/~~~\___/~
//                        
//  tx_vld .. ___XXXXXXXXX_____________........____________________________________
//                        
//  tx_brk .. ___/~~~~~~~~~~~~~~~~~~~~~........~~~~~~~~~~\_________________________
//                       |             ........                  |
//  tx_data . XXXXXXXXXXX|XXXXXXXXXXXXX........xxxxxxxxxxxxxxxxxx|xxxxxxxxxxxxxxxxx
//                       V                                       V
//  tx_busy . ___________/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\_________________
//                                                                
//  tx_done . _________________________........____________________________________
// 
//  txd     . ~~~~~~~~~~~~~~~~~~~\_____........_< break pattern >________/~~~~~~~~~
// 
//  *. If you assert tx_brk when tx_busy is 0, the TXD becomes 0 while a frame time.
//     This is break transmission. And, during the transmittion tx_busy becomes 1 but
//     tx_done doesn't assert 1 at the end of transmission.
//  *. When tx_vld and tx_brk assert 1 in same time, the tx_vld is ignored but tx_brk validated.
//     And also, assert of tx_vld during the break transmission is ignored.
// =================================================================================================
module	uart_tx (
	clk,
	rst,
	txd,
	tx_vld,
	tx_done,
	tx_busy,
	tx_data,
	prtysel,
	stpsel,
	tc_ckdiv,
	tx_brk
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

input			tx_vld;
output			tx_done;
output			tx_busy;
input	[DBW-1:0]	tx_data;
output			txd;

input	[ 1:0]		prtysel;// parity
				// 0x ... none
				// 10 ... even
				// 11 ... odd

input			stpsel; // stop bit
				// 0 ... 1bit
				// 1 ... 2bit

input	[12:0]		tc_ckdiv;
input			tx_brk;	// send break
				// 0 ... normal
				// 1 ... send break
//--------------------------------------------------------------------------------
// reg,wire declaration
//--------------------------------------------------------------------------------
reg	[ 1:0]		st_tx;
parameter		ST_TX_IDLE = 2'd0;
parameter		ST_TX_BUSY = 2'd1;
parameter		ST_TX_BRK  = 2'd2;

reg	[12:0]		tx_ckdiv;
reg 			tx_cken;

reg	[BCW-1:0]	tx_bcnt;
wire	[BCW-1:0]	end_of_frame;
parameter		START_BIT_FLD = 0;
parameter		LSB_FLD	      = 1;
parameter		MSB_FLD	      = DBW;
parameter		PARITY_FLD    = FRW-3;
parameter		STOP1_FLD     = FRW-2;
parameter		STOP2_FLD     = FRW-1;

reg 	[FRW-1:0]	tx_frm;
parameter		START_BIT_VAL  = 1'b0;
parameter		STOP_BIT_VAL   = 1'b1;
parameter		BREAK_VAL      = 1'b0;

wire			tx_parity;

reg			tx_done;
reg			txd;

reg	[3:0]		brk_cnt;
//--------------------------------------------------------------------------------
// circuit description
//--------------------------------------------------------------------------------

//
// clock divider for baud rate clock 
//
always @(posedge clk)
begin
 if (rst) begin
   tx_ckdiv <= #UD tc_ckdiv;
 end else if (st_tx == ST_TX_IDLE) begin
   tx_ckdiv <= #UD tc_ckdiv;
 end else begin
   tx_ckdiv <= #UD (tx_ckdiv == 0)? tc_ckdiv:tx_ckdiv - 1'b1;
 end
end

always @(posedge clk)
begin
 if (rst) begin
   tx_cken <= #UD 1'b0;
 end else if (st_tx == ST_TX_IDLE) begin
   tx_cken <= #UD 1'b0;
 end else begin
   tx_cken <= #UD (tx_ckdiv == 1);
 end
end

//
// tx state machine
//
always @(posedge clk)
begin
 if (rst) begin
   st_tx <= #UD ST_TX_IDLE;
 end else case (st_tx)
   ST_TX_IDLE : st_tx <= #UD (tx_brk)? ST_TX_BRK:
   			     (tx_vld)? ST_TX_BUSY:ST_TX_IDLE;
   ST_TX_BUSY : st_tx <= #UD (tx_cken & (tx_bcnt == end_of_frame))? ST_TX_IDLE:ST_TX_BUSY;
   ST_TX_BRK  : st_tx <= #UD (tx_cken & (tx_bcnt == end_of_frame) & (brk_cnt == 4'd15))? 
   				ST_TX_IDLE:ST_TX_BRK;
    default   : st_tx <= #UD ST_TX_IDLE;
 endcase
end

//
// break timer
//
always @(posedge clk)
begin
 if (rst) begin
   brk_cnt <= #UD 4'd0;
 end else if (st_tx != ST_TX_BRK) begin
   brk_cnt <= #UD 4'd0;
 end else if (tx_cken & (tx_bcnt == end_of_frame)) begin
   brk_cnt <= #UD brk_cnt + 1'b1;
 end else begin
   brk_cnt <= #UD brk_cnt;
 end
end

//
// busy status
//
assign tx_busy = (st_tx == ST_TX_BUSY) | (st_tx == ST_TX_BRK);

//
// bit counter
//
always @(posedge clk)
begin
 if (rst) begin
   tx_bcnt <= #UD START_BIT_FLD;
 end else if (st_tx == ST_TX_IDLE) begin
   tx_bcnt <= #UD START_BIT_FLD;
 end else if (tx_cken) begin
   tx_bcnt <= #UD (tx_bcnt != end_of_frame)? tx_bcnt + 1:START_BIT_FLD;
 end
end

//
// done pulse
//
always @(posedge clk)
begin
 if (rst) begin
   tx_done <= #UD 1'b0;
 end else begin
   tx_done <= #UD ((st_tx == ST_TX_BUSY) & tx_cken & (tx_bcnt == end_of_frame));
 end
end

//
// txd shift register
//
assign tx_parity = ~prtysel[1] | (^tx_data ^ prtysel[0]);

assign end_of_frame = (~prtysel[1] & ~stpsel)? PARITY_FLD:
		      (~prtysel[1] &  stpsel)? STOP1_FLD:
		      ( prtysel[1] & ~stpsel)? STOP1_FLD:STOP2_FLD;

always @(posedge clk)
begin
 if (rst) begin
   tx_frm <= #UD {FRW{STOP_BIT_VAL}};
 end else if (st_tx == ST_TX_BRK) begin
   tx_frm <= #UD {{FRW-1{STOP_BIT_VAL}},BREAK_VAL};
 end else if ((st_tx == ST_TX_IDLE) & tx_vld) begin
   tx_frm <= #UD {STOP_BIT_VAL, STOP_BIT_VAL, tx_parity, tx_data, START_BIT_VAL};
 end else if ((st_tx == ST_TX_IDLE) & ~tx_vld) begin
   tx_frm <= #UD {FRW{STOP_BIT_VAL}};
 end else if (tx_cken) begin
   tx_frm <= #UD {STOP_BIT_VAL,tx_frm[FRW-1:1]};
 end
end

//
// output register
//
always @(posedge clk) txd <= #UD tx_frm[0];

endmodule

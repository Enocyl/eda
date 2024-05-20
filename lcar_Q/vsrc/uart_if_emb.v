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
// UART I/F for EMB
//
// [frame format]
// 
//   +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
//   |STX|TYP|ADH|ADV|CMD| P5| P4| P3| P2| P1| P0|CS1|CS0|ETX| CR|
//   +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
// 
//   frame := {STX, TYP, ADH, ADV, CMD, P5, P4, P3, P2, P1, P0, CS1, CS0, ETX, CR}
//   STX   := 8'H02  (Start of Text)
//   TYP   := Header Type 
//   ADH   := Horizontal Address 
//   ADV   := Vertical Address 
//   CMD   := Control Command
//   P5    := Control Parameter 
//   P4    := Control Parameter 
//   P3    := Control Parameter 
//   P2    := Control Parameter 
//   P1    := Control Parameter 
//   P0    := Control Parameter 
//   CS1   := Check Sum 
//   CS0   := Check Sum 
//   ETX   := 8'H03  (End of Text)
//   CR    := 8'H0d  (Carriage Return)
//	      Check Sum = ADH + ADV + CMD + P5 + P4 + P3 + P2 + P1 + P0
// 
// =================================================================================================
//
//  Aug 2011
//  modified by amano@pti
//  module name : uif -> uart_if_mpc
//
//  Feb 2013
//  module name : uart_if_mpc -> uart_if_emb
//  modified for EMB
//
// =================================================================================================

module	uart_if_emb (
	clk,
	rst,

	// uart_rx
	rx_vld,
	rx_data,
	rx_frm_err,
	rx_prty_err,

	rx_time_out_on,
	rx_time_out,

	// cmd_if rx
	cmd_rx_req,
	rcv_ok,
	rx_cmd_data,

	// uart_tx 
	tx_vld,
	tx_data,
	tx_busy,
	tx_done,
	tx_brk,

	// cmd_if tx
	cmd_tx_req,
	tx_cmd_data,
	cmd_tx_done
);

//--------------------------------------------------------------------------------
// port declaration
//--------------------------------------------------------------------------------
input			clk;
input			rst;
input			rx_vld;
input		[ 7:0]	rx_data;
input			rx_frm_err;
input			rx_prty_err;
input			rx_time_out_on;
output			rx_time_out;      // rx char interval > 1 sec
output	reg		cmd_rx_req;
output	reg		rcv_ok;
output	reg	[79:0]	rx_cmd_data;
output	reg		tx_vld;
output	reg	[ 7:0]	tx_data;
input			tx_busy;
input			tx_done;
output	reg		tx_brk;
input			cmd_tx_req;
input		[79:0]	tx_cmd_data;
output	reg		cmd_tx_done;

//--------------------------------------------------------------------------------
// reg,wire declaration
//--------------------------------------------------------------------------------
reg 			f_parity_error;
reg		[ 3:0]	st_cmd;
reg		[ 7:0]	chk_sum;
reg		[ 7:0]	rcv_stx, rcv_typ, rcv_adh, rcv_adv, rcv_cmd;
reg		[ 7:0]	rcv_p5, rcv_p4, rcv_p3, rcv_p2, rcv_p1, rcv_p0;
reg		[ 7:0]	rcv_cs1, rcv_cs0, rcv_etx, rcv_cr;
reg		[17:0]	rxto_cnta;
reg		[10:0]	rxto_cntb;
reg		[ 7:0]	dec_sum;
reg			cmd_cr_vld;
reg		[ 3:0]	st_tx;
reg   		[ 7:0]	tx_sum;

wire			rxto_cnt_rst;
wire		[ 3:0]	dec_sum_msb, dec_sum_lsb;
wire		[ 7:0]	enc_sum_msb, enc_sum_lsb;

//--------------------------------------------------------------------------------
// parameter define
//--------------------------------------------------------------------------------
parameter		UD  = 'd1;
parameter		STX = 8'h02;
parameter		ETX = 8'h03;
parameter		CR  = 8'h0d;

parameter		ST_CMD_STX  = 4'd0;
parameter		ST_CMD_TYP  = 4'd1;
parameter		ST_CMD_ADH  = 4'd2;
parameter		ST_CMD_ADV  = 4'd3;
parameter		ST_CMD_CMD  = 4'd4;
parameter		ST_CMD_P5   = 4'd5;
parameter		ST_CMD_P4   = 4'd6;
parameter		ST_CMD_P3   = 4'd7;
parameter		ST_CMD_P2   = 4'd8;
parameter		ST_CMD_P1   = 4'd9;
parameter		ST_CMD_P0   = 4'd10;
parameter		ST_CMD_CS1  = 4'd11;
parameter		ST_CMD_CS0  = 4'd12;
parameter		ST_CMD_ETX  = 4'd13;
parameter		ST_CMD_CR   = 4'd14;
parameter		ST_SND_BRK  = 4'd15;

parameter		ST_TX_IDLE = 4'd0;
parameter		ST_TX_STX  = 4'd1;
parameter		ST_TX_TYP  = 4'd2;
parameter		ST_TX_ADH  = 4'd3;
parameter		ST_TX_ADV  = 4'd4;
parameter		ST_TX_CMD  = 4'd5;
parameter		ST_TX_P5   = 4'd6;
parameter		ST_TX_P4   = 4'd7;
parameter		ST_TX_P3   = 4'd8;
parameter		ST_TX_P2   = 4'd9;
parameter		ST_TX_P1   = 4'd10;
parameter		ST_TX_P0   = 4'd11;
parameter		ST_TX_CS1  = 4'd12;
parameter		ST_TX_CS0  = 4'd13;
parameter		ST_TX_ETX  = 4'd14;
parameter		ST_TX_CR   = 4'd15;

//--------------------------------------------------------------------------------
// circuit description
//--------------------------------------------------------------------------------

//-----------------------//
// Receive State Machine //
//-----------------------//

// f_parity_error
always @(posedge clk)
begin
 if (rst) begin
   f_parity_error <= #UD 1'b0;
 end else if (rx_vld) begin
   f_parity_error <= #UD rx_prty_err;
 end
end

// st_cmd  4bit,  chk_sum  8bit
always @(posedge clk)
begin
 if (rst) begin
   st_cmd   <= #UD ST_CMD_STX;
   chk_sum  <= #UD 8'd0;
 end else case (st_cmd)
   ST_CMD_STX  : begin
   		  chk_sum  <= #UD 8'd0;
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_TYP;
                  end else begin
                    st_cmd <= #UD ST_CMD_STX;
                  end
                 end
   ST_CMD_TYP  : begin
   		  chk_sum  <= #UD 8'd0;
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_ADH;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_TYP;
                  end
                 end
   ST_CMD_ADH  : begin
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_ADV;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_ADH;
                  end

                  if (rx_vld) begin
                    chk_sum <= #UD rx_data;
                  end else begin
                    chk_sum <= #UD chk_sum;
                  end
     		 end
   ST_CMD_ADV  : begin
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_CMD;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_ADV;
                  end

                  if (rx_vld) begin
                    chk_sum <= #UD chk_sum + rx_data;
                  end else begin
                    chk_sum <= #UD chk_sum;
                  end
     		 end
   ST_CMD_CMD  : begin
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_P5;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_CMD;
                  end

                  if (rx_vld) begin
                    chk_sum <= #UD chk_sum + rx_data;
                  end else begin
                    chk_sum <= #UD chk_sum;
                  end
     		 end
   ST_CMD_P5:    begin
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_P4;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_P5;
                  end

                  if (rx_vld) begin
                    chk_sum <= #UD chk_sum + rx_data;
                  end else begin
                    chk_sum <= #UD chk_sum;
                  end
                 end
   ST_CMD_P4:    begin
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_P3;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_P4;
                  end

                  if (rx_vld) begin
                    chk_sum <= #UD chk_sum + rx_data;
                  end else begin
                    chk_sum <= #UD chk_sum;
                  end
                 end
   ST_CMD_P3:    begin
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_P2;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_P3;
                  end

                  if (rx_vld) begin
                    chk_sum <= #UD chk_sum + rx_data;
                  end else begin
                    chk_sum <= #UD chk_sum;
                  end
                 end
   ST_CMD_P2:    begin
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_P1;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_P2;
                  end

                  if (rx_vld) begin
                    chk_sum <= #UD chk_sum + rx_data;
                  end else begin
                    chk_sum <= #UD chk_sum;
                  end
                 end
   ST_CMD_P1:    begin
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_P0;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_P1;
                  end

                  if (rx_vld) begin
                    chk_sum <= #UD chk_sum + rx_data;
                  end else begin
                    chk_sum <= #UD chk_sum;
                  end
                 end
   ST_CMD_P0:    begin
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_CS1;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_P0;
                  end

                  if (rx_vld) begin
                    chk_sum <= #UD chk_sum + rx_data;
                  end else begin
                    chk_sum <= #UD chk_sum;
                  end
                 end
   ST_CMD_CS1:   begin
                  chk_sum <= #UD chk_sum;
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_CS0;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_CS1;
                  end
                 end
   ST_CMD_CS0:   begin
                  chk_sum <= #UD chk_sum;
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_ETX;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_CS0;
                  end
                 end
   ST_CMD_ETX:   begin
                  chk_sum <= #UD chk_sum;
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_CR;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_ETX;
                  end
                 end
   ST_CMD_CR:    begin
                  chk_sum <= #UD chk_sum;
                  if (rx_vld & rx_frm_err) begin
                    st_cmd <= #UD ST_SND_BRK;
                  end else if (rx_vld) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else if (rx_time_out) begin
                    st_cmd <= #UD ST_CMD_STX;
                  end else begin
                    st_cmd <= #UD ST_CMD_CR;
                  end
                 end
   ST_SND_BRK  : begin
                  st_cmd   <= #UD (tx_brk)? ST_SND_BRK:ST_CMD_STX;
                  chk_sum  <= #UD 8'd0;
                 end
   default     : begin
                  st_cmd   <= #UD ST_CMD_STX;
                  chk_sum  <= #UD 8'd0;
                 end
 endcase
end

// tx_brk
always @(posedge clk)
begin
 if (rst) begin
   tx_brk <= #UD 1'b0;
 end else case (tx_brk)
   1'b0: tx_brk <= #UD rx_vld & rx_frm_err;
   1'b1: tx_brk <= #UD tx_busy;
 endcase
end

// rcv_stx -- rcv_cr  8bit
always @(posedge clk) 
begin
 if (rst) begin
   rcv_stx <= #UD 8'd0;
 end else begin
   rcv_stx <= #UD ((st_cmd == ST_CMD_STX) & rx_vld)? rx_data:rcv_stx;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_typ <= #UD 8'd0;
 end else begin
   rcv_typ <= #UD ((st_cmd == ST_CMD_TYP) & rx_vld)? rx_data:rcv_typ;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_adh <= #UD 8'd0;
 end else begin
   rcv_adh <= #UD ((st_cmd == ST_CMD_ADH) & rx_vld)? rx_data:rcv_adh;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_adv <= #UD 8'd0;
 end else begin
   rcv_adv <= #UD ((st_cmd == ST_CMD_ADV) & rx_vld)? rx_data:rcv_adv;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_cmd <= #UD 8'd0;
 end else begin
   rcv_cmd <= #UD ((st_cmd == ST_CMD_CMD) & rx_vld)? rx_data:rcv_cmd;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_p5 <= #UD 8'd0;
 end else begin
   rcv_p5 <= #UD ((st_cmd == ST_CMD_P5) & rx_vld)? rx_data:rcv_p5;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_p4 <= #UD 8'd0;
 end else begin
   rcv_p4 <= #UD ((st_cmd == ST_CMD_P4) & rx_vld)? rx_data:rcv_p4;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_p3 <= #UD 8'd0;
 end else begin
   rcv_p3 <= #UD ((st_cmd == ST_CMD_P3) & rx_vld)? rx_data:rcv_p3;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_p2 <= #UD 8'd0;
 end else begin
   rcv_p2 <= #UD ((st_cmd == ST_CMD_P2) & rx_vld)? rx_data:rcv_p2;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_p1 <= #UD 8'd0;
 end else begin
   rcv_p1 <= #UD ((st_cmd == ST_CMD_P1) & rx_vld)? rx_data:rcv_p1;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_p0 <= #UD 8'd0;
 end else begin
   rcv_p0 <= #UD ((st_cmd == ST_CMD_P0) & rx_vld)? rx_data:rcv_p0;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_cs1 <= #UD 8'd0;
 end else begin
   rcv_cs1 <= #UD ((st_cmd == ST_CMD_CS1) & rx_vld)? rx_data:rcv_cs1;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_cs0 <= #UD 8'd0;
 end else begin
   rcv_cs0 <= #UD ((st_cmd == ST_CMD_CS0) & rx_vld)? rx_data:rcv_cs0;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_etx <= #UD 8'd0;
 end else begin
   rcv_etx <= #UD ((st_cmd == ST_CMD_ETX) & rx_vld)? rx_data:rcv_etx;
 end
end

always @(posedge clk) 
begin
 if (rst) begin
   rcv_cr <= #UD 8'd0;
 end else begin
   rcv_cr <= #UD ((st_cmd == ST_CMD_CR) & rx_vld)? rx_data:rcv_cr;
 end
end

// rxto_cnt_rst
assign rxto_cnt_rst = rst | (st_cmd == ST_CMD_STX) | (st_cmd == ST_SND_BRK) |
                      rx_vld | ~rx_time_out_on;

// rxto_cnta  18bit counter
always @(posedge clk) 
begin
 if (rxto_cnt_rst | rxto_cnta[17])
   rxto_cnta <= #UD 18'd59073;
 else if (~rxto_cntb[10])
   rxto_cnta <= #UD rxto_cnta + 18'd1;
end

// rxto_cntb  11bit counter
always @(posedge clk) 
begin
 if (rxto_cnt_rst)
   rxto_cntb <= #UD 11'd24;
 else if (rxto_cnta[17] & ~rxto_cntb[10])
   rxto_cntb <= #UD rxto_cntb + 11'd1;
end

// rx_time_out
assign rx_time_out = rxto_cntb[10];

// dec_sum_msb, dec_sum_lsb  4bit
function [3:0] ascii_dec;     // Convert from ASCII code to Binary value
input [7:0] ascii;
  case(ascii)
    8'h30  : ascii_dec = 4'h0;
    8'h31  : ascii_dec = 4'h1;
    8'h32  : ascii_dec = 4'h2;
    8'h33  : ascii_dec = 4'h3;
    8'h34  : ascii_dec = 4'h4;
    8'h35  : ascii_dec = 4'h5;
    8'h36  : ascii_dec = 4'h6;
    8'h37  : ascii_dec = 4'h7;
    8'h38  : ascii_dec = 4'h8;
    8'h39  : ascii_dec = 4'h9;
    8'h41  : ascii_dec = 4'ha;
    8'h61  : ascii_dec = 4'ha;
    8'h42  : ascii_dec = 4'hb;
    8'h62  : ascii_dec = 4'hb;
    8'h43  : ascii_dec = 4'hc;
    8'h63  : ascii_dec = 4'hc;
    8'h44  : ascii_dec = 4'hd;
    8'h64  : ascii_dec = 4'hd;
    8'h45  : ascii_dec = 4'he;
    8'h65  : ascii_dec = 4'he;
    8'h46  : ascii_dec = 4'hf;
    8'h66  : ascii_dec = 4'hf;
    default: ascii_dec = 4'h0;
  endcase
endfunction

assign dec_sum_msb = ascii_dec(rcv_cs1);
assign dec_sum_lsb = ascii_dec(rcv_cs0);

// dec_sum  8bit
always @(posedge clk) 
begin
 if (rst) begin
   dec_sum <= #UD 8'd0;
 end else begin
   dec_sum <= #UD {dec_sum_msb, dec_sum_lsb};
 end
end

// cmd_cr_vld
always @(posedge clk) 
begin
 if (rst) begin
   cmd_cr_vld <= #UD 1'b0;
 end else begin
   cmd_cr_vld <= #UD (st_cmd == ST_CMD_CR) & rx_vld;
 end
end

// rcv_ok
always @(posedge clk) 
begin
 if (rst) begin
   rcv_ok <= #UD 1'b0;
 end else if (cmd_cr_vld) begin
   rcv_ok <= #UD (rcv_stx == STX) & (rcv_etx == ETX) & (rcv_cr == CR) &
                 (f_parity_error == 1'b0) & (chk_sum == dec_sum);
 end
end

// cmd_rx_req
always @(posedge clk) 
begin
 if (rst) begin
   cmd_rx_req <= #UD 1'b0;
 end else begin
   cmd_rx_req <= #UD cmd_cr_vld;
 end
end

// rx_cmd_data  80bit
always @(posedge clk) 
begin
 if (rst) begin
   rx_cmd_data <= #UD 80'd0;
 end else if (cmd_cr_vld) begin
   rx_cmd_data <= #UD {rcv_typ, rcv_adh, rcv_adv, rcv_cmd,
                       rcv_p5, rcv_p4, rcv_p3, rcv_p2, rcv_p1, rcv_p0};
 end
end


//------------------------//
// Transmit State Machine //
//------------------------//

// st_tx  4bit
always @(posedge clk)
begin
 if (rst) begin
   st_tx<=#UD ST_TX_IDLE;
 end else if (tx_brk) begin
   st_tx<=#UD ST_TX_IDLE;
 end else case(st_tx)
   ST_TX_IDLE :st_tx <= #UD (cmd_tx_req)? ST_TX_STX :ST_TX_IDLE;
   ST_TX_STX  :st_tx <= #UD (tx_done)? ST_TX_TYP :ST_TX_STX;
   ST_TX_TYP  :st_tx <= #UD (tx_done)? ST_TX_ADH :ST_TX_TYP;
   ST_TX_ADH  :st_tx <= #UD (tx_done)? ST_TX_ADV :ST_TX_ADH;
   ST_TX_ADV  :st_tx <= #UD (tx_done)? ST_TX_CMD :ST_TX_ADV;
   ST_TX_CMD  :st_tx <= #UD (tx_done)? ST_TX_P5  :ST_TX_CMD;
   ST_TX_P5   :st_tx <= #UD (tx_done)? ST_TX_P4  :ST_TX_P5;
   ST_TX_P4   :st_tx <= #UD (tx_done)? ST_TX_P3  :ST_TX_P4;
   ST_TX_P3   :st_tx <= #UD (tx_done)? ST_TX_P2  :ST_TX_P3;
   ST_TX_P2   :st_tx <= #UD (tx_done)? ST_TX_P1  :ST_TX_P2;
   ST_TX_P1   :st_tx <= #UD (tx_done)? ST_TX_P0  :ST_TX_P1;
   ST_TX_P0   :st_tx <= #UD (tx_done)? ST_TX_CS1 :ST_TX_P0;
   ST_TX_CS1  :st_tx <= #UD (tx_done)? ST_TX_CS0 :ST_TX_CS1;
   ST_TX_CS0  :st_tx <= #UD (tx_done)? ST_TX_ETX :ST_TX_CS0;
   ST_TX_ETX  :st_tx <= #UD (tx_done)? ST_TX_CR  :ST_TX_ETX;
   ST_TX_CR   :st_tx <= #UD (tx_done)? ST_TX_IDLE:ST_TX_CR;
   default    :st_tx <= #UD ST_TX_IDLE;
endcase
end

// tx_vld
always @(posedge clk)
begin
 if (rst) begin                                         
   tx_vld <= #UD 1'b0;
 end else if (tx_brk) begin
   tx_vld <= #UD 1'b0;
 end else case (st_tx)
   ST_TX_IDLE :tx_vld <= #UD cmd_tx_req;
   ST_TX_STX  :tx_vld <= #UD tx_done;
   ST_TX_TYP  :tx_vld <= #UD tx_done;
   ST_TX_ADH  :tx_vld <= #UD tx_done;
   ST_TX_ADV  :tx_vld <= #UD tx_done;
   ST_TX_CMD  :tx_vld <= #UD tx_done;
   ST_TX_P5   :tx_vld <= #UD tx_done;
   ST_TX_P4   :tx_vld <= #UD tx_done;
   ST_TX_P3   :tx_vld <= #UD tx_done;
   ST_TX_P2   :tx_vld <= #UD tx_done;
   ST_TX_P1   :tx_vld <= #UD tx_done;
   ST_TX_P0   :tx_vld <= #UD tx_done;
   ST_TX_CS1  :tx_vld <= #UD tx_done;
   ST_TX_CS0  :tx_vld <= #UD tx_done;
   ST_TX_ETX  :tx_vld <= #UD tx_done;
   ST_TX_CR   :tx_vld <= #UD 1'b0;
   default    :tx_vld <= #UD 1'b0;
 endcase
end

// tx_data  8bit
always @(posedge clk)
begin
 if (rst) begin
   tx_data <= #UD 8'd0;
 end else if (tx_brk) begin
   tx_data <= #UD 8'd0;
 end else case (st_tx)
   ST_TX_IDLE : tx_data <= #UD (cmd_tx_req)? STX : 8'd0;
   ST_TX_STX  : tx_data <= #UD tx_cmd_data[79:72];
   ST_TX_TYP  : tx_data <= #UD tx_cmd_data[71:64];
   ST_TX_ADH  : tx_data <= #UD tx_cmd_data[63:56];
   ST_TX_ADV  : tx_data <= #UD tx_cmd_data[55:48];
   ST_TX_CMD  : tx_data <= #UD tx_cmd_data[47:40];
   ST_TX_P5   : tx_data <= #UD tx_cmd_data[39:32];
   ST_TX_P4   : tx_data <= #UD tx_cmd_data[31:24];
   ST_TX_P3   : tx_data <= #UD tx_cmd_data[23:16];
   ST_TX_P2   : tx_data <= #UD tx_cmd_data[15: 8];
   ST_TX_P1   : tx_data <= #UD tx_cmd_data[ 7: 0];
   ST_TX_P0   : tx_data <= #UD enc_sum_msb;
   ST_TX_CS1  : tx_data <= #UD enc_sum_lsb;
   ST_TX_CS0  : tx_data <= #UD ETX;
   ST_TX_ETX  : tx_data <= #UD CR;
   ST_TX_CR   : tx_data <= #UD 8'd0;
   default    : tx_data <= #UD 8'd0;
 endcase
end

// tx_sum  8bit
always @(posedge clk)
begin
 if (rst) begin
   tx_sum <= #UD 8'd0;
 end else if (tx_brk) begin
   tx_sum <= #UD 8'd0;
 end else case (st_tx)
   ST_TX_IDLE : tx_sum <= #UD 8'd0;
   ST_TX_STX  : tx_sum <= #UD 8'd0;
   ST_TX_TYP  : tx_sum <= #UD tx_cmd_data[71:64];
   ST_TX_ADH  : tx_sum <= #UD (tx_done)? tx_sum + tx_cmd_data[63:56] : tx_sum;
   ST_TX_ADV  : tx_sum <= #UD (tx_done)? tx_sum + tx_cmd_data[55:48] : tx_sum;
   ST_TX_CMD  : tx_sum <= #UD (tx_done)? tx_sum + tx_cmd_data[47:40] : tx_sum;
   ST_TX_P5   : tx_sum <= #UD (tx_done)? tx_sum + tx_cmd_data[39:32] : tx_sum;
   ST_TX_P4   : tx_sum <= #UD (tx_done)? tx_sum + tx_cmd_data[31:24] : tx_sum;
   ST_TX_P3   : tx_sum <= #UD (tx_done)? tx_sum + tx_cmd_data[23:16] : tx_sum;
   ST_TX_P2   : tx_sum <= #UD (tx_done)? tx_sum + tx_cmd_data[15: 8] : tx_sum;
   ST_TX_P1   : tx_sum <= #UD (tx_done)? tx_sum + tx_cmd_data[ 7: 0] : tx_sum;
   ST_TX_P0   : tx_sum <= #UD tx_sum;
   ST_TX_CS1  : tx_sum <= #UD tx_sum;
   ST_TX_CS0  : tx_sum <= #UD 8'd0;
   ST_TX_ETX  : tx_sum <= #UD 8'd0;
   ST_TX_CR   : tx_sum <= #UD 8'd0;
   default    : tx_sum <= #UD 8'd0;
 endcase
end

// enc_sum_msb, enc_sum_lsb  8bit
function [7:0] ascii_enc;     // Convert from Binary value to ASCII code 
input [3:0] value;
  case(value)
    4'h0   : ascii_enc = 8'h30;
    4'h1   : ascii_enc = 8'h31;
    4'h2   : ascii_enc = 8'h32;
    4'h3   : ascii_enc = 8'h33;
    4'h4   : ascii_enc = 8'h34;
    4'h5   : ascii_enc = 8'h35;
    4'h6   : ascii_enc = 8'h36;
    4'h7   : ascii_enc = 8'h37;
    4'h8   : ascii_enc = 8'h38;
    4'h9   : ascii_enc = 8'h39;
    4'ha   : ascii_enc = 8'h41;
    4'hb   : ascii_enc = 8'h42;
    4'hc   : ascii_enc = 8'h43;
    4'hd   : ascii_enc = 8'h44;
    4'he   : ascii_enc = 8'h45;
    4'hf   : ascii_enc = 8'h46;
    default: ascii_enc = 8'h30;
  endcase
endfunction

assign enc_sum_msb = ascii_enc(tx_sum[7:4]);
assign enc_sum_lsb = ascii_enc(tx_sum[3:0]);

// cmd_tx_done
always @(posedge clk) 
begin
 if (rst) begin
   cmd_tx_done <= #UD 1'b0;
 end else begin
   cmd_tx_done <= #UD (st_tx == ST_TX_CR) & tx_done;
 end
end

endmodule
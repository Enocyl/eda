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
// UART I/F
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
//   CR    := 8'H0d  (Carrage Return)
//	      Check Sum = ADH + ADV + CMD + P5 + P4 + P3 + P2 + P1 + P0
// 
// =================================================================================================
//
//  Aug 2011
//  modified by amano@pti
//  module name : uif -> uart_if_mpc
//
//  Nov 2012
//  module name : uart_if_mpc -> uart_if_x3
//  added the command mode for XL
//
//  Mar 2013
//  module name : uart_if_x3 -> uart_if_mpc2
//  added the function to receive the command for EMB
// (added the following output : emb_cmd, emb_cmd_rcv_ok, emb_tx_req, emb_tx_data)
//
//  Jun 2013
//  module name : uart_if_mpc2 -> uart_if_impact
//  added the function to receive the command to IM for M5
// (added the following output : m5_cmd, m5_cmd_rcv_ok, m5_tx_req, m5_tx_data, m5_rsp_ram_re)
//
//  Mar 2014
//  module name : uart_if_impact -> uart_if_impact_a
//  modified the calculation of tx_sum
//
// =================================================================================================

module	uart_if_impact_a (
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
	xl_mode,
	exe_req,
	rcv_ok,
	emb_cmd,
	emb_cmd_rcv_ok,
        m5_cmd,
        m5_cmd_rcv_ok,
	exe_p5, exe_p4, exe_p3, exe_p2, exe_p1, exe_p0,
	exe_cmd_num,
	emb_tx_req,
	emb_tx_data,
        m5_tx_req,
        m5_tx_data,
	cmd_ram_do,
	cmd_ram_ra,
	cmd_com_buf_write,
	cmd_com_buf_we,
	cmd_com_buf_wa,

	// uart_tx 
	tx_vld,
	tx_data,
	tx_busy,
	tx_done,
	tx_brk,

	// cmd_if tx
	rsp_req,
	rsp_data,
	rsp_done,
	rsp_ram_re,
        m5_rsp_ram_re
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
input			xl_mode;          // 1 : select the command mode for XL
output	reg		exe_req;
output	reg		rcv_ok;
output	reg		emb_cmd;
output	reg		emb_cmd_rcv_ok;
output	reg		m5_cmd;
output	reg		m5_cmd_rcv_ok;
output	reg	[ 7:0]	exe_p5, exe_p4, exe_p3, exe_p2, exe_p1, exe_p0;
output	reg	[ 5:0]	exe_cmd_num;
output	reg		emb_tx_req;
output	reg	[79:0]	emb_tx_data;
output	reg		m5_tx_req;
output	reg	[79:0]	m5_tx_data;
output	reg	[ 7:0]	cmd_ram_do;
input		[ 6:0]	cmd_ram_ra;
output	reg		cmd_com_buf_write;
output	reg		cmd_com_buf_we;
output	reg	[ 7:0]	cmd_com_buf_wa;
output	reg		tx_vld;
output	reg	[ 7:0]	tx_data;
input			tx_busy;
input			tx_done;
output	reg		tx_brk;
input			rsp_req;
input		[79:0]	rsp_data;
output	reg		rsp_done;
output	reg		rsp_ram_re;
output	reg		m5_rsp_ram_re;

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
reg		[ 5:0]	cmd_num;
reg		[ 7:0]	rx_pnum;
reg		[ 7:0]	rx_pcnt;
reg		[ 7:0]	dec_sum;
reg			cmd_cr_vld;
reg		[ 7:0]	exe_typ, exe_adh, exe_adv, exe_cmd;
reg		[ 7:0]	cmd_ram_wa;
reg		[ 8:0]	com_wa;
reg		[ 5:0]	com_wb;
reg		[ 3:0]	st_tx;
reg   		[ 7:0]	tx_sum;
reg		[ 7:0]	tx_pnum;
reg		[ 7:0]	tx_pcnt;

wire			rxto_cnt_rst;
wire		[15:0]	rcv_typ_cmd;
wire		[ 3:0]	dec_sum_msb, dec_sum_lsb;
wire			emb_cmd_rcv_ok_a;
wire			m5_cmd_rcv_ok_a;
wire			cmd_ram_we;
wire		[ 7:0]	cmd_ram_doa;
wire		[ 7:0]	tx_data_typ, tx_data_adh, tx_data_adv, tx_data_cmd;
wire		[ 7:0]	tx_data_p5, tx_data_p4, tx_data_p3, tx_data_p2, tx_data_p1, tx_data_p0;
wire		[ 7:0]	enc_sum_msb, enc_sum_lsb;
wire		[ 3:0]	dec_p4, dec_p5;
wire			com_cnt_ce;

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
                  end else if (rx_vld & (rx_pcnt == rx_pnum)) begin
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

// rcv_typ_cmd  16bit
assign rcv_typ_cmd = {rcv_typ, rcv_cmd};

// cmd_num  6bit
always @(posedge clk) 
begin
 if (rst) begin
   cmd_num <= #UD 6'd0;
 end
 else if (~xl_mode) begin            // Command for LH
 case(rcv_typ_cmd)
   // Set command  cmd_num[5]=0
   16'h4346 : cmd_num <= #UD 6'h01;  // Type="C", Cmd="F"
   16'h4342 : cmd_num <= #UD 6'h02;  // Type="C", Cmd="B"
   16'h4347 : cmd_num <= #UD 6'h03;  // Type="C", Cmd="G"
   16'h4350 : cmd_num <= #UD 6'h04;  // Type="C", Cmd="P"
   16'h4359 : cmd_num <= #UD 6'h05;  // Type="C", Cmd="Y"
   16'h434f : cmd_num <= #UD 6'h06;  // Type="C", Cmd="O"
   16'h434c : cmd_num <= #UD 6'h07;  // Type="C", Cmd="L"
   16'h4358 : cmd_num <= #UD 6'h08;  // Type="C", Cmd="X"
   16'h4357 : cmd_num <= #UD 6'h09;  // Type="C", Cmd="W"
   16'h4345 : cmd_num <= #UD 6'h0a;  // Type="C", Cmd="E"
   16'h4355 : cmd_num <= #UD 6'h0b;  // Type="C", Cmd="U"
   16'h5642 : cmd_num <= #UD 6'h0c;  // Type="V", Cmd="B"
   16'h5649 : cmd_num <= #UD 6'h0d;  // Type="V", Cmd="I"
   16'h5652 : cmd_num <= #UD 6'h0e;  // Type="V", Cmd="R"
   16'h4353 : cmd_num <= #UD 6'h0f;  // Type="C", Cmd="S"
   16'h4351 : cmd_num <= #UD 6'h10;  // Type="C", Cmd="Q"
   16'h435a : cmd_num <= #UD 6'h11;  // Type="C", Cmd="Z"
   16'h5651 : cmd_num <= #UD 6'h12;  // Type="V", Cmd="Q"
   16'h565a : cmd_num <= #UD 6'h13;  // Type="V", Cmd="Z"
   16'h434e : cmd_num <= #UD 6'h14;  // Type="C", Cmd="N"
   16'h4343 : cmd_num <= #UD 6'h15;  // Type="C", Cmd="C"

   // Read command  cmd_num[5]=1
   16'h4366 : cmd_num <= #UD 6'h20;  // Type="C", Cmd="f"
   16'h4362 : cmd_num <= #UD 6'h21;  // Type="C", Cmd="b"
   16'h4367 : cmd_num <= #UD 6'h22;  // Type="C", Cmd="g"
   16'h4370 : cmd_num <= #UD 6'h23;  // Type="C", Cmd="p"
   16'h4379 : cmd_num <= #UD 6'h24;  // Type="C", Cmd="y"
   16'h436f : cmd_num <= #UD 6'h25;  // Type="C", Cmd="o"
   16'h4376 : cmd_num <= #UD 6'h26;  // Type="C", Cmd="v"
   16'h5662 : cmd_num <= #UD 6'h27;  // Type="V", Cmd="b"
   16'h5669 : cmd_num <= #UD 6'h28;  // Type="V", Cmd="i"
   16'h5672 : cmd_num <= #UD 6'h29;  // Type="V", Cmd="r"
   16'h4361 : cmd_num <= #UD 6'h2a;  // Type="C", Cmd="a"
   16'h4373 : cmd_num <= #UD 6'h2b;  // Type="C", Cmd="s"
   16'h4371 : cmd_num <= #UD 6'h2c;  // Type="C", Cmd="q"
   16'h5671 : cmd_num <= #UD 6'h2d;  // Type="V", Cmd="q"
   16'h436e : cmd_num <= #UD 6'h2e;  // Type="C", Cmd="n"

   default  : cmd_num <= #UD 6'h00;
 endcase
 end
 else if (xl_mode) begin             // Command for XL
 case(rcv_typ_cmd)
   // Set command  cmd_num[5]=0
   16'h5846 : cmd_num <= #UD 6'h01;  // Type="X", Cmd="F"
   16'h5842 : cmd_num <= #UD 6'h02;  // Type="X", Cmd="B"
   16'h5847 : cmd_num <= #UD 6'h03;  // Type="X", Cmd="G"
   16'h5850 : cmd_num <= #UD 6'h04;  // Type="X", Cmd="P"
   16'h5859 : cmd_num <= #UD 6'h05;  // Type="X", Cmd="Y"
   16'h584f : cmd_num <= #UD 6'h06;  // Type="X", Cmd="O"
   16'h584c : cmd_num <= #UD 6'h07;  // Type="X", Cmd="L"
   16'h5858 : cmd_num <= #UD 6'h08;  // Type="X", Cmd="X"
   16'h5857 : cmd_num <= #UD 6'h09;  // Type="X", Cmd="W"
   16'h5845 : cmd_num <= #UD 6'h0a;  // Type="X", Cmd="E"
   16'h5855 : cmd_num <= #UD 6'h0b;  // Type="X", Cmd="U"
   16'h5942 : cmd_num <= #UD 6'h0c;  // Type="Y", Cmd="B"
   16'h5949 : cmd_num <= #UD 6'h0d;  // Type="Y", Cmd="I"
   16'h5952 : cmd_num <= #UD 6'h0e;  // Type="Y", Cmd="R"
   16'h5853 : cmd_num <= #UD 6'h0f;  // Type="X", Cmd="S"
   16'h5851 : cmd_num <= #UD 6'h10;  // Type="X", Cmd="Q"
   16'h585a : cmd_num <= #UD 6'h11;  // Type="X", Cmd="Z"
   16'h5951 : cmd_num <= #UD 6'h12;  // Type="Y", Cmd="Q"
   16'h595a : cmd_num <= #UD 6'h13;  // Type="Y", Cmd="Z"
   16'h584e : cmd_num <= #UD 6'h14;  // Type="X", Cmd="N"
   16'h5843 : cmd_num <= #UD 6'h15;  // Type="X", Cmd="C"

   // Read command  cmd_num[5]=1
   16'h5866 : cmd_num <= #UD 6'h20;  // Type="X", Cmd="f"
   16'h5862 : cmd_num <= #UD 6'h21;  // Type="X", Cmd="b"
   16'h5867 : cmd_num <= #UD 6'h22;  // Type="X", Cmd="g"
   16'h5870 : cmd_num <= #UD 6'h23;  // Type="X", Cmd="p"
   16'h5879 : cmd_num <= #UD 6'h24;  // Type="X", Cmd="y"
   16'h586f : cmd_num <= #UD 6'h25;  // Type="X", Cmd="o"
   16'h5876 : cmd_num <= #UD 6'h26;  // Type="X", Cmd="v"
   16'h5962 : cmd_num <= #UD 6'h27;  // Type="Y", Cmd="b"
   16'h5969 : cmd_num <= #UD 6'h28;  // Type="Y", Cmd="i"
   16'h5972 : cmd_num <= #UD 6'h29;  // Type="Y", Cmd="r"
   16'h5861 : cmd_num <= #UD 6'h2a;  // Type="X", Cmd="a"
   16'h5873 : cmd_num <= #UD 6'h2b;  // Type="X", Cmd="s"
   16'h5871 : cmd_num <= #UD 6'h2c;  // Type="X", Cmd="q"
   16'h5971 : cmd_num <= #UD 6'h2d;  // Type="Y", Cmd="q"
   16'h586e : cmd_num <= #UD 6'h2e;  // Type="X", Cmd="n"

   default  : cmd_num <= #UD 6'h00;
 endcase
 end
end

// rx_pnum  8bit
always @(posedge clk) 
begin
 if (rst) begin
   rx_pnum <= #UD 8'd0;
 end else if((cmd_num == 6'h04) | (cmd_num == 6'h0e)) begin
   rx_pnum <= #UD 8'd126;
 end else if((cmd_num == 6'h10) | (cmd_num == 6'h12)) begin
   rx_pnum <= #UD 8'd30;
 end else begin
   rx_pnum <= #UD 8'd0;
 end
end

// rx_pcnt  8bit
always @(posedge clk) 
begin
 if (rst | (st_cmd != ST_CMD_P0))
   rx_pcnt <= #UD 8'd0;
 else if(rx_vld & (st_cmd == ST_CMD_P0) & ~rx_pcnt[7])
   rx_pcnt <= #UD rx_pcnt + 8'd1;
end

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
                 (f_parity_error == 1'b0) & (chk_sum == dec_sum) & (cmd_num != 6'h00);
 end
end

// emb_cmd
always @(posedge clk) 
begin
 if (rst) begin
   emb_cmd <= #UD 1'b0;
 end else if (cmd_cr_vld) begin
   emb_cmd <= #UD (rcv_typ == 8'h45);  // Type="E"
 end
end

// emb_cmd_rcv_ok_a
assign emb_cmd_rcv_ok_a = (rcv_stx == STX) & (rcv_etx == ETX) & (rcv_cr == CR) &
                          (f_parity_error == 1'b0) & (chk_sum == dec_sum) & (rcv_typ == 8'h45);

// emb_cmd_rcv_ok
always @(posedge clk) 
begin
 if (rst) begin
   emb_cmd_rcv_ok <= #UD 1'b0;
 end else if (cmd_cr_vld) begin
   emb_cmd_rcv_ok <= #UD emb_cmd_rcv_ok_a;
 end
end

// m5_cmd
always @(posedge clk) 
begin
 if (rst) begin
   m5_cmd <= #UD 1'b0;
 end else if (cmd_cr_vld) begin
   m5_cmd <= #UD (rcv_typ == 8'h4d);  // Type="M"
 end
end

// m5_cmd_rcv_ok_a
assign m5_cmd_rcv_ok_a = (rcv_stx == STX) & (rcv_etx == ETX) & (rcv_cr == CR) &
                         (f_parity_error == 1'b0) & (chk_sum == dec_sum) & (rcv_typ == 8'h4d);

// m5_cmd_rcv_ok
always @(posedge clk) 
begin
 if (rst) begin
   m5_cmd_rcv_ok <= #UD 1'b0;
 end else if (cmd_cr_vld) begin
   m5_cmd_rcv_ok <= #UD m5_cmd_rcv_ok_a;
 end
end

// exe_req
always @(posedge clk) 
begin
 if (rst) begin
   exe_req <= #UD 1'b0;
 end else begin
   exe_req <= #UD cmd_cr_vld;
 end
end

// exe_typ -- exe_p0  8bit,  exe_cmd_num  6bit
always @(posedge clk) 
begin
 if (rst) begin
   exe_typ <= #UD 8'd0;
   exe_adh <= #UD 8'd0;
   exe_adv <= #UD 8'd0;
   exe_cmd <= #UD 8'd0;
   exe_p5  <= #UD 8'd0;
   exe_p4  <= #UD 8'd0;
   exe_p3  <= #UD 8'd0;
   exe_p2  <= #UD 8'd0;
   exe_p1  <= #UD 8'd0;
   exe_p0  <= #UD 8'd0;
   exe_cmd_num <= #UD 6'd0;
 end else if (cmd_cr_vld) begin
   exe_typ <= #UD rcv_typ;
   exe_adh <= #UD rcv_adh;
   exe_adv <= #UD rcv_adv;
   exe_cmd <= #UD rcv_cmd;
   exe_p5  <= #UD rcv_p5;
   exe_p4  <= #UD rcv_p4;
   exe_p3  <= #UD rcv_p3;
   exe_p2  <= #UD rcv_p2;
   exe_p1  <= #UD rcv_p1;
   exe_p0  <= #UD rcv_p0;
   exe_cmd_num <= #UD cmd_num;
 end
end

// emb_tx_req
always @(posedge clk) 
begin
 if (rst) begin
   emb_tx_req <= #UD 1'b0;
 end else begin
   emb_tx_req <= #UD cmd_cr_vld & emb_cmd_rcv_ok_a;
 end
end

// emb_tx_data  80bit
always @(posedge clk) 
begin
 if (rst) begin
   emb_tx_data <= #UD 80'd0;
 end else if (cmd_cr_vld) begin
   emb_tx_data <= #UD emb_cmd_rcv_ok_a ?
   {rcv_typ, rcv_adh, rcv_adv, rcv_cmd, rcv_p5, rcv_p4, rcv_p3, rcv_p2, rcv_p1, rcv_p0} : 80'd0;
 end
end

// m5_tx_req
always @(posedge clk) 
begin
 if (rst) begin
   m5_tx_req <= #UD 1'b0;
 end else begin
   m5_tx_req <= #UD cmd_cr_vld & m5_cmd_rcv_ok_a;
 end
end

// m5_tx_data  80bit
always @(posedge clk) 
begin
 if (rst) begin
   m5_tx_data <= #UD 80'd0;
 end else if (cmd_cr_vld) begin
   m5_tx_data <= #UD m5_cmd_rcv_ok_a ?
   {rcv_typ, rcv_adh, rcv_adv, rcv_cmd, rcv_p5, rcv_p4, rcv_p3, rcv_p2, rcv_p1, rcv_p0} : 80'd0;
 end
end

// cmd_ram_wa  8bit counter
always @(posedge clk) 
begin
 if (rst | ~((st_cmd == ST_CMD_P1) | (st_cmd == ST_CMD_P0)))
   cmd_ram_wa <= #UD 8'd0;
 else if(cmd_ram_we)
   cmd_ram_wa <= #UD cmd_ram_wa + 8'd1;
end

// cmd_ram_we
assign cmd_ram_we = ((st_cmd == ST_CMD_P1) | (st_cmd == ST_CMD_P0)) &
                    ((cmd_num == 6'h04) | (cmd_num == 6'h0e)) & rx_vld & ~cmd_ram_wa[7];

// 8bit x 128 ram module
uart_ram_mpc  cmd_ram_mpc(
  .clk    (clk),
  .d      (rx_data),
  .a      (cmd_ram_wa[6:0]),
  .we     (cmd_ram_we),
  .dpra   (cmd_ram_ra),
  .dpo    (cmd_ram_doa)
);

// cmd_ram_do  8bit
always @(posedge clk) 
begin
 if (rst) begin
   cmd_ram_do <= #UD 8'd0;
 end else begin
   cmd_ram_do <= #UD cmd_ram_doa;
 end
end


// COM Buffer write control

// cmd_com_buf_write
always @(posedge clk) 
begin
   cmd_com_buf_write <= #UD (cmd_num == 6'h10) | (cmd_num == 6'h12);
end

// dec_p5, dec_p4  4bit
assign dec_p5 = ascii_dec(rcv_p5);
assign dec_p4 = ascii_dec(rcv_p4);

// com_wa  9bit counter
always @(posedge clk) 
begin
 if (rst | ~cmd_com_buf_write)
   com_wa <= #UD 9'd0;
 else if(~((st_cmd == ST_CMD_P1) | (st_cmd == ST_CMD_P0)))
   com_wa <= #UD {1'b0, dec_p5, dec_p4};
 else if(com_cnt_ce)
   com_wa <= #UD com_wa + 9'd1;
end

// com_wb  6bit counter
always @(posedge clk) 
begin
 if ((rst | ~cmd_com_buf_write) | ~((st_cmd == ST_CMD_P1) | (st_cmd == ST_CMD_P0)))
   com_wb <= #UD 6'd0;
 else if(com_cnt_ce)
   com_wb <= #UD com_wb + 6'd1;
end

// com_cnt_ce
assign com_cnt_ce = ((st_cmd == ST_CMD_P1) | (st_cmd == ST_CMD_P0)) & rx_vld &
                    ~(com_wa[8] | com_wb[5]);

// cmd_com_buf_we
always @(posedge clk) 
begin
   cmd_com_buf_we <= #UD com_cnt_ce;
end

// cmd_com_buf_wa  8bit
always @(posedge clk) 
begin
   cmd_com_buf_wa <= #UD com_wa[7:0];
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
   ST_TX_IDLE :st_tx <= #UD (rsp_req)? ST_TX_STX :ST_TX_IDLE;
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
   ST_TX_P0   :st_tx <= #UD (tx_done & (tx_pcnt == tx_pnum))? ST_TX_CS1 :ST_TX_P0;
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
   ST_TX_IDLE :tx_vld <= #UD (rsp_req);
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

// tx_data_typ -- tx_data_p0  8bit
assign tx_data_typ = (emb_cmd_rcv_ok | m5_cmd_rcv_ok) ? rsp_data[79:72] : exe_typ;
assign tx_data_adh = (emb_cmd_rcv_ok | m5_cmd_rcv_ok) ? rsp_data[71:64] : exe_adh;
assign tx_data_adv = (emb_cmd_rcv_ok | m5_cmd_rcv_ok) ? rsp_data[63:56] : exe_adv;
assign tx_data_cmd = (emb_cmd_rcv_ok | m5_cmd_rcv_ok) ? rsp_data[55:48] : 
                     (exe_cmd == 8'h51) ? 8'h71 : (exe_cmd == 8'h71) ? 8'h51 : exe_cmd;
assign tx_data_p5  = rsp_data[47:40];
assign tx_data_p4  = rsp_data[39:32];
assign tx_data_p3  = rsp_data[31:24];
assign tx_data_p2  = rsp_data[23:16];
assign tx_data_p1  = rsp_data[15: 8];
assign tx_data_p0  = rsp_data[ 7: 0];

// tx_data  8bit
always @(posedge clk)
begin
 if (rst) begin
   tx_data <= #UD 8'd0;
 end else if (tx_brk) begin
   tx_data <= #UD 8'd0;
 end else case (st_tx)
   ST_TX_IDLE : tx_data <= #UD (rsp_req)? STX : 8'd0;
   ST_TX_STX  : tx_data <= #UD tx_data_typ;
   ST_TX_TYP  : tx_data <= #UD tx_data_adh;
   ST_TX_ADH  : tx_data <= #UD tx_data_adv;
   ST_TX_ADV  : tx_data <= #UD tx_data_cmd;
   ST_TX_CMD  : tx_data <= #UD tx_data_p5;
   ST_TX_P5   : tx_data <= #UD tx_data_p4;
   ST_TX_P4   : tx_data <= #UD tx_data_p3;
   ST_TX_P3   : tx_data <= #UD tx_data_p2;
   ST_TX_P2   : tx_data <= #UD tx_data_p1;
   ST_TX_P1   : tx_data <= #UD tx_data_p0;
   ST_TX_P0   : tx_data <= #UD (tx_pcnt == tx_pnum)? enc_sum_msb : tx_data_p0;
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
   ST_TX_TYP  : tx_sum <= #UD tx_data_adh;
   ST_TX_ADH  : tx_sum <= #UD (tx_done)? tx_sum + tx_data_adv : tx_sum;
   ST_TX_ADV  : tx_sum <= #UD (tx_done)? tx_sum + tx_data_cmd : tx_sum;
   ST_TX_CMD  : tx_sum <= #UD (tx_done)? tx_sum + tx_data_p5 : tx_sum;
   ST_TX_P5   : tx_sum <= #UD (tx_done)? tx_sum + tx_data_p4 : tx_sum;
   ST_TX_P4   : tx_sum <= #UD (tx_done)? tx_sum + tx_data_p3 : tx_sum;
   ST_TX_P3   : tx_sum <= #UD (tx_done)? tx_sum + tx_data_p2 : tx_sum;
   ST_TX_P2   : tx_sum <= #UD (tx_done)? tx_sum + tx_data_p1 : tx_sum;
   ST_TX_P1   : tx_sum <= #UD (tx_done)? tx_sum + tx_data_p0 : tx_sum;
   ST_TX_P0   : tx_sum <= #UD (tx_done & ~(tx_pcnt == tx_pnum))? tx_sum + tx_data_p0 : tx_sum;
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

// tx_pnum  8bit
always @(posedge clk) 
begin
 if (rst) begin
   tx_pnum <= #UD 8'd0;
 end else if((exe_cmd_num == 6'h23) | (exe_cmd_num == 6'h29) |
             (m5_cmd & (exe_cmd == 8'h64))                      // M5 Detail Read Command
            ) begin
   tx_pnum <= #UD 8'd126;
 end else if((exe_cmd_num == 6'h2c) | (exe_cmd_num == 6'h2d)) begin
   tx_pnum <= #UD 8'd30;
 end else begin
   tx_pnum <= #UD 8'd0;
 end
end

// tx_pcnt  8bit
always @(posedge clk) 
begin
 if (rst | (st_tx != ST_TX_P0))
   tx_pcnt <= #UD 8'd0;
 else if(tx_done & (st_tx == ST_TX_P0) & ~tx_pcnt[7])
   tx_pcnt <= #UD tx_pcnt + 8'd1;
end

// rsp_done
always @(posedge clk) 
begin
 if (rst) begin
   rsp_done <= #UD 1'b0;
 end else begin
   rsp_done <= #UD (st_tx == ST_TX_CR) & tx_done;
 end
end

// rsp_ram_re
always @(posedge clk) 
begin
 if (rst) begin
   rsp_ram_re <= #UD 1'b0;
 end else begin
   rsp_ram_re <= #UD ((st_tx == ST_TX_P2) | (st_tx == ST_TX_P1) |
                      ((st_tx == ST_TX_P0) & (tx_pcnt != tx_pnum))) & ~m5_cmd;
 end
end

// m5_rsp_ram_re
always @(posedge clk) 
begin
 if (rst) begin
   m5_rsp_ram_re <= #UD 1'b0;
 end else begin
   m5_rsp_ram_re <= #UD ((st_tx == ST_TX_P2) | (st_tx == ST_TX_P1) |
                         ((st_tx == ST_TX_P0) & (tx_pcnt != tx_pnum))) & m5_cmd;
 end
end

endmodule
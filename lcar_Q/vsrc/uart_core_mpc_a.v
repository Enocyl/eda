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
// UART CORE
//
// [txd/rxd format]
//      ___     ___ ___ ___ ___ ___ ___ ___ ___ ___ _____
//  xxd    \_s_X_0_X_1_X_2_X_3_X_4_X_5_X_6_X_7_X_p_X e 
//           
//  *s = start bit, p = parity bit, e = stop bit
// ---------------------------------------------------------------------------------
//  [rx i/f]
// 
//  clk ..... ___/~~~\___/~~~\___/~~~\_........__/~~~\___/~~~\___/~~~\___/~~~\___/~
// 
//  rx_vld .. ___/~~~~~~~\_____________........__________/~~~~~~~\_________________
//            ___ _____________________........__________ _________________________
//  rx_data . ___X Valid ______________........__________X Valid __________________
//            ___ _____________________........__________ _________________________
//  rx_err  . ___X Valid ______________........__________X Valid __________________
//            ___ _____________________........__________ _________________________
//  rx_brk  . ___X Valid ______________........__________X Valid __________________
// 
//  *. After detect a frame error, it cancel the receive operation until RXD 
//     maintain 1 during in frame period.
//  *. The rx_err is constructed by frame_error and parity_error.
//     Parity checking is performed on a normal frame.
//     Because signal parity_error is indicate result of parity check of
//     normal frame, it become 0 in case of frame error.
//     It means the frame_error and parity_error are not become 1 in same time.
// --------------------------------------------------------------------------------
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
//
//  Aug 2011
//  modified by amano@pti
//  module name : uart_core -> uart_core_mpc
//
//  Mar 2013
//  module name : uart_core_mpc -> uart_core_mpc_a
//  changed the sub-module : uart_rx -> uart_rx_a
//
// =================================================================================================

module	uart_core_mpc_a (
	clk,		// clock
	rst,		// reset

	txd,		// transmit port
	rxd,		// receive port

	tx_vld,		// send data valid
	tx_data,	// send data
	tx_busy,	// send busy
	tx_done,	// send done
	tx_brk,		// send break

	rx_vld,		// receive data valid
	rx_data,	// receive data
	rx_frm_err,	// framing error
	rx_prty_err,	// parity error
	rx_brk,		// receive break

	prtysel,	// parity select
	stpsel, 	// stop bit select
	brdsel 		// baud rate select
);

//--------------------------------------------------------------------------------
// parameter define
//--------------------------------------------------------------------------------
parameter  UD  = 'd1;
parameter  DBN = 3;
parameter  DBW = 1 << DBN;

//--------------------------------------------------------------------------------
// port declaration
//--------------------------------------------------------------------------------
input			rst;

input			clk;
// parameter		TC_CLK_HZ  = 72_000_000; // 72MHz
			////////////////////////////////////////////////
			// Because the baud rate depend on TC_CLK_HZ, //
			// it must set to real frequency value.       //
			////////////////////////////////////////////////

output			txd;
input			rxd;
input			tx_vld;
input	[DBW-1:0]	tx_data;
output			tx_busy;
output			tx_done;
input 			tx_brk;

output			rx_vld;
output	[DBW-1:0]	rx_data;
output			rx_frm_err;
output			rx_prty_err;
output			rx_brk;

input	[1:0]		prtysel;// parity
				// 0x ... none
				// 10 ... even
				// 11 ... odd

input	     		stpsel; // stop bit
				// 0 ... 1bit
				// 1 ... 2bit

input	[1:0]		brdsel; // baud rate
				// 00 ... 9600
				// 01 ... 57600
				// 1x ... 115200

//--------------------------------------------------------------------------------
// reg,wire declaration
//--------------------------------------------------------------------------------
reg 	[12:0]		tc_ckdiv;
parameter		TC_9600    = 13'h1d4b;  // 7500 - 1 = 7499
parameter		TC_57600   = 13'h04e1;  // 1250 - 1 = 1249
parameter		TC_115200  = 13'h0270;  //  625 - 1 =  624

//--------------------------------------------------------------------------------
// circuit description
//--------------------------------------------------------------------------------

always @(brdsel)
begin
 case (brdsel)
    2'd0:tc_ckdiv = TC_9600;
    2'd1:tc_ckdiv = TC_57600;
    2'd2:tc_ckdiv = TC_115200;
    2'd3:tc_ckdiv = TC_115200;
 default:tc_ckdiv = TC_9600;
 endcase
end

uart_tx i_uart_tx (
	.rst	  (rst	   ),
	.clk	  (clk	   ),
	.txd	  (txd	   ),
	.tx_vld	  (tx_vld  ),
	.tx_data  (tx_data ),
	.tx_busy  (tx_busy ),
	.tx_done  (tx_done ),
	.tx_brk	  (tx_brk  ),
	.prtysel  (prtysel ),
	.stpsel	  (stpsel  ),
	.tc_ckdiv (tc_ckdiv)
);

uart_rx_a i_uart_rx_a (
	.rst	     (rst	  ),
	.clk	     (clk	  ),
	.rxd	     (rxd	  ),
	.rx_vld	     (rx_vld	  ),
	.rx_data     (rx_data 	  ),
	.rx_frm_err  (rx_frm_err  ),
	.rx_prty_err (rx_prty_err ),
	.rx_brk	     (rx_brk	  ),
	.prtysel     (prtysel 	  ),
	.stpsel	     (stpsel  	  ),
	.tc_ckdiv    (tc_ckdiv	  )
);

endmodule

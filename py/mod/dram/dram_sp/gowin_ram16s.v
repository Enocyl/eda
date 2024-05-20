//Copyright (C)2014-2022 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.8.05
//Part Number: GW2A-LV55UG324DC7/I6
//Device: GW2A-55
//Created Time: Wed Jul 27 10:13:55 2022

module Gowin_RAM16S (dout, di, ad, wre, clk);

output [0:0] dout;
input [0:0] di;
input [0:0] ad;
input wre;
input clk;

wire gw_gnd;

assign gw_gnd = 1'b0;

RAM16S1 ram16s_inst_0 (
    .DO(dout[0]),
    .DI(di[0]),
    .AD({gw_gnd,gw_gnd,gw_gnd,ad[0]}),
    .WRE(wre),
    .CLK(clk)
);

endmodule //Gowin_RAM16S

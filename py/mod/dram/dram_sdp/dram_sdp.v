//Copyright (C)2014-2022 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.8.05
//Part Number: GW2A-LV55UG324DC7/I6
//Device: GW2A-55
//Created Time: Thu Jul 28 09:45:39 2022

module dram_sdp (dout, di, wad, rad, wre, clk);

output [0:0] dout;
input [0:0] di;
input [0:0] wad;
input [0:0] rad;
input wre;
input clk;

wire gw_gnd;

assign gw_gnd = 1'b0;

RAM16SDP1 ram16sdp_inst_0 (
    .DO(dout[0]),
    .DI(di[0]),
    .WAD({gw_gnd,gw_gnd,gw_gnd,wad[0]}),
    .RAD({gw_gnd,gw_gnd,gw_gnd,rad[0]}),
    .WRE(wre),
    .CLK(clk)
);

endmodule //dram_sdp

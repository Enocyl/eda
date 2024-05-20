//Copyright (C)2014-2022 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.8.05
//Part Number: GW2A-LV55UG324DC7/I6
//Device: GW2A-55
//Created Time: Thu Jul 28 09:45:39 2022

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    dram_sdp your_instance_name(
        .dout(dout_o), //output [0:0] dout
        .di(di_i), //input [0:0] di
        .wad(wad_i), //input [0:0] wad
        .rad(rad_i), //input [0:0] rad
        .wre(wre_i), //input wre
        .clk(clk_i) //input clk
    );

//--------Copy end-------------------

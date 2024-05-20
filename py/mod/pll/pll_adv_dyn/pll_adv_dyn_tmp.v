//Copyright (C)2014-2022 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.8.05
//Part Number: GW2A-LV55UG324DC7/I6
//Device: GW2A-55
//Created Time: Fri Jul 29 15:27:47 2022

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    PLL_ADV your_instance_name(
        .clkout(clkout_o), //output clkout
        .lock(lock_o), //output lock
        .clkoutp(clkoutp_o), //output clkoutp
        .clkoutd(clkoutd_o), //output clkoutd
        .clkoutd3(clkoutd3_o), //output clkoutd3
        .reset(reset_i), //input reset
        .clkin(clkin_i), //input clkin
        .clkfb(clkfb_i), //input clkfb
        .fbdsel(fbdsel_i), //input [5:0] fbdsel
        .idsel(idsel_i), //input [5:0] idsel
        .odsel(odsel_i), //input [5:0] odsel
        .psda(psda_i), //input [3:0] psda
        .dutyda(dutyda_i), //input [3:0] dutyda
        .fdly(fdly_i) //input [3:0] fdly
    );

//--------Copy end-------------------

//Copyright (C)2014-2022 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.8.05
//Part Number: GW2A-LV55UG324DC7/I6
//Device: GW2A-55
//Created Time: Fri Jul 29 15:27:47 2022

module PLL_ADV (clkout, lock, clkoutp, clkoutd, clkoutd3, reset, clkin, clkfb, fbdsel, idsel, odsel, psda, dutyda, fdly);

output clkout;
output lock;
output clkoutp;
output clkoutd;
output clkoutd3;
input reset;
input clkin;
input clkfb;
input [5:0] fbdsel;
input [5:0] idsel;
input [5:0] odsel;
input [3:0] psda;
input [3:0] dutyda;
input [3:0] fdly;

wire gw_gnd;

assign gw_gnd = 1'b0;

rPLL rpll_inst (
    .CLKOUT(clkout),
    .LOCK(lock),
    .CLKOUTP(clkoutp),
    .CLKOUTD(clkoutd),
    .CLKOUTD3(clkoutd3),
    .RESET(reset),
    .RESET_P(gw_gnd),
    .CLKIN(clkin),
    .CLKFB(clkfb),
    .FBDSEL(fbdsel),
    .IDSEL(idsel),
    .ODSEL(odsel),
    .PSDA(psda),
    .DUTYDA(dutyda),
    .FDLY(fdly)
);

defparam rpll_inst.FCLKIN = "125";
defparam rpll_inst.DYN_IDIV_SEL = "true";
defparam rpll_inst.IDIV_SEL = 0;
defparam rpll_inst.DYN_FBDIV_SEL = "true";
defparam rpll_inst.FBDIV_SEL = 1;
defparam rpll_inst.DYN_ODIV_SEL = "true";
defparam rpll_inst.ODIV_SEL = 2;
defparam rpll_inst.PSDA_SEL = "0000";
defparam rpll_inst.DYN_DA_EN = "true";
defparam rpll_inst.DUTYDA_SEL = "1000";
defparam rpll_inst.CLKOUT_FT_DIR = 1'b1;
defparam rpll_inst.CLKOUTP_FT_DIR = 1'b1;
defparam rpll_inst.CLKOUT_DLY_STEP = 0;
defparam rpll_inst.CLKOUTP_DLY_STEP = 0;
defparam rpll_inst.CLKFB_SEL = "external";
defparam rpll_inst.CLKOUT_BYPASS = "false";
defparam rpll_inst.CLKOUTP_BYPASS = "false";
defparam rpll_inst.CLKOUTD_BYPASS = "false";
defparam rpll_inst.DYN_SDIV_SEL = 2;
defparam rpll_inst.CLKOUTD_SRC = "CLKOUT";
defparam rpll_inst.CLKOUTD3_SRC = "CLKOUT";
defparam rpll_inst.DEVICE = "GW2A-55";

endmodule //PLL_ADV

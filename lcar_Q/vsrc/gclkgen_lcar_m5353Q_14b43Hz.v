module gclkgen_lcar_m5353Q_14b43Hz(BLANK, 
                                   CLK25M, 
                                   CLK31M, 
                                   C_DONE, 
                                   M4_SET_DONE, 
                                   OVP, 
                                   CLK125M_SS, 
                                   GCLK, 
                                   GCLKOUT_START, 
                                   XGCLK, 
                                   XGCLK60_DCM_RST);

    input BLANK;
    input CLK25M;
    input CLK31M;
    input C_DONE;
    input M4_SET_DONE;
    input OVP;
   output CLK125M_SS;
   output GCLK;
   output GCLKOUT_START;
   output XGCLK;
   output XGCLK60_DCM_RST;
   
   wire CLK125M_SSCG;
   wire [2:1] DCM_SS_ST;
   wire [7:0] DCM60_ST;
   wire F50HZ;
   wire XLXN_151;
   wire XLXN_155;
   wire XLXN_159;
   wire XLXN_162;
   wire XLXN_354;
   wire XLXN_355;
   wire XLXN_362;
   wire XLXN_367;
   wire XLXN_368;
   wire XGCLK60_DCM_RST_DUMMY;
   wire CLK125M_SS_DUMMY;
   wire XGCLK_DUMMY;
   
   assign CLK125M_SS = CLK125M_SS_DUMMY;
   assign XGCLK = XGCLK_DUMMY;
   assign XGCLK60_DCM_RST = XGCLK60_DCM_RST_DUMMY;
   DCM_CLKGEN #( .SPREAD_SPECTRUM("CENTER_HIGH_SPREAD"), .CLKIN_PERIOD(32.0), 
         .CLKFX_MULTIPLY(8), .CLKFX_MD_MAX(4.000), .CLKFX_DIVIDE(2), 
         .CLKFXDV_DIVIDE(2), .STARTUP_WAIT("FALSE") ) DCM_CLK125M_SS 
         (.CLKIN(CLK31M), 
                              .FREEZEDCM(XLXN_354), 
                              .PROGCLK(XLXN_354), 
                              .PROGDATA(XLXN_354), 
                              .PROGEN(XLXN_354), 
                              .RST(XLXN_355), 
                              .CLKFX(CLK125M_SSCG), 
                              .CLKFXDV(), 
                              .CLKFX180(), 
                              .LOCKED(XLXN_367), 
                              .PROGDONE(), 
                              .STATUS(DCM_SS_ST[2:1]));
   DCM_SP #( .CLKIN_PERIOD(8.0), .CLK_FEEDBACK("NONE"), .CLKFX_MULTIPLY(4), 
         .CLKFX_DIVIDE(10), .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), 
         .CLKDV_DIVIDE(2.0), .CLKIN_DIVIDE_BY_2("FALSE"), 
         .CLKOUT_PHASE_SHIFT("NONE"), .DFS_FREQUENCY_MODE("LOW"), 
         .DLL_FREQUENCY_MODE("LOW"), .DSS_MODE("NONE"), 
         .DUTY_CYCLE_CORRECTION("TRUE"), .PHASE_SHIFT(0), 
         .STARTUP_WAIT("FALSE"), .FACTORY_JF(16'hC080) ) DCM_SP_XGCLK60 
         (.CLKFB(XLXN_162), 
                          .CLKIN(CLK125M_SS_DUMMY), 
                          .DSSEN(XLXN_162), 
                          .PSCLK(XLXN_162), 
                          .PSEN(XLXN_162), 
                          .PSINCDEC(XLXN_162), 
                          .RST(XLXN_151), 
                          .CLKDV(), 
                          .CLKFX(XGCLK_DUMMY), 
                          .CLKFX180(), 
                          .CLK0(), 
                          .CLK2X(), 
                          .CLK2X180(), 
                          .CLK90(), 
                          .CLK180(), 
                          .CLK270(), 
                          .LOCKED(XLXN_159), 
                          .PSDONE(), 
                          .STATUS(DCM60_ST[7:0]));
   gclkout_lcar_m5353Q_14b43Hz  gclkout_0 (.blank(BLANK), 
                                          .clk(CLK25M), 
                                          .c_done(C_DONE), 
                                          .f50hz(F50HZ), 
                                          .m4_set_done(M4_SET_DONE), 
                                          .ovp(OVP), 
                                          .xgclk(XGCLK_DUMMY), 
                                          .gclk(GCLK), 
                                          .gclkout_start(GCLKOUT_START));
   GND  XLXI_85 (.G(XLXN_162));
   OR2B1  XLXI_86 (.I0(C_DONE), 
                  .I1(XGCLK60_DCM_RST_DUMMY), 
                  .O(XLXN_151));
   dcm_rst_mpc  XLXI_87 (.clk(CLK25M), 
                        .clkin_stop(DCM60_ST[2]), 
                        .c_done(C_DONE), 
                        .f59hz(XLXN_155), 
                        .locked(XLXN_159), 
                        .ovp(OVP), 
                        .dcm_rst(XGCLK60_DCM_RST_DUMMY));
   GND  XLXI_88 (.G(XLXN_155));
   GND  XLXI_169 (.G(XLXN_354));
   OR2B1  XLXI_170 (.I0(C_DONE), 
                   .I1(XLXN_368), 
                   .O(XLXN_355));
   dcm_rst_mpc  XLXI_171 (.clk(CLK25M), 
                         .clkin_stop(DCM_SS_ST[2]), 
                         .c_done(C_DONE), 
                         .f59hz(XLXN_362), 
                         .locked(XLXN_367), 
                         .ovp(OVP), 
                         .dcm_rst(XLXN_368));
   GND  XLXI_172 (.G(XLXN_362));
   BUFG  XLXI_175 (.I(CLK125M_SSCG), 
                  .O(CLK125M_SS_DUMMY));
endmodule

module video_proc(BRIGHTNESS, 
                  CHECK, 
                  CLK, 
                  CT_BLUE, 
                  CT_GREEN, 
                  CT_RED, 
                  FM_CYCLE_STP_ADV, 
                  FM_IV_WR_CYCLE, 
                  FM_OV_RD_CYCLE, 
                  FM_RD_D, 
                  FRAME_ALT, 
                  FRAME_ALT_FRZ, 
                  GAMMA, 
                  M4_BRT, 
                  M4_ON, 
                  OVP, 
                  PANEL_SEL, 
                  FM_IN_RD_BLUE, 
                  FM_IN_RD_GREEN, 
                  FM_IN_RD_RED, 
                  FM_IN_VID_RD_ADRS, 
                  FM_IV_RD_CYCLE, 
                  FM_M4_CF_RD_ADRS, 
                  FM_OV_WR_ADRS, 
                  FM_OV_WR_CYCLE, 
                  FM_OV_WR_D);

    input [6:0] BRIGHTNESS;
    input CHECK;
    input CLK;
    input [3:0] CT_BLUE;
    input [3:0] CT_GREEN;
    input [3:0] CT_RED;
    input FM_CYCLE_STP_ADV;
    input FM_IV_WR_CYCLE;
    input FM_OV_RD_CYCLE;
    input [29:0] FM_RD_D;
    input FRAME_ALT;
    input FRAME_ALT_FRZ;
    input [2:0] GAMMA;
    input [6:0] M4_BRT;
    input M4_ON;
    input OVP;
    input [3:0] PANEL_SEL;
   output [9:0] FM_IN_RD_BLUE;
   output [9:0] FM_IN_RD_GREEN;
   output [9:0] FM_IN_RD_RED;
   output [16:0] FM_IN_VID_RD_ADRS;
   output FM_IV_RD_CYCLE;
   output [18:0] FM_M4_CF_RD_ADRS;
   output [18:0] FM_OV_WR_ADRS;
   output FM_OV_WR_CYCLE;
   output [31:0] FM_OV_WR_D;
   
   wire [15:0] B_M4IN;
   wire [12:0] CF0D;
   wire [12:0] CF1D;
   wire [12:0] CF2D;
   wire [12:0] CF3D;
   wire [12:0] CF4D;
   wire [12:0] CF5D;
   wire [12:0] CF6D;
   wire [12:0] CF7D;
   wire [12:0] CF8D;
   wire [15:0] G_M4IN;
   wire [15:0] R_M4IN;
   wire [15:0] XLXN_1513;
   wire [15:0] XLXN_1514;
   wire [15:0] XLXN_1515;
   wire [15:0] XLXN_1670;
   wire [15:0] XLXN_1671;
   wire [15:0] XLXN_1672;
   wire [15:0] XLXN_1675;
   wire [15:0] XLXN_1676;
   wire [15:0] XLXN_1678;
   wire [15:0] XLXN_1817;
   wire [15:0] XLXN_1818;
   wire [15:0] XLXN_1819;
   wire [15:0] XLXN_2105;
   wire [15:0] XLXN_2106;
   wire [15:0] XLXN_2108;
   wire [15:0] XLXN_2127;
   wire [9:0] FM_IN_RD_BLUE_DUMMY;
   wire [9:0] FM_IN_RD_GREEN_DUMMY;
   wire [9:0] FM_IN_RD_RED_DUMMY;
   wire FM_IV_RD_CYCLE_DUMMY;
   
   assign FM_IN_RD_BLUE[9:0] = FM_IN_RD_BLUE_DUMMY[9:0];
   assign FM_IN_RD_GREEN[9:0] = FM_IN_RD_GREEN_DUMMY[9:0];
   assign FM_IN_RD_RED[9:0] = FM_IN_RD_RED_DUMMY[9:0];
   assign FM_IV_RD_CYCLE = FM_IV_RD_CYCLE_DUMMY;
   fm_in_video_read_lcar_m5353Q_14b43Hz  fm_in0 (.clk(CLK), 
                                                
         .fm_cycle_stp_adv(FM_CYCLE_STP_ADV), 
                                                
         .fm_iv_wr_cycle(FM_IV_WR_CYCLE), 
                                                
         .fm_ov_rd_cycle(FM_OV_RD_CYCLE), 
                                                .fm_rd_d(FM_RD_D[29:0]), 
                                                .frame_alt(FRAME_ALT), 
                                                .ovp(OVP), 
                                                .panel_sel(PANEL_SEL[3:0]), 
                                                
         .blue(FM_IN_RD_BLUE_DUMMY[9:0]), 
                                                .cf0d(CF0D[12:0]), 
                                                .cf1d(CF1D[12:0]), 
                                                .cf2d(CF2D[12:0]), 
                                                .cf3d(CF3D[12:0]), 
                                                .cf4d(CF4D[12:0]), 
                                                .cf5d(CF5D[12:0]), 
                                                .cf6d(CF6D[12:0]), 
                                                .cf7d(CF7D[12:0]), 
                                                .cf8d(CF8D[12:0]), 
                                                
         .fm_in_vid_rd_adrs(FM_IN_VID_RD_ADRS[16:0]), 
                                                
         .fm_iv_rd_cycle(FM_IV_RD_CYCLE_DUMMY), 
                                                
         .fm_m4_cf_rd_adrs(FM_M4_CF_RD_ADRS[18:0]), 
                                                
         .green(FM_IN_RD_GREEN_DUMMY[9:0]), 
                                                .red(FM_IN_RD_RED_DUMMY[9:0]));
   fm_out_video_write_pv2_4_4x4  fm_out0 (.b_din(XLXN_2108[15:0]), 
                                         .clk(CLK), 
                                         .fm_cycle_stp_adv(FM_CYCLE_STP_ADV), 
                                         .fm_iv_rd_cycle(FM_IV_RD_CYCLE_DUMMY), 
                                         .fm_iv_wr_cycle(FM_IV_WR_CYCLE), 
                                         .fm_ov_rd_cycle(FM_OV_RD_CYCLE), 
                                         .frame_alt(FRAME_ALT_FRZ), 
                                         .g_din(XLXN_2106[15:0]), 
                                         .ovp(OVP), 
                                         .r_din(XLXN_2105[15:0]), 
                                         .fm_ov_wr_adrs(FM_OV_WR_ADRS[18:0]), 
                                         .fm_ov_wr_cycle(FM_OV_WR_CYCLE), 
                                         .fm_ov_wr_d(FM_OV_WR_D[31:0]));
   gamma_ctemp_mpc_MUSER_video_proc  XLXI_81 (.CLK(CLK), 
                                             .CT_GAIN(CT_RED[3:0]), 
                                             .DIN(FM_IN_RD_RED_DUMMY[9:0]), 
                                             .GAMMA(GAMMA[2:0]), 
                                             .OVP(OVP), 
                                             .DOUT(XLXN_1513[15:0]));
   gamma_ctemp_mpc_MUSER_video_proc  XLXI_90 (.CLK(CLK), 
                                             .CT_GAIN(CT_GREEN[3:0]), 
                                             .DIN(FM_IN_RD_GREEN_DUMMY[9:0]), 
                                             .GAMMA(GAMMA[2:0]), 
                                             .OVP(OVP), 
                                             .DOUT(XLXN_1514[15:0]));
   gamma_ctemp_mpc_MUSER_video_proc  XLXI_91 (.CLK(CLK), 
                                             .CT_GAIN(CT_BLUE[3:0]), 
                                             .DIN(FM_IN_RD_BLUE_DUMMY[9:0]), 
                                             .GAMMA(GAMMA[2:0]), 
                                             .OVP(OVP), 
                                             .DOUT(XLXN_1515[15:0]));
   sel16  XLXI_383 (.ia(XLXN_1675[15:0]), 
                   .ib(XLXN_2127[15:0]), 
                   .s(CHECK), 
                   .o(XLXN_1817[15:0]));
   sel16  XLXI_384 (.ia(XLXN_1678[15:0]), 
                   .ib(XLXN_2127[15:0]), 
                   .s(CHECK), 
                   .o(XLXN_1818[15:0]));
   sel16  XLXI_385 (.ia(XLXN_1676[15:0]), 
                   .ib(XLXN_2127[15:0]), 
                   .s(CHECK), 
                   .o(XLXN_1819[15:0]));
   f1d16_MUSER_video_proc  XLXI_425 (.CK(CLK), 
                                    .D(XLXN_1817[15:0]), 
                                    .Q(XLXN_2105[15:0]));
   f1d16_MUSER_video_proc  XLXI_426 (.CK(CLK), 
                                    .D(XLXN_1818[15:0]), 
                                    .Q(XLXN_2106[15:0]));
   f1d16_MUSER_video_proc  XLXI_427 (.CK(CLK), 
                                    .D(XLXN_1819[15:0]), 
                                    .Q(XLXN_2108[15:0]));
   m4_mult_xt2p5_a_MUSER_video_proc  XLXI_456 (.BIN(B_M4IN[15:0]), 
                                              .CF0D(CF0D[12:0]), 
                                              .CF1D(CF1D[12:0]), 
                                              .CF2D(CF2D[12:0]), 
                                              .CF3D(CF3D[12:0]), 
                                              .CF4D(CF4D[12:0]), 
                                              .CF5D(CF5D[12:0]), 
                                              .CF6D(CF6D[12:0]), 
                                              .CF7D(CF7D[12:0]), 
                                              .CF8D(CF8D[12:0]), 
                                              .CLK(CLK), 
                                              .GIN(G_M4IN[15:0]), 
                                              .M4_ON(M4_ON), 
                                              .OVP(OVP), 
                                              .RIN(R_M4IN[15:0]), 
                                              .BOUT(XLXN_1676[15:0]), 
                                              .BR(), 
                                              .GOUT(XLXN_1678[15:0]), 
                                              .ROUT(XLXN_1675[15:0]));
   f1d16_MUSER_video_proc  XLXI_459 (.CK(CLK), 
                                    .D({M4_ON, GAMMA[2:0], CT_BLUE[3:0], 
         CT_GREEN[3:0], CT_RED[3:0]}), 
                                    .Q(XLXN_2127[15:0]));
   brightness_mpc_b  XLXI_473 (.brightness(BRIGHTNESS[6:0]), 
                              .clk(CLK), 
                              .din(XLXN_1670[15:0]), 
                              .ovp(OVP), 
                              .dout(R_M4IN[15:0]));
   brightness_mpc_b  XLXI_474 (.brightness(BRIGHTNESS[6:0]), 
                              .clk(CLK), 
                              .din(XLXN_1671[15:0]), 
                              .ovp(OVP), 
                              .dout(G_M4IN[15:0]));
   brightness_mpc_b  XLXI_475 (.brightness(BRIGHTNESS[6:0]), 
                              .clk(CLK), 
                              .din(XLXN_1672[15:0]), 
                              .ovp(OVP), 
                              .dout(B_M4IN[15:0]));
   brightness_mpc_b  XLXI_476 (.brightness(M4_BRT[6:0]), 
                              .clk(CLK), 
                              .din(XLXN_1513[15:0]), 
                              .ovp(OVP), 
                              .dout(XLXN_1670[15:0]));
   brightness_mpc_b  XLXI_477 (.brightness(M4_BRT[6:0]), 
                              .clk(CLK), 
                              .din(XLXN_1514[15:0]), 
                              .ovp(OVP), 
                              .dout(XLXN_1671[15:0]));
   brightness_mpc_b  XLXI_478 (.brightness(M4_BRT[6:0]), 
                              .clk(CLK), 
                              .din(XLXN_1515[15:0]), 
                              .ovp(OVP), 
                              .dout(XLXN_1672[15:0]));
endmodule

module output_rcv_lcar_m5353Q_14b43Hz(ADDCLK, 
                                      ADDSDA, 
                                      CLK, 
                                      CLK31M, 
                                      CLK125M, 
                                      C_DONE, 
                                      FM_CYCLE_STP, 
                                      FM_RD_D, 
                                      FRAME_ALT, 
                                      FRAME_ALT_FRZ, 
                                      FR_RATE, 
                                      F50HZ, 
                                      M4_SET_DONE, 
                                      OCLK, 
                                      RGB_OUT_ZERO, 
                                      CLK125M_SS, 
                                      CN2_D, 
                                      FM_OV_RD_ADRS, 
                                      FM_OV_RD_CYCLE, 
                                      XGCLK60_DCM_RST);

    input ADDCLK;
    input ADDSDA;
    input CLK;
    input CLK31M;
    input CLK125M;
    input C_DONE;
    input FM_CYCLE_STP;
    input [31:0] FM_RD_D;
    input FRAME_ALT;
    input FRAME_ALT_FRZ;
    input [15:0] FR_RATE;
    input F50HZ;
    input M4_SET_DONE;
    input OCLK;
    input [2:0] RGB_OUT_ZERO;
   output CLK125M_SS;
   output [27:0] CN2_D;
   output [18:0] FM_OV_RD_ADRS;
   output FM_OV_RD_CYCLE;
   output XGCLK60_DCM_RST;
   
   wire DCLK;
   wire GCLK;
   wire GCLKOUT_START;
   wire LE;
   wire [15:0] R_OUT;
   wire [3:0] SCAN_LINE;
   wire XGCLK;
   wire XLXN_6;
   wire XLXN_10;
   
   data_out_lcar_m5353Q_14b43Hz  data_out_0 (.blank(XLXN_10), 
                                            .clk(CLK125M), 
                                            .fm_cycle_stp(FM_CYCLE_STP), 
                                            .fm_rd_d(FM_RD_D[31:0]), 
                                            .frame_alt(FRAME_ALT), 
                                            .frame_alt_frz(FRAME_ALT_FRZ), 
                                            .gclkout_start(GCLKOUT_START), 
                                            .oclk(OCLK), 
                                            .rgb_out_zero(RGB_OUT_ZERO[2:0]), 
                                            .b_out(), 
                                            .b_we(), 
                                            .dclk_out(DCLK), 
                                            
         .fm_ov_rd_adrs(FM_OV_RD_ADRS[18:0]), 
                                            .fm_ov_rd_cycle(FM_OV_RD_CYCLE), 
                                            .g_out(), 
                                            .g_we(), 
                                            .le_out(LE), 
                                            .r_out(R_OUT[15:0]), 
                                            .r_we(), 
                                            .scan_line(SCAN_LINE[3:0]));
   gclkgen_lcar_m5353Q_14b43Hz_MUSER_output_rcv_lcar_m5353Q_14b43Hz  gclkgen_0 
         (.BLANK(XLXN_10), 
                                                                               
         .CLK25M(CLK), 
                                                                               
         .CLK31M(CLK31M), 
                                                                               
         .C_DONE(C_DONE), 
                                                                               
         .M4_SET_DONE(M4_SET_DONE), 
                                                                               
         .OVP(XLXN_6), 
                                                                               
         .CLK125M_SS(CLK125M_SS), 
                                                                               
         .GCLK(GCLK), 
                                                                               
         .GCLKOUT_START(GCLKOUT_START), 
                                                                               
         .XGCLK(XGCLK), 
                                                                               
         .XGCLK60_DCM_RST(XGCLK60_DCM_RST));
   out_tim_lcar_m5353Q_14b43Hz  out_tim_0 (.clk(CLK), 
                                          .frame_alt(FRAME_ALT), 
                                          .fr_rate(FR_RATE[15:0]), 
                                          .f50hz(F50HZ), 
                                          .blanka(XLXN_10), 
                                          .ovt(), 
                                          .ov_stp(XLXN_6));
   ofd3_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_3 (.CK(OCLK), 
                                                     .D0(R_OUT[3]), 
                                                     .D1(R_OUT[4]), 
                                                     .D2(R_OUT[5]), 
                                                     .Q0(CN2_D[6]), 
                                                     .Q1(CN2_D[7]), 
                                                     .Q2(CN2_D[8]));
   ofd3_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_5 (.CK(OCLK), 
                                                     .D0(R_OUT[6]), 
                                                     .D1(R_OUT[7]), 
                                                     .D2(R_OUT[8]), 
                                                     .Q0(CN2_D[12]), 
                                                     .Q1(CN2_D[13]), 
                                                     .Q2(CN2_D[14]));
   ofd1s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_8 (.CK(OCLK), 
                                                      .D(DCLK), 
                                                      .Q(CN2_D[3]));
   ofd3_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_16 (.CK(OCLK), 
                                                      .D0(R_OUT[0]), 
                                                      .D1(R_OUT[1]), 
                                                      .D2(R_OUT[2]), 
                                                      .Q0(CN2_D[0]), 
                                                      .Q1(CN2_D[1]), 
                                                      .Q2(CN2_D[2]));
   ofd1s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_23 (.CK(OCLK), 
                                                       .D(DCLK), 
                                                       .Q(CN2_D[9]));
   ofd1s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_62 (.CK(OCLK), 
                                                       .D(DCLK), 
                                                       .Q(CN2_D[15]));
   ofd1s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_85 (.CK(OCLK), 
                                                       .D(LE), 
                                                       .Q(CN2_D[10]));
   ofd1s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_101 (.CK(OCLK), 
                                                        .D(LE), 
                                                        .Q(CN2_D[4]));
   ofd1s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_111 (.CK(OCLK), 
                                                        .D(LE), 
                                                        .Q(CN2_D[16]));
   ofd2_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_113 (.CK(CLK), 
                                                       .D0(ADDCLK), 
                                                       .D1(ADDSDA), 
                                                       .Q0(), 
                                                       .Q1());
   ofd3_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_137 (.CK(XGCLK), 
                                                       .D0(GCLK), 
                                                       .D1(GCLK), 
                                                       .D2(GCLK), 
                                                       .Q0(CN2_D[22]), 
                                                       .Q1(CN2_D[23]), 
                                                       .Q2(CN2_D[24]));
   ofd1s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_165 (.CK(XGCLK), 
                                                        .D(GCLK), 
                                                        .Q(CN2_D[5]));
   ofd1s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_168 (.CK(XGCLK), 
                                                        .D(GCLK), 
                                                        .Q(CN2_D[11]));
   ofd1s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_172 (.CK(XGCLK), 
                                                        .D(GCLK), 
                                                        .Q(CN2_D[17]));
   ofd4s_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_246 (.CK(OCLK), 
                                                        .D0(SCAN_LINE[0]), 
                                                        .D1(SCAN_LINE[1]), 
                                                        .D2(SCAN_LINE[2]), 
                                                        .D3(SCAN_LINE[3]), 
                                                        .Q0(CN2_D[18]), 
                                                        .Q1(CN2_D[19]), 
                                                        .Q2(CN2_D[20]), 
                                                        .Q3(CN2_D[21]));
   ofd3_MUSER_output_rcv_lcar_m5353Q_14b43Hz  XLXI_306 (.CK(XGCLK), 
                                                       .D0(GCLK), 
                                                       .D1(GCLK), 
                                                       .D2(GCLK), 
                                                       .Q0(CN2_D[25]), 
                                                       .Q1(CN2_D[26]), 
                                                       .Q2(CN2_D[27]));
endmodule

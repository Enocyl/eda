module video_process(BRIGHTNESS, 
                     CHECK, 
                     CLK, 
                     CT_BLUE, 
                     CT_GREEN, 
                     CT_RED, 
                     C_DONE, 
                     FRAME_ALT, 
                     FRAME_ALT_FRZ, 
                     GAMMA, 
                     HSTP, 
                     H_SIZE, 
                     M4_BRT, 
                     M4_CMD_RD_ADRS, 
                     M4_CMD_RD_BANK1, 
                     M4_CMD_RD_CYCLE, 
                     M4_CMD_WR_ADRS, 
                     M4_CMD_WR_BANK1, 
                     M4_CMD_WR_CYCLE, 
                     M4_CMD_WR_D, 
                     M4_CMD_WR_DQM, 
                     M4_ON, 
                     OUT_VID_RD_ADRS, 
                     OUT_VID_RD_CYCLE, 
                     OVP, 
                     PAC_STP, 
                     PANEL_SEL, 
                     RXD, 
                     VSTP, 
                     V_SIZE, 
                     FM_IN_RD_B, 
                     FM_IN_RD_G, 
                     FM_IN_RD_R, 
                     FM_IV_RD_CYCLE, 
                     FM_IV_WR_CYCLE, 
                     FM_OV_WR_CYCLE, 
                     MEM_A, 
                     MEM_BA, 
                     MEM_CAS_N, 
                     MEM_CKE, 
                     MEM_CS_N, 
                     MEM_CYCLE_STP, 
                     MEM_DQM, 
                     MEM_M4_CMD_CYCLE, 
                     MEM_RAS_N, 
                     MEM_RD_D, 
                     MEM_WE_N, 
                     PUP_TIME, 
                     MEM_D);

    input [6:0] BRIGHTNESS;
    input CHECK;
    input CLK;
    input [3:0] CT_BLUE;
    input [3:0] CT_GREEN;
    input [3:0] CT_RED;
    input C_DONE;
    input FRAME_ALT;
    input FRAME_ALT_FRZ;
    input [2:0] GAMMA;
    input [10:0] HSTP;
    input [10:0] H_SIZE;
    input [6:0] M4_BRT;
    input [18:0] M4_CMD_RD_ADRS;
    input M4_CMD_RD_BANK1;
    input M4_CMD_RD_CYCLE;
    input [18:0] M4_CMD_WR_ADRS;
    input M4_CMD_WR_BANK1;
    input M4_CMD_WR_CYCLE;
    input [31:0] M4_CMD_WR_D;
    input [3:0] M4_CMD_WR_DQM;
    input M4_ON;
    input [18:0] OUT_VID_RD_ADRS;
    input OUT_VID_RD_CYCLE;
    input OVP;
    input PAC_STP;
    input [3:0] PANEL_SEL;
    input [7:0] RXD;
    input [10:0] VSTP;
    input [10:0] V_SIZE;
   output [9:0] FM_IN_RD_B;
   output [9:0] FM_IN_RD_G;
   output [9:0] FM_IN_RD_R;
   output FM_IV_RD_CYCLE;
   output FM_IV_WR_CYCLE;
   output FM_OV_WR_CYCLE;
   output [10:0] MEM_A;
   output [1:0] MEM_BA;
   output MEM_CAS_N;
   output MEM_CKE;
   output MEM_CS_N;
   output MEM_CYCLE_STP;
   output [3:0] MEM_DQM;
   output MEM_M4_CMD_CYCLE;
   output MEM_RAS_N;
   output [31:0] MEM_RD_D;
   output MEM_WE_N;
   output PUP_TIME;
    inout [31:0] MEM_D;
   
   wire L;
   wire MEM_CYCLE_STP_ADV;
   wire [3:0] XLXN_24;
   wire [31:0] XLXN_26;
   wire XLXN_29;
   wire [1:0] XLXN_120;
   wire [10:0] XLXN_121;
   wire XLXN_123;
   wire XLXN_124;
   wire XLXN_125;
   wire XLXN_126;
   wire XLXN_127;
   wire [16:0] XLXN_146;
   wire [16:0] XLXN_148;
   wire [31:0] XLXN_180;
   wire XLXN_393;
   wire [29:0] XLXN_655;
   wire [18:0] XLXN_657;
   wire [18:0] XLXN_658;
   wire [29:0] XLXN_661;
   wire [16:0] XLXN_662;
   wire FM_OV_WR_CYCLE_DUMMY;
   wire FM_IV_WR_CYCLE_DUMMY;
   wire [31:0] MEM_RD_D_DUMMY;
   wire FM_IV_RD_CYCLE_DUMMY;
   
   assign FM_IV_RD_CYCLE = FM_IV_RD_CYCLE_DUMMY;
   assign FM_IV_WR_CYCLE = FM_IV_WR_CYCLE_DUMMY;
   assign FM_OV_WR_CYCLE = FM_OV_WR_CYCLE_DUMMY;
   assign MEM_RD_D[31:0] = MEM_RD_D_DUMMY[31:0];
   mem_if_pv2_4  mem_if0 (.clk(CLK), 
                         .c_done(C_DONE), 
                         .in_vid_rd_adrs(XLXN_148[16:0]), 
                         .in_vid_rd_req(FM_IV_RD_CYCLE_DUMMY), 
                         .in_vid_wr_adrs(XLXN_146[16:0]), 
                         .in_vid_wr_d(XLXN_655[29:0]), 
                         .in_vid_wr_req(FM_IV_WR_CYCLE_DUMMY), 
                         .m4_bank1(L), 
                         .m4_cf_cmd_rd_adrs(M4_CMD_RD_ADRS[18:0]), 
                         .m4_cf_cmd_rd_bank1(M4_CMD_RD_BANK1), 
                         .m4_cf_cmd_rd_req(M4_CMD_RD_CYCLE), 
                         .m4_cf_cmd_wr_adrs(M4_CMD_WR_ADRS[18:0]), 
                         .m4_cf_cmd_wr_bank1(M4_CMD_WR_BANK1), 
                         .m4_cf_cmd_wr_byten(M4_CMD_WR_DQM[3:0]), 
                         .m4_cf_cmd_wr_d(M4_CMD_WR_D[31:0]), 
                         .m4_cf_cmd_wr_req(M4_CMD_WR_CYCLE), 
                         .m4_cf_rd_adrs(XLXN_658[18:0]), 
                         .out_vid_rd_adrs(OUT_VID_RD_ADRS[18:0]), 
                         .out_vid_rd_req(OUT_VID_RD_CYCLE), 
                         .out_vid_wr_adrs(XLXN_657[18:0]), 
                         .out_vid_wr_d(XLXN_180[31:0]), 
                         .out_vid_wr_req(FM_OV_WR_CYCLE_DUMMY), 
                         .adrs(XLXN_121[10:0]), 
                         .ba(XLXN_120[1:0]), 
                         .cas_n(XLXN_124), 
                         .cke(XLXN_127), 
                         .cs_n(XLXN_126), 
                         .cycle_stp(MEM_CYCLE_STP), 
                         .cycle_stp_adv(MEM_CYCLE_STP_ADV), 
                         .dot(XLXN_29), 
                         .dq(XLXN_26[31:0]), 
                         .dqm(XLXN_24[3:0]), 
                         .m4_cmd_cycle(MEM_M4_CMD_CYCLE), 
                         .pup_time(PUP_TIME), 
                         .ras_n(XLXN_125), 
                         .we_n(XLXN_123));
   video_proc_MUSER_video_process  video_proc0 (.BRIGHTNESS(BRIGHTNESS[6:0]), 
                                               .CHECK(CHECK), 
                                               .CLK(CLK), 
                                               .CT_BLUE(CT_BLUE[3:0]), 
                                               .CT_GREEN(CT_GREEN[3:0]), 
                                               .CT_RED(CT_RED[3:0]), 
                                               
         .FM_CYCLE_STP_ADV(MEM_CYCLE_STP_ADV), 
                                               
         .FM_IV_WR_CYCLE(FM_IV_WR_CYCLE_DUMMY), 
                                               
         .FM_OV_RD_CYCLE(OUT_VID_RD_CYCLE), 
                                               .FM_RD_D(MEM_RD_D_DUMMY[29:0]), 
                                               .FRAME_ALT(FRAME_ALT), 
                                               .FRAME_ALT_FRZ(FRAME_ALT_FRZ), 
                                               .GAMMA(GAMMA[2:0]), 
                                               .M4_BRT(M4_BRT[6:0]), 
                                               .M4_ON(M4_ON), 
                                               .OVP(OVP), 
                                               .PANEL_SEL(PANEL_SEL[3:0]), 
                                               .FM_IN_RD_BLUE(FM_IN_RD_B[9:0]), 
                                               
         .FM_IN_RD_GREEN(FM_IN_RD_G[9:0]), 
                                               .FM_IN_RD_RED(FM_IN_RD_R[9:0]), 
                                               
         .FM_IN_VID_RD_ADRS(XLXN_148[16:0]), 
                                               
         .FM_IV_RD_CYCLE(FM_IV_RD_CYCLE_DUMMY), 
                                               
         .FM_M4_CF_RD_ADRS(XLXN_658[18:0]), 
                                               .FM_OV_WR_ADRS(XLXN_657[18:0]), 
                                               
         .FM_OV_WR_CYCLE(FM_OV_WR_CYCLE_DUMMY), 
                                               .FM_OV_WR_D(XLXN_180[31:0]));
   video_input_256x256  vin256 (.clk(CLK), 
                               .d(RXD[7:0]), 
                               .fm_cycle_stp_adv(MEM_CYCLE_STP_ADV), 
                               .frame_alt(FRAME_ALT), 
                               .hstp(HSTP[10:0]), 
                               .h_size(H_SIZE[10:0]), 
                               .pac_stp(PAC_STP), 
                               .vp(OVP), 
                               .vstp(VSTP[10:0]), 
                               .v_size(V_SIZE[10:0]), 
                               .dout(XLXN_661[29:0]), 
                               .fm_iv_wr_cycle(XLXN_393), 
                               .fm_wr_adrs(XLXN_662[16:0]), 
                               .lm_we(), 
                               .lm_wr_stp(), 
                               .pad_adrs(), 
                               .pix_ce(), 
                               .video_stp(), 
                               .video_st_pac());
   ofd11b  XLXI_3 (.clk(CLK), 
                  .d(XLXN_121[10:0]), 
                  .q(MEM_A[10:0]));
   ofd4b  XLXI_4 (.clk(CLK), 
                 .d(XLXN_24[3:0]), 
                 .q(MEM_DQM[3:0]));
   ofd2b  XLXI_5 (.clk(CLK), 
                 .d(XLXN_120[1:0]), 
                 .q(MEM_BA[1:0]));
   ofd5_MUSER_video_process  XLXI_6 (.CK(CLK), 
                                    .D0(XLXN_127), 
                                    .D1(XLXN_126), 
                                    .D2(XLXN_125), 
                                    .D3(XLXN_124), 
                                    .D4(XLXN_123), 
                                    .Q0(MEM_CKE), 
                                    .Q1(MEM_CS_N), 
                                    .Q2(MEM_RAS_N), 
                                    .Q3(MEM_CAS_N), 
                                    .Q4(MEM_WE_N));
   ofdt_ifd32  XLXI_8 (.clk(CLK), 
                      .dout_in(XLXN_26[31:0]), 
                      .dout_tri(XLXN_29), 
                      .din_out(MEM_RD_D_DUMMY[31:0]), 
                      .dio(MEM_D[31:0]));
   fd1_MUSER_video_process  XLXI_545 (.CK(CLK), 
                                     .D(XLXN_393), 
                                     .Q(FM_IV_WR_CYCLE_DUMMY));
   fd30  XLXI_546 (.ck(CLK), 
                  .d(XLXN_661[29:0]), 
                  .q(XLXN_655[29:0]));
   fd17  XLXI_547 (.ck(CLK), 
                  .d(XLXN_662[16:0]), 
                  .q(XLXN_146[16:0]));
   GND  XLXI_548 (.G(L));
endmodule

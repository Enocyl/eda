module m4_coeff_ctrl_xt(BRIGHTNESS, 
                        CLK25M, 
                        CLK72M, 
                        CLK125M, 
                        CT_BLUE, 
                        CT_GREEN, 
                        CT_RED, 
                        C_DONE_DLY, 
                        DSW_IM_DOWNLOAD_REQ, 
                        DSW_LOSS_BRT100, 
                        EMB_RSP_DATA, 
                        EMB_RSP_REQ, 
                        FPGA_VER, 
                        FRAME_ALT, 
                        GAMMA, 
                        MEM_COLOR_LOSS, 
                        MEM_CYCLE_STP, 
                        MEM_M4_CMD_CYCLE, 
                        MEM_RD_D, 
                        M4_BANK1, 
                        M4_ON, 
                        PANEL_SEL, 
                        RS232C_RXD, 
                        RX_IM_DOWNLOAD_ON, 
                        TEST_PAT, 
                        ADDCLK, 
                        ADDSDA, 
                        CMD_BAUD_RATE, 
                        CMD_BRIGHTNESS, 
                        CMD_CT_BLUE, 
                        CMD_CT_GREEN, 
                        CMD_CT_RED, 
                        CMD_GAMMA, 
                        CMD_M4_BANK1, 
                        CMD_M4_ON, 
                        CMD_REBOOT_N, 
                        CMD_TEST_PAT, 
                        COLOR_LOSS, 
                        DSW_IM_DOWNLOAD_ON, 
                        EMB_TX_DATA, 
                        EMB_TX_REQ, 
                        IM_CH_SEL0, 
                        IM_CH_SEL1, 
                        IM_CH_SEL2, 
                        IM_DIR, 
                        IM_DOWNLOAD_EXE_TIM, 
                        IM_ERR_DETO, 
                        IM_SCL, 
                        MEM_CLEAR_DONE_N, 
                        M4_CMD_RADRS, 
                        M4_CMD_RD_BANK1, 
                        M4_CMD_RD_CYCLE, 
                        M4_CMD_WADRS, 
                        M4_CMD_WDATA, 
                        M4_CMD_WR_BANK1, 
                        M4_CMD_WR_CYCLE, 
                        M4_CMD_WR_DQM, 
                        M4_SET_DONE, 
                        PIXEL_DISP_RGB_ON, 
                        PIXEL1_DISP_MODE, 
                        PIXEL1_DISP_ON, 
                        PIXEL4_DISP_ON, 
                        RGB_OUT_ZERO, 
                        RS232C_RXD_A, 
                        RS232C_TXD, 
                        RS232C_TXD_A, 
                        STARTN_DLY, 
                        TESTP_LEVEL, 
                        TESTP_RGB_EN, 
                        TP1, 
                        TP2, 
                        TP3, 
                        TP4, 
                        TP5, 
                        TP6, 
                        TP7, 
                        TP8, 
                        IM_SDA);

    input [6:0] BRIGHTNESS;
    input CLK25M;
    input CLK72M;
    input CLK125M;
    input [3:0] CT_BLUE;
    input [3:0] CT_GREEN;
    input [3:0] CT_RED;
    input C_DONE_DLY;
    input DSW_IM_DOWNLOAD_REQ;
    input DSW_LOSS_BRT100;
    input [79:0] EMB_RSP_DATA;
    input EMB_RSP_REQ;
    input [7:0] FPGA_VER;
    input FRAME_ALT;
    input [2:0] GAMMA;
    input [2:0] MEM_COLOR_LOSS;
    input MEM_CYCLE_STP;
    input MEM_M4_CMD_CYCLE;
    input [31:0] MEM_RD_D;
    input M4_BANK1;
    input M4_ON;
    input [3:0] PANEL_SEL;
    input RS232C_RXD;
    input RX_IM_DOWNLOAD_ON;
    input [7:0] TEST_PAT;
   output ADDCLK;
   output ADDSDA;
   output [1:0] CMD_BAUD_RATE;
   output [6:0] CMD_BRIGHTNESS;
   output [3:0] CMD_CT_BLUE;
   output [3:0] CMD_CT_GREEN;
   output [3:0] CMD_CT_RED;
   output [2:0] CMD_GAMMA;
   output CMD_M4_BANK1;
   output CMD_M4_ON;
   output CMD_REBOOT_N;
   output [7:0] CMD_TEST_PAT;
   output [2:0] COLOR_LOSS;
   output DSW_IM_DOWNLOAD_ON;
   output [79:0] EMB_TX_DATA;
   output EMB_TX_REQ;
   output IM_CH_SEL0;
   output IM_CH_SEL1;
   output IM_CH_SEL2;
   output IM_DIR;
   output IM_DOWNLOAD_EXE_TIM;
   output IM_ERR_DETO;
   output IM_SCL;
   output MEM_CLEAR_DONE_N;
   output [18:0] M4_CMD_RADRS;
   output M4_CMD_RD_BANK1;
   output M4_CMD_RD_CYCLE;
   output [18:0] M4_CMD_WADRS;
   output [31:0] M4_CMD_WDATA;
   output M4_CMD_WR_BANK1;
   output M4_CMD_WR_CYCLE;
   output [3:0] M4_CMD_WR_DQM;
   output M4_SET_DONE;
   output [2:0] PIXEL_DISP_RGB_ON;
   output [23:0] PIXEL1_DISP_MODE;
   output PIXEL1_DISP_ON;
   output PIXEL4_DISP_ON;
   output [2:0] RGB_OUT_ZERO;
   output RS232C_RXD_A;
   output RS232C_TXD;
   output RS232C_TXD_A;
   output STARTN_DLY;
   output [7:0] TESTP_LEVEL;
   output [2:0] TESTP_RGB_EN;
   output TP1;
   output TP2;
   output TP3;
   output TP4;
   output TP5;
   output TP6;
   output TP7;
   output TP8;
    inout IM_SDA;
   
   wire COEFF_OFFSET_WE;
   wire COPY_CORRECT_BUSY;
   wire IM_BANK_READ;
   wire IM_BANK_WRITE;
   wire IM_BUSY;
   wire [4:0] IM_CF_AD;
   wire [2:0] IM_CH_SELA;
   wire [15:0] IM_CMD_AD;
   wire [7:0] IM_CMD_RD;
   wire IM_CMD_RD_RSTW;
   wire IM_CMD_RD_WE;
   wire IM_CMD_STARTP;
   wire IM_DOWNLOAD_ERR;
   wire IM_ERR_DET;
   wire [3:0] IM_HADRS;
   wire [3:0] IM_OPE_HADRS;
   wire [3:0] IM_OPE_SEL;
   wire [3:0] IM_OPE_VADRS;
   wire IM_RAM_RSTR;
   wire [7:0] IM_RD;
   wire IM_RD_RSTW;
   wire IM_RD_WE;
   wire [7:0] IM_ROM_WD;
   wire IM_ROM_WD_RSTW;
   wire IM_ROM_WD_WE;
   wire [3:0] IM_VADRS;
   wire [10:0] IM_32BYTE_NUM;
   wire L;
   wire MEM_CTRL_TP1;
   wire MEM_CTRL_TP2;
   wire MEM_CTRL_TP3;
   wire MEM_CTRL_TP4;
   wire MEM_CTRL_TP5;
   wire ONE_IM_TO_RAM_COPY;
   wire OVP_25M;
   wire PANEL_CORRECT_IM;
   wire PANEL_CORRECT_ONE_IM;
   wire PANEL_CORRECT_STARTP;
   wire [21:0] RAM_CMD_AD;
   wire [7:0] RAM_CMD_RD;
   wire RAM_CMD_RD_WE;
   wire RAM_CMD_STARTP;
   wire [2:0] RAM_OPE_SEL;
   wire [7:0] RSP_RAM_RD;
   wire RSP_RAM_RD_RSTW;
   wire RSP_RAM_RD_WE;
   wire STARTN;
   wire XLXN_3;
   wire XLXN_4;
   wire XLXN_6;
   wire XLXN_29;
   wire XLXN_30;
   wire XLXN_32;
   wire [79:0] XLXN_39;
   wire XLXN_45;
   wire XLXN_63;
   wire XLXN_64;
   wire XLXN_84;
   wire XLXN_111;
   wire XLXN_113;
   wire XLXN_115;
   wire XLXN_116;
   wire XLXN_118;
   wire MEM_CLEAR_DONE_N_DUMMY;
   wire STARTN_DLY_DUMMY;
   wire RS232C_RXD_A_DUMMY;
   wire M4_SET_DONE_DUMMY;
   wire DSW_IM_DOWNLOAD_ON_DUMMY;
   wire RS232C_TXD_A_DUMMY;
   
   assign DSW_IM_DOWNLOAD_ON = DSW_IM_DOWNLOAD_ON_DUMMY;
   assign MEM_CLEAR_DONE_N = MEM_CLEAR_DONE_N_DUMMY;
   assign M4_SET_DONE = M4_SET_DONE_DUMMY;
   assign RS232C_RXD_A = RS232C_RXD_A_DUMMY;
   assign RS232C_TXD_A = RS232C_TXD_A_DUMMY;
   assign STARTN_DLY = STARTN_DLY_DUMMY;
   rs232c_xt_MUSER_m4_coeff_ctrl_xt  XLXI_1 (.BRIGHTNESS(BRIGHTNESS[6:0]), 
                                            .CLK(CLK72M), 
                                            .CT_BLUE(CT_BLUE[3:0]), 
                                            .CT_GREEN(CT_GREEN[3:0]), 
                                            .CT_RED(CT_RED[3:0]), 
                                            .DSW_LOSS_BRT100(DSW_LOSS_BRT100), 
                                            .EMB_RSP_DATA(EMB_RSP_DATA[79:0]), 
                                            .EMB_RSP_REQ(EMB_RSP_REQ), 
                                            .EXE_EN(M4_SET_DONE_DUMMY), 
                                            .FPGA_VER(FPGA_VER[7:0]), 
                                            .GAMMA(GAMMA[2:0]), 
                                            .IM_BUSY(IM_BUSY), 
                                            
         .IM_COPY_CORRECT_BUSY(COPY_CORRECT_BUSY), 
                                            .IM_ERR_DET(IM_ERR_DET), 
                                            
         .MEM_COLOR_LOSS(MEM_COLOR_LOSS[2:0]), 
                                            .M4_BANK1(M4_BANK1), 
                                            .M4_ON(M4_ON), 
                                            .M5_RSP_DATA(XLXN_39[79:0]), 
                                            .M5_RSP_REQ(L), 
                                            .OVPX(OVP_25M), 
                                            .PANEL_SEL(PANEL_SEL[3:0]), 
                                            .RSP_IM_RD(IM_RD[7:0]), 
                                            .RSP_IM_RD_RSTW(IM_RD_RSTW), 
                                            .RSP_IM_RD_WE(IM_RD_WE), 
                                            .RSP_RAM_RD(RSP_RAM_RD[7:0]), 
                                            .RSP_RAM_RD_RSTW(RSP_RAM_RD_RSTW), 
                                            .RSP_RAM_RD_WE(RSP_RAM_RD_WE), 
                                            .RXD(RS232C_RXD_A_DUMMY), 
                                            .RX_IM_DOWNLOAD_ON(XLXN_45), 
                                            .STARTN(STARTN), 
                                            .TEST_PAT(TEST_PAT[7:0]), 
                                            .CMD_BAUD_RATE(CMD_BAUD_RATE[1:0]), 
                                            
         .CMD_BRIGHTNESS(CMD_BRIGHTNESS[6:0]), 
                                            .CMD_CT_BLUE(CMD_CT_BLUE[3:0]), 
                                            .CMD_CT_GREEN(CMD_CT_GREEN[3:0]), 
                                            .CMD_CT_RED(CMD_CT_RED[3:0]), 
                                            .CMD_GAMMA(CMD_GAMMA[2:0]), 
                                            .CMD_M4_BANK1(CMD_M4_BANK1), 
                                            .CMD_M4_ON(CMD_M4_ON), 
                                            .CMD_REBOOT_N(CMD_REBOOT_N), 
                                            .CMD_TEST_PAT(CMD_TEST_PAT[7:0]), 
                                            .COEFF_OFFSET_WE(COEFF_OFFSET_WE), 
                                            .COLOR_LOSS(COLOR_LOSS[2:0]), 
                                            .EMB_TX_DATA(EMB_TX_DATA[79:0]), 
                                            .EMB_TX_REQ(EMB_TX_REQ), 
                                            .IM_CMD_AD(IM_CMD_AD[15:0]), 
                                            .IM_CMD_RD(IM_CMD_RD[7:0]), 
                                            .IM_CMD_RD_RSTW(IM_CMD_RD_RSTW), 
                                            .IM_CMD_RD_WE(IM_CMD_RD_WE), 
                                            .IM_CMD_STARTP(IM_CMD_STARTP), 
                                            
         .IM_DOWNLOAD_EXE_TIM(IM_DOWNLOAD_EXE_TIM), 
                                            .IM_HADRS(IM_HADRS[3:0]), 
                                            .IM_OPE_SEL(IM_OPE_SEL[3:0]), 
                                            .IM_VADRS(IM_VADRS[3:0]), 
                                            .M5_RSP_RAM_RE(), 
                                            .M5_TX_DATA(), 
                                            .M5_TX_REQ(), 
                                            
         .ONE_IM_TO_RAM_COPY(ONE_IM_TO_RAM_COPY), 
                                            
         .PANEL_CORRECT_IM(PANEL_CORRECT_IM), 
                                            
         .PANEL_CORRECT_ONE_IM(PANEL_CORRECT_ONE_IM), 
                                            
         .PANEL_CORRECT_STARTP(PANEL_CORRECT_STARTP), 
                                            
         .PIXEL_DISP_RGB_ON(PIXEL_DISP_RGB_ON[2:0]), 
                                            
         .PIXEL1_DISP_MODE(PIXEL1_DISP_MODE[23:0]), 
                                            .PIXEL1_DISP_ON(PIXEL1_DISP_ON), 
                                            .PIXEL4_DISP_ON(PIXEL4_DISP_ON), 
                                            .RAM_CMD_AD(RAM_CMD_AD[21:0]), 
                                            .RAM_CMD_RD(RAM_CMD_RD[7:0]), 
                                            .RAM_CMD_RD_WE(RAM_CMD_RD_WE), 
                                            .RAM_CMD_STARTP(RAM_CMD_STARTP), 
                                            .RAM_OPE_SEL(RAM_OPE_SEL[2:0]), 
                                            .RGB_OUT_ZERO(RGB_OUT_ZERO[2:0]), 
                                            .TESTP_LEVEL(TESTP_LEVEL[7:0]), 
                                            .TESTP_RGB_EN(TESTP_RGB_EN[2:0]), 
                                            .TP1(), 
                                            .TP2(), 
                                            .TP3(), 
                                            .TXD(XLXN_84), 
                                            .TX_DONE());
   fd1_MUSER_m4_coeff_ctrl_xt  XLXI_2 (.CK(CLK25M), 
                                      .D(FRAME_ALT), 
                                      .Q(XLXN_3));
   fd1_MUSER_m4_coeff_ctrl_xt  XLXI_3 (.CK(CLK25M), 
                                      .D(XLXN_3), 
                                      .Q(XLXN_4));
   XOR2  XLXI_4 (.I0(XLXN_4), 
                .I1(XLXN_3), 
                .O(XLXN_6));
   fd1_MUSER_m4_coeff_ctrl_xt  XLXI_5 (.CK(CLK25M), 
                                      .D(XLXN_6), 
                                      .Q(OVP_25M));
   fd1e_MUSER_m4_coeff_ctrl_xt  XLXI_6 (.CE(OVP_25M), 
                                       .CK(CLK25M), 
                                       .D(DSW_IM_DOWNLOAD_REQ), 
                                       .Q(XLXN_29));
   fd1e_MUSER_m4_coeff_ctrl_xt  XLXI_7 (.CE(OVP_25M), 
                                       .CK(CLK25M), 
                                       .D(XLXN_29), 
                                       .Q(XLXN_30));
   AND3B1  XLXI_8 (.I0(XLXN_30), 
                  .I1(XLXN_29), 
                  .I2(M4_SET_DONE_DUMMY), 
                  .O(XLXN_32));
   fd1_MUSER_m4_coeff_ctrl_xt  XLXI_9 (.CK(CLK25M), 
                                      .D(XLXN_32), 
                                      .Q(DSW_IM_DOWNLOAD_ON_DUMMY));
   const_0_80b  XLXI_10 (.dout(XLXN_39[79:0]));
   GND  XLXI_12 (.G(L));
   OR2  XLXI_13 (.I0(DSW_IM_DOWNLOAD_ON_DUMMY), 
                .I1(RX_IM_DOWNLOAD_ON), 
                .O(XLXN_45));
   OR2  XLXI_16 (.I0(XLXN_84), 
                .I1(STARTN_DLY_DUMMY), 
                .O(RS232C_TXD_A_DUMMY));
   (* IOSTANDARD = "DEFAULT" *) (* IBUF_DELAY_VALUE = "0" *) (* 
         IFD_DELAY_VALUE = "AUTO" *) 
   IBUF  XLXI_17 (.I(RS232C_RXD), 
                 .O(RS232C_RXD_A_DUMMY));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_18 (.I(RS232C_TXD_A_DUMMY), 
                 .O(RS232C_TXD));
   fd1e_MUSER_m4_coeff_ctrl_xt  XLXI_19 (.CE(OVP_25M), 
                                        .CK(CLK25M), 
                                        .D(STARTN), 
                                        .Q(XLXN_63));
   fd1e_MUSER_m4_coeff_ctrl_xt  XLXI_20 (.CE(OVP_25M), 
                                        .CK(CLK25M), 
                                        .D(XLXN_63), 
                                        .Q(XLXN_64));
   OR2  XLXI_21 (.I0(XLXN_64), 
                .I1(STARTN), 
                .O(STARTN_DLY_DUMMY));
   INV  XLXI_22 (.I(C_DONE_DLY), 
                .O(STARTN));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_524 (.I(XLXN_113), 
                  .O(IM_DIR));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_525 (.I(XLXN_111), 
                  .O(IM_SCL));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_526 (.I(IM_CH_SELA[0]), 
                  .O(IM_CH_SEL0));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_527 (.I(IM_CH_SELA[1]), 
                  .O(IM_CH_SEL1));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) (* 
         IBUF_DELAY_VALUE = "0" *) (* IFD_DELAY_VALUE = "AUTO" *) 
   IOBUF  XLXI_531 (.I(XLXN_116), 
                   .T(XLXN_115), 
                   .O(XLXN_118), 
                   .IO(IM_SDA));
   OR2  XLXI_535 (.I0(IM_DOWNLOAD_ERR), 
                 .I1(IM_ERR_DET), 
                 .O(IM_ERR_DETO));
   BUF  XLXI_536 (.I(IM_ROM_WD[0]), 
                 .O(TP1));
   BUF  XLXI_538 (.I(IM_ROM_WD_RSTW), 
                 .O(TP2));
   BUF  XLXI_539 (.I(IM_ROM_WD_WE), 
                 .O(TP3));
   BUF  XLXI_540 (.I(MEM_CTRL_TP3), 
                 .O(TP6));
   BUF  XLXI_541 (.I(MEM_CTRL_TP4), 
                 .O(TP7));
   BUF  XLXI_542 (.I(MEM_CTRL_TP5), 
                 .O(TP8));
   BUF  XLXI_546 (.I(MEM_CTRL_TP1), 
                 .O(TP4));
   BUF  XLXI_547 (.I(MEM_CTRL_TP2), 
                 .O(TP5));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_551 (.I(IM_CH_SELA[2]), 
                  .O(IM_CH_SEL2));
   im_eeprom_ctrl_pv2_4_4x4  XLXI_558 (.clk(CLK25M), 
                                      .cmd_ad(IM_CMD_AD[15:0]), 
                                      .cmd_startp(IM_CMD_STARTP), 
                                      .im_hadrs(IM_HADRS[3:0]), 
                                      .im_vadrs(IM_VADRS[3:0]), 
                                      .one_im_ope(ONE_IM_TO_RAM_COPY), 
                                      .ope_sel(IM_OPE_SEL[3:0]), 
                                      .panel_sel(PANEL_SEL[3:0]), 
                                      .sda_in(XLXN_118), 
                                      .startn_in(MEM_CLEAR_DONE_N_DUMMY), 
                                      .test_wd({L, L, L, L, L, L, L, L}), 
                                      .wd_ram_rstwa(IM_CMD_RD_RSTW), 
                                      .wd_ram_rstwb(IM_ROM_WD_RSTW), 
                                      .wd_ram_wea(IM_CMD_RD_WE), 
                                      .wd_ram_web(IM_ROM_WD_WE), 
                                      .wd_test(L), 
                                      .wr_dina(IM_CMD_RD[7:0]), 
                                      .wr_dinb(IM_ROM_WD[7:0]), 
                                      .addclk(ADDCLK), 
                                      .addsda(ADDSDA), 
                                      .bank_read(IM_BANK_READ), 
                                      .bank_write(IM_BANK_WRITE), 
                                      .busy(IM_BUSY), 
                                      .cnt_rst(), 
                                      .download_err(IM_DOWNLOAD_ERR), 
                                      .err_det(IM_ERR_DET), 
                                      .im_cf_ad(IM_CF_AD[4:0]), 
                                      .im_ope_hadrs(IM_OPE_HADRS[3:0]), 
                                      .im_ope_vadrs(IM_OPE_VADRS[3:0]), 
                                      .im_32byte_num(IM_32BYTE_NUM[10:0]), 
                                      .m4_set_done(M4_SET_DONE_DUMMY), 
                                      .m4_set_err(), 
                                      .out_ch_sel(IM_CH_SELA[2:0]), 
                                      .ram_rstr(IM_RAM_RSTR), 
                                      .rd_dout(IM_RD[7:0]), 
                                      .rd_startp(IM_RD_RSTW), 
                                      .rd_we(IM_RD_WE), 
                                      .scl(XLXN_111), 
                                      .sdao(XLXN_116), 
                                      .sda_dir(XLXN_113), 
                                      .sda_ot(XLXN_115), 
                                      .tp1(), 
                                      .tp2(), 
                                      .tp3(), 
                                      .tp4(), 
                                      .tp5());
   m4_mem_ctrl_pv2_4_4x4  XLXI_559 (.bank_read(IM_BANK_READ), 
                                   .bank_write(IM_BANK_WRITE), 
                                   .clk(CLK125M), 
                                   .cmd_ad(RAM_CMD_AD[21:0]), 
                                   .cmd_startp(RAM_CMD_STARTP), 
                                   .coeff_offset_we(COEFF_OFFSET_WE), 
                                   .c_done_dly(C_DONE_DLY), 
                                   .im_cf_ad(IM_CF_AD[4:0]), 
                                   .im_din(IM_RD[7:0]), 
                                   .im_ope_hadrs(IM_OPE_HADRS[3:0]), 
                                   .im_ope_vadrs(IM_OPE_VADRS[3:0]), 
                                   .im_ram_rstr(IM_RAM_RSTR), 
                                   .im_ram_rstw(IM_RD_RSTW), 
                                   .im_we_in(IM_RD_WE), 
                                   .im_32byte_num(IM_32BYTE_NUM[10:0]), 
                                   .mem_cycle_stp(MEM_CYCLE_STP), 
                                   .mem_din(MEM_RD_D[31:0]), 
                                   .mem_m4_cmd_cycle(MEM_M4_CMD_CYCLE), 
                                   .panel_correct_im(PANEL_CORRECT_IM), 
                                   .panel_correct_im_had(IM_HADRS[3:0]), 
                                   .panel_correct_im_vad(IM_VADRS[3:0]), 
                                   .panel_correct_one_im(PANEL_CORRECT_ONE_IM), 
                                   .panel_correct_startp(PANEL_CORRECT_STARTP), 
                                   .ram_ope_sel(RAM_OPE_SEL[2:0]), 
                                   .rs_din(RAM_CMD_RD[7:0]), 
                                   .rs_we_in(RAM_CMD_RD_WE), 
                                   .copy_correct_busy(COPY_CORRECT_BUSY), 
                                   .im_rdata(IM_ROM_WD[7:0]), 
                                   .im_rstwo(IM_ROM_WD_RSTW), 
                                   .im_weo(IM_ROM_WD_WE), 
                                   .mem_clear_done_n(MEM_CLEAR_DONE_N_DUMMY), 
                                   .radrs(M4_CMD_RADRS[18:0]), 
                                   .rd_bank1(M4_CMD_RD_BANK1), 
                                   .re(M4_CMD_RD_CYCLE), 
                                   .rs_rdata(RSP_RAM_RD[7:0]), 
                                   .rs_rstwo(RSP_RAM_RD_RSTW), 
                                   .rs_weo(RSP_RAM_RD_WE), 
                                   .tp1(MEM_CTRL_TP1), 
                                   .tp2(MEM_CTRL_TP2), 
                                   .tp3(MEM_CTRL_TP3), 
                                   .tp4(MEM_CTRL_TP4), 
                                   .tp5(MEM_CTRL_TP5), 
                                   .wadrs(M4_CMD_WADRS[18:0]), 
                                   .wdata(M4_CMD_WDATA[31:0]), 
                                   .we(M4_CMD_WR_CYCLE), 
                                   .wr_bank1(M4_CMD_WR_BANK1), 
                                   .wr_dqm(M4_CMD_WR_DQM[3:0]));
endmodule

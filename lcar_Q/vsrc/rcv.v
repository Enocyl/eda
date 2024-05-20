module rcv(C_DONE_IN, 
           EMB_RXD, 
           MEM_CLKI, 
           PA_LED1, 
           PA_LED2, 
           PA_RXD, 
           PA_RX_CLK, 
           PA_RX_DV, 
           PA_TX_CLK, 
           RS232C_RXD, 
           SPI_MISO, 
           XCLK_IN, 
           CN2_D, 
           CN3_CH_SEL0, 
           CN3_CH_SEL1, 
           CN3_DIR, 
           CN3_SCL, 
           CS, 
           EMB_TXD, 
           ENET_RST_N, 
           LED_A, 
           MEM_A, 
           MEM_BA, 
           MEM_CAS_N, 
           MEM_CKE, 
           MEM_CLKO, 
           MEM_CS_N, 
           MEM_DQM, 
           MEM_RAS_N, 
           MEM_WE_N, 
           OUT_ENA_N, 
           PA_CLK25M, 
           PA_TXD, 
           PA_TX_EN, 
           RECONF_N, 
           RS232C_TXD, 
           SCK, 
           SENS_SCL, 
           SPI_MOSI, 
           CN3_SDA, 
           MEM_D, 
           SENS_SDA);

    input C_DONE_IN;
    input EMB_RXD;
    input MEM_CLKI;
    input PA_LED1;
    input PA_LED2;
    input [3:0] PA_RXD;
    input PA_RX_CLK;
    input PA_RX_DV;
    input PA_TX_CLK;
    input RS232C_RXD;
    input SPI_MISO;
    input XCLK_IN;
   output [27:0] CN2_D;
   output CN3_CH_SEL0;
   output CN3_CH_SEL1;
   output CN3_DIR;
   output CN3_SCL;
   output CS;
   output EMB_TXD;
   output ENET_RST_N;
   output LED_A;
   output [10:0] MEM_A;
   output [1:0] MEM_BA;
   output MEM_CAS_N;
   output MEM_CKE;
   output MEM_CLKO;
   output MEM_CS_N;
   output [3:0] MEM_DQM;
   output MEM_RAS_N;
   output MEM_WE_N;
   output OUT_ENA_N;
   output PA_CLK25M;
   output [3:0] PA_TXD;
   output PA_TX_EN;
   output RECONF_N;
   output RS232C_TXD;
   output SCK;
   output SENS_SCL;
   output SPI_MOSI;
    inout CN3_SDA;
    inout [31:0] MEM_D;
    inout SENS_SDA;
   
   wire ADDCLK;
   wire ADDSDA;
   wire [6:0] BRIGHTNESS;
   wire CLK25M;
   wire CLK31M;
   wire CLK72M;
   wire CLK125M;
   wire CLK125M_SS;
   wire [6:0] CMD_BRIGHTNESS;
   wire [3:0] CMD_CT_BLUE;
   wire [3:0] CMD_CT_GREEN;
   wire [3:0] CMD_CT_RED;
   wire [2:0] CMD_GAMMA;
   wire CMD_M4_BANK1;
   wire CMD_M4_ON;
   wire CMD_REBOOT_N;
   wire [7:0] CMD_TEST_PAT;
   wire [2:0] COLOR_LOSS;
   wire [3:0] CT_BLUE;
   wire [3:0] CT_GREEN;
   wire [3:0] CT_RED;
   wire C_DONE;
   wire C_DONE_DLY;
   wire DSW_IM_DOWNLOAD_ON;
   wire DSW_TP;
   wire [79:0] EMB_RSP_DATA;
   wire EMB_RSP_REQ;
   wire [79:0] EMB_TX_DATA;
   wire EMB_TX_REQ;
   wire [18:0] FM_M4_CMD_RD_ADRS;
   wire FM_M4_CMD_RD_BANK1;
   wire FM_M4_CMD_RD_CYCLE;
   wire [18:0] FM_M4_CMD_WR_ADRS;
   wire FM_M4_CMD_WR_BANK1;
   wire FM_M4_CMD_WR_CYCLE;
   wire [31:0] FM_M4_CMD_WR_D;
   wire [3:0] FM_M4_CMD_WR_DQM;
   wire [18:0] FM_OV_RD_ADRS;
   wire FM_OV_RD_CYCLE;
   wire [7:0] FPGA_VER;
   wire FRAME_ALT;
   wire FRAME_ALT_FRZ;
   wire [15:0] FR_RATE;
   wire [2:0] GAMMA;
   wire H;
   wire [10:0] HSTP;
   wire [10:0] H_SIZE;
   wire IM_DOWNLOAD_EXE_TIM;
   wire IM_ERR_DET;
   wire L;
   wire MEM_CYCLE_STP;
   wire MEM_M4_CMD_CYCLE;
   wire [31:0] MEM_RD_D;
   wire M4_BANK1;
   wire [6:0] M4_BRT;
   wire M4_ON;
   wire M4_SET_DONE;
   wire OVP;
   wire PAC_STP;
   wire [3:0] PANEL_SEL;
   wire PA_CSUM_ERR;
   wire PA_LINK_ON;
   wire PA_RX_OK;
   wire [2:0] PIXEL_DISP_RGB;
   wire [23:0] PIXEL1_DISP_MODE;
   wire PIXEL1_DISP_ON;
   wire PIXEL4_DISP_ON;
   wire REBOOT_N;
   wire [2:0] RGB_OUT_ZERO;
   wire [7:0] RXD;
   wire RX_IM_DOWNLOAD;
   wire RX50HZ;
   wire STARTN_DLY;
   wire [7:0] TESTP_LEVEL;
   wire [2:0] TESTP_RGB_EN;
   wire [10:0] VSTP;
   wire [10:0] V_SIZE;
   wire XLXN_475;
   wire XLXN_477;
   
   clk_gen_MUSER_rcv  clk_gen_0 (.C_DONE(C_DONE), 
                                .MEM_CLKI(MEM_CLKI), 
                                .XCLK_IN(XCLK_IN), 
                                .CLK25M(CLK25M), 
                                .CLK31M(CLK31M), 
                                .CLK72M(CLK72M), 
                                .CLK125M(CLK125M), 
                                .MEM_CLKO(MEM_CLKO), 
                                .PA_CLK25M(PA_CLK25M), 
                                .VP());
   dsw_read_MUSER_rcv  dsw_read0 (.CLK(CLK25M), 
                                 .C_DONE(C_DONE), 
                                 .C_DONE_DLY(C_DONE_DLY), 
                                 .DSW_TP(DSW_TP));
   input_rcv_MUSER_rcv  input_rcv0 (.CLK25M(CLK25M), 
                                   .CLK72M(CLK72M), 
                                   .CLK125M(CLK125M), 
                                   .CMD_BRIGHTNESS(CMD_BRIGHTNESS[6:0]), 
                                   .CMD_CT_BLUE(CMD_CT_BLUE[3:0]), 
                                   .CMD_CT_GREEN(CMD_CT_GREEN[3:0]), 
                                   .CMD_CT_RED(CMD_CT_RED[3:0]), 
                                   .CMD_GAMMA(CMD_GAMMA[2:0]), 
                                   .CMD_M4_BANK1(CMD_M4_BANK1), 
                                   .CMD_M4_ON(CMD_M4_ON), 
                                   .CMD_TEST_PAT(CMD_TEST_PAT[7:0]), 
                                   .C_DONE(C_DONE_DLY), 
                                   .DSW_PAD_UPDATE(), 
                                   .EMB_RXD(EMB_RXD), 
                                   .EMB_TX_DATA(EMB_TX_DATA[79:0]), 
                                   .EMB_TX_REQ(EMB_TX_REQ), 
                                   .MEM_PAD(), 
                                   .MEM_PAD_ENA(H), 
                                   .M4_SET_DONE(M4_SET_DONE), 
                                   .PA_LINK_ON(PA_LINK_ON), 
                                   .PA_RXD(PA_RXD[3:0]), 
                                   .PA_RX_CLK(PA_RX_CLK), 
                                   .PA_RX_DV(PA_RX_DV), 
                                   .PA_TX_CLK(PA_TX_CLK), 
                                   .SPI_MISO(SPI_MISO), 
                                   .STARTN_DLY(STARTN_DLY), 
                                   .BRIGHTNESS(BRIGHTNESS[6:0]), 
                                   .COLOR_LOSS(), 
                                   .COLOR_LOSS_ON_N(), 
                                   .CS(CS), 
                                   .CTRLD_CSUM_OK(), 
                                   .CT_BLUE(CT_BLUE[3:0]), 
                                   .CT_GREEN(CT_GREEN[3:0]), 
                                   .CT_RED(CT_RED[3:0]), 
                                   .EMB_RSP_DATA(EMB_RSP_DATA[79:0]), 
                                   .EMB_RSP_REQ(EMB_RSP_REQ), 
                                   .EMB_TXD(EMB_TXD), 
                                   .ER_UPDATE(), 
                                   .FRAME_ALT(FRAME_ALT), 
                                   .FRAME_ALT_FRZ(FRAME_ALT_FRZ), 
                                   .FREEZE(), 
                                   .FR_RATE(FR_RATE[15:0]), 
                                   .GAMMA(GAMMA[2:0]), 
                                   .HSTP(HSTP[10:0]), 
                                   .H_SIZE(H_SIZE[10:0]), 
                                   .L(), 
                                   .M4_BANK1(M4_BANK1), 
                                   .M4_BRT(M4_BRT[6:0]), 
                                   .M4_ON(M4_ON), 
                                   .OUT_CH(), 
                                   .OVP(OVP), 
                                   .PAC_STP(PAC_STP), 
                                   .PAC1_OK(), 
                                   .PANEL_NUM(), 
                                   .PA_CSUM_ERR(PA_CSUM_ERR), 
                                   .PA_RX_OK(PA_RX_OK), 
                                   .PA_TXD(PA_TXD[3:0]), 
                                   .PA_TX_EN(PA_TX_EN), 
                                   .PNL_ADRS_UPDATE(), 
                                   .REBOOT_N(REBOOT_N), 
                                   .RH_CSUM_OK_P(), 
                                   .RXD(RXD[7:0]), 
                                   .RX_FAN_ON(), 
                                   .RX_IM_DOWNLOAD(RX_IM_DOWNLOAD), 
                                   .RX_OK(), 
                                   .RX50HZ(RX50HZ), 
                                   .SCK(SCK), 
                                   .SENS_SCL(SENS_SCL), 
                                   .SENS_SCL_TP(), 
                                   .SENS_SDA_TP(), 
                                   .SPI_MOSI(SPI_MOSI), 
                                   .TMP_CSUM_OK_P(), 
                                   .TOTAL_PANEL(), 
                                   .UPDATE_ER_ON(), 
                                   .UPDATE_PNL_NUM(), 
                                   .VSTP(VSTP[10:0]), 
                                   .V_SIZE(V_SIZE[10:0]), 
                                   .SENS_SDA(SENS_SDA));
   led_ctrl_b_MUSER_rcv  led_ctrl_b0 (.CLK(CLK25M), 
                                     .CSUM_ERR_SEL(L), 
                                     .C_DONE(C_DONE), 
                                     .DSW_IM_DOWNLOAD_ON(DSW_IM_DOWNLOAD_ON), 
                                     .FRAME_ALT(FRAME_ALT), 
                                     .IM_DOWNLOAD_EXE_TIM(IM_DOWNLOAD_EXE_TIM), 
                                     .IM_ERR_DET(IM_ERR_DET), 
                                     .PA_CSUM_ERR(PA_CSUM_ERR), 
                                     .PA_LED1(PA_LED1), 
                                     .PA_LED2(PA_LED2), 
                                     .PA_RX_OK(PA_RX_OK), 
                                     .SEL_PORT_B(), 
                                     .VER(FPGA_VER[7:0]), 
                                     .LED_A(LED_A), 
                                     .PA_LINK_ON(PA_LINK_ON));
   output_rcv_lcar_m5353Q_14b43Hz_MUSER_rcv  output_rcv_0 (.ADDCLK(ADDCLK), 
                                                          .ADDSDA(ADDSDA), 
                                                          .CLK(CLK25M), 
                                                          .CLK31M(CLK31M), 
                                                          .CLK125M(CLK125M), 
                                                          .C_DONE(C_DONE_DLY), 
                                                          
         .FM_CYCLE_STP(MEM_CYCLE_STP), 
                                                          
         .FM_RD_D(MEM_RD_D[31:0]), 
                                                          
         .FRAME_ALT(FRAME_ALT), 
                                                          
         .FRAME_ALT_FRZ(FRAME_ALT_FRZ), 
                                                          
         .FR_RATE(FR_RATE[15:0]), 
                                                          .F50HZ(RX50HZ), 
                                                          .M4_SET_DONE(H), 
                                                          .OCLK(CLK125M_SS), 
                                                          
         .RGB_OUT_ZERO(RGB_OUT_ZERO[2:0]), 
                                                          
         .CLK125M_SS(CLK125M_SS), 
                                                          .CN2_D(CN2_D[27:0]), 
                                                          
         .FM_OV_RD_ADRS(FM_OV_RD_ADRS[18:0]), 
                                                          
         .FM_OV_RD_CYCLE(FM_OV_RD_CYCLE), 
                                                          .XGCLK60_DCM_RST());
   video_process_MUSER_rcv  video_process0 (.BRIGHTNESS(BRIGHTNESS[6:0]), 
                                           .CHECK(L), 
                                           .CLK(CLK125M), 
                                           .CT_BLUE(CT_BLUE[3:0]), 
                                           .CT_GREEN(CT_GREEN[3:0]), 
                                           .CT_RED(CT_RED[3:0]), 
                                           .C_DONE(C_DONE_DLY), 
                                           .FRAME_ALT(FRAME_ALT), 
                                           .FRAME_ALT_FRZ(FRAME_ALT_FRZ), 
                                           .GAMMA(GAMMA[2:0]), 
                                           .HSTP(HSTP[10:0]), 
                                           .H_SIZE(H_SIZE[10:0]), 
                                           .M4_BRT(M4_BRT[6:0]), 
                                           
         .M4_CMD_RD_ADRS(FM_M4_CMD_RD_ADRS[18:0]), 
                                           
         .M4_CMD_RD_BANK1(FM_M4_CMD_RD_BANK1), 
                                           
         .M4_CMD_RD_CYCLE(FM_M4_CMD_RD_CYCLE), 
                                           
         .M4_CMD_WR_ADRS(FM_M4_CMD_WR_ADRS[18:0]), 
                                           
         .M4_CMD_WR_BANK1(FM_M4_CMD_WR_BANK1), 
                                           
         .M4_CMD_WR_CYCLE(FM_M4_CMD_WR_CYCLE), 
                                           .M4_CMD_WR_D(FM_M4_CMD_WR_D[31:0]), 
                                           
         .M4_CMD_WR_DQM(FM_M4_CMD_WR_DQM[3:0]), 
                                           .M4_ON(M4_ON), 
                                           
         .OUT_VID_RD_ADRS(FM_OV_RD_ADRS[18:0]), 
                                           .OUT_VID_RD_CYCLE(FM_OV_RD_CYCLE), 
                                           .OVP(OVP), 
                                           .PAC_STP(PAC_STP), 
                                           .PANEL_SEL(PANEL_SEL[3:0]), 
                                           .RXD(RXD[7:0]), 
                                           .VSTP(VSTP[10:0]), 
                                           .V_SIZE(V_SIZE[10:0]), 
                                           .FM_IN_RD_B(), 
                                           .FM_IN_RD_G(), 
                                           .FM_IN_RD_R(), 
                                           .FM_IV_RD_CYCLE(), 
                                           .FM_IV_WR_CYCLE(), 
                                           .FM_OV_WR_CYCLE(), 
                                           .MEM_A(MEM_A[10:0]), 
                                           .MEM_BA(MEM_BA[1:0]), 
                                           .MEM_CAS_N(MEM_CAS_N), 
                                           .MEM_CKE(MEM_CKE), 
                                           .MEM_CS_N(MEM_CS_N), 
                                           .MEM_CYCLE_STP(MEM_CYCLE_STP), 
                                           .MEM_DQM(MEM_DQM[3:0]), 
                                           .MEM_M4_CMD_CYCLE(MEM_M4_CMD_CYCLE), 
                                           .MEM_RAS_N(MEM_RAS_N), 
                                           .MEM_RD_D(MEM_RD_D[31:0]), 
                                           .MEM_WE_N(MEM_WE_N), 
                                           .PUP_TIME(), 
                                           .MEM_D(MEM_D[31:0]));
   (* IOSTANDARD = "DEFAULT" *) (* IBUF_DELAY_VALUE = "0" *) (* 
         IFD_DELAY_VALUE = "AUTO" *) 
   IBUF  XLXI_2 (.I(C_DONE_IN), 
                .O(C_DONE));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_39 (.I(C_DONE), 
                 .O(ENET_RST_N));
   GND  XLXI_94 (.G(L));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_95 (.I(XLXN_475), 
                 .O(RECONF_N));
   VCC  XLXI_350 (.P(H));
   m4_coeff_ctrl_xt_MUSER_rcv  XLXI_587 (.BRIGHTNESS(BRIGHTNESS[6:0]), 
                                        .CLK25M(CLK25M), 
                                        .CLK72M(CLK72M), 
                                        .CLK125M(CLK125M), 
                                        .CT_BLUE(CT_BLUE[3:0]), 
                                        .CT_GREEN(CT_GREEN[3:0]), 
                                        .CT_RED(CT_RED[3:0]), 
                                        .C_DONE_DLY(C_DONE_DLY), 
                                        .DSW_IM_DOWNLOAD_REQ(), 
                                        .DSW_LOSS_BRT100(), 
                                        .EMB_RSP_DATA(EMB_RSP_DATA[79:0]), 
                                        .EMB_RSP_REQ(EMB_RSP_REQ), 
                                        .FPGA_VER(FPGA_VER[7:0]), 
                                        .FRAME_ALT(FRAME_ALT), 
                                        .GAMMA(GAMMA[2:0]), 
                                        .MEM_COLOR_LOSS(), 
                                        .MEM_CYCLE_STP(MEM_CYCLE_STP), 
                                        .MEM_M4_CMD_CYCLE(MEM_M4_CMD_CYCLE), 
                                        .MEM_RD_D(MEM_RD_D[31:0]), 
                                        .M4_BANK1(M4_BANK1), 
                                        .M4_ON(M4_ON), 
                                        .PANEL_SEL(PANEL_SEL[3:0]), 
                                        .RS232C_RXD(RS232C_RXD), 
                                        .RX_IM_DOWNLOAD_ON(RX_IM_DOWNLOAD), 
                                        .TEST_PAT(), 
                                        .ADDCLK(ADDCLK), 
                                        .ADDSDA(ADDSDA), 
                                        .CMD_BAUD_RATE(), 
                                        .CMD_BRIGHTNESS(CMD_BRIGHTNESS[6:0]), 
                                        .CMD_CT_BLUE(CMD_CT_BLUE[3:0]), 
                                        .CMD_CT_GREEN(CMD_CT_GREEN[3:0]), 
                                        .CMD_CT_RED(CMD_CT_RED[3:0]), 
                                        .CMD_GAMMA(CMD_GAMMA[2:0]), 
                                        .CMD_M4_BANK1(CMD_M4_BANK1), 
                                        .CMD_M4_ON(CMD_M4_ON), 
                                        .CMD_REBOOT_N(CMD_REBOOT_N), 
                                        .CMD_TEST_PAT(CMD_TEST_PAT[7:0]), 
                                        .COLOR_LOSS(COLOR_LOSS[2:0]), 
                                        
         .DSW_IM_DOWNLOAD_ON(DSW_IM_DOWNLOAD_ON), 
                                        .EMB_TX_DATA(EMB_TX_DATA[79:0]), 
                                        .EMB_TX_REQ(EMB_TX_REQ), 
                                        .IM_CH_SEL0(CN3_CH_SEL0), 
                                        .IM_CH_SEL1(CN3_CH_SEL1), 
                                        .IM_CH_SEL2(), 
                                        .IM_DIR(CN3_DIR), 
                                        
         .IM_DOWNLOAD_EXE_TIM(IM_DOWNLOAD_EXE_TIM), 
                                        .IM_ERR_DETO(IM_ERR_DET), 
                                        .IM_SCL(CN3_SCL), 
                                        .MEM_CLEAR_DONE_N(), 
                                        .M4_CMD_RADRS(FM_M4_CMD_RD_ADRS[18:0]), 
                                        .M4_CMD_RD_BANK1(FM_M4_CMD_RD_BANK1), 
                                        .M4_CMD_RD_CYCLE(FM_M4_CMD_RD_CYCLE), 
                                        .M4_CMD_WADRS(FM_M4_CMD_WR_ADRS[18:0]), 
                                        .M4_CMD_WDATA(FM_M4_CMD_WR_D[31:0]), 
                                        .M4_CMD_WR_BANK1(FM_M4_CMD_WR_BANK1), 
                                        .M4_CMD_WR_CYCLE(FM_M4_CMD_WR_CYCLE), 
                                        .M4_CMD_WR_DQM(FM_M4_CMD_WR_DQM[3:0]), 
                                        .M4_SET_DONE(M4_SET_DONE), 
                                        
         .PIXEL_DISP_RGB_ON(PIXEL_DISP_RGB[2:0]), 
                                        
         .PIXEL1_DISP_MODE(PIXEL1_DISP_MODE[23:0]), 
                                        .PIXEL1_DISP_ON(PIXEL1_DISP_ON), 
                                        .PIXEL4_DISP_ON(PIXEL4_DISP_ON), 
                                        .RGB_OUT_ZERO(RGB_OUT_ZERO[2:0]), 
                                        .RS232C_RXD_A(), 
                                        .RS232C_TXD(RS232C_TXD), 
                                        .RS232C_TXD_A(), 
                                        .STARTN_DLY(STARTN_DLY), 
                                        .TESTP_LEVEL(TESTP_LEVEL[7:0]), 
                                        .TESTP_RGB_EN(TESTP_RGB_EN[2:0]), 
                                        .TP1(), 
                                        .TP2(), 
                                        .TP3(), 
                                        .TP4(), 
                                        .TP5(), 
                                        .TP6(), 
                                        .TP7(), 
                                        .TP8(), 
                                        .IM_SDA(CN3_SDA));
   buf8b_MUSER_rcv  XLXI_590 (.I({L, L, L, L, L, H, L, H}), 
                             .O(FPGA_VER[7:0]));
   AND2  XLXI_951 (.I0(CMD_REBOOT_N), 
                  .I1(REBOOT_N), 
                  .O(XLXN_475));
   buf4b_MUSER_rcv  XLXI_984 (.I({L, L, L, L}), 
                             .O(PANEL_SEL[3:0]));
   INV  XLXI_985 (.I(C_DONE), 
                 .O(XLXN_477));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_987 (.I(XLXN_477), 
                  .O(OUT_ENA_N));
endmodule

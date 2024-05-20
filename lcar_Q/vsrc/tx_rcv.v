module tx_rcv(CLK25M, 
              CLK72M, 
              C_DONE, 
              EMB_RXD, 
              EMB_TX_DATA, 
              EMB_TX_REQ, 
              FRAME_ALT, 
              PA_DST_IP, 
              PA_DST_MAC, 
              PA_DST_PORT, 
              PA_LINK_ON, 
              PA_RX_OK, 
              PA_SRC_IP, 
              PA_SRC_MAC, 
              PA_SRC_PORT, 
              RX_FAN_ON, 
              SS_NE, 
              STARTN_DLY, 
              tcm_e, 
              tcm_v, 
              tcm_wd, 
              TX_CLK, 
              EMB_RSP_DATA, 
              EMB_RSP_REQ, 
              EMB_TXD, 
              PA_TXD, 
              PA_TX_EN, 
              RH_CSUM_OK_P, 
              SENS_SCL, 
              SENS_SCL_TP, 
              SENS_SDA_TP, 
              TMP_CSUM_OK_P, 
              SENS_SDA);

    input CLK25M;
    input CLK72M;
    input C_DONE;
    input EMB_RXD;
    input [79:0] EMB_TX_DATA;
    input EMB_TX_REQ;
    input FRAME_ALT;
    input [31:0] PA_DST_IP;
    input [47:0] PA_DST_MAC;
    input [15:0] PA_DST_PORT;
    input PA_LINK_ON;
    input PA_RX_OK;
    input [31:0] PA_SRC_IP;
    input [47:0] PA_SRC_MAC;
    input [15:0] PA_SRC_PORT;
    input RX_FAN_ON;
    input SS_NE;
    input STARTN_DLY;
    input tcm_e;
    input tcm_v;
    input [7:0] tcm_wd;
    input TX_CLK;
   output [79:0] EMB_RSP_DATA;
   output EMB_RSP_REQ;
   output EMB_TXD;
   output [3:0] PA_TXD;
   output PA_TX_EN;
   output RH_CSUM_OK_P;
   output SENS_SCL;
   output SENS_SCL_TP;
   output SENS_SDA_TP;
   output TMP_CSUM_OK_P;
    inout SENS_SDA;
   
   wire [15:0] EMB_HUMID;
   wire [15:0] EMB_POWER1;
   wire [15:0] EMB_POWER2;
   wire [15:0] EMB_POWER3;
   wire [15:0] EMB_POWER4;
   wire [15:0] EMB_POWER5;
   wire [15:0] EMB_POWER6;
   wire [15:0] EMB_POWER7;
   wire [15:0] EMB_POWER8;
   wire [15:0] EMB_TEMP;
   wire H;
   wire [15:0] SENS_HUMID;
   wire [15:0] SENS_POWER;
   wire [15:0] SENS_TEMP;
   wire STARTN;
   wire XLXN_86;
   wire XLXN_89;
   wire SENS_SCL_TP_DUMMY;
   wire SENS_SDA_TP_DUMMY;
   
   assign SENS_SCL_TP = SENS_SCL_TP_DUMMY;
   assign SENS_SDA_TP = SENS_SDA_TP_DUMMY;
   adc_sensor_ctrl_b  adc_sensor0 (.clk(CLK25M), 
                                  .frame_alt(FRAME_ALT), 
                                  .sda_in(SENS_SDA_TP_DUMMY), 
                                  .startn_in(STARTN), 
                                  .adc_err_det(), 
                                  .adc2_err_det(), 
                                  .busy(), 
                                  .cnt_rst(), 
                                  .rh_csum_ok_p(RH_CSUM_OK_P), 
                                  .rh_dout(SENS_HUMID[15:0]), 
                                  .scl(SENS_SCL_TP_DUMMY), 
                                  .sdao(XLXN_86), 
                                  .sda_ot(XLXN_89), 
                                  .sens_err_det(), 
                                  .tmp_csum_ok_p(TMP_CSUM_OK_P), 
                                  .tmp_dout(SENS_TEMP[15:0]), 
                                  .volt_dout(SENS_POWER[15:0]));
   rs232c_emb_MUSER_tx_rcv  rs232c_emb0 (.CLK(CLK72M), 
                                        .EMB_TX_DATA(EMB_TX_DATA[79:0]), 
                                        .EMB_TX_REQ(EMB_TX_REQ), 
                                        .FRAME_ALT(FRAME_ALT), 
                                        .RXD(EMB_RXD), 
                                        .SDI_FAN_ON(RX_FAN_ON), 
                                        .STARTN(STARTN), 
                                        .STARTN_DLY(STARTN_DLY), 
                                        .CMD_RX_REQ(), 
                                        .CMD_TX_REQ(), 
                                        .EMB_BAUD_RATE(), 
                                        .EMB_RSP_DATA(EMB_RSP_DATA[79:0]), 
                                        .EMB_RSP_REQ(EMB_RSP_REQ), 
                                        .EMB_TP_OUT(), 
                                        .HUMIDITY1(EMB_HUMID[15:0]), 
                                        .HUMIDITY2(), 
                                        .POWER1(EMB_POWER1[15:0]), 
                                        .POWER2(EMB_POWER2[15:0]), 
                                        .POWER3(EMB_POWER3[15:0]), 
                                        .POWER4(EMB_POWER4[15:0]), 
                                        .POWER5(EMB_POWER5[15:0]), 
                                        .POWER6(EMB_POWER6[15:0]), 
                                        .POWER7(EMB_POWER7[15:0]), 
                                        .POWER8(EMB_POWER8[15:0]), 
                                        .POWER9(), 
                                        .RXD_O(), 
                                        .TEMPERATURE1(EMB_TEMP[15:0]), 
                                        .TEMPERATURE2(), 
                                        .TXD(EMB_TXD));
   tx_process_MUSER_tx_rcv  tx_process_a (.CLK25M(CLK25M), 
                                         .DST_IP(PA_DST_IP[31:0]), 
                                         .DST_MAC(PA_DST_MAC[47:0]), 
                                         .DST_PORT(PA_DST_PORT[15:0]), 
                                         .frame_alt(FRAME_ALT), 
                                         .HUMID1(SENS_HUMID[15:0]), 
                                         .HUMID2(EMB_HUMID[15:0]), 
                                         .LINK_ON(PA_LINK_ON), 
                                         .POWER1(SENS_POWER[15:0]), 
                                         .POWER2(EMB_POWER1[15:0]), 
                                         .RX_OK(PA_RX_OK), 
                                         .SRC_IP(PA_SRC_IP[31:0]), 
                                         .SRC_MAC(PA_SRC_MAC[47:0]), 
                                         .SRC_PORT(PA_SRC_PORT[15:0]), 
                                         .SS_NE(SS_NE), 
                                         .tcm_e(tcm_e), 
                                         .tcm_v(tcm_v), 
                                         .tcm_wd(tcm_wd[7:0]), 
                                         .TEMP1(SENS_TEMP[15:0]), 
                                         .TEMP2(EMB_TEMP[15:0]), 
                                         .TX_CLK(TX_CLK), 
                                         .TXD(PA_TXD[3:0]), 
                                         .TX_EN(PA_TX_EN));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) (* 
         IBUF_DELAY_VALUE = "0" *) (* IFD_DELAY_VALUE = "AUTO" *) 
   IOBUF  XLXI_25 (.I(XLXN_86), 
                  .T(XLXN_89), 
                  .O(SENS_SDA_TP_DUMMY), 
                  .IO(SENS_SDA));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_26 (.I(SENS_SCL_TP_DUMMY), 
                 .O(SENS_SCL));
   INV  XLXI_32 (.I(C_DONE), 
                .O(STARTN));
   VCC  XLXI_33 (.P(H));
endmodule

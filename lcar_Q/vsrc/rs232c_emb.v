module rs232c_emb(CLK, 
                  EMB_TX_DATA, 
                  EMB_TX_REQ, 
                  FRAME_ALT, 
                  RXD, 
                  SDI_FAN_ON, 
                  STARTN, 
                  STARTN_DLY, 
                  CMD_RX_REQ, 
                  CMD_TX_REQ, 
                  EMB_BAUD_RATE, 
                  EMB_RSP_DATA, 
                  EMB_RSP_REQ, 
                  EMB_TP_OUT, 
                  HUMIDITY1, 
                  HUMIDITY2, 
                  POWER1, 
                  POWER2, 
                  POWER3, 
                  POWER4, 
                  POWER5, 
                  POWER6, 
                  POWER7, 
                  POWER8, 
                  POWER9, 
                  RXD_O, 
                  TEMPERATURE1, 
                  TEMPERATURE2, 
                  TXD);

    input CLK;
    input [79:0] EMB_TX_DATA;
    input EMB_TX_REQ;
    input FRAME_ALT;
    input RXD;
    input SDI_FAN_ON;
    input STARTN;
    input STARTN_DLY;
   output CMD_RX_REQ;
   output CMD_TX_REQ;
   output [1:0] EMB_BAUD_RATE;
   output [79:0] EMB_RSP_DATA;
   output EMB_RSP_REQ;
   output [7:0] EMB_TP_OUT;
   output [15:0] HUMIDITY1;
   output [15:0] HUMIDITY2;
   output [15:0] POWER1;
   output [15:0] POWER2;
   output [15:0] POWER3;
   output [15:0] POWER4;
   output [15:0] POWER5;
   output [15:0] POWER6;
   output [15:0] POWER7;
   output [15:0] POWER8;
   output [15:0] POWER9;
   output RXD_O;
   output [15:0] TEMPERATURE1;
   output [15:0] TEMPERATURE2;
   output TXD;
   
   wire H;
   wire L;
   wire RST;
   wire TX_TIMEOUT;
   wire [7:0] XLXN_12;
   wire XLXN_80;
   wire [7:0] XLXN_81;
   wire XLXN_82;
   wire XLXN_83;
   wire XLXN_85;
   wire XLXN_98;
   wire XLXN_99;
   wire XLXN_100;
   wire XLXN_138;
   wire [79:0] XLXN_142;
   wire [79:0] XLXN_144;
   wire XLXN_154;
   wire XLXN_159;
   wire RXD_O_DUMMY;
   wire CMD_RX_REQ_DUMMY;
   wire CMD_TX_REQ_DUMMY;
   wire [1:0] EMB_BAUD_RATE_DUMMY;
   
   assign CMD_RX_REQ = CMD_RX_REQ_DUMMY;
   assign CMD_TX_REQ = CMD_TX_REQ_DUMMY;
   assign EMB_BAUD_RATE[1:0] = EMB_BAUD_RATE_DUMMY[1:0];
   assign RXD_O = RXD_O_DUMMY;
   VCC  XLXI_5 (.P(H));
   GND  XLXI_6 (.G(L));
   fd1_MUSER_rs232c_emb  XLXI_7 (.CK(CLK), 
                                .D(STARTN), 
                                .Q(XLXN_138));
   uart_if_emb  XLXI_14 (.clk(CLK), 
                        .cmd_tx_req(CMD_TX_REQ_DUMMY), 
                        .rst(RST), 
                        .rx_data(XLXN_81[7:0]), 
                        .rx_frm_err(XLXN_82), 
                        .rx_prty_err(XLXN_83), 
                        .rx_time_out_on(H), 
                        .rx_vld(XLXN_80), 
                        .tx_busy(XLXN_99), 
                        .tx_cmd_data(XLXN_142[79:0]), 
                        .tx_done(XLXN_100), 
                        .cmd_rx_req(CMD_RX_REQ_DUMMY), 
                        .cmd_tx_done(), 
                        .rcv_ok(XLXN_85), 
                        .rx_cmd_data(XLXN_144[79:0]), 
                        .rx_time_out(), 
                        .tx_brk(), 
                        .tx_data(XLXN_12[7:0]), 
                        .tx_vld(XLXN_98));
   (* IOSTANDARD = "DEFAULT" *) (* IBUF_DELAY_VALUE = "0" *) (* 
         IFD_DELAY_VALUE = "AUTO" *) 
   IBUF  XLXI_15 (.I(RXD), 
                 .O(RXD_O_DUMMY));
   OR2  XLXI_16 (.I0(XLXN_154), 
                .I1(STARTN_DLY), 
                .O(XLXN_159));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_18 (.I(XLXN_159), 
                 .O(TXD));
   uart_core_mpc_a  XLXI_19 (.brdsel(EMB_BAUD_RATE_DUMMY[1:0]), 
                            .clk(CLK), 
                            .prtysel({L, L}), 
                            .rst(RST), 
                            .rxd(RXD_O_DUMMY), 
                            .stpsel(L), 
                            .tx_brk(L), 
                            .tx_data(XLXN_12[7:0]), 
                            .tx_vld(XLXN_98), 
                            .rx_brk(), 
                            .rx_data(XLXN_81[7:0]), 
                            .rx_frm_err(XLXN_82), 
                            .rx_prty_err(XLXN_83), 
                            .rx_vld(XLXN_80), 
                            .txd(XLXN_154), 
                            .tx_busy(XLXN_99), 
                            .tx_done(XLXN_100));
   OR3  XLXI_21 (.I0(TX_TIMEOUT), 
                .I1(XLXN_138), 
                .I2(STARTN), 
                .O(RST));
   cmd_if_emb_xt_a  XLXI_22 (.clk(CLK), 
                            .cmd_rx_req(CMD_RX_REQ_DUMMY), 
                            .ext_cmd_data(EMB_TX_DATA[79:0]), 
                            .ext_cmd_tx_req(EMB_TX_REQ), 
                            .fan_set_ena(L), 
                            .frame_alt(FRAME_ALT), 
                            .humid_ena({L, L}), 
                            .pwr_ena({H, H, H, H, H, H, H, H, H}), 
                            .rcv_ok(XLXN_85), 
                            .rst(RST), 
                            .rx_cmd_data(XLXN_144[79:0]), 
                            .rx_timeout_set({L, L, L, L, H, H, H}), 
                            .sdi_fan_cmd_ena(L), 
                            .sdi_fan_on(SDI_FAN_ON), 
                            .sensor_port_sel({L, L}), 
                            .temp_ena({L, H}), 
                            .cmd_tx_req(CMD_TX_REQ_DUMMY), 
                            .emb_baud_rate(EMB_BAUD_RATE_DUMMY[1:0]), 
                            .humidity1(HUMIDITY1[15:0]), 
                            .humidity2(HUMIDITY2[15:0]), 
                            .power1(POWER1[15:0]), 
                            .power2(POWER2[15:0]), 
                            .power3(POWER3[15:0]), 
                            .power4(POWER4[15:0]), 
                            .power5(POWER5[15:0]), 
                            .power6(POWER6[15:0]), 
                            .power7(POWER7[15:0]), 
                            .power8(POWER8[15:0]), 
                            .power9(POWER9[15:0]), 
                            .rsp_data(EMB_RSP_DATA[79:0]), 
                            .rsp_rx_req(EMB_RSP_REQ), 
                            .sens_num(), 
                            .temperature1(TEMPERATURE1[15:0]), 
                            .temperature2(TEMPERATURE2[15:0]), 
                            .tp_out(EMB_TP_OUT[7:0]), 
                            .tx_cmd_data(XLXN_142[79:0]), 
                            .tx_timeout(TX_TIMEOUT));
endmodule

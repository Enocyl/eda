module rgmii_rx(RXD, 
                RX_CLK, 
                RX_DV, 
                RXDQ, 
                RX_DVQ, 
                RX_ER);

    input [3:0] RXD;
    input RX_CLK;
    input RX_DV;
   output [7:0] RXDQ;
   output RX_DVQ;
   output RX_ER;
   
   wire XLXN_2;
   wire XLXN_3;
   wire XLXN_4;
   wire XLXN_10;
   wire XLXN_11;
   wire XLXN_12;
   wire XLXN_17;
   wire XLXN_18;
   wire XLXN_19;
   wire XLXN_24;
   wire XLXN_25;
   wire XLXN_26;
   wire XLXN_31;
   wire XLXN_32;
   wire XLXN_33;
   wire XLXN_42;
   wire XLXN_151;
   wire XLXN_152;
   wire XLXN_153;
   wire XLXN_154;
   wire XLXN_155;
   wire XLXN_163;
   wire XLXN_164;
   wire XLXN_165;
   wire XLXN_166;
   wire XLXN_167;
   wire XLXN_168;
   wire XLXN_169;
   wire XLXN_170;
   wire XLXN_171;
   wire XLXN_172;
   wire XLXN_177;
   wire XLXN_178;
   wire XLXN_179;
   wire XLXN_180;
   wire XLXN_181;
   wire RX_DVQ_DUMMY;
   
   assign RX_DVQ = RX_DVQ_DUMMY;
//   IODELAY2 #( .DELAY_SRC("IDATAIN"), .DATA_RATE("DDR"), 
//         .COUNTER_WRAPAROUND("STAY_AT_LIMIT"), .IDELAY_TYPE("FIXED"), 
//         .IDELAY2_VALUE(0), .IDELAY_MODE("NORMAL"), .IDELAY_VALUE(0), 
//         .ODELAY_VALUE(0), .SERDES_MODE("NONE"), .SIM_TAPDELAY_VALUE(75) ) 
//         delay_rgmii_rxd0 (.CAL(1'b0), 
//                              .CE(1'b0), 
//                              .CLK(1'b0), 
//                              .IDATAIN(RXD[0]), 
//                              .INC(1'b0), 
//                              .IOCLK0(1'b0), 
//                              .IOCLK1(1'b0), 
//                              .ODATAIN(1'b0), 
//                              .RST(1'b0), 
//                              .T(1'b1), 
//                              .BUSY(), 
//                              .DATAOUT(XLXN_151), 
//                              .DATAOUT2(), 
//                              .DOUT(), 
//                              .TOUT());
//   IODELAY2 #( .DELAY_SRC("IDATAIN"), .DATA_RATE("DDR"), 
//         .COUNTER_WRAPAROUND("STAY_AT_LIMIT"), .IDELAY_TYPE("FIXED"), 
//         .IDELAY2_VALUE(0), .IDELAY_MODE("NORMAL"), .IDELAY_VALUE(0), 
//         .ODELAY_VALUE(0), .SERDES_MODE("NONE"), .SIM_TAPDELAY_VALUE(75) ) 
//         delay_rgmii_rxd1 (.CAL(1'b0), 
//                              .CE(1'b0), 
//                              .CLK(1'b0), 
//                              .IDATAIN(RXD[1]), 
//                              .INC(1'b0), 
//                              .IOCLK0(1'b0), 
//                              .IOCLK1(1'b0), 
//                              .ODATAIN(1'b0), 
//                              .RST(1'b0), 
//                              .T(1'b1), 
//                              .BUSY(), 
//                              .DATAOUT(XLXN_152), 
//                              .DATAOUT2(), 
//                              .DOUT(), 
//                              .TOUT());
//   IODELAY2 #( .DELAY_SRC("IDATAIN"), .DATA_RATE("DDR"), 
//         .COUNTER_WRAPAROUND("STAY_AT_LIMIT"), .IDELAY_TYPE("FIXED"), 
//         .IDELAY2_VALUE(0), .IDELAY_MODE("NORMAL"), .IDELAY_VALUE(0), 
//         .ODELAY_VALUE(0), .SERDES_MODE("NONE"), .SIM_TAPDELAY_VALUE(75) ) 
//         delay_rgmii_rxd2 (.CAL(1'b0), 
//                              .CE(1'b0), 
//                              .CLK(1'b0), 
//                              .IDATAIN(RXD[2]), 
//                              .INC(1'b0), 
//                              .IOCLK0(1'b0), 
//                              .IOCLK1(1'b0), 
//                              .ODATAIN(1'b0), 
//                              .RST(1'b0), 
//                              .T(1'b1), 
//                              .BUSY(), 
//                              .DATAOUT(XLXN_153), 
//                              .DATAOUT2(), 
//                              .DOUT(), 
//                              .TOUT());
//   IODELAY2 #( .DELAY_SRC("IDATAIN"), .DATA_RATE("DDR"), 
//         .COUNTER_WRAPAROUND("STAY_AT_LIMIT"), .IDELAY_TYPE("FIXED"), 
//         .IDELAY2_VALUE(0), .IDELAY_MODE("NORMAL"), .IDELAY_VALUE(0), 
//         .ODELAY_VALUE(0), .SERDES_MODE("NONE"), .SIM_TAPDELAY_VALUE(75) ) 
//         delay_rgmii_rxd3 (.CAL(1'b0), 
//                              .CE(1'b0), 
//                              .CLK(1'b0), 
//                              .IDATAIN(RXD[3]), 
//                              .INC(1'b0), 
//                              .IOCLK0(1'b0), 
//                              .IOCLK1(1'b0), 
//                              .ODATAIN(1'b0), 
//                              .RST(1'b0), 
//                              .T(1'b1), 
//                              .BUSY(), 
//                              .DATAOUT(XLXN_154), 
//                              .DATAOUT2(), 
//                              .DOUT(), 
//                              .TOUT());
//   IODELAY2 #( .DELAY_SRC("IDATAIN"), .DATA_RATE("DDR"), 
//         .COUNTER_WRAPAROUND("STAY_AT_LIMIT"), .IDELAY_TYPE("FIXED"), 
//         .IDELAY2_VALUE(0), .IDELAY_MODE("NORMAL"), .IDELAY_VALUE(0), 
//         .ODELAY_VALUE(0), .SERDES_MODE("NONE"), .SIM_TAPDELAY_VALUE(75) ) 
//         delay_rgmii_rx_dv (.CAL(1'b0), 
//                               .CE(1'b0), 
//                               .CLK(1'b0), 
//                               .IDATAIN(RX_DV), 
//                               .INC(1'b0), 
//                               .IOCLK0(1'b0), 
//                               .IOCLK1(1'b0), 
//                               .ODATAIN(1'b0), 
//                               .RST(1'b0), 
//                               .T(1'b1), 
//                               .BUSY(), 
//                               .DATAOUT(XLXN_155), 
//                               .DATAOUT2(), 
//                               .DOUT(), 
//                               .TOUT());
//   IDDR2 #( .DDR_ALIGNMENT("C0"), .INIT_Q0(1'b0), .INIT_Q1(1'b0), 
//         .SRTYPE("SYNC") ) XLXI_1 (.CE(1'b1), 
//                 .C0(RX_CLK), 
//                 .C1(XLXN_4), 
//                 .D(XLXN_151), 
//                 .R(1'b0), 
//                 .S(1'b0), 
//                 .Q0(XLXN_177), 
//                 .Q1(RXDQ[4]));
//   GND  XLXI_2 (.G(1'b0));
//   VCC  XLXI_3 (.P(1'b1));
//   INV  XLXI_4 (.I(RX_CLK), 
//               .O(XLXN_4));
//   IDDR2 #( .DDR_ALIGNMENT("C0"), .INIT_Q0(1'b0), .INIT_Q1(1'b0), 
//         .SRTYPE("SYNC") ) XLXI_5 (.CE(1'b1), 
//                 .C0(RX_CLK), 
//                 .C1(XLXN_12), 
//                 .D(XLXN_152), 
//                 .R(1'b0), 
//                 .S(1'b0), 
//                 .Q0(XLXN_178), 
//                 .Q1(RXDQ[5]));
//   GND  XLXI_6 (.G(1'b0));
//   VCC  XLXI_7 (.P(1'b1));
//   INV  XLXI_8 (.I(RX_CLK), 
//               .O(XLXN_12));
//   IDDR2 #( .DDR_ALIGNMENT("C0"), .INIT_Q0(1'b0), .INIT_Q1(1'b0), 
//         .SRTYPE("SYNC") ) XLXI_9 (.CE(1'b1), 
//                 .C0(RX_CLK), 
//                 .C1(XLXN_19), 
//                 .D(XLXN_153), 
//                 .R(1'b0), 
//                 .S(1'b0), 
//                 .Q0(XLXN_179), 
//                 .Q1(RXDQ[6]));
//   GND  XLXI_10 (.G(1'b0));
//   VCC  XLXI_11 (.P(1'b1));
//   INV  XLXI_12 (.I(RX_CLK), 
//                .O(XLXN_19));
//   IDDR2 #( .DDR_ALIGNMENT("C0"), .INIT_Q0(1'b0), .INIT_Q1(1'b0), 
//         .SRTYPE("SYNC") ) XLXI_13 (.CE(1'b1), 
//                  .C0(RX_CLK), 
//                  .C1(XLXN_26), 
//                  .D(XLXN_154), 
//                  .R(1'b0), 
//                  .S(1'b0), 
//                  .Q0(XLXN_180), 
//                  .Q1(RXDQ[7]));
//   GND  XLXI_14 (.G(1'b0));
//   VCC  XLXI_15 (.P(1'b1));
//   INV  XLXI_16 (.I(RX_CLK), 
//                .O(XLXN_26));
//   IDDR2 #( .DDR_ALIGNMENT("C0"), .INIT_Q0(1'b0), .INIT_Q1(1'b0), 
//         .SRTYPE("SYNC") ) XLXI_17 (.CE(1'b1), 
//                  .C0(RX_CLK), 
//                  .C1(XLXN_33), 
//                  .D(XLXN_155), 
//                  .R(1'b0), 
//                  .S(1'b0), 
//                  .Q0(XLXN_181), 
//                  .Q1(XLXN_42));
//   GND  XLXI_18 (.G(1'b0));
//   VCC  XLXI_19 (.P(1'b1));
//   INV  XLXI_20 (.I(RX_CLK), 
//                .O(XLXN_33));
//   XOR2  XLXI_21 (.I0(XLXN_42), 
//                 .I1(RX_DVQ_DUMMY), 
//                 .O(RX_ER));
//   GND  XLXI_105 (.G(1'b0));
//   VCC  XLXI_107 (.P(1'b1));
//   GND  XLXI_108 (.G(1'b0));
//   VCC  XLXI_109 (.P(1'b1));
//   GND  XLXI_110 (.G(1'b0));
//   VCC  XLXI_111 (.P(1'b1));
//   GND  XLXI_112 (.G(1'b0));
//   VCC  XLXI_113 (.P(1'b1));
//   GND  XLXI_114 (.G(1'b0));
//   VCC  XLXI_115 (.P(1'b1));
   fd1  XLXI_117 (.CK(RX_CLK), 
                 .D(XLXN_181), 
                 .Q(RX_DVQ_DUMMY));
   fd1  XLXI_118 (.CK(RX_CLK), 
                 .D(XLXN_180), 
                 .Q(RXDQ[3]));
   fd1  XLXI_119 (.CK(RX_CLK), 
                 .D(XLXN_179), 
                 .Q(RXDQ[2]));
   fd1  XLXI_120 (.CK(RX_CLK), 
                 .D(XLXN_178), 
                 .Q(RXDQ[1]));
   fd1  XLXI_121 (.CK(RX_CLK), 
                 .D(XLXN_177), 
                 .Q(RXDQ[0]));
endmodule

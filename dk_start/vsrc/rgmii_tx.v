module rgmii_tx(CLK, 
                CLK_OE, 
                TXC_CLK, 
                TXD_IN, 
                TX_EN, 
                TX_ER, 
                TXC, 
                TXD, 
                TX_CTL);

    input CLK;
    input CLK_OE;
    input TXC_CLK;
    input [7:0] TXD_IN;
    input TX_EN;
    input TX_ER;
   output TXC;
   output [3:0] TXD;
   output TX_CTL;
   
   wire XLXN_3;
   wire XLXN_4;
   wire XLXN_6;
   wire XLXN_10;
   wire XLXN_11;
   wire XLXN_12;
   wire XLXN_22;
   wire XLXN_24;
   wire XLXN_25;
   wire XLXN_29;
   wire XLXN_31;
   wire XLXN_32;
   wire XLXN_36;
   wire XLXN_38;
   wire XLXN_39;
   wire XLXN_196;
   wire XLXN_198;
   wire XLXN_199;
   wire XLXN_208;
   
//   GND  XLXI_2 (.G(1'b0));
//   VCC  XLXI_3 (.P(1'b1));
//   INV  XLXI_4 (.I(TXC_CLK), 
//               .O(XLXN_6));
//   GND  XLXI_6 (.G(1'b0));
//   VCC  XLXI_7 (.P(1'b1));
//   INV  XLXI_8 (.I(CLK), 
//               .O(XLXN_12));
//   GND  XLXI_14 (.G(1'b0));
//   VCC  XLXI_15 (.P(1'b1));
//   INV  XLXI_16 (.I(CLK), 
//                .O(XLXN_22));
//   GND  XLXI_18 (.G(1'b0));
//   VCC  XLXI_19 (.P(1'b1));
//   INV  XLXI_20 (.I(CLK), 
//                .O(XLXN_29));
//   GND  XLXI_22 (.G(1'b0));
//   VCC  XLXI_23 (.P(1'b1));
//   INV  XLXI_24 (.I(CLK), 
//                .O(XLXN_36));
//   GND  XLXI_118 (.G(1'b0));
//   VCC  XLXI_119 (.P(1'b1));
//   INV  XLXI_120 (.I(CLK), 
//                 .O(XLXN_196));
//   XOR2  XLXI_121 (.I0(TX_ER), 
//                  .I1(TX_EN), 
//                  .O(XLXN_208));
//   ODDR2 #( .DDR_ALIGNMENT("C0"), .SRTYPE("ASYNC"), .INIT(1'b0) ) XLXI_122 
//         (.CE(1'b1), 
//                   .C0(TXC_CLK), 
//                   .C1(XLXN_6), 
//                   .D0(CLK_OE), 
//                   .D1(1'b0), 
//                   .R(1'b0), 
//                   .S(1'b0), 
//                   .Q(TXC));
//   ODDR2 #( .DDR_ALIGNMENT("C0"), .SRTYPE("ASYNC"), .INIT(1'b0) ) XLXI_127 
//         (.CE(1'b1), 
//                   .C0(CLK), 
//                   .C1(XLXN_12), 
//                   .D0(TXD_IN[0]), 
//                   .D1(TXD_IN[4]), 
//                   .R(1'b0), 
//                   .S(1'b0), 
//                   .Q(TXD[0]));
//   ODDR2 #( .DDR_ALIGNMENT("C0"), .SRTYPE("ASYNC"), .INIT(1'b0) ) XLXI_128 
//         (.CE(1'b1), 
//                   .C0(CLK), 
//                   .C1(XLXN_22), 
//                   .D0(TXD_IN[1]), 
//                   .D1(TXD_IN[5]), 
//                   .R(1'b0), 
//                   .S(1'b0), 
//                   .Q(TXD[1]));
//   ODDR2 #( .DDR_ALIGNMENT("C0"), .SRTYPE("ASYNC"), .INIT(1'b0) ) XLXI_129 
//         (.CE(1'b1), 
//                   .C0(CLK), 
//                   .C1(XLXN_29), 
//                   .D0(TXD_IN[2]), 
//                   .D1(TXD_IN[6]), 
//                   .R(1'b0), 
//                   .S(1'b0), 
//                   .Q(TXD[2]));
//   ODDR2 #( .DDR_ALIGNMENT("C0"), .SRTYPE("ASYNC"), .INIT(1'b0) ) XLXI_130 
//         (.CE(1'b1), 
//                   .C0(CLK), 
//                   .C1(XLXN_36), 
//                   .D0(TXD_IN[3]), 
//                   .D1(TXD_IN[7]), 
//                   .R(1'b0), 
//                   .S(1'b0), 
//                   .Q(TXD[3]));
//   ODDR2 #( .DDR_ALIGNMENT("C0"), .SRTYPE("ASYNC"), .INIT(1'b0) ) XLXI_131 
//         (.CE(1'b1), 
//                   .C0(CLK), 
//                   .C1(XLXN_196), 
//                   .D0(TX_EN), 
//                   .D1(XLXN_208), 
//                   .R(1'b0), 
//                   .S(1'b0), 
//                   .Q(TX_CTL));
endmodule

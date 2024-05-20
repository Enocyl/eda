module gamma_ctemp_mpc(CLK, 
                                           CT_GAIN, 
                                           DIN, 
                                           GAMMA, 
                                           OVP, 
                                           DOUT);

    input CLK;
    input [3:0] CT_GAIN;
    input [9:0] DIN;
    input [2:0] GAMMA;
    input OVP;
   output [15:0] DOUT;
   
   wire [3:0] GAIN;
   wire [2:0] GAM;
   wire XLXN_12;
   wire XLXN_13;
   wire XLXN_14;
   wire XLXN_15;
   wire XLXN_16;
   wire XLXN_17;
   wire XLXN_22;
   wire XLXN_23;
   wire XLXN_24;
   wire [15:0] XLXN_37;
   wire [15:0] XLXN_38;
   wire [15:0] XLXN_39;
   wire [15:0] XLXN_40;
   wire [15:0] XLXN_41;
   wire [15:0] XLXN_42;
   wire [15:0] XLXN_43;
   wire XLXN_45;
   wire [15:0] XLXN_52;
   wire [15:0] XLXN_61;
   wire [15:0] XLXN_64;
   
   gamma10_rom_mpc  XLXI_2 (.addra(DIN[9:0]), 
                           .clka(CLK), 
                           .ena(XLXN_22), 
                           .douta(XLXN_43[15:0]));
   gamma18_rom_mpc  XLXI_3 (.addra(DIN[9:0]), 
                           .clka(CLK), 
                           .ena(XLXN_16), 
                           .douta(XLXN_52[15:0]));
   gamma20_rom_mpc  XLXI_4 (.addra(DIN[9:0]), 
                           .clka(CLK), 
                           .ena(XLXN_15), 
                           .douta(XLXN_37[15:0]));
   gamma22_rom_mpc  XLXI_5 (.addra(DIN[9:0]), 
                           .clka(CLK), 
                           .ena(XLXN_14), 
                           .douta(XLXN_38[15:0]));
   gamma24_rom_mpc  XLXI_6 (.addra(DIN[9:0]), 
                           .clka(CLK), 
                           .ena(XLXN_13), 
                           .douta(XLXN_39[15:0]));
   gamma25_rom_mpc  XLXI_7 (.addra(DIN[9:0]), 
                           .clka(CLK), 
                           .ena(XLXN_12), 
                           .douta(XLXN_40[15:0]));
   gamma28_rom_mpc  XLXI_8 (.addra(DIN[9:0]), 
                           .clka(CLK), 
                           .ena(XLXN_24), 
                           .douta(XLXN_41[15:0]));
   gamma30_rom_mpc  XLXI_9 (.addra(DIN[9:0]), 
                           .clka(CLK), 
                           .ena(XLXN_23), 
                           .douta(XLXN_42[15:0]));
   (* HU_SET = "XLXI_10_25" *) 
   D3_8E  XLXI_10 (.A0(GAM[0]), 
                                        .A1(GAM[1]), 
                                        .A2(GAM[2]), 
                                        .E(XLXN_17), 
                                        .D0(XLXN_16), 
                                        .D1(XLXN_15), 
                                        .D2(XLXN_14), 
                                        .D3(XLXN_13), 
                                        .D4(XLXN_12), 
                                        .D5(XLXN_24), 
                                        .D6(XLXN_23), 
                                        .D7(XLXN_22));
   VCC  XLXI_11 (.P(XLXN_17));
   m8_1e16b  XLXI_12 (.E(XLXN_45), 
                                         .I0D(XLXN_52[15:0]), 
                                         .I1D(XLXN_37[15:0]), 
                                         .I2D(XLXN_38[15:0]), 
                                         .I3D(XLXN_39[15:0]), 
                                         .I4D(XLXN_40[15:0]), 
                                         .I5D(XLXN_41[15:0]), 
                                         .I6D(XLXN_42[15:0]), 
                                         .I7D(XLXN_43[15:0]), 
                                         .S(GAM[2:0]), 
                                         .O(XLXN_61[15:0]));
   VCC  XLXI_14 (.P(XLXN_45));
   f1d16  XLXI_21 (.CK(CLK), 
                                      .D(XLXN_61[15:0]), 
                                      .Q(XLXN_64[15:0]));
   ctemp_multi_mpc  XLXI_22 (.clk(CLK), 
                            .din(XLXN_64[15:0]), 
                            .gain(GAIN[3:0]), 
                            .dout(DOUT[15:0]));
   fd3e  XLXI_51 (.CE(OVP), 
                                     .CK(CLK), 
                                     .D(GAMMA[2:0]), 
                                     .Q(GAM[2:0]));
   fd4e  XLXI_52 (.CE(OVP), 
                                     .CK(CLK), 
                                     .D(CT_GAIN[3:0]), 
                                     .Q(GAIN[3:0]));
endmodule
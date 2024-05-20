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
   wire [15:0] XLXN_61;
   wire [15:0] XLXN_64;
   wire XLXN_74;
   
   gamma28_rom_mpc  XLXI_8 (.addra(DIN[9:0]), 
                           .clka(CLK), 
                           .ena(XLXN_74), 
                           .douta(XLXN_61[15:0]));
   VCC  XLXI_11 (.P(XLXN_74));
   f1d16_MUSER_gamma_ctemp_mpc  XLXI_21 (.CK(CLK), 
                                        .D(XLXN_61[15:0]), 
                                        .Q(XLXN_64[15:0]));
   ctemp_multi_mpc  XLXI_22 (.clk(CLK), 
                            .din(XLXN_64[15:0]), 
                            .gain(GAIN[3:0]), 
                            .dout(DOUT[15:0]));
   fd4e_MUSER_gamma_ctemp_mpc  XLXI_52 (.CE(OVP), 
                                       .CK(CLK), 
                                       .D(CT_GAIN[3:0]), 
                                       .Q(GAIN[3:0]));
endmodule

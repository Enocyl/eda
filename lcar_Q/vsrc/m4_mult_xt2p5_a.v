module m4_mult_xt2p5_a(BIN, 
                       CF0D, 
                       CF1D, 
                       CF2D, 
                       CF3D, 
                       CF4D, 
                       CF5D, 
                       CF6D, 
                       CF7D, 
                       CF8D, 
                       CLK, 
                       GIN, 
                       M4_ON, 
                       OVP, 
                       RIN, 
                       BOUT, 
                       BR, 
                       GOUT, 
                       ROUT);

    input [15:0] BIN;
    input [12:0] CF0D;
    input [12:0] CF1D;
    input [12:0] CF2D;
    input [12:0] CF3D;
    input [12:0] CF4D;
    input [12:0] CF5D;
    input [12:0] CF6D;
    input [12:0] CF7D;
    input [12:0] CF8D;
    input CLK;
    input [15:0] GIN;
    input M4_ON;
    input OVP;
    input [15:0] RIN;
   output [15:0] BOUT;
   output [35:0] BR;
   output [15:0] GOUT;
   output [15:0] ROUT;
   
   wire [35:0] BB;
   wire [35:0] BG;
   wire [35:0] GB;
   wire [35:0] GG;
   wire [35:0] GR;
   wire L;
   wire [35:0] RB;
   wire [35:0] RG;
   wire [35:0] RR;
   wire XLXN_1;
   wire [35:0] BR_DUMMY;
   
   assign BR[35:0] = BR_DUMMY[35:0];
   GND  XLXI_15 (.G(L));
   signed_mult_18x18  XLXI_39 (.a({L, L, RIN[15:0]}), 
                              .b({L, L, L, L, L, CF0D[12:0]}), 
                              .clk(CLK), 
                              .p(RR[35:0]));
   signed_mult_18x18  XLXI_42 (.a({L, L, RIN[15:0]}), 
                              .b({CF1D[12], CF1D[12], CF1D[12], CF1D[12], 
         CF1D[12], CF1D[12:0]}), 
                              .clk(CLK), 
                              .p(RG[35:0]));
   signed_mult_18x18  XLXI_43 (.a({L, L, RIN[15:0]}), 
                              .b({CF2D[12], CF2D[12], CF2D[12], CF2D[12], 
         CF2D[12], CF2D[12:0]}), 
                              .clk(CLK), 
                              .p(RB[35:0]));
   signed_mult_18x18  XLXI_44 (.a({L, L, GIN[15:0]}), 
                              .b({CF3D[12], CF3D[12], CF3D[12], CF3D[12], 
         CF3D[12], CF3D[12:0]}), 
                              .clk(CLK), 
                              .p(GR[35:0]));
   signed_mult_18x18  XLXI_45 (.a({L, L, GIN[15:0]}), 
                              .b({L, L, L, L, L, CF4D[12:0]}), 
                              .clk(CLK), 
                              .p(GG[35:0]));
   signed_mult_18x18  XLXI_46 (.a({L, L, GIN[15:0]}), 
                              .b({CF5D[12], CF5D[12], CF5D[12], CF5D[12], 
         CF5D[12], CF5D[12:0]}), 
                              .clk(CLK), 
                              .p(GB[35:0]));
   signed_mult_18x18  XLXI_47 (.a({L, L, BIN[15:0]}), 
                              .b({CF6D[12], CF6D[12], CF6D[12], CF6D[12], 
         CF6D[12], CF6D[12:0]}), 
                              .clk(CLK), 
                              .p(BR_DUMMY[35:0]));
   signed_mult_18x18  XLXI_48 (.a({L, L, BIN[15:0]}), 
                              .b({CF7D[12], CF7D[12], CF7D[12], CF7D[12], 
         CF7D[12], CF7D[12:0]}), 
                              .clk(CLK), 
                              .p(BG[35:0]));
   signed_mult_18x18  XLXI_49 (.a({L, L, BIN[15:0]}), 
                              .b({L, L, L, L, L, CF8D[12:0]}), 
                              .clk(CLK), 
                              .p(BB[35:0]));
   m4_postmult_xt2p5_a  XLXI_50 (.bb(BB[30:0]), 
                                .bg(BG[30:0]), 
                                .bin(BIN[15:0]), 
                                .br(BR_DUMMY[30:0]), 
                                .cf0d(CF0D[12:0]), 
                                .cf4d(CF4D[12:0]), 
                                .cf8d(CF8D[12:0]), 
                                .clk(CLK), 
                                .gb(GB[30:0]), 
                                .gg(GG[30:0]), 
                                .gin(GIN[15:0]), 
                                .gr(GR[30:0]), 
                                .m4_on(XLXN_1), 
                                .rb(RB[30:0]), 
                                .rg(RG[30:0]), 
                                .rin(RIN[15:0]), 
                                .rr(RR[30:0]), 
                                .bout(BOUT[15:0]), 
                                .gout(GOUT[15:0]), 
                                .rout(ROUT[15:0]));
   fd1e_MUSER_m4_mult_xt2p5_a  XLXI_51 (.CE(OVP), 
                                       .CK(CLK), 
                                       .D(M4_ON), 
                                       .Q(XLXN_1));
endmodule

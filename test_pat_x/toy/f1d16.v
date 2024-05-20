module f1d16(CK, 
                                 D, 
                                 Q);

    input CK;
    input [15:0] D;
   output [15:0] Q;
   
   wire XLXN_16;
   wire XLXN_19;
   
   (* HU_SET = "XLXI_11_7" *) 
   FD16CE  XLXI_11 (.C(CK), 
                                         .CE(XLXN_19), 
                                         .CLR(XLXN_16), 
                                         .D(D[15:0]), 
                                         .Q(Q[15:0]));
   GND  XLXI_12 (.G(XLXN_16));
   VCC  XLXI_13 (.P(XLXN_19));
endmodule
module fd8(CK, 
           I, 
           O);

    input CK;
    input [7:0] I;
   output [7:0] O;
   
   wire XLXN_3;
   wire XLXN_4;
   
   (* HU_SET = "XLXI_1_0" *) 
   FD8CE_HXILINX_fd8  XLXI_1 (.C(CK), 
                             .CE(XLXN_4), 
                             .CLR(XLXN_3), 
                             .D(I[7:0]), 
                             .Q(O[7:0]));
   GND  XLXI_2 (.G(XLXN_3));
   VCC  XLXI_3 (.P(XLXN_4));
endmodule

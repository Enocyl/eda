module fd8(CK, 
           I, 
           O);

    input CK;
    input [7:0] I;
   output [7:0] O;
   
   //wire XLXN_3;
   //wire XLXN_4;

	reg[7:0] O;
	always @(posedge CK)begin
		O <= I;
	end
   
//   (* HU_SET = "XLXI_1_0" *) 
//   FD8CE_HXILINX_fd8  XLXI_1 (.C(CK), 
//                             .CE(1), 
//                             .CLR(0), 
//                             .D(I[7:0]), 
//                             .Q(O[7:0]));
//   GND  XLXI_2 (.G(0));
//   VCC  XLXI_3 (.P(1));
endmodule

module f1d16(CK, 
             D, 
             Q);

    input CK;
    input [15:0] D;
   output [15:0] Q;
   
   //wire XLXN_16;
   //wire XLXN_19;
   //
   //(* HU_SET = "XLXI_11_0" *)

	reg[15:0] Q;
	always @(posedge CK)begin
		Q <= D;
	end
//   FD16CE_HXILINX_f1d16  XLXI_11 (.C(CK), 
//                                 .CE(1), 
//                                 .CLR(0), 
//                                 .D(D[15:0]), 
//                                 .Q(Q[15:0]));
//   GND  XLXI_12 (.G(0));
//   VCC  XLXI_13 (.P(1));
endmodule

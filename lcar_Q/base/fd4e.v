module fd4e(CE, 
            CK, 
            D, 
            Q);

    input CE;
    input CK;
    input [3:0] D;
   output [3:0] Q;
   
   //wire XLXN_3;

	reg[3:0] Q;
	always @(posedge CK)begin
		if(CE)
			Q <= D;
	end
   
//   (* HU_SET = "XLXI_1_0" *) 
//   FD4CE_HXILINX_fd4e  XLXI_1 (.C(CK), 
//                              .CE(CE), 
//                              .CLR(0), 
//                              .D0(D[0]), 
//                              .D1(D[1]), 
//                              .D2(D[2]), 
//                              .D3(D[3]), 
//                              .Q0(Q[0]), 
//                              .Q1(Q[1]), 
//                              .Q2(Q[2]), 
//                              .Q3(Q[3]));
//   GND  XLXI_7 (.G(0));
endmodule

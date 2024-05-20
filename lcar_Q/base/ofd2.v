module ofd2(CK, 
            D0, 
            D1, 
            Q0, 
            Q1);

    input CK;
    input D0;
    input D1;
   output Q0;
   output Q1;
   
	reg Q0;
	always @(posedge CK)begin
//		Q0 <= D0;
	end

	reg Q1;
	always @(posedge CK)begin
//		Q1 <= D1;
	end
	
//   (* HU_SET = "XLXI_1_0" *) 
//   OFD_HXILINX_ofd2 #( .INIT(1'b0) ) XLXI_1 (.C(CK), 
//                            .D(D0), 
//                            .Q(Q0));
//   (* HU_SET = "XLXI_2_1" *) 
//   OFD_HXILINX_ofd2 #( .INIT(1'b0) ) XLXI_2 (.C(CK), 
//                            .D(D1), 
//                            .Q(Q1));
endmodule

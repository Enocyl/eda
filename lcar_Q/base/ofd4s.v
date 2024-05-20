module ofd4s(CK, 
             D0, 
             D1, 
             D2, 
             D3, 
             Q0, 
             Q1, 
             Q2, 
             Q3);

    input CK;
    input D0;
    input D1;
    input D2;
    input D3;
   output Q0;
   output Q1;
   output Q2;
   output Q3;
   
	reg Q0;
	always @(posedge CK)begin
//		Q0 <= D0;
	end

	reg Q1;
	always @(posedge CK)begin
//		Q1 <= D1;
	end

	reg Q2;
	always @(posedge CK)begin
//		Q2 <= D2;
	end

	reg Q3;
	always @(posedge CK)begin
//		Q3 <= D3;
	end
	
//   (* HU_SET = "XLXI_1_0" *) 
//   OFD_HXILINX_ofd4s #( .INIT(1'b0) ) XLXI_1 (.C(CK), 
//                             .D(D0), 
//                             .Q(Q0));
//   (* HU_SET = "XLXI_2_1" *) 
//   OFD_HXILINX_ofd4s #( .INIT(1'b0) ) XLXI_2 (.C(CK), 
//                             .D(D1), 
//                             .Q(Q1));
//   (* HU_SET = "XLXI_3_2" *) 
//   OFD_HXILINX_ofd4s #( .INIT(1'b0) ) XLXI_3 (.C(CK), 
//                             .D(D2), 
//                             .Q(Q2));
//  (* HU_SET = "XLXI_4_3" *) 
//   OFD_HXILINX_ofd4s #( .INIT(1'b0) ) XLXI_4 (.C(CK), 
//                             .D(D3), 
//                             .Q(Q3));
endmodule

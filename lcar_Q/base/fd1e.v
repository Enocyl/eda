module fd1e(CE, 
            CK, 
            D, 
            Q);

    input CE;
    input CK;
    input D;
   output Q;

	reg Q;
	always @(posedge CK)begin
		if(CE)
			Q <= D;
	end
   
//   wire XLXN_1;
   
//   FDCE  XLXI_1 (.C(CK), 
//                .CE(CE), 
//                .CLR(0), 
//                .D(D), 
//                .Q(Q));
//   GND  XLXI_2 (.G(0));
endmodule

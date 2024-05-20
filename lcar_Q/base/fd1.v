module fd1(CK, 
           D, 
           Q);

    input CK;
    input D;
   output Q;
   
	reg Q;
	always @(posedge CK)begin
		Q <= D;
	end
   
//   FD #( .INIT(1'b0) ) XLXI_1 (.C(CK), 
//              .D(D), 
//              .Q(Q));
endmodule

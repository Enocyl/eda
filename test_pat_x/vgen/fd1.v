module fd1(CK, 
                               D, 
                               Q);

    input CK;
    input D;
   output Q;
   
   
   FD #( .INIT(1'b0) ) XLXI_1 (.C(CK), 
              .D(D), 
              .Q(Q));
endmodule
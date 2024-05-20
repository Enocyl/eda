module fd1e(CE, 
            CK, 
            D, 
            Q);

    input CE;
    input CK;
    input D;
   output Q;
   
   wire XLXN_1;
   
   FDCE  XLXI_1 (.C(CK), 
                .CE(CE), 
                .CLR(XLXN_1), 
                .D(D), 
                .Q(Q));
   GND  XLXI_2 (.G(XLXN_1));
endmodule

module fd3e(CE, 
                                CK, 
                                D, 
                                Q);

    input CE;
    input CK;
    input [2:0] D;
   output [2:0] Q;
   
   wire XLXN_1;
   
   FDCE  XLXI_1 (.C(CK), 
                .CE(CE), 
                .CLR(XLXN_1), 
                .D(D[0]), 
                .Q(Q[0]));
   FDCE  XLXI_2 (.C(CK), 
                .CE(CE), 
                .CLR(XLXN_1), 
                .D(D[1]), 
                .Q(Q[1]));
   GND  XLXI_3 (.G(XLXN_1));
   FDCE  XLXI_7 (.C(CK), 
                .CE(CE), 
                .CLR(XLXN_1), 
                .D(D[2]), 
                .Q(Q[2]));
endmodule
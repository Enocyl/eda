module ofd5(CK, 
            D0, 
            D1, 
            D2, 
            D3, 
            D4, 
            Q0, 
            Q1, 
            Q2, 
            Q3, 
            Q4);

    input CK;
    input D0;
    input D1;
    input D2;
    input D3;
    input D4;
   output Q0;
   output Q1;
   output Q2;
   output Q3;
   output Q4;
   
   
   (* HU_SET = "XLXI_1_0" *) 
   OFD_HXILINX_ofd5 #( .INIT(1'b0) ) XLXI_1 (.C(CK), 
                            .D(D0), 
                            .Q(Q0));
   (* HU_SET = "XLXI_2_1" *) 
   OFD_HXILINX_ofd5 #( .INIT(1'b0) ) XLXI_2 (.C(CK), 
                            .D(D1), 
                            .Q(Q1));
   (* HU_SET = "XLXI_3_2" *) 
   OFD_HXILINX_ofd5 #( .INIT(1'b0) ) XLXI_3 (.C(CK), 
                            .D(D2), 
                            .Q(Q2));
   (* HU_SET = "XLXI_4_3" *) 
   OFD_HXILINX_ofd5 #( .INIT(1'b0) ) XLXI_4 (.C(CK), 
                            .D(D3), 
                            .Q(Q3));
   (* HU_SET = "XLXI_5_4" *) 
   OFD_HXILINX_ofd5 #( .INIT(1'b0) ) XLXI_5 (.C(CK), 
                            .D(D4), 
                            .Q(Q4));
endmodule

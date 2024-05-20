module ofd1s(CK, 
             D, 
             Q);

    input CK;
    input D;
   output Q;
   
   
   (* HU_SET = "XLXI_1_0" *) 
   OFD_HXILINX_ofd1s #( .INIT(1'b0) ) XLXI_1 (.C(CK), 
                             .D(D), 
                             .Q(Q));
endmodule

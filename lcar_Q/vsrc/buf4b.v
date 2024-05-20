module buf4b(I, 
             O);

    input [3:0] I;
   output [3:0] O;
   
   
   BUF  XLXI_3 (.I(I[3]), 
               .O(O[3]));
   BUF  XLXI_4 (.I(I[2]), 
               .O(O[2]));
   BUF  XLXI_5 (.I(I[1]), 
               .O(O[1]));
   BUF  XLXI_7 (.I(I[0]), 
               .O(O[0]));
endmodule

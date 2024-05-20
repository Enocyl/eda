module M2_1 (O, D0, D1, S0);
    

   output O;

   input  D0;
   input  D1;
   input  S0;

   reg O;

   always @ ( D0 or D1 or S0)
   begin
      case(S0)
      1'b0 : O <= D0;
      1'b1 : O <= D1;
      endcase
   end
    
endmodule
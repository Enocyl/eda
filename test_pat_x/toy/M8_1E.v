module M8_1E (O, D0, D1, D2, D3, D4, D5, D6, D7, E, S0, S1, S2);
    

   output O;

   input  D0;
   input  D1;
   input  D2;
   input  D3;
   input  D4;
   input  D5;
   input  D6;
   input  D7;
   input  E;
   input  S0;
   input  S1;
   input  S2;

   reg O;

   always @ ( D0 or D1 or D2 or D3 or D4 or D5 or D6 or D7 or E or S0 or S1 or S2)
   begin
      if(!E)
      O <= 1'b0;
      else 
      begin
        case({S2,S1,S0})
        3'b000 : O <= D0;
        3'b001 : O <= D1;
        3'b010 : O <= D2;
        3'b011 : O <= D3;
        3'b100 : O <= D4;
        3'b101 : O <= D5;
        3'b110 : O <= D6;
        3'b111 : O <= D7;
        endcase
      end
   end
    
endmodule
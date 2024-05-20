module D3_8E (D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A2, E);
    

   output D0;
   output D1;
   output D2;
   output D3;
   output D4;
   output D5;
   output D6;
   output D7;

   input  A0;
   input  A1;
   input  A2;
   input  E;
  
   reg D0;
   reg D1;
   reg D2;
   reg D3;
   reg D4;
   reg D5;
   reg D6;
   reg D7;

      always @ (A0 or A1 or A2 or E)
      begin
         if(!E)
           {D7, D6, D5, D4, D3, D2, D1, D0} <= 8'b0000_0000;
        else
        begin
           case({A2,A1,A0})
             3'b000 :  {D7, D6, D5, D4, D3, D2, D1, D0} <=  8'b0000_0001;
             3'b001 :  {D7, D6, D5, D4, D3, D2, D1, D0} <=  8'b0000_0010;
             3'b010 :  {D7, D6, D5, D4, D3, D2, D1, D0} <=  8'b0000_0100;
             3'b011 :  {D7, D6, D5, D4, D3, D2, D1, D0} <=  8'b0000_1000;
             3'b100 :  {D7, D6, D5, D4, D3, D2, D1, D0} <=  8'b0001_0000;
             3'b101 :  {D7, D6, D5, D4, D3, D2, D1, D0} <=  8'b0010_0000;
             3'b110 :  {D7, D6, D5, D4, D3, D2, D1, D0} <=  8'b0100_0000;
             3'b111 :  {D7, D6, D5, D4, D3, D2, D1, D0} <=  8'b1000_0000;
          endcase
        end
     end 

endmodule
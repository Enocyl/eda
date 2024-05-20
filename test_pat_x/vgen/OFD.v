module OFD(Q, C, D);
   
   output             Q;

   input 	      C;	
   input              D;
   
   parameter INIT = 1'b0;
   (* IOB = "TRUE" *)

   reg                Q = INIT;

   always @(posedge C)
     begin
          Q <= D;
     end
   
   
endmodule
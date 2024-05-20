module FD4CE(Q0, Q1, Q2, Q3, C, CE, CLR, D0, D1, D2, D3);
   
   output             Q0;
   output             Q1;
   output             Q2;
   output             Q3;

   input 	      C;	
   input 	      CE;	
   input 	      CLR;	
   input              D0;
   input              D1;
   input              D2;
   input              D3;
   
   reg                Q0;
   reg                Q1;
   reg                Q2;
   reg                Q3;
   
   always @(posedge C or posedge CLR)
     begin
	if (CLR)
	  {Q3, Q2, Q1, Q0} <= 4'b0000;
	else if (CE)
          {Q3, Q2, Q1, Q0} <= {D3, D2, D1, D0};
     end
   
   
endmodule
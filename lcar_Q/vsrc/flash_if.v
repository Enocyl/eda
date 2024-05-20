module flash_if(
	clk_in,
	sdi,	
	clk_en,
	cs_en,
	
	clk,	
	cs,
	d,
	q,
	
	rx_q
);
	input clk_in;	
	input clk_en;
	input cs_en;
	input sdi;
	
	output clk;
	output cs;
	output reg d;
	//output d;
	input q;
	
	output rx_q;


	wire clk_inv;
   ODDR2 #( .INIT(1'b0), .SRTYPE("SYNC"), .DDR_ALIGNMENT("NONE") ) ODDR2_FIF
				(.CE(clk_en), 
                 .C0(clk_in), 
                 .C1(clk_inv), 
                 //.D0(1'b1), 
                 //.D1(1'b0),                 
				 .D0(1'b0), 
                 .D1(1'b1), 
                 .R(1'b0), 
                 .S(1'b0), 
                 .Q(clk));
   //GND  GND_FIF (.G(XLXN_7));
   //VCC  VCC_FIF (.P(XLXN_8));
   INV  INV_FIF (.I(clk_in), 
                .O(clk_inv));
				
	//assign clk = clk_en ? clk_in : 0;
	assign cs = cs_en ? 0 : 1;
	
	//always @(negedge clk_in) begin
	//	d <= sdi;	
	//end
	always @(posedge clk_in) begin
		d <= sdi;	
	end	
	//assign d = sdi;
	
	assign rx_q = q;
	
endmodule
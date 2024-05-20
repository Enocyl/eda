`timescale 1ns / 1ns
// `default_nettype none

// 2bit OFD 

module ofd2b (d, clk, q);

    input [1:0] d;
    input clk;

    output reg [1:0] q;


  (* IOB = "TRUE" *)


    // q  2bit
    always @(posedge clk) begin
      q <= d;
    end

endmodule
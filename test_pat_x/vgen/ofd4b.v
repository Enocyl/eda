`timescale 1ns / 1ns
// `default_nettype none

// 4bit OFD 

module ofd4b (d, clk, q);

    input [3:0] d;
    input clk;

    output reg [3:0] q;


  (* IOB = "TRUE" *)


    // q  4bit
    always @(posedge clk) begin
      q <= d;
    end

endmodule
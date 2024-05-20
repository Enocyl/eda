`timescale 1ns / 1ns
// `default_nettype none

// 11bit OFD 

module ofd11b (d, clk, q);

    input [10:0] d;
    input clk;

    output reg [10:0] q;


  (* IOB = "TRUE" *)


    // q  11bit
    always @(posedge clk) begin
      q <= d;
    end

endmodule
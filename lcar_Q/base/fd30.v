`timescale 1ns / 1ns
// //`default_nettype none

// DFF 30bit

module fd30 (d, ck, q);

    input [29:0] d;
    input ck;

    output reg [29:0] q;

    always @(posedge ck) begin
      q <= d;
    end

endmodule
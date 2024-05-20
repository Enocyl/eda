`timescale 1ns / 1ns


// DFF 17bit

module fd17 (d, ck, q);

    input [16:0] d;
    input ck;

    output reg [16:0] q;

    always @(posedge ck) begin
      q <= d;
    end

endmodule
`timescale 1ns / 1ns
`default_nettype none

// MPC
// color temperatureİ’èƒQƒCƒ“æZ

module ctemp_multi_mpc(din, gain, clk,
                       dout);

    input [15:0] din;
    input [3:0] gain;
    input clk;

    output reg [15:0] dout;

    reg [15:0] din1, din2;
    reg [16:0] gaina;
    reg [17:0] dga;
    reg [15:0] dgc;

    wire [32:0] dg;
    wire [18:0] dgb;

    // gaina  17bit
    always @(posedge clk) begin
      gaina <= gain * 13'h199a;  // d6554
    end

    // dg  33bit
    assign dg = din * gaina;

    // dga  18bit
    always @(posedge clk) begin
      dga <= dg[32:15];
    end

    // din1, din2  16bit
    always @(posedge clk) begin
      din1 <= din;
      din2 <= din1;
    end

    // dgb  19bit
    assign dgb = {2'b00, din1} + dga;

    // dgc  16bit
    always @(posedge clk) begin
      dgc = dgb[18] ? 16'hffff : dgb[17:2];
    end

    // dout  16bit
    always @(posedge clk) begin
      dout = (gain == 4'hf) ? din2 : dgc;
    end

endmodule
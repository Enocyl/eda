`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
//
// LINK_ON入力信号用フィルタ

module link_on_in_filter (din, clk, dout);

    input din;        // input 1:link_on
    input clk;        // 25MHz

    output reg dout;  // output

    reg din_1d, din_2d;

    // din_1d, din_2d, dout
    always @(posedge clk) begin
      din_1d <= din;
      din_2d <= din_1d;
      dout <= din_1d | din_2d;
    end

endmodule

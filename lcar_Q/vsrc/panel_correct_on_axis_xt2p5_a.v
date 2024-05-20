`timescale 1ns / 1ns
// `default_nettype none

// XT
// Panel Correction Commandóp M4 coefficient offset â¡å∏éZ
// Coefficient No. 0 / 4 / 8 óp
// èoóÕ 0 - 8191

module 	panel_correct_on_axis_xt2p5_a (din, offset, clk,
                                       dout);

    input [15:0] din;     // 13bit SB
    input [15:0] offset;  // 13bit 2'c
    input clk;

    output [15:0] dout;

    reg [14:0] offset_add;
    reg [12:0] doa;


    // offset_add  15bit
    always @(posedge clk) begin
      offset_add <= {2'h0, din[12:0]} + {offset[12], offset[12], offset[12:0]};
    end

    // doa  13bit
    always @(posedge clk) begin
      case (offset_add[14:13])
        2'h0: doa <= offset_add[12:0];
        2'h1: doa <= 13'h1fff;
        2'h2: doa <= 13'h0000;
        2'h3: doa <= 13'h0000;
      endcase
    end

    // dout  16bit
    assign dout = {3'd0, doa};

endmodule
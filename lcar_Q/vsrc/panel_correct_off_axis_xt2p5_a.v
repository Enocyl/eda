`timescale 1ns / 1ns
// `default_nettype none

// XT
// Panel Correction Commandóp M4 coefficient offset â¡å∏éZ
// Coefficient No. 1 / 2 / 3 / 5 / 6 / 7 óp
// èoóÕ 0 - 4095

module 	panel_correct_off_axis_xt2p5_a (din, offset, clk,
                                        dout);

    input [15:0] din;     // 13bit 2'c or 12bit SB
    input [15:0] offset;  // 12bit 2'c
    input clk;

    output [15:0] dout;

    reg [13:0] offset_add;
    reg [11:0] doa;


    // offset_add  14bit
    always @(posedge clk) begin
      offset_add <= {din[12], din[12:0]} + {offset[11], offset[11], offset[11:0]};
    end

    // doa  12bit
    always @(posedge clk) begin
      case (offset_add[13:12])
        2'h0: doa <= offset_add[11:0];
        2'h1: doa <= 12'hfff;
        2'h2: doa <= 12'h000;
        2'h3: doa <= 12'h000;
      endcase
    end

    // dout  16bit
    assign dout = {4'd0, doa};

endmodule
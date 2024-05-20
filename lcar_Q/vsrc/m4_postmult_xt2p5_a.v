`timescale 1ns / 1ns
// `default_nettype none

// XT2.5
// M4 ��Z��̏��� (�W��13bit)

module m4_postmult_xt2p5_a (rin, gin, bin, rr, rg, rb, gr, gg, gb, br, bg, bb,
                            cf0d, cf4d, cf8d,
                            m4_on, clk,
                            rout, gout, bout);

    input [15:0] rin, gin, bin;
    input [30:0] rr, rg, rb, gr, gg, gb, br, bg, bb;  // 2'c
    input [12:0] cf0d, cf4d, cf8d;
    input m4_on, clk;

    output reg [15:0] rout, gout, bout;

    reg [15:0] r1d, r2d, r3d, g1d, g2d, g3d, b1d, b2d, b3d;
    reg [30:0] gbr, rbg, rgb;
    reg [30:0] rr1d, gg1d, bb1d;
    reg [30:0] roa, goa, boa;
    reg no_coeff_1d, no_coeff_2d, no_coeff_3d;

    wire [1:0] rosel, gosel, bosel;
    wire m4_on_a;


 // no coefficient ���o

    // no_coeff_1d, no_coeff_2d, no_coeff_3d
    always @(posedge clk) begin
      no_coeff_1d <= (cf0d == 13'h0000) | (cf4d == 13'h0000) | (cf8d == 13'h0000);
      no_coeff_2d <= no_coeff_1d;
      no_coeff_3d <= no_coeff_2d;
    end

    // m4_on_a
    assign m4_on_a = m4_on & ~no_coeff_3d;


 // Red LED�p�o��

    // r1d, r2d, r3d  16bit  M4_OFF���̃X���[�o�͗p�f�B���C
    always @(posedge clk) begin
      r1d <= rin;
      r2d <= r1d;
      r3d <= r2d;
    end

    // gbr  31bit  Red LED�p G,B���Z  2'c
    always @(posedge clk) begin
      gbr <= gr + br;
    end

    // rr1d  31bit  Red LED�p R �f�B���C
    always @(posedge clk) begin
      rr1d <= rr;
    end

    // roa  31bit  Red LED�p R,G,B���Z  2'c
    always @(posedge clk) begin
      roa <= gbr + rr1d;
    end

    // rosel  2bit  �t���[�����p�I��M��
    assign rosel[0] = (roa[29] & ~roa[30]) | ~m4_on_a;
    assign rosel[1] = roa[30] | ~m4_on_a;

    // rout  16bit   Red LED�p�o��
    always @(posedge clk) begin
      case (rosel)
        2'h0: rout <= roa[28:13];  // M4 ON �m�[�}���o��
        2'h1: rout <= 16'hffff;    // M4 ON �I�[�o�[�t���[
        2'h2: rout <= 16'h0000;    // M4 ON �A���_�[�t���[
        2'h3: rout <= r3d;         // M4 OFF ���̓X���[
      endcase
    end


 // Green LED�p�o��

    // g1d, g2d, g3d  16bit  M4_OFF���̃X���[�o�͗p�f�B���C
    always @(posedge clk) begin
      g1d <= gin;
      g2d <= g1d;
      g3d <= g2d;
    end

    // rbg  31bit  Green LED�p R,B���Z  2'c
    always @(posedge clk) begin
      rbg <= rg + bg;
    end

    // gg1d  31bit  Green LED�p G �f�B���C
    always @(posedge clk) begin
      gg1d <= gg;
    end

    // goa  31bit  Green LED�p R,G,B���Z  2'c
    always @(posedge clk) begin
      goa <= rbg + gg1d;
    end

    // gosel  2bit  �t���[�����p�I��M��
    assign gosel[0] = (goa[29] & ~goa[30]) | ~m4_on_a;
    assign gosel[1] = goa[30] | ~m4_on_a;

    // gout  16bit   Green LED�p�o��
    always @(posedge clk) begin
      case (gosel)
        2'h0: gout <= goa[28:13];  // M4 ON �m�[�}���o��
        2'h1: gout <= 16'hffff;    // M4 ON �I�[�o�[�t���[
        2'h2: gout <= 16'h0000;    // M4 ON �A���_�[�t���[
        2'h3: gout <= g3d;         // M4 OFF ���̓X���[
      endcase
    end


 // Blue LED�p�o��

    // b1d, b2d, b3d  16bit  M4_OFF���̃X���[�o�͗p�f�B���C
    always @(posedge clk) begin
      b1d <= bin;
      b2d <= b1d;
      b3d <= b2d;
    end

    // rgb  31bit  Blue LED�p R,G���Z  2'c
    always @(posedge clk) begin
      rgb <= rb + gb;
    end

    // bb1d  31bit  Blue LED�p B �f�B���C
    always @(posedge clk) begin
      bb1d <= bb;
    end

    // boa  31bit  Blue LED�p R,G,B���Z  2'c
    always @(posedge clk) begin
      boa <= rgb + bb1d;
    end

    // bosel  2bit  �t���[�����p�I��M��
    assign bosel[0] = (boa[29] & ~boa[30]) | ~m4_on_a;
    assign bosel[1] = boa[30] | ~m4_on_a;

    // bout  16bit   Blue LED�p�o��
    always @(posedge clk) begin
      case (bosel)
        2'h0: bout <= boa[28:13];  // M4 ON �m�[�}���o��
        2'h1: bout <= 16'hffff;    // M4 ON �I�[�o�[�t���[
        2'h2: bout <= 16'h0000;    // M4 ON �A���_�[�t���[
        2'h3: bout <= b3d;         // M4 OFF ���̓X���[
      endcase
    end

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// パネルアドレス表示信号作成


module pnl_adrs_gen_pv2_4_4x4 (panel_sel, panel_num, ovp,
                               video_pad_adrs, test_pad_adrs, test_on, pnl_adrs_on,
                               rom_l_out, rom_s_out, clk,
                               rom_l_adrs, rom_s_adrs, rom_l_en, rom_s_en,
                               pad_white, pad_black);

    input [3:0] panel_sel;
    input [9:0] panel_num;
    input ovp;
    input [15:0] video_pad_adrs;
    input [15:0] test_pad_adrs;
    input test_on;
    input pnl_adrs_on;
    input [1:0] rom_l_out;
    input [1:0] rom_s_out;
    input clk;

    output [13:0] rom_l_adrs;
    output [11:0] rom_s_adrs;
    output rom_l_en;
    output rom_s_en;
    output reg pad_white;
    output reg pad_black;

    reg [9:0] numa;
    reg le900, le800, le700, le600, le500, le400, le300, le200, le100;
    reg [3:0] hund_numa;
    reg [9:0] hund;
    reg [9:0] numb;
    reg le90, le80, le70, le60, le50, le40, le30, le20, le10;
    reg [3:0] ten_numa;
    reg [6:0] ten;
    reg [6:0] numc;
    reg [3:0] hund_num, ten_num, one_num;
    reg [7:0] vadrs, hadrs;
    reg pad_on;
    reg [7:0] rom_had, rom_vad;
    reg [3:0] dec_num;
    reg hen, ven;
    reg left_bd, right_bd, up_bd, bottom_bd;
    reg border;
    reg hv_en;

    wire xt10, xt6;
    wire [7:0] pnl_h_pix_m1, pnl_v_pix_m1;
    wire [7:0] pad_h_start, pad_v_start;
    wire [7:0] pad_h_size, pad_v_size;
    wire pad_rom_s_sel;
    wire [7:0] pad_h_ten_start, pad_h_one_start, pad_h_end;
    wire [7:0] pad_v_end;
    wire [10:0] num;
    wire [1:0] rom_out;


// パラメータ設定

 // P0 : PVII-4 (4x4 IM)
    parameter  P0_PNL_H_PIX_M1 = 8'd239;
    parameter  P0_PNL_V_PIX_M1 = 8'd239;
    parameter  P0_PAD_H_START = 8'd90;
    parameter  P0_PAD_V_START = 8'd106;
    parameter  P0_PAD_H_SIZE = 8'd20;
    parameter  P0_PAD_V_SIZE = 8'd28;
    parameter  P0_PAD_ROM_S_SEL = 1'b0;

 // P1 : PVII-6 (4x4 IM)
    parameter  P1_PNL_H_PIX_M1 = 8'd159;
    parameter  P1_PNL_V_PIX_M1 = 8'd159;
    parameter  P1_PAD_H_START = 8'd50;
    parameter  P1_PAD_V_START = 8'd66;
    parameter  P1_PAD_H_SIZE = 8'd12;
    parameter  P1_PAD_V_SIZE = 8'd28;
    parameter  P1_PAD_ROM_S_SEL = 1'b0;

 // P2 : ImpactII-10
    parameter  P2_PNL_H_PIX_M1 = 8'd35;
    parameter  P2_PNL_V_PIX_M1 = 8'd107;
    parameter  P2_PAD_H_START = 8'd3;
    parameter  P2_PAD_V_START = 8'd47;
    parameter  P2_PAD_H_SIZE = 8'd10;
    parameter  P2_PAD_V_SIZE = 8'd14;
    parameter  P2_PAD_ROM_S_SEL = 1'b1;

 // P3 : ImpactII-12
    parameter  P3_PNL_H_PIX_M1 = 8'd63;
    parameter  P3_PNL_V_PIX_M1 = 8'd95;
    parameter  P3_PAD_H_START = 8'd17;
    parameter  P3_PAD_V_START = 8'd41;
    parameter  P3_PAD_H_SIZE = 8'd10;
    parameter  P3_PAD_V_SIZE = 8'd14;
    parameter  P3_PAD_ROM_S_SEL = 1'b1;

 // P4 : ImpactII-16
    parameter  P4_PNL_H_PIX_M1 = 8'd47;
    parameter  P4_PNL_V_PIX_M1 = 8'd71;
    parameter  P4_PAD_H_START = 8'd9;
    parameter  P4_PAD_V_START = 8'd29;
    parameter  P4_PAD_H_SIZE = 8'd10;
    parameter  P4_PAD_V_SIZE = 8'd14;
    parameter  P4_PAD_ROM_S_SEL = 1'b1;

 // P5 : Pv16i/o-oval
    parameter  P5_PNL_H_PIX_M1 = 8'd59;
    parameter  P5_PNL_V_PIX_M1 = 8'd79;
    parameter  P5_PAD_H_START = 8'd15;
    parameter  P5_PAD_V_START = 8'd33;
    parameter  P5_PAD_H_SIZE = 8'd10;
    parameter  P5_PAD_V_SIZE = 8'd14;
    parameter  P5_PAD_ROM_S_SEL = 1'b1;

 // P6 : Bv16i/o-oval
    parameter  P6_PNL_H_PIX_M1 = 8'd79;
    parameter  P6_PNL_V_PIX_M1 = 8'd59;
    parameter  P6_PAD_H_START = 8'd25;
    parameter  P6_PAD_V_START = 8'd23;
    parameter  P6_PAD_H_SIZE = 8'd10;
    parameter  P6_PAD_V_SIZE = 8'd14;
    parameter  P6_PAD_ROM_S_SEL = 1'b1;

 // P7 : Pv20i/o-oval
    parameter  P7_PNL_H_PIX_M1 = 8'd95;
    parameter  P7_PNL_V_PIX_M1 = 8'd63;
    parameter  P7_PAD_H_START = 8'd33;
    parameter  P7_PAD_V_START = 8'd25;
    parameter  P7_PAD_H_SIZE = 8'd10;
    parameter  P7_PAD_V_SIZE = 8'd14;
    parameter  P7_PAD_ROM_S_SEL = 1'b1;

 // P8 : Pv26i/o-oval
    parameter  P8_PNL_H_PIX_M1 = 8'd71;
    parameter  P8_PNL_V_PIX_M1 = 8'd47;
    parameter  P8_PAD_H_START = 8'd21;
    parameter  P8_PAD_V_START = 8'd17;
    parameter  P8_PAD_H_SIZE = 8'd10;
    parameter  P8_PAD_V_SIZE = 8'd14;
    parameter  P8_PAD_ROM_S_SEL = 1'b1;

 // P9 : Fv20T
    parameter  P9_PNL_H_PIX_M1 = 8'd63;
    parameter  P9_PNL_V_PIX_M1 = 8'd47;
    parameter  P9_PAD_H_START = 8'd17;
    parameter  P9_PAD_V_START = 8'd17;
    parameter  P9_PAD_H_SIZE = 8'd10;
    parameter  P9_PAD_V_SIZE = 8'd14;
    parameter  P9_PAD_ROM_S_SEL = 1'b1;

 // P10 : Pv10
    parameter  P10_PNL_H_PIX_M1 = 8'd95;
    parameter  P10_PNL_V_PIX_M1 = 8'd95;
    parameter  P10_PAD_H_START = 8'd33;
    parameter  P10_PAD_V_START = 8'd41;
    parameter  P10_PAD_H_SIZE = 8'd10;
    parameter  P10_PAD_V_SIZE = 8'd14;
    parameter  P10_PAD_ROM_S_SEL = 1'b1;


 // parameter select

    // pnl_h_pix_m1  8bit
    function [7:0] pnl_h_pix_m1_sel;
    input [3:0] sel;
      case(sel)
        4'h0: pnl_h_pix_m1_sel = P0_PNL_H_PIX_M1;
        4'h1: pnl_h_pix_m1_sel = P1_PNL_H_PIX_M1;
        4'h2: pnl_h_pix_m1_sel = P2_PNL_H_PIX_M1;
        4'h3: pnl_h_pix_m1_sel = P3_PNL_H_PIX_M1;
        4'h4: pnl_h_pix_m1_sel = P4_PNL_H_PIX_M1;
        4'h5: pnl_h_pix_m1_sel = P5_PNL_H_PIX_M1;
        4'h6: pnl_h_pix_m1_sel = P6_PNL_H_PIX_M1;
        4'h7: pnl_h_pix_m1_sel = P7_PNL_H_PIX_M1;
        4'h8: pnl_h_pix_m1_sel = P8_PNL_H_PIX_M1;
        4'h9: pnl_h_pix_m1_sel = P9_PNL_H_PIX_M1;
        4'ha: pnl_h_pix_m1_sel = P10_PNL_H_PIX_M1;
        default: pnl_h_pix_m1_sel = P0_PNL_H_PIX_M1;
      endcase
    endfunction

    assign pnl_h_pix_m1 = pnl_h_pix_m1_sel(panel_sel);

    // pnl_v_pix_m1  8bit
    function [7:0] pnl_v_pix_m1_sel;
    input [3:0] sel;
      case(sel)
        4'h0: pnl_v_pix_m1_sel = P0_PNL_V_PIX_M1;
        4'h1: pnl_v_pix_m1_sel = P1_PNL_V_PIX_M1;
        4'h2: pnl_v_pix_m1_sel = P2_PNL_V_PIX_M1;
        4'h3: pnl_v_pix_m1_sel = P3_PNL_V_PIX_M1;
        4'h4: pnl_v_pix_m1_sel = P4_PNL_V_PIX_M1;
        4'h5: pnl_v_pix_m1_sel = P5_PNL_V_PIX_M1;
        4'h6: pnl_v_pix_m1_sel = P6_PNL_V_PIX_M1;
        4'h7: pnl_v_pix_m1_sel = P7_PNL_V_PIX_M1;
        4'h8: pnl_v_pix_m1_sel = P8_PNL_V_PIX_M1;
        4'h9: pnl_v_pix_m1_sel = P9_PNL_V_PIX_M1;
        4'ha: pnl_v_pix_m1_sel = P10_PNL_V_PIX_M1;
        default: pnl_v_pix_m1_sel = P0_PNL_V_PIX_M1;
      endcase
    endfunction

    assign pnl_v_pix_m1 = pnl_v_pix_m1_sel(panel_sel);

    // pad_h_start  8bit
    function [7:0] pad_h_start_sel;
    input [3:0] sel;
      case(sel)
        4'h0: pad_h_start_sel = P0_PAD_H_START;
        4'h1: pad_h_start_sel = P1_PAD_H_START;
        4'h2: pad_h_start_sel = P2_PAD_H_START;
        4'h3: pad_h_start_sel = P3_PAD_H_START;
        4'h4: pad_h_start_sel = P4_PAD_H_START;
        4'h5: pad_h_start_sel = P5_PAD_H_START;
        4'h6: pad_h_start_sel = P6_PAD_H_START;
        4'h7: pad_h_start_sel = P7_PAD_H_START;
        4'h8: pad_h_start_sel = P8_PAD_H_START;
        4'h9: pad_h_start_sel = P9_PAD_H_START;
        4'ha: pad_h_start_sel = P10_PAD_H_START;
        default: pad_h_start_sel = P0_PAD_H_START;
      endcase
    endfunction

    assign pad_h_start = pad_h_start_sel(panel_sel);

    // pad_v_start  8bit
    function [7:0] pad_v_start_sel;
    input [3:0] sel;
      case(sel)
        4'h0: pad_v_start_sel = P0_PAD_V_START;
        4'h1: pad_v_start_sel = P1_PAD_V_START;
        4'h2: pad_v_start_sel = P2_PAD_V_START;
        4'h3: pad_v_start_sel = P3_PAD_V_START;
        4'h4: pad_v_start_sel = P4_PAD_V_START;
        4'h5: pad_v_start_sel = P5_PAD_V_START;
        4'h6: pad_v_start_sel = P6_PAD_V_START;
        4'h7: pad_v_start_sel = P7_PAD_V_START;
        4'h8: pad_v_start_sel = P8_PAD_V_START;
        4'h9: pad_v_start_sel = P9_PAD_V_START;
        4'ha: pad_v_start_sel = P10_PAD_V_START;
        default: pad_v_start_sel = P0_PAD_V_START;
      endcase
    endfunction

    assign pad_v_start = pad_v_start_sel(panel_sel);

    // pad_h_size  8bit
    function [7:0] pad_h_size_sel;
    input [3:0] sel;
      case(sel)
        4'h0: pad_h_size_sel = P0_PAD_H_SIZE;
        4'h1: pad_h_size_sel = P1_PAD_H_SIZE;
        4'h2: pad_h_size_sel = P2_PAD_H_SIZE;
        4'h3: pad_h_size_sel = P3_PAD_H_SIZE;
        4'h4: pad_h_size_sel = P4_PAD_H_SIZE;
        4'h5: pad_h_size_sel = P5_PAD_H_SIZE;
        4'h6: pad_h_size_sel = P6_PAD_H_SIZE;
        4'h7: pad_h_size_sel = P7_PAD_H_SIZE;
        4'h8: pad_h_size_sel = P8_PAD_H_SIZE;
        4'h9: pad_h_size_sel = P9_PAD_H_SIZE;
        4'ha: pad_h_size_sel = P10_PAD_H_SIZE;
        default: pad_h_size_sel = P0_PAD_H_SIZE;
      endcase
    endfunction

    assign pad_h_size = pad_h_size_sel(panel_sel);

    // pad_v_size  8bit
    function [7:0] pad_v_size_sel;
    input [3:0] sel;
      case(sel)
        4'h0: pad_v_size_sel = P0_PAD_V_SIZE;
        4'h1: pad_v_size_sel = P1_PAD_V_SIZE;
        4'h2: pad_v_size_sel = P2_PAD_V_SIZE;
        4'h3: pad_v_size_sel = P3_PAD_V_SIZE;
        4'h4: pad_v_size_sel = P4_PAD_V_SIZE;
        4'h5: pad_v_size_sel = P5_PAD_V_SIZE;
        4'h6: pad_v_size_sel = P6_PAD_V_SIZE;
        4'h7: pad_v_size_sel = P7_PAD_V_SIZE;
        4'h8: pad_v_size_sel = P8_PAD_V_SIZE;
        4'h9: pad_v_size_sel = P9_PAD_V_SIZE;
        4'ha: pad_v_size_sel = P10_PAD_V_SIZE;
        default: pad_v_size_sel = P0_PAD_V_SIZE;
      endcase
    endfunction

    assign pad_v_size = pad_v_size_sel(panel_sel);

    // pad_rom_s_sel
    function pad_rom_s_sel_sel;
    input [3:0] sel;
      case(sel)
        4'h0: pad_rom_s_sel_sel = P0_PAD_ROM_S_SEL;
        4'h1: pad_rom_s_sel_sel = P1_PAD_ROM_S_SEL;
        4'h2: pad_rom_s_sel_sel = P2_PAD_ROM_S_SEL;
        4'h3: pad_rom_s_sel_sel = P3_PAD_ROM_S_SEL;
        4'h4: pad_rom_s_sel_sel = P4_PAD_ROM_S_SEL;
        4'h5: pad_rom_s_sel_sel = P5_PAD_ROM_S_SEL;
        4'h6: pad_rom_s_sel_sel = P6_PAD_ROM_S_SEL;
        4'h7: pad_rom_s_sel_sel = P7_PAD_ROM_S_SEL;
        4'h8: pad_rom_s_sel_sel = P8_PAD_ROM_S_SEL;
        4'h9: pad_rom_s_sel_sel = P9_PAD_ROM_S_SEL;
        4'ha: pad_rom_s_sel_sel = P10_PAD_ROM_S_SEL;
        default: pad_rom_s_sel_sel = P0_PAD_ROM_S_SEL;
      endcase
    endfunction

    assign pad_rom_s_sel = pad_rom_s_sel_sel(panel_sel);


    // pad_h_ten_start, pad_h_one_start, pad_h_end  8bit
    assign pad_h_ten_start = pad_h_start     + pad_h_size;
    assign pad_h_one_start = pad_h_ten_start + pad_h_size;
    assign pad_h_end       = pad_h_one_start + pad_h_size;

    // pad_v_end  8bit
    assign pad_v_end = pad_v_start + pad_v_size;


// パネル接続順番号 2進数>>10進数変換部

    // num  11bit
    assign num = panel_num + 10'h001;

    // numa  10bit
    always @(posedge clk) begin
      numa <= (num > 11'h3e7) ? 11'h3e7 : num[9:0];
    end

    // le900, le800, le700, le600, le500, le400, le300, le200, le100
    always @(posedge clk) begin
      le900 <= (numa >= 10'h384);  // d900
      le800 <= (numa >= 10'h320);  // d800
      le700 <= (numa >= 10'h2bc);  // d700
      le600 <= (numa >= 10'h258);  // d600
      le500 <= (numa >= 10'h1f4);  // d500
      le400 <= (numa >= 10'h190);  // d400
      le300 <= (numa >= 10'h12c);  // d300
      le200 <= (numa >= 10'h0c8);  // d200
      le100 <= (numa >= 10'h064);  // d100
    end

    // hund_numa  4bit
    always @(posedge clk) begin
      if(le900)
        hund_numa <= 4'h9;
      else if(le800)
        hund_numa <= 4'h8;
      else if(le700)
        hund_numa <= 4'h7;
      else if(le600)
        hund_numa <= 4'h6;
      else if(le500)
        hund_numa <= 4'h5;
      else if(le400)
        hund_numa <= 4'h4;
      else if(le300)
        hund_numa <= 4'h3;
      else if(le200)
        hund_numa <= 4'h2;
      else if(le100)
        hund_numa <= 4'h1;
      else
        hund_numa <= 4'h0;
    end

    // hund  10bit
    always @(posedge clk) begin
      case (hund_numa)
        4'h0: hund <= 10'h000;
        4'h1: hund <= 10'h064;
        4'h2: hund <= 10'h0c8;
        4'h3: hund <= 10'h12c;
        4'h4: hund <= 10'h190;
        4'h5: hund <= 10'h1f4;
        4'h6: hund <= 10'h258;
        4'h7: hund <= 10'h2bc;
        4'h8: hund <= 10'h320;
        4'h9: hund <= 10'h384;
        4'ha: hund <= 10'h000;
        4'hb: hund <= 10'h000;
        4'hc: hund <= 10'h000;
        4'hd: hund <= 10'h000;
        4'he: hund <= 10'h000;
        4'hf: hund <= 10'h000;
      endcase
    end

    // numb  10bit
    always @(posedge clk) begin
      numb <= numa + ~hund + 1'b1;
    end

    // le90, le80, le70, le60, le50, le40, le30, le20, le10
    always @(posedge clk) begin
      le90 <= (numb[6:0] >= 7'h5a);  // d90
      le80 <= (numb[6:0] >= 7'h50);  // d80
      le70 <= (numb[6:0] >= 7'h46);  // d70
      le60 <= (numb[6:0] >= 7'h3c);  // d60
      le50 <= (numb[6:0] >= 7'h32);  // d50
      le40 <= (numb[6:0] >= 7'h28);  // d40
      le30 <= (numb[6:0] >= 7'h1e);  // d30
      le20 <= (numb[6:0] >= 7'h14);  // d20
      le10 <= (numb[6:0] >= 7'h0a);  // d10
    end

    // ten_numa  4bit
    always @(posedge clk) begin
      if(le90)
        ten_numa <= 4'h9;
      else if(le80)
        ten_numa <= 4'h8;
      else if(le70)
        ten_numa <= 4'h7;
      else if(le60)
        ten_numa <= 4'h6;
      else if(le50)
        ten_numa <= 4'h5;
      else if(le40)
        ten_numa <= 4'h4;
      else if(le30)
        ten_numa <= 4'h3;
      else if(le20)
        ten_numa <= 4'h2;
      else if(le10)
        ten_numa <= 4'h1;
      else
        ten_numa <= 4'h0;
    end

    // ten  7bit
    always @(posedge clk) begin
      case (ten_numa)
        4'h0: ten <= 7'h00;
        4'h1: ten <= 7'h0a;
        4'h2: ten <= 7'h14;
        4'h3: ten <= 7'h1e;
        4'h4: ten <= 7'h28;
        4'h5: ten <= 7'h32;
        4'h6: ten <= 7'h3c;
        4'h7: ten <= 7'h46;
        4'h8: ten <= 7'h50;
        4'h9: ten <= 7'h5a;
        4'ha: ten <= 7'h00;
        4'hb: ten <= 7'h00;
        4'hc: ten <= 7'h00;
        4'hd: ten <= 7'h00;
        4'he: ten <= 7'h00;
        4'hf: ten <= 7'h00;
      endcase
    end

    // numc  7bit
    always @(posedge clk) begin
      numc <= numb + ~ten + 1'b1;
    end

    // hund_num, ten_num, one_num  4bit
    always @(posedge clk) begin
      if(ovp) begin
        hund_num <= hund_numa;
        ten_num <= ten_numa;
        one_num <= numc[3:0];
      end
    end


// ROM address 作成

    // vadrs, hadrs  8bit
    always @(posedge clk) begin
      {vadrs, hadrs} <= test_on ? test_pad_adrs : video_pad_adrs;
    end

    // pad_on
    always @(posedge clk) begin
      if(ovp)
        pad_on <= pnl_adrs_on;
    end


    // rom_had  8bit
    // dec_num  4bit
    // hen
    always @(posedge clk) begin
      if(~pad_on) begin
        rom_had <= 8'd0;
        dec_num <= 4'hf;
        hen     <= 1'b0;
      end
      else if(hadrs >= pad_h_end) begin
        rom_had <= 8'd0;
        dec_num <= 4'hf;
        hen     <= 1'b0;
      end
      else if(hadrs >= pad_h_one_start) begin
        rom_had <= hadrs - pad_h_one_start;
        dec_num <= one_num;
        hen     <= 1'b1;
      end
      else if(hadrs >= pad_h_ten_start) begin
        rom_had <= hadrs - pad_h_ten_start;
        dec_num <= ten_num;
        hen     <= 1'b1;
      end
      else if(hadrs >= pad_h_start) begin
        rom_had <= hadrs - pad_h_start;
        dec_num <= hund_num;
        hen     <= 1'b1;
      end
      else begin
        rom_had <= 8'd0;
        dec_num <= 4'hf;
        hen     <= 1'b0;
      end
    end

    // rom_vad  8bit
    // ven
    always @(posedge clk) begin
      if(~pad_on) begin
        rom_vad <= 8'd0;
        ven     <= 1'b0;
      end
      else if(vadrs >= pad_v_end) begin
        rom_vad <= 8'd0;
        ven     <= 1'b0;
      end
      else if(vadrs >= pad_v_start) begin
        rom_vad <= vadrs - pad_v_start;
        ven     <= 1'b1;
      end
      else begin
        rom_vad <= 8'd0;
        ven     <= 1'b0;
      end
    end


    // rom_l_adrs  14bit
    assign rom_l_adrs = {dec_num, rom_vad[4:0], rom_had[4:0]};

    // rom_s_adrs  12bit
    assign rom_s_adrs = {dec_num, rom_vad[3:0], rom_had[3:0]};

    // rom_l_en, rom_s_en
    assign rom_l_en = pad_on & ~pad_rom_s_sel;
    assign rom_s_en = pad_on &  pad_rom_s_sel;


// border line 作成

    // left_bd, right_bd, up_bd, bottom_bd
    always @(posedge clk) begin
      left_bd   <= (hadrs == 8'd0);
      right_bd  <= (hadrs == pnl_h_pix_m1);
      up_bd     <= (vadrs == 8'd0);
      bottom_bd <= (vadrs == pnl_v_pix_m1);
    end

    // border
    always @(posedge clk) begin
      border <= (left_bd | right_bd | up_bd | bottom_bd) & pad_on;
    end


// 出力

    // hv_en
    always @(posedge clk) begin
      hv_en <= hen & ven & pad_on;
    end

    // rom_out  2bit ([0] 白線, [1] 黒エッジ)
    assign rom_out = pad_rom_s_sel ? rom_s_out : rom_l_out;

    // pad_white, pad_black
    always @(posedge clk) begin
      pad_white <= (rom_out[0] & hv_en) | border;
      pad_black <=  rom_out[1] & hv_en;
    end

endmodule
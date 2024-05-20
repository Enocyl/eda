`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board for PVII-4 (4x4 IM)
// テストパターン作成


module test_pat_gen_pv2_4_4x4 (panel_sel, frame_alt, test_pat, color_loss_on_n,
                           pixel1_disp_on, pixel4_disp_on,
                           video_st_pac, color_loss,
                           testp_rgb_en, testp_level,
                           pixel1_disp_mode, pixel_disp_rgb_on, clk,

                           pixel_disp_on, test_sel,
                           lm_we, lm_ha, lm_va, dout);

    input [3:0] panel_sel;
    input frame_alt;
    input [6:0] test_pat;
    input color_loss_on_n;
    input pixel1_disp_on;
    input pixel4_disp_on;
    input video_st_pac;
    input [2:0] color_loss;
    input [2:0] testp_rgb_en;
    input [7:0] testp_level;
    input [23:0] pixel1_disp_mode;
    input [2:0] pixel_disp_rgb_on;
    input clk;

    output pixel_disp_on;
    output reg test_sel;
    output reg lm_we;
    output reg [7:0] lm_ha;
    output reg [7:0] lm_va;
    output reg [29:0] dout;

    reg frame_alt_1d, frame_alt_2d, ovpx;
    reg [6:0] tst_ptn;
    reg tp_move;
    reg rainbow_on, h_ramp_on, v_ramp_on, diagonal_on;
    reg h_line_on, v_line_on, gray_sc_on;
    reg pixel1_on, pixel4_on;
    reg tp_pix_on;
    reg video_st_pac_1d, video_st_pac_2d, video_stpx;
    reg [8:0] ha;
    reg ha_end;
    reg [8:0] va;
    reg lm_wea_1d, lm_wea_2d, lm_wea_3d;
    reg [7:0] ha_1d, ha_2d, ha_3d;
    reg [7:0] va_1d, va_2d, va_3d;
    reg [3:0] tst_ptn_1d;
    reg tp_change;
    reg [6:0] qa;
    reg [7:0] qb;
    reg [6:0] qc;
    reg [6:0] qhline, qvline;
    reg hv_line;
    reg [17:0] ramp_step;
    reg [17:0] ramp_c;
    reg [9:0] ramp;
    reg [17:0] hv_offset;
    reg video_stpx_1d;
    reg [17:0] dia_offset;
    reg [1:0] qd, qe, qf;
    reg [9:0] rainbow_r, rainbow_g, rainbow_b;
    reg [2:0] flat_tp;
    reg flat_tp_r_on, flat_tp_g_on, flat_tp_b_on;
    reg flat_r_on, flat_g_on, flat_b_on;
    reg [2:0] tp_osel;
    reg [9:0] r_tp, g_tp, b_tp;
    reg test_grid, test_odd, test_even;
    reg odd_blk, even_blk, odd_even_blk;
    reg [6:0] im_pix_ha, im_pix_va;
    reg grid_tri, grid_line, grid;
    reg [2:0] tp_rgb_en;
    reg [7:0] testp_lvl;
    reg [8:0] testp_lvla;
    reg [9:0] r_tp_out, g_tp_out, b_tp_out;
    reg [7:0] h_4pix_acc;
    reg h_4pix_acc_p1_sel;
    reg [7:0] v_4pix_acc;
    reg v_4pix_acc_p1_sel;
    reg all_im_4pixel;
    reg [7:0] pixel_h_posi, pixel_v_posi;
    reg [2:0] im_h_ad, im_v_ad;
    reg [1:0] pixel1_mode;
    reg posi_over;
    reg [6:0] im_h_pix, im_v_pix;
    reg [7:0] h_1pix_acc;
    reg [3:0] qhim;
    reg [7:0] v_1pix_acc;
    reg [3:0] qvim;
    reg [5:0] qpixblink;
    reg im_1pixel;
    reg pixel1or4;
    reg [2:0] pixel_rgb_on;
    reg r_pixel, g_pixel, b_pixel;

    wire xt6, xt10;
    wire [6:0] tst_line_speed, tst_speed;
    wire [7:0] tst_rainbow_seq_end, tst_seq_end;
    wire [6:0] tst_h_line_seq_end, tst_v_line_seq_end;
    wire [17:0] tst_h_ramp_step, tst_v_ramp_step, tst_rainbow_step;
    wire [6:0] im_h_pix_m1, im_v_pix_m1;
    wire tp_msb, tp_on;
    wire ha_rst;
    wire adrs_cnt_stop;
    wire lm_wea;
    wire tp_off_chg;
    wire [6:0] qa_lda;
    wire qa_end;
    wire move_timp;
    wire seq_rst;
    wire seq_end;
    wire seq_endp;
    wire line_seq_rst;
    wire line_seq_end;
    wire qhline_end, qvline_end;
    wire h_line_a, v_line_a;
    wire [9:0] line;
    wire [17:0] tst_ramp_step;
    wire [18:0] ramp_a;
    wire [17:0] ramp_b;
    wire ramp_rst, offset_sel;
    wire [18:0] hv_offset_a;
    wire hv_offset_rst;
    wire [18:0] dia_offset_a;
    wire [17:0] dia_offset_b;
    wire [17:0] ramp_offset;
    wire qd_end, qe_end;
    wire [1:0] qf_lda;
    wire qf_end;
    wire flat_tp_dec1, flat_tp_dec2, flat_tp_dec3, flat_tp_dec4;
    wire flat_tp_dec5, flat_tp_dec6, flat_tp_dec7;
    wire [9:0] flat_r, flat_g, flat_b;
    wire im_pix_ha_end, im_pix_va_end;
    wire im_pix_ha_0, im_pix_ha_1, im_pix_ha_2;
    wire im_pix_va_0, im_pix_va_1, im_pix_va_2;
    wire grid_va_0, grid_va_1, grid_va_2;
    wire tp_r_blk, tp_g_blk, tp_b_blk;
    wire [18:0] r_tp_mlt, g_tp_mlt, b_tp_mlt;
    wire [29:0] tp_do;
    wire [7:0] h_4pix_acc_a;
    wire im_h_edge;
    wire [7:0] v_4pix_acc_a;
    wire im_v_edge;
    wire h_posi_over, v_posi_over;
    wire [7:0] h_1pix_acc_a;
    wire im_1pix_h_posi;
    wire [7:0] v_1pix_acc_a;
    wire im_1pix_v_posi;
    wire all_im_1pixel;
    wire sel_im_1pixel;
    wire [29:0] pixel_do;


// パラメータ設定

 // P0 : PVII-4 (2x4 IM)
    parameter  P0_TST_LINE_SPEED = 7'd53;
    parameter  P0_TST_SPEED = 7'd64;
    parameter  P0_TST_RAINBOW_SEQ_END = 8'd239;
    parameter  P0_TST_SEQ_END = 8'd239;
    parameter  P0_TST_H_LINE_SEQ_END = 7'd59;
    parameter  P0_TST_V_LINE_SEQ_END = 7'd59;
    parameter  P0_TST_H_RAMP_STEP = 18'd1096;
    parameter  P0_TST_V_RAMP_STEP = 18'd1096;
    parameter  P0_TST_RAINBOW_STEP = 18'd3316;
    parameter  P0_IM_H_PIX_M1 = 7'd59;
    parameter  P0_IM_V_PIX_M1 = 7'd59;

 // P1 : PVII-6 (4x4 IM)
    parameter  P1_TST_LINE_SPEED = 7'd53;
    parameter  P1_TST_SPEED = 7'd63;
    parameter  P1_TST_RAINBOW_SEQ_END = 8'd161;
    parameter  P1_TST_SEQ_END = 8'd159;
    parameter  P1_TST_H_LINE_SEQ_END = 7'd39;
    parameter  P1_TST_V_LINE_SEQ_END = 7'd39;
    parameter  P1_TST_H_RAMP_STEP = 18'd1648;
    parameter  P1_TST_V_RAMP_STEP = 18'd1648;
    parameter  P1_TST_RAINBOW_STEP = 18'd4942;
    parameter  P1_IM_H_PIX_M1 = 7'd39;
    parameter  P1_IM_V_PIX_M1 = 7'd39;

 // P2 : ImpactII-10
    parameter  P2_TST_LINE_SPEED = 7'd53;
    parameter  P2_TST_SPEED = 7'd62;
    parameter  P2_TST_RAINBOW_SEQ_END = 8'd35;
    parameter  P2_TST_SEQ_END = 8'd35;
    parameter  P2_TST_H_LINE_SEQ_END = 7'd17;
    parameter  P2_TST_V_LINE_SEQ_END = 7'd17;
    parameter  P2_TST_H_RAMP_STEP = 18'd7483;
    parameter  P2_TST_V_RAMP_STEP = 18'd7483;
    parameter  P2_TST_RAINBOW_STEP = 18'd23808;
    parameter  P2_IM_H_PIX_M1 = 7'd17;
    parameter  P2_IM_V_PIX_M1 = 7'd17;

 // P3 : ImpactII-12
    parameter  P3_TST_LINE_SPEED = 7'd53;
    parameter  P3_TST_SPEED = 7'd62;
    parameter  P3_TST_RAINBOW_SEQ_END = 8'd65;
    parameter  P3_TST_SEQ_END = 8'd63;
    parameter  P3_TST_H_LINE_SEQ_END = 7'd15;
    parameter  P3_TST_V_LINE_SEQ_END = 7'd15;
    parameter  P3_TST_H_RAMP_STEP = 18'd4157;
    parameter  P3_TST_V_RAMP_STEP = 18'd4157;
    parameter  P3_TST_RAINBOW_STEP = 18'd12471;
    parameter  P3_IM_H_PIX_M1 = 7'd15;
    parameter  P3_IM_V_PIX_M1 = 7'd15;

 // P4 : ImpactII-16
    parameter  P4_TST_LINE_SPEED = 7'd53;
    parameter  P4_TST_SPEED = 7'd62;
    parameter  P4_TST_RAINBOW_SEQ_END = 8'd47;
    parameter  P4_TST_SEQ_END = 8'd47;
    parameter  P4_TST_H_LINE_SEQ_END = 7'd11;
    parameter  P4_TST_V_LINE_SEQ_END = 7'd11;
    parameter  P4_TST_H_RAMP_STEP = 18'd5573;
    parameter  P4_TST_V_RAMP_STEP = 18'd5573;
    parameter  P4_TST_RAINBOW_STEP = 18'd17460;
    parameter  P4_IM_H_PIX_M1 = 7'd11;
    parameter  P4_IM_V_PIX_M1 = 7'd11;

 // P5 : Pv16i/o-oval
    parameter  P5_TST_LINE_SPEED = 7'd53;
    parameter  P5_TST_SPEED = 7'd62;
    parameter  P5_TST_RAINBOW_SEQ_END = 8'd59;
    parameter  P5_TST_SEQ_END = 8'd59;
    parameter  P5_TST_H_LINE_SEQ_END = 7'd19;
    parameter  P5_TST_V_LINE_SEQ_END = 7'd19;
    parameter  P5_TST_H_RAMP_STEP = 18'd4439;
    parameter  P5_TST_V_RAMP_STEP = 18'd4439;
    parameter  P5_TST_RAINBOW_STEP = 18'd13784;
    parameter  P5_IM_H_PIX_M1 = 7'd19;
    parameter  P5_IM_V_PIX_M1 = 7'd19;

 // P6 : Bv16i/o-oval
    parameter  P6_TST_LINE_SPEED = 7'd53;
    parameter  P6_TST_SPEED = 7'd62;
    parameter  P6_TST_RAINBOW_SEQ_END = 8'd59;
    parameter  P6_TST_SEQ_END = 8'd59;
    parameter  P6_TST_H_LINE_SEQ_END = 7'd19;
    parameter  P6_TST_V_LINE_SEQ_END = 7'd19;
    parameter  P6_TST_H_RAMP_STEP = 18'd4439;
    parameter  P6_TST_V_RAMP_STEP = 18'd4439;
    parameter  P6_TST_RAINBOW_STEP = 18'd13784;
    parameter  P6_IM_H_PIX_M1 = 7'd19;
    parameter  P6_IM_V_PIX_M1 = 7'd19;

 // P7 : Pv20i/o-oval
    parameter  P7_TST_LINE_SPEED = 7'd53;
    parameter  P7_TST_SPEED = 7'd62;
    parameter  P7_TST_RAINBOW_SEQ_END = 8'd65;
    parameter  P7_TST_SEQ_END = 8'd63;
    parameter  P7_TST_H_LINE_SEQ_END = 7'd15;
    parameter  P7_TST_V_LINE_SEQ_END = 7'd15;
    parameter  P7_TST_H_RAMP_STEP = 18'd4157;
    parameter  P7_TST_V_RAMP_STEP = 18'd4157;
    parameter  P7_TST_RAINBOW_STEP = 18'd12471;
    parameter  P7_IM_H_PIX_M1 = 7'd15;
    parameter  P7_IM_V_PIX_M1 = 7'd15;

 // P8 : Pv26i/o-oval
    parameter  P8_TST_LINE_SPEED = 7'd53;
    parameter  P8_TST_SPEED = 7'd62;
    parameter  P8_TST_RAINBOW_SEQ_END = 8'd47;
    parameter  P8_TST_SEQ_END = 8'd47;
    parameter  P8_TST_H_LINE_SEQ_END = 7'd11;
    parameter  P8_TST_V_LINE_SEQ_END = 7'd11;
    parameter  P8_TST_H_RAMP_STEP = 18'd5573;
    parameter  P8_TST_V_RAMP_STEP = 18'd5573;
    parameter  P8_TST_RAINBOW_STEP = 18'd17460;
    parameter  P8_IM_H_PIX_M1 = 7'd11;
    parameter  P8_IM_V_PIX_M1 = 7'd11;

 // P9 : Fv20T
    parameter  P9_TST_LINE_SPEED = 7'd53;
    parameter  P9_TST_SPEED = 7'd62;
    parameter  P9_TST_RAINBOW_SEQ_END = 8'd47;
    parameter  P9_TST_SEQ_END = 8'd47;
    parameter  P9_TST_H_LINE_SEQ_END = 7'd15;
    parameter  P9_TST_V_LINE_SEQ_END = 7'd15;
    parameter  P9_TST_H_RAMP_STEP = 18'd5573;
    parameter  P9_TST_V_RAMP_STEP = 18'd5573;
    parameter  P9_TST_RAINBOW_STEP = 18'd17460;
    parameter  P9_IM_H_PIX_M1 = 7'd15;
    parameter  P9_IM_V_PIX_M1 = 7'd15;

 // P10 : Pv10
    parameter  P10_TST_LINE_SPEED = 7'd53;
    parameter  P10_TST_SPEED = 7'd62;
    parameter  P10_TST_RAINBOW_SEQ_END = 8'd95;
    parameter  P10_TST_SEQ_END = 8'd95;
    parameter  P10_TST_H_LINE_SEQ_END = 7'd23;
    parameter  P10_TST_V_LINE_SEQ_END = 7'd23;
    parameter  P10_TST_H_RAMP_STEP = 18'd2757;
    parameter  P10_TST_V_RAMP_STEP = 18'd2757;
    parameter  P10_TST_RAINBOW_STEP = 18'd8448;
    parameter  P10_IM_H_PIX_M1 = 7'd23;
    parameter  P10_IM_V_PIX_M1 = 7'd23;


 // parameter select

    // tst_line_speed  7bit
    function [6:0] tst_line_speed_sel;
    input [3:0] sel;
      case(sel)
        4'h0: tst_line_speed_sel = P0_TST_LINE_SPEED;
        4'h1: tst_line_speed_sel = P1_TST_LINE_SPEED;
        4'h2: tst_line_speed_sel = P2_TST_LINE_SPEED;
        4'h3: tst_line_speed_sel = P3_TST_LINE_SPEED;
        4'h4: tst_line_speed_sel = P4_TST_LINE_SPEED;
        4'h5: tst_line_speed_sel = P5_TST_LINE_SPEED;
        4'h6: tst_line_speed_sel = P6_TST_LINE_SPEED;
        4'h7: tst_line_speed_sel = P7_TST_LINE_SPEED;
        4'h8: tst_line_speed_sel = P8_TST_LINE_SPEED;
        4'h9: tst_line_speed_sel = P9_TST_LINE_SPEED;
        4'ha: tst_line_speed_sel = P10_TST_LINE_SPEED;
        default: tst_line_speed_sel = P0_TST_LINE_SPEED;
      endcase
    endfunction

    assign tst_line_speed = tst_line_speed_sel(panel_sel);

    // tst_speed  7bit
    function [6:0] tst_speed_sel;
    input [3:0] sel;
      case(sel)
        4'h0: tst_speed_sel = P0_TST_SPEED;
        4'h1: tst_speed_sel = P1_TST_SPEED;
        4'h2: tst_speed_sel = P2_TST_SPEED;
        4'h3: tst_speed_sel = P3_TST_SPEED;
        4'h4: tst_speed_sel = P4_TST_SPEED;
        4'h5: tst_speed_sel = P5_TST_SPEED;
        4'h6: tst_speed_sel = P6_TST_SPEED;
        4'h7: tst_speed_sel = P7_TST_SPEED;
        4'h8: tst_speed_sel = P8_TST_SPEED;
        4'h9: tst_speed_sel = P9_TST_SPEED;
        4'ha: tst_speed_sel = P10_TST_SPEED;
        default: tst_speed_sel = P0_TST_SPEED;
      endcase
    endfunction

    assign tst_speed = tst_speed_sel(panel_sel);

    // tst_rainbow_seq_end  8bit
    function [7:0] tst_rainbow_seq_end_sel;
    input [3:0] sel;
      case(sel)
        4'h0: tst_rainbow_seq_end_sel = P0_TST_RAINBOW_SEQ_END;
        4'h1: tst_rainbow_seq_end_sel = P1_TST_RAINBOW_SEQ_END;
        4'h2: tst_rainbow_seq_end_sel = P2_TST_RAINBOW_SEQ_END;
        4'h3: tst_rainbow_seq_end_sel = P3_TST_RAINBOW_SEQ_END;
        4'h4: tst_rainbow_seq_end_sel = P4_TST_RAINBOW_SEQ_END;
        4'h5: tst_rainbow_seq_end_sel = P5_TST_RAINBOW_SEQ_END;
        4'h6: tst_rainbow_seq_end_sel = P6_TST_RAINBOW_SEQ_END;
        4'h7: tst_rainbow_seq_end_sel = P7_TST_RAINBOW_SEQ_END;
        4'h8: tst_rainbow_seq_end_sel = P8_TST_RAINBOW_SEQ_END;
        4'h9: tst_rainbow_seq_end_sel = P9_TST_RAINBOW_SEQ_END;
        4'ha: tst_rainbow_seq_end_sel = P10_TST_RAINBOW_SEQ_END;
        default: tst_rainbow_seq_end_sel = P0_TST_RAINBOW_SEQ_END;
      endcase
    endfunction

    assign tst_rainbow_seq_end = tst_rainbow_seq_end_sel(panel_sel);

    // tst_seq_end  8bit
    function [7:0] tst_seq_end_sel;
    input [3:0] sel;
      case(sel)
        4'h0: tst_seq_end_sel = P0_TST_SEQ_END;
        4'h1: tst_seq_end_sel = P1_TST_SEQ_END;
        4'h2: tst_seq_end_sel = P2_TST_SEQ_END;
        4'h3: tst_seq_end_sel = P3_TST_SEQ_END;
        4'h4: tst_seq_end_sel = P4_TST_SEQ_END;
        4'h5: tst_seq_end_sel = P5_TST_SEQ_END;
        4'h6: tst_seq_end_sel = P6_TST_SEQ_END;
        4'h7: tst_seq_end_sel = P7_TST_SEQ_END;
        4'h8: tst_seq_end_sel = P8_TST_SEQ_END;
        4'h9: tst_seq_end_sel = P9_TST_SEQ_END;
        4'ha: tst_seq_end_sel = P10_TST_SEQ_END;
        default: tst_seq_end_sel = P0_TST_SEQ_END;
      endcase
    endfunction

    assign tst_seq_end = tst_seq_end_sel(panel_sel);

    // tst_h_line_seq_end  7bit
    function [6:0] tst_h_line_seq_end_sel;
    input [3:0] sel;
      case(sel)
        4'h0: tst_h_line_seq_end_sel = P0_TST_H_LINE_SEQ_END;
        4'h1: tst_h_line_seq_end_sel = P1_TST_H_LINE_SEQ_END;
        4'h2: tst_h_line_seq_end_sel = P2_TST_H_LINE_SEQ_END;
        4'h3: tst_h_line_seq_end_sel = P3_TST_H_LINE_SEQ_END;
        4'h4: tst_h_line_seq_end_sel = P4_TST_H_LINE_SEQ_END;
        4'h5: tst_h_line_seq_end_sel = P5_TST_H_LINE_SEQ_END;
        4'h6: tst_h_line_seq_end_sel = P6_TST_H_LINE_SEQ_END;
        4'h7: tst_h_line_seq_end_sel = P7_TST_H_LINE_SEQ_END;
        4'h8: tst_h_line_seq_end_sel = P8_TST_H_LINE_SEQ_END;
        4'h9: tst_h_line_seq_end_sel = P9_TST_H_LINE_SEQ_END;
        4'ha: tst_h_line_seq_end_sel = P10_TST_H_LINE_SEQ_END;
        default: tst_h_line_seq_end_sel = P0_TST_H_LINE_SEQ_END;
      endcase
    endfunction

    assign tst_h_line_seq_end = tst_h_line_seq_end_sel(panel_sel);

    // tst_v_line_seq_end  7bit
    function [6:0] tst_v_line_seq_end_sel;
    input [3:0] sel;
      case(sel)
        4'h0: tst_v_line_seq_end_sel = P0_TST_V_LINE_SEQ_END;
        4'h1: tst_v_line_seq_end_sel = P1_TST_V_LINE_SEQ_END;
        4'h2: tst_v_line_seq_end_sel = P2_TST_V_LINE_SEQ_END;
        4'h3: tst_v_line_seq_end_sel = P3_TST_V_LINE_SEQ_END;
        4'h4: tst_v_line_seq_end_sel = P4_TST_V_LINE_SEQ_END;
        4'h5: tst_v_line_seq_end_sel = P5_TST_V_LINE_SEQ_END;
        4'h6: tst_v_line_seq_end_sel = P6_TST_V_LINE_SEQ_END;
        4'h7: tst_v_line_seq_end_sel = P7_TST_V_LINE_SEQ_END;
        4'h8: tst_v_line_seq_end_sel = P8_TST_V_LINE_SEQ_END;
        4'h9: tst_v_line_seq_end_sel = P9_TST_V_LINE_SEQ_END;
        4'ha: tst_v_line_seq_end_sel = P10_TST_V_LINE_SEQ_END;
        default: tst_v_line_seq_end_sel = P0_TST_V_LINE_SEQ_END;
      endcase
    endfunction

    assign tst_v_line_seq_end = tst_v_line_seq_end_sel(panel_sel);

    // tst_h_ramp_step  18bit
    function [17:0] tst_h_ramp_step_sel;
    input [3:0] sel;
      case(sel)
        4'h0: tst_h_ramp_step_sel = P0_TST_H_RAMP_STEP;
        4'h1: tst_h_ramp_step_sel = P1_TST_H_RAMP_STEP;
        4'h2: tst_h_ramp_step_sel = P2_TST_H_RAMP_STEP;
        4'h3: tst_h_ramp_step_sel = P3_TST_H_RAMP_STEP;
        4'h4: tst_h_ramp_step_sel = P4_TST_H_RAMP_STEP;
        4'h5: tst_h_ramp_step_sel = P5_TST_H_RAMP_STEP;
        4'h6: tst_h_ramp_step_sel = P6_TST_H_RAMP_STEP;
        4'h7: tst_h_ramp_step_sel = P7_TST_H_RAMP_STEP;
        4'h8: tst_h_ramp_step_sel = P8_TST_H_RAMP_STEP;
        4'h9: tst_h_ramp_step_sel = P9_TST_H_RAMP_STEP;
        4'ha: tst_h_ramp_step_sel = P10_TST_H_RAMP_STEP;
        default: tst_h_ramp_step_sel = P0_TST_H_RAMP_STEP;
      endcase
    endfunction

    assign tst_h_ramp_step = tst_h_ramp_step_sel(panel_sel);

    // tst_v_ramp_step  18bit
    function [17:0] tst_v_ramp_step_sel;
    input [3:0] sel;
      case(sel)
        4'h0: tst_v_ramp_step_sel = P0_TST_V_RAMP_STEP;
        4'h1: tst_v_ramp_step_sel = P1_TST_V_RAMP_STEP;
        4'h2: tst_v_ramp_step_sel = P2_TST_V_RAMP_STEP;
        4'h3: tst_v_ramp_step_sel = P3_TST_V_RAMP_STEP;
        4'h4: tst_v_ramp_step_sel = P4_TST_V_RAMP_STEP;
        4'h5: tst_v_ramp_step_sel = P5_TST_V_RAMP_STEP;
        4'h6: tst_v_ramp_step_sel = P6_TST_V_RAMP_STEP;
        4'h7: tst_v_ramp_step_sel = P7_TST_V_RAMP_STEP;
        4'h8: tst_v_ramp_step_sel = P8_TST_V_RAMP_STEP;
        4'h9: tst_v_ramp_step_sel = P9_TST_V_RAMP_STEP;
        4'ha: tst_v_ramp_step_sel = P10_TST_V_RAMP_STEP;
        default: tst_v_ramp_step_sel = P0_TST_V_RAMP_STEP;
      endcase
    endfunction

    assign tst_v_ramp_step = tst_v_ramp_step_sel(panel_sel);

    // tst_rainbow_step  18bit
    function [17:0] tst_rainbow_step_sel;
    input [3:0] sel;
      case(sel)
        4'h0: tst_rainbow_step_sel = P0_TST_RAINBOW_STEP;
        4'h1: tst_rainbow_step_sel = P1_TST_RAINBOW_STEP;
        4'h2: tst_rainbow_step_sel = P2_TST_RAINBOW_STEP;
        4'h3: tst_rainbow_step_sel = P3_TST_RAINBOW_STEP;
        4'h4: tst_rainbow_step_sel = P4_TST_RAINBOW_STEP;
        4'h5: tst_rainbow_step_sel = P5_TST_RAINBOW_STEP;
        4'h6: tst_rainbow_step_sel = P6_TST_RAINBOW_STEP;
        4'h7: tst_rainbow_step_sel = P7_TST_RAINBOW_STEP;
        4'h8: tst_rainbow_step_sel = P8_TST_RAINBOW_STEP;
        4'h9: tst_rainbow_step_sel = P9_TST_RAINBOW_STEP;
        4'ha: tst_rainbow_step_sel = P10_TST_RAINBOW_STEP;
        default: tst_rainbow_step_sel = P0_TST_RAINBOW_STEP;
      endcase
    endfunction

    assign tst_rainbow_step = tst_rainbow_step_sel(panel_sel);

    // im_h_pix_m1  7bit
    function [6:0] im_h_pix_m1_sel;
    input [3:0] sel;
      case(sel)
        4'h0: im_h_pix_m1_sel = P0_IM_H_PIX_M1;
        4'h1: im_h_pix_m1_sel = P1_IM_H_PIX_M1;
        4'h2: im_h_pix_m1_sel = P2_IM_H_PIX_M1;
        4'h3: im_h_pix_m1_sel = P3_IM_H_PIX_M1;
        4'h4: im_h_pix_m1_sel = P4_IM_H_PIX_M1;
        4'h5: im_h_pix_m1_sel = P5_IM_H_PIX_M1;
        4'h6: im_h_pix_m1_sel = P6_IM_H_PIX_M1;
        4'h7: im_h_pix_m1_sel = P7_IM_H_PIX_M1;
        4'h8: im_h_pix_m1_sel = P8_IM_H_PIX_M1;
        4'h9: im_h_pix_m1_sel = P9_IM_H_PIX_M1;
        4'ha: im_h_pix_m1_sel = P10_IM_H_PIX_M1;
        default: im_h_pix_m1_sel = P0_IM_H_PIX_M1;
      endcase
    endfunction

    assign im_h_pix_m1 = im_h_pix_m1_sel(panel_sel);

    // im_v_pix_m1  7bit
    function [6:0] im_v_pix_m1_sel;
    input [3:0] sel;
      case(sel)
        4'h0: im_v_pix_m1_sel = P0_IM_V_PIX_M1;
        4'h1: im_v_pix_m1_sel = P1_IM_V_PIX_M1;
        4'h2: im_v_pix_m1_sel = P2_IM_V_PIX_M1;
        4'h3: im_v_pix_m1_sel = P3_IM_V_PIX_M1;
        4'h4: im_v_pix_m1_sel = P4_IM_V_PIX_M1;
        4'h5: im_v_pix_m1_sel = P5_IM_V_PIX_M1;
        4'h6: im_v_pix_m1_sel = P6_IM_V_PIX_M1;
        4'h7: im_v_pix_m1_sel = P7_IM_V_PIX_M1;
        4'h8: im_v_pix_m1_sel = P8_IM_V_PIX_M1;
        4'h9: im_v_pix_m1_sel = P9_IM_V_PIX_M1;
        4'ha: im_v_pix_m1_sel = P10_IM_V_PIX_M1;
        default: im_v_pix_m1_sel = P0_IM_V_PIX_M1;
      endcase
    endfunction

    assign im_v_pix_m1 = im_v_pix_m1_sel(panel_sel);


// テストパターン選択信号作成

    // frame_alt_1d, frame_alt_2d, ovpx
    always @(posedge clk) begin
      frame_alt_1d <= frame_alt;
      frame_alt_2d <= frame_alt_1d;
      ovpx <= frame_alt_1d ^ frame_alt_2d;
    end

    // tst_ptn  7bit
    always @(posedge clk) begin
      if(ovpx)
        tst_ptn <= test_pat;
    end

    // tp_msb
    assign tp_msb = (tst_ptn[6:4] <= 3'h2) | (tst_ptn[6:4] == 3'h4);

    // tp_move
    always @(posedge clk) begin
      tp_move <= tp_msb & tst_ptn[3] & (tst_ptn[2] | tst_ptn[1] | tst_ptn[0]);
    end

    // rainbow_on, h_ramp_on, v_ramp_on, h_line_on, v_line_on, gray_sc_on
    always @(posedge clk) begin
      rainbow_on <= tp_msb & (tst_ptn[3:0] == 4'h9);
      h_ramp_on <= tp_msb & (tst_ptn[3:0] == 4'ha);
      v_ramp_on <= tp_msb & (tst_ptn[3:0] == 4'hb);
      diagonal_on <= tp_msb & (tst_ptn[3:0] == 4'hc);
      h_line_on <= tp_msb & (tst_ptn[3:0] == 4'hd);
      v_line_on <= tp_msb & (tst_ptn[3:0] == 4'he);
      gray_sc_on <= tp_msb & (tst_ptn[3:0] == 4'hf);
    end

    // tp_on
    assign tp_on = tp_msb & (tst_ptn[3] | tst_ptn[2] | tst_ptn[1] | tst_ptn[0]);

    // pixel1_on, pixel4_on
    always @(posedge clk) begin
      if(ovpx) begin
        pixel1_on <= pixel1_disp_on;
        pixel4_on <= pixel4_disp_on;
      end
    end

    // pixel_disp_on
    assign pixel_disp_on = pixel1_on | pixel4_on;

    // tp_pix_on
    always @(posedge clk) begin
      tp_pix_on <= tp_on | pixel_disp_on | ~color_loss_on_n;
    end

    // test_sel
    always @(posedge clk) begin
      if(ovpx)
        test_sel <= tp_pix_on;
    end


// HVアドレス作成

    // video_st_pac_1d, video_st_pac_2d, video_stpx
    always @(posedge clk) begin
      video_st_pac_1d <= video_st_pac;
      video_st_pac_2d <= video_st_pac_1d;
      video_stpx <= video_st_pac_1d & ~video_st_pac_2d;
    end

    // ha  9bitカウンタ  (Hアドレス)
    always @(posedge clk) begin
      if(ha_rst)
        ha <= 0;
      else if(~adrs_cnt_stop)
        ha <= ha + 1;
    end

    // ha_end
    always @(posedge clk) begin
 //   ha_end <= (ha == 8'hfe);
      ha_end <= (ha == 9'h1fe);
    end

    // ha_rst
    assign ha_rst = video_stpx | ha_end;

    // va  9bitカウンタ  (Vアドレス)
    always @(posedge clk) begin
      if(video_stpx)
 //     va <= {~tp_pix_on, ~tp_pix_on, ~tp_pix_on, ~tp_pix_on, 4'd0};
        va <= {~tp_pix_on, 8'd0};
      else if(ha_end)
        va <= va + 1;
    end

    // adrs_cnt_stop
 // assign adrs_cnt_stop = va[7] & va[6];  // 128+64=192
 // assign adrs_cnt_stop = va[7] & va[6] & va[5] & va[4];  // 128+64+32+16=240
    assign adrs_cnt_stop = va[8];  // 256

    // lm_wea
 // assign lm_wea = (ha < 8'd192) & ~adrs_cnt_stop;
 // assign lm_wea = (ha < 8'd160) & ~adrs_cnt_stop;
    assign lm_wea = (ha < 9'd256) & ~adrs_cnt_stop;

    // lm_wea_1d, lm_wea_2d, lm_wea_3d, lm_we
    always @(posedge clk) begin
      lm_wea_1d <= lm_wea;
      lm_wea_2d <= lm_wea_1d;
      lm_wea_3d <= lm_wea_2d;
      lm_we     <= lm_wea_3d;
    end

    // ha_1d, ha_2d, ha_3d, lm_ha  8bit
    always @(posedge clk) begin
      ha_1d <= ha[7:0];
      ha_2d <= ha_1d;
      ha_3d <= ha_2d;
      lm_ha <= ha_3d;
    end

    // va_1d, va_2d, va_3d, lm_va  8bit
    always @(posedge clk) begin
      va_1d <= va[7:0];
      va_2d <= va_1d;
      va_3d <= va_2d;
      lm_va <= va_3d;
    end


// 変化スピード設定

    // tst_ptn_1d  4bit
    always @(posedge clk) begin
      tst_ptn_1d <= tst_ptn[3:0];
    end

    // tp_change
    always @(posedge clk) begin
      tp_change <= ~(tst_ptn[3:0] == tst_ptn_1d);
    end

    // tp_off_chg
    assign tp_off_chg = ~tp_move | tp_change;

    // qa_lda  7bit  speed setting
    assign qa_lda = (h_line_on | v_line_on) ? tst_line_speed : tst_speed;

    // qa  7bitカウンタ  (変化スピード設定)
    always @(posedge clk) begin
      if(tp_off_chg | move_timp)
        qa <= qa_lda;
      else if(ovpx)
        qa <= qa + 1;
    end

    // qa_end
    assign qa_end = qa[6];  // 64

    // move_timp
    assign move_timp = ovpx & qa_end;

    // qb  8bitカウンタ  (変化シーケンス設定)
    always @(posedge clk) begin
      if(seq_rst)
        qb <= 0;
      else if(move_timp)
        qb <= qb + 1;
    end

    // seq_end
    assign seq_end = rainbow_on ? (qb == tst_rainbow_seq_end) : (qb == tst_seq_end);

    // seq_endp
    assign seq_endp = move_timp & seq_end;

    // seq_rst
    assign seq_rst = tp_off_chg | seq_endp;


// line パターン作成

    // qc  7bitカウンタ  (line シーケンス)
    always @(posedge clk) begin
      if(line_seq_rst)
        qc <= 0;
      else if(move_timp)
        qc <= qc + 1;
    end

    // line_seq_end
    assign line_seq_end = v_line_on ? (qc == tst_v_line_seq_end) : (qc == tst_h_line_seq_end);

    // line_seq_rst
    assign line_seq_rst = seq_rst | (move_timp & line_seq_end);

    // qhline  7bitカウンタ  (h line)
    always @(posedge clk) begin
      if(ha_rst | qhline_end)
        qhline <= 0;
      else if(~adrs_cnt_stop)
        qhline <= qhline + 1;
    end

    // qhline_end
    assign qhline_end = (qhline == tst_h_line_seq_end);

    // qvline  7bitカウンタ  (v line)
    always @(posedge clk) begin
      if(video_stpx | (ha_rst & qvline_end))
        qvline <= 0;
      else if(ha_rst)
        qvline <= qvline + 1;
    end

    // qvline_end
    assign qvline_end = (qvline == tst_v_line_seq_end);


    // h_line_a, v_line_a
    assign h_line_a = (qhline == qc) & h_line_on;
    assign v_line_a = (qvline == qc) & v_line_on;

    // hv_line
    always @(posedge clk) begin
      hv_line <= h_line_a | v_line_a;
    end

    // line  10bit
    assign line = {10{hv_line}};


// ramp パターン作成

    // tst_ramp_step  18bit
    assign tst_ramp_step = v_ramp_on ? tst_v_ramp_step : tst_h_ramp_step;

    // ramp_step  18bit
    always @(posedge clk) begin
      case ({gray_sc_on, rainbow_on})
        2'h0: ramp_step <= tst_ramp_step;
        2'h1: ramp_step <= tst_rainbow_step;
        2'h2: ramp_step <= 18'h00100;          // tst_gray_sc_step
        2'h3: ramp_step <= 18'h00100;
      endcase
    end

    // ramp_rst
    assign ramp_rst = v_ramp_on ? video_stpx : ha_rst;

    // offset_sel
    assign offset_sel = ramp_rst |
                        (~v_ramp_on & ~h_ramp_on & ~diagonal_on & ~gray_sc_on & ~rainbow_on);

    // ramp_a  19bit
    assign ramp_a = ramp_step + ramp_c;

    // ramp_b  18bit
    assign ramp_b = ramp_a[18] ? 18'h00000 : ramp_a[17:0];

    // ramp_c  18bit
    always @(posedge clk) begin
      if(ha_rst | ~v_ramp_on)
        ramp_c <= offset_sel ? ramp_offset : ramp_b;
    end

    // ramp  10bit
    always @(posedge clk) begin
      ramp <= ramp_c[17:8];
    end

    // hv_offset_a  19bit
    assign hv_offset_a = ramp_step + hv_offset;

    // hv_offset_rst
    assign hv_offset_rst = hv_offset_a[18] | seq_rst |
                           (~h_ramp_on & ~v_ramp_on & ~diagonal_on & ~rainbow_on);

    // hv_offset  18bit
    always @(posedge clk) begin
      if(move_timp | tp_off_chg)
        hv_offset <= hv_offset_rst ? 18'h00000 : hv_offset_a[17:0];
    end

    // dia_offset_a  19bit
    assign dia_offset_a = ramp_step + dia_offset;

    // dia_offset_b  18bit
    assign dia_offset_b = dia_offset_a[18] ? 18'h00000 : dia_offset_a[17:0];

    // video_stpx_1d
    always @(posedge clk) begin
      video_stpx_1d <= video_stpx;
    end

    // dia_offset  18bit
    always @(posedge clk) begin
      if(ha_rst | video_stpx_1d)
        dia_offset <= (video_stpx | (~diagonal_on & ~rainbow_on)) ? hv_offset : dia_offset_b;
    end

    // ramp_offset  18bit
    assign ramp_offset = ((diagonal_on | rainbow_on) & ~video_stpx) ? dia_offset : hv_offset;


// rainbow パターン作成

    // qd  2bitカウンタ
    always @(posedge clk) begin
      if((seq_rst | ~rainbow_on) | ((move_timp & hv_offset_a[18]) & qd_end))
        qd <= 0;
      else if(move_timp & hv_offset_a[18])
        qd <= qd + 1;
    end

    // qd_end
    assign qd_end = qd[1];  // 2

    // qe  2bitカウンタ
    always @(posedge clk) begin
      if(video_stpx | ~rainbow_on)
        qe <= qd;
      else if(((ha_rst | video_stpx_1d) & dia_offset_a[18]) & qe_end & ~(video_stpx | ~rainbow_on))
        qe <= 0;
      else if((ha_rst | video_stpx_1d) & dia_offset_a[18])
        qe <= qe + 1;
    end

    // qe_end
    assign qe_end = qe[1];  // 2

    // qf_lda  2bit
    assign qf_lda = video_stpx ? qd : qe;

    // qf  2bitカウンタ
    always @(posedge clk) begin
      if(ha_rst | ~rainbow_on)
        qf <= qf_lda;
      else if(ramp_a[18] & qf_end & ~(ha_rst | ~rainbow_on))
        qf <= 0;
      else if(ramp_a[18])
        qf <= qf + 1;
    end

    // qf_end
    assign qf_end = qf[1];  // 2

    // rainbow_r  10bit
    always @(posedge clk) begin
      case (qf)
        2'h0: rainbow_r <= ramp_c[17:8];
        2'h1: rainbow_r <= ~ramp_c[17:8];
        2'h2: rainbow_r <= 0;
        2'h3: rainbow_r <= 0;
      endcase
    end

    // rainbow_g  10bit
    always @(posedge clk) begin
      case (qf)
        2'h0: rainbow_g <= ~ramp_c[17:8];
        2'h1: rainbow_g <= 0;
        2'h2: rainbow_g <= ramp_c[17:8];
       2'h3: rainbow_g <= 0;
      endcase
    end

    // rainbow_b  10bit
    always @(posedge clk) begin
      case (qf)
        2'h0: rainbow_b <= 0;
        2'h1: rainbow_b <= ramp_c[17:8];
        2'h2: rainbow_b <= ~ramp_c[17:8];
        2'h3: rainbow_b <= 0;
      endcase
    end


// flat パターン作成

    // flat_tp  3bit
    always @(posedge clk) begin
      flat_tp <= (tst_ptn[3] | ~tp_msb) ? 3'h0 : tst_ptn[2:0];
    end

    // flat_tp_dec1 -- flat_tp_dec7
    assign flat_tp_dec1 = ~flat_tp[2] & ~flat_tp[1] &  flat_tp[0];
    assign flat_tp_dec2 = ~flat_tp[2] &  flat_tp[1] & ~flat_tp[0];
    assign flat_tp_dec3 = ~flat_tp[2] &  flat_tp[1] &  flat_tp[0];
    assign flat_tp_dec4 =  flat_tp[2] & ~flat_tp[1] & ~flat_tp[0];
    assign flat_tp_dec5 =  flat_tp[2] & ~flat_tp[1] &  flat_tp[0];
    assign flat_tp_dec6 =  flat_tp[2] &  flat_tp[1] & ~flat_tp[0];
    assign flat_tp_dec7 =  flat_tp[2] &  flat_tp[1] &  flat_tp[0];

    // flat_tp_r_on, flat_tp_g_on, flat_tp_b_on
    always @(posedge clk) begin
      flat_tp_r_on <= flat_tp_dec1 | flat_tp_dec4 | flat_tp_dec6 | flat_tp_dec7;
      flat_tp_g_on <= flat_tp_dec2 | flat_tp_dec5 | flat_tp_dec6 | flat_tp_dec7;
      flat_tp_b_on <= flat_tp_dec3 | flat_tp_dec4 | flat_tp_dec5 | flat_tp_dec7;
    end

    // flat_r_on, flat_g_on, flat_b_on
    always @(posedge clk) begin
      if(ovpx)
        flat_r_on <= color_loss_on_n ? flat_tp_r_on : color_loss[0];
        flat_g_on <= color_loss_on_n ? flat_tp_g_on : color_loss[1];
        flat_b_on <= color_loss_on_n ? flat_tp_b_on : color_loss[2];
    end

    // flat_r, flat_g, flat_b  10bit
    assign flat_r = {10{flat_r_on}};
    assign flat_g = {10{flat_g_on}};
    assign flat_b = {10{flat_b_on}};


// テストパターン選択出力

    // tp_osel  3bit
    always @(posedge clk) begin
      tp_osel <= (~tst_ptn[3] | ~tp_msb) ? 3'h0 : tst_ptn[2:0];
    end

    // r_tp  10bit
    always @(posedge clk) begin
      case (tp_osel)
        3'h0: r_tp <= flat_r;
        3'h1: r_tp <= rainbow_r;
        3'h2: r_tp <= ramp;
        3'h3: r_tp <= ramp;
        3'h4: r_tp <= ramp;
        3'h5: r_tp <= line;
        3'h6: r_tp <= line;
        3'h7: r_tp <= ramp;
      endcase
    end

    // g_tp  10bit
    always @(posedge clk) begin
      case (tp_osel)
        3'h0: g_tp <= flat_g;
        3'h1: g_tp <= rainbow_g;
        3'h2: g_tp <= ramp;
        3'h3: g_tp <= ramp;
        3'h4: g_tp <= ramp;
        3'h5: g_tp <= line;
        3'h6: g_tp <= line;
        3'h7: g_tp <= ramp;
      endcase
    end

    // b_tp  10bit
    always @(posedge clk) begin
      case (tp_osel)
        3'h0: b_tp <= flat_b;
        3'h1: b_tp <= rainbow_b;
        3'h2: b_tp <= ramp;
        3'h3: b_tp <= ramp;
        3'h4: b_tp <= ramp;
        3'h5: b_tp <= line;
        3'h6: b_tp <= line;
        3'h7: b_tp <= ramp;
      endcase
    end


// テストパターン Odd / Even 制御信号作成

    // test_grid, test_odd, test_even
    always @(posedge clk) begin
      test_grid <= (tst_ptn[6:4] == 3'h1);
      test_odd  <= (tst_ptn[6:4] == 3'h2);
      test_even <= (tst_ptn[6:4] == 3'h4);
    end

    // odd_blk
    always @(posedge clk) begin
      odd_blk <= (~ha[0] & ~va[0]) | (ha[0] & va[0]);
    end

    // even_blk
    always @(posedge clk) begin
      even_blk <= (~ha[0] & va[0]) | (ha[0] & ~va[0]);
    end

    // odd_even_blk
    always @(posedge clk) begin
      odd_even_blk <= (odd_blk & test_odd) | (even_blk & test_even);
    end


// テストパターン Grid 制御信号作成

    // im_pix_ha  7bitカウンタ  (IM pixel Hアドレス)
    always @(posedge clk) begin
      if(ha_rst | im_pix_ha_end)
        im_pix_ha <= 0;
      else if(~adrs_cnt_stop)
        im_pix_ha <= im_pix_ha + 1;
    end

    // im_pix_ha_end
    assign im_pix_ha_end = (im_pix_ha == im_h_pix_m1);

    // im_pix_va  7bitカウンタ  (IM pixel Vアドレス)
    always @(posedge clk) begin
      if(video_stpx | (ha_end & im_pix_va_end))
        im_pix_va <= 0;
      else if(ha_end)
        im_pix_va <= im_pix_va + 1;
    end

    // im_pix_va_end
    assign im_pix_va_end = (im_pix_va == im_v_pix_m1);


    // im_pix_ha_0, im_pix_ha_1, im_pix_ha_2, im_pix_va_0, im_pix_va_1, im_pix_va_2
    assign im_pix_ha_0 = (im_pix_ha == 7'd0);
    assign im_pix_ha_1 = (im_pix_ha == 7'd1);
    assign im_pix_ha_2 = (im_pix_ha == 7'd2);
    assign im_pix_va_0 = (im_pix_va == 7'd0);
    assign im_pix_va_1 = (im_pix_va == 7'd1);
    assign im_pix_va_2 = (im_pix_va == 7'd2);

    // grid_va_0, grid_va_1, grid_va_2
    assign grid_va_0 = im_pix_va_0 & (im_pix_ha_0 | im_pix_ha_1 | im_pix_ha_2);
    assign grid_va_1 = im_pix_va_1 & (im_pix_ha_0 | im_pix_ha_1);
    assign grid_va_2 = im_pix_va_2 &  im_pix_ha_0;

    // grid_tri
    always @(posedge clk) begin
      grid_tri <= grid_va_0 | grid_va_1 | grid_va_2;
    end

    // grid_line
    always @(posedge clk) begin
 //   grid_line <= (va == 8'd0);
      grid_line <= (va == 9'd0);
    end

    // grid
    always @(posedge clk) begin
      grid <= (grid_tri | grid_line) & test_grid;
    end


// テストパターン RGB イネーブル, レベル設定, 出力

    // tp_rgb_en  3bit  r:[2], g:[1], b:[0]
    always @(posedge clk) begin
      if(ovpx)
        tp_rgb_en <= color_loss_on_n ? testp_rgb_en : 3'h7;
    end

    // tp_r_blk, tp_g_blk, tp_b_blk
    assign tp_r_blk = ~tp_rgb_en[2] | odd_even_blk;
    assign tp_g_blk = ~tp_rgb_en[1] | odd_even_blk;
    assign tp_b_blk = ~tp_rgb_en[0] | odd_even_blk;


    // testp_lvl  8bit
    always @(posedge clk) begin
      testp_lvl <= color_loss_on_n ? testp_level : 8'hff;
    end

    // testp_lvla  9bit
    always @(posedge clk) begin
      if(ovpx)
        testp_lvla <= testp_lvl + 8'h01;
    end

    // r_tp_mlt, g_tp_mlt, b_tp_mlt  19bit
    assign r_tp_mlt = r_tp * testp_lvla;
    assign g_tp_mlt = g_tp * testp_lvla;
    assign b_tp_mlt = b_tp * testp_lvla;

    // r_tp_out  10bit
    always @(posedge clk) begin
      case ({grid, tp_r_blk})
        2'h0: r_tp_out <= r_tp_mlt[17:8];
        2'h1: r_tp_out <= 10'h000;
        2'h2: r_tp_out <= 10'h3ff;
        2'h3: r_tp_out <= 10'h3ff;
      endcase
    end

    // g_tp_out  10bit
    always @(posedge clk) begin
      case ({grid, tp_g_blk})
        2'h0: g_tp_out <= g_tp_mlt[17:8];
        2'h1: g_tp_out <= 10'h000;
        2'h2: g_tp_out <= 10'h3ff;
        2'h3: g_tp_out <= 10'h3ff;
      endcase
    end

    // b_tp_out  10bit
    always @(posedge clk) begin
      case ({grid, tp_b_blk})
        2'h0: b_tp_out <= b_tp_mlt[17:8];
        2'h1: b_tp_out <= 10'h000;
        2'h2: b_tp_out <= 10'h3ff;
        2'h3: b_tp_out <= 10'h3ff;
      endcase
    end

    // tp_do  30bit
    assign tp_do = {r_tp_out, g_tp_out, b_tp_out};



// Pixel Display パターン作成 

// 4 pixel display  (4 corner of the IM)

    // h_4pix_acc_a  8bit
    assign h_4pix_acc_a = (h_4pix_acc_p1_sel ? 8'd1 : {1'b0, im_h_pix_m1}) + h_4pix_acc;

    // h_4pix_acc  8bit
    always @(posedge clk) begin
      if(video_stpx | ha_end)
        h_4pix_acc <= 0;
      else if(im_h_edge)
        h_4pix_acc <= h_4pix_acc_a;
    end

    // im_h_edge
    assign im_h_edge = (h_4pix_acc == ha[7:0]) & ~adrs_cnt_stop;

    // h_4pix_acc_p1_sel
    always @(posedge clk) begin
      if(video_stpx | ha_end)
        h_4pix_acc_p1_sel <= 1'b0;
      else if(im_h_edge)
        h_4pix_acc_p1_sel <= ~h_4pix_acc_p1_sel;
    end

    // v_4pix_acc_a  8bit
    assign v_4pix_acc_a = (v_4pix_acc_p1_sel ? 8'd1 : {1'b0, im_v_pix_m1}) + v_4pix_acc;

    // v_4pix_acc  8bit
    always @(posedge clk) begin
      if(video_stpx)
        v_4pix_acc <= 0;
      else if(im_v_edge & ha_end)
        v_4pix_acc <= v_4pix_acc_a;
    end

    // im_v_edge
    assign im_v_edge = (v_4pix_acc == va[7:0]) & ~adrs_cnt_stop;

    // v_4pix_acc_p1_sel
    always @(posedge clk) begin
      if(video_stpx)
        v_4pix_acc_p1_sel <= 1'b0;
      else if(im_v_edge & ha_end)
        v_4pix_acc_p1_sel <= ~v_4pix_acc_p1_sel;
    end

    // all_im_4pixel
    always @(posedge clk) begin
      all_im_4pixel <= im_h_edge & im_v_edge;
    end


// 1 pixel display

    // pixel_h_posi, pixel_v_posi  8bit
    // im_h_ad, im_v_ad  3bit
    // pixel1_mode  2bit
    always @(posedge clk) begin
      if(ovpx) begin
        pixel_h_posi <= pixel1_disp_mode[23:16];
        pixel_v_posi <= pixel1_disp_mode[15:8];
        im_h_ad      <= pixel1_disp_mode[7:5];
        im_v_ad      <= pixel1_disp_mode[4:2];
        pixel1_mode  <= pixel1_disp_mode[1:0];
      end
    end

    // h_posi_over, v_posi_over, posi_over
    assign h_posi_over = (pixel_h_posi > {1'b0, im_h_pix_m1});
    assign v_posi_over = (pixel_v_posi > {1'b0, im_v_pix_m1});

    // posi_over
    always @(posedge clk) begin
      posi_over <= h_posi_over | v_posi_over;
    end

    // im_h_pix, im_v_pix  7bit
    always @(posedge clk) begin
      im_h_pix <= im_h_pix_m1 + 7'd1;
      im_v_pix <= im_v_pix_m1 + 7'd1;
    end

    // h_1pix_acc_a  8bit
    assign h_1pix_acc_a = {1'b0, im_h_pix} + h_1pix_acc;

    // h_1pix_acc  8bit
    always @(posedge clk) begin
      if(video_stpx | ha_end)
        h_1pix_acc <= pixel_h_posi;
      else if(im_1pix_h_posi)
        h_1pix_acc <= h_1pix_acc_a;
    end

    // im_1pix_h_posi
    assign im_1pix_h_posi = (h_1pix_acc == ha[7:0]) & ~adrs_cnt_stop;

    // qhim  4bitカウンタ
    always @(posedge clk) begin
      if(video_stpx | ha_end)
        qhim <= 0;
      else if(im_1pix_h_posi & ~qhim[3])
        qhim <= qhim + 1;
    end

    // v_1pix_acc_a  8bit
    assign v_1pix_acc_a = {1'b0, im_v_pix} + v_1pix_acc;

    // v_1pix_acc  8bit
    always @(posedge clk) begin
      if(video_stpx)
        v_1pix_acc <= pixel_v_posi;
      else if(im_1pix_v_posi & ha_end)
        v_1pix_acc <= v_1pix_acc_a;
    end

    // im_1pix_v_posi
    assign im_1pix_v_posi = (v_1pix_acc == va[7:0]) & ~adrs_cnt_stop;

    // qvim  4bitカウンタ
    always @(posedge clk) begin
      if(video_stpx)
        qvim <= 0;
      else if(im_1pix_v_posi & ha_end & ~qvim[3])
        qvim <= qvim + 1;
    end

    // all_im_1pixel
    assign all_im_1pixel = im_1pix_h_posi & im_1pix_v_posi & ~posi_over;

    // qpixblink  6bit ブリンク用カウンタ
    always @(posedge clk) begin
      if(~pixel1_on | ~(pixel1_mode == 2'h3))
        qpixblink <= 0;
      else if(ovpx)
        qpixblink <= qpixblink + 1;
    end

    // sel_im_1pixel
    assign sel_im_1pixel = all_im_1pixel &
                           (qhim == {1'b0, im_h_ad}) & (qvim == {1'b0, im_v_ad}) &
                           ~qpixblink[5];

    // im_1pixel
    always @(posedge clk) begin
      im_1pixel <= (pixel1_mode[0]) ? sel_im_1pixel : all_im_1pixel;
    end


// pixel display 出力

    // pixel1or4
    always @(posedge clk) begin
      pixel1or4 <= (all_im_4pixel & pixel4_on) | (im_1pixel & pixel1_on);
    end

    // pixel_rgb_on  3bit
    always @(posedge clk) begin
      if(ovpx) begin
        pixel_rgb_on <= pixel_disp_rgb_on;
      end
    end

    // r_pixel, g_pixel, b_pixel
    always @(posedge clk) begin
      r_pixel <= pixel1or4 & pixel_rgb_on[2];
      g_pixel <= pixel1or4 & pixel_rgb_on[1];
      b_pixel <= pixel1or4 & pixel_rgb_on[0];
    end

    // pixel_do  30bit
    assign pixel_do = {{10{r_pixel}}, {10{g_pixel}}, {10{b_pixel}}};


// 出力

    // dout  30bit
    always @(posedge clk) begin
      dout <= pixel_disp_on ? pixel_do : tp_do;
    end

endmodule
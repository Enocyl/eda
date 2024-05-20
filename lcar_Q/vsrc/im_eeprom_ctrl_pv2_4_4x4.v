`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// IM上のM4用EEPROM制御
//
// サブモジュール
//   uart_ram_mpc
//

module im_eeprom_ctrl_pv2_4_4x4 (panel_sel, startn_in, cmd_startp, clk,
                          ope_sel, one_im_ope, im_hadrs, im_vadrs, sda_in,
                          wr_dina, wr_dinb, wd_ram_rstwa, wd_ram_rstwb,
                          wd_ram_wea, wd_ram_web, test_wd, wd_test, cmd_ad,
                          addclk, addsda,
                          cnt_rst, busy, err_det, m4_set_done, im_32byte_num, im_cf_ad, m4_set_err, 
                          bank_read, bank_write, ram_rstr, // im_bank1_read, im_bank1_write,
                          im_ope_hadrs, im_ope_vadrs,
                          scl, sda_ot, sda_dir, sdao, out_ch_sel, rd_dout, rd_we, rd_startp,
                          download_err,
                          tp1, tp2, tp3, tp4, tp5);

    input [3:0] panel_sel;
    input startn_in, cmd_startp, clk, one_im_ope;
    input [3:0] im_hadrs;
    input [3:0] im_vadrs;
    input [3:0] ope_sel;
    input sda_in;
    input [7:0] wr_dina, wr_dinb;
    input wd_ram_rstwa, wd_ram_rstwb, wd_ram_wea, wd_ram_web;
    input [7:0] test_wd;
    input wd_test;
    input [15:0] cmd_ad;

    output reg addclk, addsda;
    output cnt_rst, m4_set_done;
    output reg busy, err_det;
    output reg m4_set_err;
    output bank_read, bank_write;
    // output im_bank1_read, im_bank1_write;
    output reg ram_rstr;
    output [3:0] im_ope_hadrs, im_ope_vadrs;
    output [10:0] im_32byte_num;
    output [4:0] im_cf_ad;
    output scl, sda_ot, sda_dir, sdao;
    output [2:0] out_ch_sel;
    output reg [7:0] rd_dout;
    output reg rd_we, rd_startp;
    output reg download_err;
    output tp1, tp2, tp3, tp4, tp5;   // test_point for debug

    reg [15:0] st_dl_qa;
    reg [7:0] st_dl_qb;
    reg [4:0] st_dl_qc;
    reg cmd_startp_1d, cmd_startp_2d, cmd_startp_xclk;
    reg [9:0] qaddclk;
    reg [5:0] qc;
    reg [1:0] qd;
    reg [3:0] qe;
    reg [15:0] qf;
    reg [10:0] qg;
    reg [4:0] qh;
    reg qj;
    reg [2:0] qk;
    reg [2:0] ql;
    reg [1:0] qs;
    reg [6:0] qsa;
    reg qsa_b6d1;
    reg soft_reset;
    reg byte_read, page_read, bank0_read, bank1_read, all_read;
    reg byte_write, page_write, bank0_write, bank1_write, all_write;
    reg qf_d0, qf_d1, qf_d2, qf_d3, qf_d4, qf_d5, qf_d6, qf_d7, qf_d8, qf_d9;
    reg qf_d10, qf_d11, qf_d12, qf_d13;
    reg qf_d36, qf_d37, qf_d38, qf_d39, qf_d40, qf_d41, qf_d42;
    reg qf_d74, qf_d75, qf_d133, qf_d134;
    // reg qf_im_pix_p5, qf_im_pix_half_p5;
    // reg qf_im_pix_p6, qf_im_pix_half_p6;
    reg qf_im_pix_x16p5, qf_im_pix_x16p6;
    reg qf_mt1, qf_mt3, qf_mt5, qf_mt6, qf_mt35, qf_mt36, qf_mt37, qf_mt42;
    reg qf_lt5, qf_lt6, qf_lt12, qf_lt36, qf_lt43, qf_lt75;
    reg qf_lt134;
    // reg qf_lt_im_pix_p6, qf_lt_im_pix_half_p6;
    reg qf_lt_im_pix_x16p6;
    reg start_bit, stop_bit, last_stop_bit;
    reg qsda_in_rst;
    reg [3:0] qsda_in;
    reg [7:0] sda_din;
    reg sda_readp1, sda_readp2;
    reg [3:0] qderr;
    reg [3:0] qnack;
    reg [10:0] qpoll;
    reg [7:0] wd_ram_din;
    reg wd_ram_wec1, wd_ram_wec2;
    reg [7:0] wd_ram_waa;
    reg [4:0] qf_mn3d, qf_mnxd;
    reg [4:0] wd_ram_lra;
    reg [7:0] wr_dout;
    reg verify_nga, verify_ng;
    reg [3:0] qvrfy;
    reg scla;
    reg qe_d8d, sda_ota, sda_otb, busy1n, busy2n, qe_d0d, srst_bit1d;
    reg [15:0] word_ad;
    // reg high_byte_1d;
    reg [3:0] qf1d;
    reg [8:0] rd_sdao;
    reg [15:0] qf_mn31d;
    reg [8:0] wr_sdao;
    reg sda_start1, sda_start2, sda_stop1, sda_stop2;
    reg [3:0] qe1d, qe2d;
    reg sdaob;
    reg rd_data_tim;
    reg rd_latchp1, rd_latchp2;
    reg [1:0] qrerd;
    reg [7:0] rd_csum_acc;
    reg [7:0] rd_csum0d, rd_csum1d, rd_csum2d;
    reg csum_neq0_1, csum_neq0_2, csum_neq1_2;

    wire [2:0] im_num;
    wire [2:0] out_num;
    wire [10:0] bw_32byte_num;
    wire [11:0] im_pix;
    wire high_speed;
    wire start_dly_on;
    wire [15:0] im_pix_x16p6, im_pix_x16p5;
    wire one_bank;
    wire cf_ad_cnt_en;
    wire st_1ms_tp, st_100ms_tp, exp_startn_in;
    wire startn;
    wire cnt_rst_a;
    wire qaddclk_over;
    wire qaddclk_stop;
    wire addsda_blank;
    wire [5:0] qc_lda;
    wire sda_readp, sda_start, sda_stop, qd_endp;
    wire qe_d8, qe_d0, qe_end, qe_endp;
    wire [15:0] qf_lda_a, qf_lda;
    wire qf_endp, dev_nack_ld, wr_nack_ld, poll_nack_ld, verify_ng_ld, re_read_ld, qf_ld;
    wire qg_d3, qg_end, qg_enda, qg_endp;
    // wire high_byte;
    wire qh_end, qh_endp;
    wire qj_end, qj_endp;
    wire qk_end, qk_endp;
    wire ql_end, ql_endp;
    wire busy_rst;
    wire ql_endp_dly, ql_endp_st;
    wire st_srst_endp;
    wire verify_adrs_tim;
    wire [3:0] st_ope_sel, ope_sela;
    wire block_read, ope_read;
    wire block_write, ope_write, ope_rd_wr;
    wire one_im_operate;
    wire srst_s, srst_p, rd_s, byte_rd_p, page_rd_p, m18_bank_rd_p, m12_bank_rd_p, bank_rd_p;
    wire byte_wr_s, block_wr_s, byte_wr_p, block_wr_p;
    wire st_bit;
    wire sda_in_high;
    wire dev_ack_tim, dev_nack, dev_nackp, dev_ackp, dev_err;
    wire dev_nack_last;
    wire err_rst;
    wire radrs_ack_tim;
    wire byte_wadrs_tim, block_wadrs_tim, wadrs_ack_tim;
    wire byte_vadrs_tim, block_vadrs_tim, vadrs_ack_tim;
    wire wr_nack, wr_nackp, wr_endp, nack_err;
    wire wr_nack_last;
    wire poll_ack_tim, poll_nack, poll_nackp, poll_ackp, poll_err;
    wire poll_nack_last;
    wire wd_ram_rstwc, wd_ram_wec, wd_ram_wed;
    wire wd_ram_we;
    wire [6:0] wd_ram_wa;
    wire [15:0] mnxd, qf_mn3da, qf_mnxda;
    wire verify_tim;
    wire [1:0] wd_ram_mra;
    wire [6:0] wd_ram_ra;
    wire [7:0] wd_ram_dout;
    wire qf_43to74, verify_data_tim, verify_data_ackp;
    wire verify_ngp, verify_err;
    wire verify_ng_last;
    wire wr_tim;
    wire [10:0] bank_ad;
    wire [10:0] cmd_mada;
    wire bank_rd_last, rd_last_data;
    wire [2:0] rd_sdao_sel;
    wire [2:0] dev_ad;
    wire wr_last_data;
    wire qf_4to35, qf_36to42;
    wire [1:0] wr_qf_sel;
    wire [3:0] wr_sdao_sel;
    wire [8:0] sdaoa;
    wire [1:0] qe_sel;
    wire [3:0] sdao_sel;
    wire qf_d6a;
    wire qf_6to133a;
    wire qf_6to_im_pix;
    // wire qf_6to_im_pix_half;
    wire rd_latchp;
    wire bank_rd_last_bit;
    wire qrerd_tim0, qrerd_tim1, qrerd_tim2;
    wire re_read;


// パラメータ設定 (panel_sel[3:0]入力によるPanel別パラメータ選択)

 // P0 : PVII-4(4x4IM)
    parameter  P0_IM_NUM = 3'd3;
    parameter  P0_OUT_NUM = 3'd3;
    parameter  P0_BW_32BYTE_NUM = 11'd1799;
    parameter  P0_IM_PIX = 12'd3600;
    parameter  P0_HIGH_SPEED = 1'b1;
    parameter  P0_START_DLY_ON = 1'b1;
    parameter  P0_CF_AD_CNT_EN = 1'b0;
    parameter  P0_ONE_BANK = 1'b1;

 // P1 : PVII-6
    parameter  P1_IM_NUM = 3'd3;
    parameter  P1_OUT_NUM = 3'd3;
    parameter  P1_BW_32BYTE_NUM = 11'd799;
    parameter  P1_IM_PIX = 12'd1600;
    parameter  P1_HIGH_SPEED = 1'b1;
    parameter  P1_START_DLY_ON = 1'b1;
    parameter  P1_CF_AD_CNT_EN = 1'b0;
    parameter  P1_ONE_BANK = 1'b1;

 // P2 : ImpactII-10
    parameter  P2_IM_NUM = 3'd1;
    parameter  P2_OUT_NUM = 3'd5;
    parameter  P2_BW_32BYTE_NUM = 11'd161;
    parameter  P2_IM_PIX = 12'd324;
    parameter  P2_HIGH_SPEED = 1'b0;
    parameter  P2_START_DLY_ON = 1'b1;
    parameter  P2_CF_AD_CNT_EN = 1'b0;
    parameter  P2_ONE_BANK = 1'b1;

 // P3 : ImpactII-12
    parameter  P3_IM_NUM = 3'd3;
    parameter  P3_OUT_NUM = 3'd5;
    parameter  P3_BW_32BYTE_NUM = 11'd127;
    parameter  P3_IM_PIX = 12'd256;
    parameter  P3_HIGH_SPEED = 1'b0;
    parameter  P3_START_DLY_ON = 1'b1;
    parameter  P3_CF_AD_CNT_EN = 1'b0;
    parameter  P3_ONE_BANK = 1'b1;

 // P4 : ImpactII-16
    parameter  P4_IM_NUM = 3'd3;
    parameter  P4_OUT_NUM = 3'd5;
    parameter  P4_BW_32BYTE_NUM = 11'd71;
    parameter  P4_IM_PIX = 12'd144;
    parameter  P4_HIGH_SPEED = 1'b0;
    parameter  P4_START_DLY_ON = 1'b1;
    parameter  P4_CF_AD_CNT_EN = 1'b0;
    parameter  P4_ONE_BANK = 1'b1;

 // P5 : Pv16i/o-oval
    parameter  P5_IM_NUM = 3'd2;
    parameter  P5_OUT_NUM = 3'd3;
    parameter  P5_BW_32BYTE_NUM = 11'd199;
    parameter  P5_IM_PIX = 12'd400;
    parameter  P5_HIGH_SPEED = 1'b0;
    parameter  P5_START_DLY_ON = 1'b1;
    parameter  P5_CF_AD_CNT_EN = 1'b0;
    parameter  P5_ONE_BANK = 1'b1;

 // P6 : Bv16i/o-oval
    parameter  P6_IM_NUM = 3'd3;
    parameter  P6_OUT_NUM = 3'd2;
    parameter  P6_BW_32BYTE_NUM = 11'd199;
    parameter  P6_IM_PIX = 12'd400;
    parameter  P6_HIGH_SPEED = 1'b0;
    parameter  P6_START_DLY_ON = 1'b1;
    parameter  P6_CF_AD_CNT_EN = 1'b0;
    parameter  P6_ONE_BANK = 1'b1;

 // P7 : Pv20i/o-oval
    parameter  P7_IM_NUM = 3'd5;
    parameter  P7_OUT_NUM = 3'd3;
    parameter  P7_BW_32BYTE_NUM = 11'd127;
    parameter  P7_IM_PIX = 12'd256;
    parameter  P7_HIGH_SPEED = 1'b0;
    parameter  P7_START_DLY_ON = 1'b1;
    parameter  P7_CF_AD_CNT_EN = 1'b0;
    parameter  P7_ONE_BANK = 1'b1;

 // P8 : Pv26i/o-oval
    parameter  P8_IM_NUM = 3'd5;
    parameter  P8_OUT_NUM = 3'd3;
    parameter  P8_BW_32BYTE_NUM = 11'd71;
    parameter  P8_IM_PIX = 12'd144;
    parameter  P8_HIGH_SPEED = 1'b0;
    parameter  P8_START_DLY_ON = 1'b1;
    parameter  P8_CF_AD_CNT_EN = 1'b0;
    parameter  P8_ONE_BANK = 1'b1;

 // P9 : Fv20T
    parameter  P9_IM_NUM = 3'd3;
    parameter  P9_OUT_NUM = 3'd2;
    parameter  P9_BW_32BYTE_NUM = 11'd127;
    parameter  P9_IM_PIX = 12'd256;
    parameter  P9_HIGH_SPEED = 1'b0;
    parameter  P9_START_DLY_ON = 1'b1;
    parameter  P9_CF_AD_CNT_EN = 1'b0;
    parameter  P9_ONE_BANK = 1'b1;

 // P10 : Pv10
    parameter  P10_IM_NUM = 3'd3;
    parameter  P10_OUT_NUM = 3'd3;
    parameter  P10_BW_32BYTE_NUM = 11'd287;
    parameter  P10_IM_PIX = 12'd576;
    parameter  P10_HIGH_SPEED = 1'b0;
    parameter  P10_START_DLY_ON = 1'b1;
    parameter  P10_CF_AD_CNT_EN = 1'b0;
    parameter  P10_ONE_BANK = 1'b1;


 // parameter select

    // im_num  3bit  (IM数 / 出力)-1
    function [2:0] im_num_sel;
    input [3:0] sel;
      case(sel)
        4'h0: im_num_sel = P0_IM_NUM;
        4'h1: im_num_sel = P1_IM_NUM;
        4'h2: im_num_sel = P2_IM_NUM;
        4'h3: im_num_sel = P3_IM_NUM;
        4'h4: im_num_sel = P4_IM_NUM;
        4'h5: im_num_sel = P5_IM_NUM;
        4'h6: im_num_sel = P6_IM_NUM;
        4'h7: im_num_sel = P7_IM_NUM;
        4'h8: im_num_sel = P8_IM_NUM;
        4'h9: im_num_sel = P9_IM_NUM;
        4'ha: im_num_sel = P10_IM_NUM;
        default: im_num_sel = P0_IM_NUM;
      endcase
    endfunction

    assign im_num = im_num_sel(panel_sel);

    // out_num  3bit  (使用出力数)-1
    function [2:0] out_num_sel;
    input [3:0] sel;
      case(sel)
        4'h0: out_num_sel = P0_OUT_NUM;
        4'h1: out_num_sel = P1_OUT_NUM;
        4'h2: out_num_sel = P2_OUT_NUM;
        4'h3: out_num_sel = P3_OUT_NUM;
        4'h4: out_num_sel = P4_OUT_NUM;
        4'h5: out_num_sel = P5_OUT_NUM;
        4'h6: out_num_sel = P6_OUT_NUM;
        4'h7: out_num_sel = P7_OUT_NUM;
        4'h8: out_num_sel = P8_OUT_NUM;
        4'h9: out_num_sel = P9_OUT_NUM;
        4'ha: out_num_sel = P10_OUT_NUM;
        default: out_num_sel = P0_OUT_NUM;
      endcase
    endfunction

    assign out_num = out_num_sel(panel_sel);

    // bw_32byte_num  11bit  block write用 ((IM pixel数 * 16byte / 32byte)-1, 端数切り上げ
    function [10:0] bw_32byte_num_sel;
    input [3:0] sel;
      case(sel)
        4'h0: bw_32byte_num_sel = P0_BW_32BYTE_NUM;
        4'h1: bw_32byte_num_sel = P1_BW_32BYTE_NUM;
        4'h2: bw_32byte_num_sel = P2_BW_32BYTE_NUM;
        4'h3: bw_32byte_num_sel = P3_BW_32BYTE_NUM;
        4'h4: bw_32byte_num_sel = P4_BW_32BYTE_NUM;
        4'h5: bw_32byte_num_sel = P5_BW_32BYTE_NUM;
        4'h6: bw_32byte_num_sel = P6_BW_32BYTE_NUM;
        4'h7: bw_32byte_num_sel = P7_BW_32BYTE_NUM;
        4'h8: bw_32byte_num_sel = P8_BW_32BYTE_NUM;
        4'h9: bw_32byte_num_sel = P9_BW_32BYTE_NUM;
        4'ha: bw_32byte_num_sel = P10_BW_32BYTE_NUM;
        default: bw_32byte_num_sel = P0_BW_32BYTE_NUM;
      endcase
    endfunction

    assign bw_32byte_num = bw_32byte_num_sel(panel_sel);

    // im_pix  12bit  IM pixel数
    function [11:0] im_pix_sel;
    input [3:0] sel;
      case(sel)
        4'h0: im_pix_sel = P0_IM_PIX;
        4'h1: im_pix_sel = P1_IM_PIX;
        4'h2: im_pix_sel = P2_IM_PIX;
        4'h3: im_pix_sel = P3_IM_PIX;
        4'h4: im_pix_sel = P4_IM_PIX;
        4'h5: im_pix_sel = P5_IM_PIX;
        4'h6: im_pix_sel = P6_IM_PIX;
        4'h7: im_pix_sel = P7_IM_PIX;
        4'h8: im_pix_sel = P8_IM_PIX;
        4'h9: im_pix_sel = P9_IM_PIX;
        4'ha: im_pix_sel = P10_IM_PIX;
        default: im_pix_sel = P0_IM_PIX;
      endcase
    endfunction

    assign im_pix = im_pix_sel(panel_sel);

    // high_speed  1bit  通信速度 (1 = 893kbps , 0 = 390kbps)
    function high_speed_sel;
    input [3:0] sel;
      case(sel)
        4'h0: high_speed_sel = P0_HIGH_SPEED;
        4'h1: high_speed_sel = P1_HIGH_SPEED;
        4'h2: high_speed_sel = P2_HIGH_SPEED;
        4'h3: high_speed_sel = P3_HIGH_SPEED;
        4'h4: high_speed_sel = P4_HIGH_SPEED;
        4'h5: high_speed_sel = P5_HIGH_SPEED;
        4'h6: high_speed_sel = P6_HIGH_SPEED;
        4'h7: high_speed_sel = P7_HIGH_SPEED;
        4'h8: high_speed_sel = P8_HIGH_SPEED;
        4'h9: high_speed_sel = P9_HIGH_SPEED;
        4'ha: high_speed_sel = P10_HIGH_SPEED;
        default: high_speed_sel = P0_HIGH_SPEED;
      endcase
    endfunction

    assign high_speed = high_speed_sel(panel_sel);

    // start_dly_on  1bit  起動時の動作スタート遅延 (1 = 3sec 遅延)
    function start_dly_on_sel;
    input [3:0] sel;
      case(sel)
        4'h0: start_dly_on_sel = P0_START_DLY_ON;
        4'h1: start_dly_on_sel = P1_START_DLY_ON;
        4'h2: start_dly_on_sel = P2_START_DLY_ON;
        4'h3: start_dly_on_sel = P3_START_DLY_ON;
        4'h4: start_dly_on_sel = P4_START_DLY_ON;
        4'h5: start_dly_on_sel = P5_START_DLY_ON;
        4'h6: start_dly_on_sel = P6_START_DLY_ON;
        4'h7: start_dly_on_sel = P7_START_DLY_ON;
        4'h8: start_dly_on_sel = P8_START_DLY_ON;
        4'h9: start_dly_on_sel = P9_START_DLY_ON;
        4'ha: start_dly_on_sel = P10_START_DLY_ON;
        default: start_dly_on_sel = P0_START_DLY_ON;
      endcase
    endfunction

    assign start_dly_on = start_dly_on_sel(panel_sel);

    // cf_ad_cnt_en  1bit  (M4 coeff. number count enable)
    function cf_ad_cnt_en_sel;
    input [3:0] sel;
      case(sel)
        4'h0: cf_ad_cnt_en_sel = P0_CF_AD_CNT_EN;
        4'h1: cf_ad_cnt_en_sel = P1_CF_AD_CNT_EN;
        4'h2: cf_ad_cnt_en_sel = P2_CF_AD_CNT_EN;
        4'h3: cf_ad_cnt_en_sel = P3_CF_AD_CNT_EN;
        4'h4: cf_ad_cnt_en_sel = P4_CF_AD_CNT_EN;
        4'h5: cf_ad_cnt_en_sel = P5_CF_AD_CNT_EN;
        4'h6: cf_ad_cnt_en_sel = P6_CF_AD_CNT_EN;
        4'h7: cf_ad_cnt_en_sel = P7_CF_AD_CNT_EN;
        4'h8: cf_ad_cnt_en_sel = P8_CF_AD_CNT_EN;
        4'h9: cf_ad_cnt_en_sel = P9_CF_AD_CNT_EN;
        4'ha: cf_ad_cnt_en_sel = P10_CF_AD_CNT_EN;
        default: cf_ad_cnt_en_sel = P0_CF_AD_CNT_EN;
      endcase
    endfunction

    assign cf_ad_cnt_en = cf_ad_cnt_en_sel(panel_sel);

    // one_bank  1bit  (M4 coeff. bank数=1)
    function one_bank_sel;
    input [3:0] sel;
      case(sel)
        4'h0: one_bank_sel = P0_ONE_BANK;
        4'h1: one_bank_sel = P1_ONE_BANK;
        4'h2: one_bank_sel = P2_ONE_BANK;
        4'h3: one_bank_sel = P3_ONE_BANK;
        4'h4: one_bank_sel = P4_ONE_BANK;
        4'h5: one_bank_sel = P5_ONE_BANK;
        4'h6: one_bank_sel = P6_ONE_BANK;
        4'h7: one_bank_sel = P7_ONE_BANK;
        4'h8: one_bank_sel = P8_ONE_BANK;
        4'h9: one_bank_sel = P9_ONE_BANK;
        4'ha: one_bank_sel = P10_ONE_BANK;
        default: one_bank_sel = P0_ONE_BANK;
      endcase
    endfunction

    assign one_bank = one_bank_sel(panel_sel);


    // im_pix_x16p6  16bit  (IM pixel数 * 16)+6
       assign im_pix_x16p6 = {im_pix, 4'd6};

    // im_pix_x16p5  16bit  (IM pixel数 * 16)+5
       assign im_pix_x16p5 = {im_pix, 4'd5};


// 起動遅延部

    // st_dl_qa  16bitカウンタ  1ms周期作成
    always @(posedge clk) begin
      if(startn_in | st_1ms_tp)
        st_dl_qa <= 16'd2769;
      else if(exp_startn_in)
        st_dl_qa <= st_dl_qa + 1;
    end

    // st_1ms_tp
    assign st_1ms_tp = st_dl_qa[15];

    // st_dl_qb  8bitカウンタ  100ms周期作成
    always @(posedge clk) begin
      if(startn_in | st_100ms_tp)
        st_dl_qb <= 8'd29;
      else if(st_1ms_tp)
        st_dl_qb <= st_dl_qb + 1;
    end

    // st_100ms_tp
    assign st_100ms_tp = st_1ms_tp & st_dl_qb[7];

    // st_dl_qc  5bitカウンタ  設定値まで100msパルスをカウント
    always @(posedge clk) begin
      if(startn_in)
        st_dl_qc <= 0;
      else if(st_100ms_tp)
        st_dl_qc <= st_dl_qc + 1;
    end

    // exp_startn_in
    assign exp_startn_in = (st_dl_qc < 5'd30);  // 設定値 30 (3sec)

    // startn
    assign startn = startn_in | (exp_startn_in & start_dly_on);


// タイミング作成カウンタ部

    // cmd_startp_1d, cmd_startp_2d, cmd_startp_xclk
    always @(posedge clk) begin
      cmd_startp_1d <= cmd_startp;
      cmd_startp_2d <= cmd_startp_1d;
      cmd_startp_xclk <= cmd_startp_1d & ~cmd_startp_2d;
    end

    // cnt_rst_a
    assign cnt_rst_a = startn | st_srst_endp | (cmd_startp_xclk & ~busy);


    // qaddclk  10bitカウンタ  (addclk, addsda 作成用)
    always @(posedge clk) begin
      if(cnt_rst_a)
        qaddclk <= 0;
      else if(~qaddclk_stop)
        qaddclk <= qaddclk + 1;
    end

    // qaddclk_over
    assign qaddclk_over = (qaddclk[9:6] > {1'b0, im_num});

    // qaddclk_stop
    assign qaddclk_stop = qaddclk_over & qaddclk[4];

    // addclk  IM EEPROM のアドレス設定用クロック  1.5625MHz (=25MHz / 16)
    always @(posedge clk) begin
      addclk <= qaddclk[3] & ~qaddclk_over;
    end

    // addsda_blank
    assign addsda_blank = cnt_rst_a | qaddclk_over;

    // addsda  IM EEPROM のアドレス設定用データ
    always @(posedge clk) begin
      case ({addsda_blank, qaddclk[5:4]})
        3'h0   : addsda <= qaddclk[8];  // A2
        3'h1   : addsda <= qaddclk[7];  // A1
        3'h2   : addsda <= qaddclk[6];  // A0
        3'h3   : addsda <= ~ope_write;  // Write Protest
        default: addsda <= 1'b0;        // blank
      endcase
    end


    // cnt_rst
    assign cnt_rst = cnt_rst_a | ~qaddclk_stop;

    // qc_lda  6bit
 // assign qc_lda = high_speed ? 6'd26 : 6'd17;
    assign qc_lda = high_speed ? 6'd23 : 6'd17;

    // qc  6bitカウンタ  (通信速度設定)
    always @(posedge clk) begin
      if(cnt_rst | qc[5])
        qc <= qc_lda;
      else if(busy)
        qc <= qc + 1;
    end

    // qd_endp
    assign qd_endp = qc[5] & (qd[0] & qd[1]);

    // qd  2bitカウンタ  (出力クロック)
    always @(posedge clk) begin
      if(cnt_rst | qd_endp)
        qd <= 0;
      else if(qc[5])
        qd <= qd + 1;
    end

    // sda_readp, sda_start, sda_stop
    assign sda_readp = ~qd[0] & qd[1] & qc[5];
    assign sda_start = ~(qd[0] & qd[1]);
    assign sda_stop = qd[0] & qd[1];

    // qe_endp
    assign qe_endp = qd_endp & qe_end;

    // qe  4bitカウンタ  (1 or 9 ビットサイクル)
    always @(posedge clk) begin
      if(cnt_rst | qe_endp)
        qe <= 0;
      else if(qd_endp)
        qe <= qe + 1;
    end

    // qe_d8, qe_d0, qe_end
    assign qe_d8 = (qe == 4'h8);
    assign qe_d0 = (qe == 4'h0);
    assign qe_end = st_bit ? qe_d0 : qe_d8;

    // qf_lda_a  16bit
    function [15:0] qf_lda_a_sel;
    input [1:0] sel;
      case(sel)
        2'h0: qf_lda_a_sel = 16'h0000;
        2'h1: qf_lda_a_sel = 16'h0000;
        2'h2: qf_lda_a_sel = 16'h0006;
        2'h3: qf_lda_a_sel = 16'h0025;
      endcase
    endfunction

    assign qf_lda_a = qf_lda_a_sel({verify_adrs_tim, block_write});

    // qf_lda  16bit
    assign qf_lda = err_rst ? 16'h0000 : qf_lda_a;

    // qf_endp, dev_nack_ld, wr_nack_ld, poll_nack_ld, verify_ng_ld, re_read_ld, qf_ld
    assign qf_endp = (last_stop_bit | err_rst) & qe_endp;
    assign dev_nack_ld = dev_nack & qe_endp;
    assign wr_nack_ld = wr_nack & qe_endp;
    assign poll_nack_ld = poll_nack & qe_endp;
    assign verify_ng_ld = verify_ng & qe_endp;
    assign re_read_ld = re_read & qe_endp;
    assign qf_ld = cnt_rst | qf_endp | dev_nack_ld | wr_nack_ld | poll_nack_ld | verify_ng_ld | re_read_ld;

    // qf  16bitカウンタ  (byteカウンタ)
    always @(posedge clk) begin
      if(qf_ld)
        qf <= qf_lda;
      else if(qe_endp)
        qf <= qf + 1;
    end

    // qg_endp
    assign qg_endp = qf_endp & (qg_enda | ~block_write | err_rst);

    // qg  11bitカウンタ  (block write用 32byte単位カウンタ)
    always @(posedge clk) begin
      if(cnt_rst | qg_endp)
        qg <= 0;
      else if(qf_endp)
        qg <= qg + 1;
    end

    // im_32byte_num  11bit  (m4_mem_ctrl用 出力)
    assign im_32byte_num = qg;

    // qg_d3
    assign qg_d3  = (qg == 11'h003);

    // qg_end
    // assign qg_end = high_byte ? (qg == bw_high_32byte_num) : (qg == bw_low_32byte_num);

    assign qg_end = (qg == bw_32byte_num);

    // qg_enda
    assign qg_enda = page_write ? qg_d3 : qg_end;

    // qh_endp
    assign qh_endp = qg_endp & qh_end;

    // qh  5bitカウンタ  (coefficient address セレクトカウンタ)
    always @(posedge clk) begin
      if(cnt_rst | qh_endp)
        qh <= 0;
      else if(qg_endp)
        qh <= qh + 1;
    end

    // im_cf_ad  5bit  (m4_mem_ctrl用 出力)
    assign im_cf_ad = qh;

    // high_byte, qh_end
    // assign high_byte = (qh > 5'h08);
    assign qh_end = (qh == 5'h11) | ~(bank_write | bank_read) | err_rst | ~cf_ad_cnt_en;

    // qj_endp
    assign qj_endp = qh_endp & qj_end;

    // qj  1bitカウンタ  (all write / all read 用 bankカウンタ)
    always @(posedge clk) begin
      if(cnt_rst | qj_endp)
        qj <= 0;
      else if(qh_endp)
        qj <= qj + 1;
    end

    // qj_end
    assign qj_end = qj | ~(all_write | all_read) | err_rst | one_bank;

    // qk_endp
    assign qk_endp = qj_endp & qk_end;

    // qk  3bitカウンタ  (IMセレクトカウンタ)
    always @(posedge clk) begin
      if(cnt_rst | qk_endp)
        qk <= 0;
      else if(qj_endp)
        qk <= qk + 1;
    end

    // qk_end
    assign qk_end = (qk == im_num) | ~((bank_write | bank_read) & ~one_im_operate);

    // ql_endp
    assign ql_endp = qk_endp & ql_end;

    // ql  2bitカウンタ  (出力ch.セレクトカウンタ)
    always @(posedge clk) begin
      if(cnt_rst | ql_endp)
        ql <= 0;
      else if(qk_endp)
        ql <= ql + 1;
    end

    // ql_end
    assign ql_end = (ql == out_num) |
                   ~(soft_reset | ((bank_write | bank_read) & ~one_im_operate));

    // err_det, busy_rst
      // assign err_det = (dev_err | nack_err | poll_err | verify_err);
    assign busy_rst = ~cnt_rst & ql_endp;

    // busy
    always @(posedge clk) begin
      if(cnt_rst)
        busy <= 1'b1;
      else if(busy_rst)
        busy <= 1'b0;
    end


    // qsa  7bitカウンタ  (起動時 ql_endp 遅延用)
    always @(posedge clk) begin
      if(startn)
        qsa <= 0;
      else if((ql_endp | busy_rst) & qs[0])
        qsa <= 7'h40;
      else if(qsa[6])
        qsa <= qsa + 1;
    end

    // qsa_b6d1
    always @(posedge clk) begin
      qsa_b6d1 <= qsa[6];
    end

    // ql_endp_dly, ql_endp_st
    assign ql_endp_dly = qsa_b6d1 & ~qsa[6];
    assign ql_endp_st  = qs[0] ? ql_endp_dly : ql_endp;

    // qs  2bitカウンタ  (起動時タイミングカウンタ)
    always @(posedge clk) begin
      if(startn)
        qs <= 0;
      else if(ql_endp_st & ~qs[1])
        qs <= qs + 1;
    end

    // st_srst_endp, m4_set_done
    assign st_srst_endp = ql_endp_st & ~qs[0] & ~qs[1];
    assign m4_set_done = qs[1];

    // m4_set_err
    always @(posedge clk) begin
      if(startn)
        m4_set_err <= 1'b0;
      else if(ql_endp_st & (qs == 2'h1))
        m4_set_err <= dev_err | nack_err;
    end

    // verify_adrs_tim
    assign verify_adrs_tim = (qf_mt6 & qf_lt12 & byte_write) | (qf_mt37 & qf_lt43 & block_write);


// operation セレクト部

    // st_ope_sel, ope_sela  4bit  (起動時自動セレクト)
    assign st_ope_sel = qs[0] ? 4'hd : 4'h0;        // soft_reset -> all_read
    assign ope_sela = qs[1] ? ope_sel : st_ope_sel;

    // ope_sela デコード部
    always @(posedge clk) begin
      soft_reset <= (ope_sela == 4'h0);
      byte_write <= (ope_sela == 4'h1);
      byte_read <= (ope_sela == 4'h2);
      page_write <= (ope_sela == 4'h3);
      page_read <= (ope_sela == 4'h4);
      bank0_write <= (ope_sela == 4'h8);
      bank1_write <= (ope_sela == 4'h9);
      all_write <= (ope_sela == 4'ha);
      bank0_read <= (ope_sela == 4'hb);
      bank1_read <= (ope_sela == 4'hc);
      all_read <= (ope_sela == 4'hd);
    end

    // bank_read, block_read, ope_read, bank_write, block_write, ope_write, ope_rd_wr
    assign bank_read = bank0_read | bank1_read | all_read;
    assign block_read = bank_read | page_read;
    assign ope_read = block_read | byte_read;

    assign bank_write = bank0_write | bank1_write | all_write;
    assign block_write = bank_write | page_write;
    assign ope_write = block_write | byte_write;

    assign ope_rd_wr = ope_read | ope_write;

    // one_im_operate
    assign one_im_operate = one_im_ope & qs[1];


// m4_mem_ctrl 用 出力

    // im_bank1_read, im_bank1_write
    // assign im_bank1_read = bank1_read | (all_read & qj);
    // assign im_bank1_write = bank1_write | (all_write & qj);

    // ram_rstr
    always @(posedge clk) begin
      ram_rstr <= sda_readp & qe_d8 & qf_d1 & bank_write;
    end

    // im_ope_hadrs  4bit
    assign im_ope_hadrs = ((bank_write | bank_read) & ~one_im_operate) ? {1'b0, qk[2:0]} : im_hadrs;

    // im_ope_vadrs  4bit
    assign im_ope_vadrs = ((bank_write | bank_read) & ~one_im_operate) ? {1'b0, ql[2:0]} : im_vadrs;


// qf デコード部

    always @(posedge clk) begin
      qf_d0 <= (qf == 16'h0000);
      qf_d1 <= (qf == 16'h0001);
      qf_d2 <= (qf == 16'h0002);
      qf_d3 <= (qf == 16'h0003);
      qf_d4 <= (qf == 16'h0004);
      qf_d5 <= (qf == 16'h0005);
      qf_d6 <= (qf == 16'h0006);
      qf_d7 <= (qf == 16'h0007);
      qf_d8 <= (qf == 16'h0008);
      qf_d9 <= (qf == 16'h0009);
      qf_d10 <= (qf == 16'h000a);
      qf_d11 <= (qf == 16'h000b);
      qf_d12 <= (qf == 16'h000c);
      qf_d13 <= (qf == 16'h000d);
      qf_d36 <= (qf == 16'h0024);
      qf_d37 <= (qf == 16'h0025);
      qf_d38 <= (qf == 16'h0026);
      qf_d39 <= (qf == 16'h0027);
      qf_d40 <= (qf == 16'h0028);
      qf_d41 <= (qf == 16'h0029);
      qf_d42 <= (qf == 16'h002a);
      qf_d74 <= (qf == 16'h004a);
      qf_d75 <= (qf == 16'h004b);
      qf_d133 <= (qf == 16'h0085);
      qf_d134 <= (qf == 16'h0086);

      // qf_im_pix_p5 <= (qf == im_pix_p5);
      // qf_im_pix_half_p5 <= (qf == im_pix_half_p5);
      // qf_im_pix_p6 <= (qf == im_pix_p6);
      // qf_im_pix_half_p6 <= (qf == im_pix_half_p6);

      qf_im_pix_x16p5 <= (qf == im_pix_x16p5);
      qf_im_pix_x16p6 <= (qf == im_pix_x16p6);

      qf_mt1 <= (qf > 16'h0001);
      qf_mt3 <= (qf > 16'h0003);
      qf_mt5 <= (qf > 16'h0005);
      qf_mt6 <= (qf > 16'h0006);
      qf_mt35 <= (qf > 16'h0023);
      qf_mt36 <= (qf > 16'h0024);
      qf_mt37 <= (qf > 16'h0025);
      qf_mt42 <= (qf > 16'h002a);

      qf_lt5 <= (qf < 16'h0005);
      qf_lt6 <= (qf < 16'h0006);
      qf_lt12 <= (qf < 16'h000c);
      qf_lt36 <= (qf < 16'h0024);
      qf_lt43 <= (qf < 16'h002b);
      qf_lt75 <= (qf < 16'h004b);
      qf_lt134 <= (qf < 16'h0086);

      // qf_lt_im_pix_p6 <= (qf < im_pix_p6);
      // qf_lt_im_pix_half_p6 <= (qf < im_pix_half_p6);

      qf_lt_im_pix_x16p6 <= (qf < im_pix_x16p6);
    end


// start_bit, stop_bit 作成

    // srst_s, srst_p, rd_s, byte_rd_p, page_rd_p, bank_rd_p
    // byte_wr_s, block_wr_s, byte_wr_p, block_wr_p
    assign srst_s = qf_d0 | qf_d2;
    assign srst_p = qf_d3;
    assign rd_s = qf_d0 | qf_d4;
    assign byte_rd_p = qf_d7;
    assign page_rd_p = qf_d134;
    // assign bank_rd_p = high_byte ? qf_im_pix_half_p6 : qf_im_pix_p6;
    assign bank_rd_p = qf_im_pix_x16p6;
    assign byte_wr_s = qf_d0 | qf_d6 | qf_d10;
    assign block_wr_s = qf_d0 | qf_d37 | qf_d41;
    assign byte_wr_p = qf_d5 | qf_d13;
    assign block_wr_p = qf_d36 | qf_d75;

    // start_bit
    always @(posedge clk) begin
      case (ope_sela)
        4'h0: start_bit <= srst_s;
        4'h1: start_bit <= byte_wr_s;
        4'h2: start_bit <= rd_s;
        4'h3: start_bit <= block_wr_s;
        4'h4: start_bit <= rd_s;
        4'h5: start_bit <= 1'b0;
        4'h6: start_bit <= 1'b0;
        4'h7: start_bit <= 1'b0;
        4'h8: start_bit <= block_wr_s;
        4'h9: start_bit <= block_wr_s;
        4'ha: start_bit <= block_wr_s;
        4'hb: start_bit <= rd_s;
        4'hc: start_bit <= rd_s;
        4'hd: start_bit <= rd_s;
        4'he: start_bit <= 1'b0;
        4'hf: start_bit <= 1'b0;
      endcase
    end

    // stop_bit
    always @(posedge clk) begin
      case (ope_sela)
        4'h0: stop_bit <= srst_p;
        4'h1: stop_bit <= byte_wr_p;
        4'h2: stop_bit <= byte_rd_p;
        4'h3: stop_bit <= block_wr_p;
        4'h4: stop_bit <= page_rd_p;
        4'h5: stop_bit <= 1'b0;
        4'h6: stop_bit <= 1'b0;
        4'h7: stop_bit <= 1'b0;
        4'h8: stop_bit <= block_wr_p;
        4'h9: stop_bit <= block_wr_p;
        4'ha: stop_bit <= block_wr_p;
        4'hb: stop_bit <= bank_rd_p;
        4'hc: stop_bit <= bank_rd_p;
        4'hd: stop_bit <= bank_rd_p;
        4'he: stop_bit <= 1'b0;
        4'hf: stop_bit <= 1'b0;
      endcase
    end

    // st_bit
    assign st_bit = start_bit | stop_bit;

    // last_stop_bit
    always @(posedge clk) begin
      case (ope_sela)
        4'h0: last_stop_bit <= qf_d3;
        4'h1: last_stop_bit <= qf_d13;
        4'h2: last_stop_bit <= qf_d7;
        4'h3: last_stop_bit <= qf_d75;
        4'h4: last_stop_bit <= qf_d134;
        4'h5: last_stop_bit <= 1'b0;
        4'h6: last_stop_bit <= 1'b0;
        4'h7: last_stop_bit <= 1'b0;
        4'h8: last_stop_bit <= qf_d75;
        4'h9: last_stop_bit <= qf_d75;
        4'ha: last_stop_bit <= qf_d75;
        4'hb: last_stop_bit <= bank_rd_p;
        4'hc: last_stop_bit <= bank_rd_p;
        4'hd: last_stop_bit <= bank_rd_p;
        4'he: last_stop_bit <= 1'b0;
        4'hf: last_stop_bit <= 1'b0;
      endcase
    end


// sda_in 入力のノイズ除去 多数決処理

    // qsda_in_rst
    always @(posedge clk) begin
      qsda_in_rst <= ~qd[1] | startn | ~busy;
    end

    // qsda_in  4bitカウンタ  (sda_in の high レベルカウンタ)
    always @(posedge clk) begin
      if(qsda_in_rst)
        qsda_in <= 0;
      else if(sda_in & ~sda_in_high)
        qsda_in <= qsda_in + 1;
    end

    // sda_in_high
 // assign sda_in_high = high_speed ? (qsda_in >= 4'd3) : (qsda_in >= 4'd7);
    assign sda_in_high = high_speed ? (qsda_in >= 4'd4) : (qsda_in >= 4'd7);


// Device Address Error 検出

    // sda_din  8bit (シリアルデータ入力シフトレジスタ)
    always @(posedge clk) begin
      if(sda_readp)
        sda_din <= {sda_din, sda_in_high};
    end

    // sda_readp1, sda_readp2
    always @(posedge clk) begin
      sda_readp1 <= sda_readp;
      sda_readp2 <= sda_readp1;
    end

    // dev_ack_tim, dev_nack, dev_nackp, dev_ackp
    assign dev_ack_tim = qe_d8 & qf_d1 & ope_rd_wr;
    assign dev_nack = dev_ack_tim & sda_din[0];
    assign dev_nackp = dev_nack & sda_readp2;
    assign dev_ackp = (dev_ack_tim & ~sda_din[0]) & sda_readp2;

    // qderr  4bitカウンタ  (dev_err カウンタ)
    always @(posedge clk) begin
      if(cnt_rst | dev_ackp | qf_endp)
        qderr <= 0;
      else if(dev_nackp & ~qderr[3])
        qderr <= qderr + 1;
    end

    // dev_err
    assign dev_err = qderr[3];

    // dev_nack_last
    assign dev_nack_last = qderr[3] & dev_nack;


// Error 検出情報統合

    // err_rst
    assign err_rst = dev_nack_last | wr_nack_last | poll_nack_last | verify_ng_last;

    // err_det
    always @(posedge clk) begin
      if(cnt_rst)
        err_det <= 1'b0;
      else if(err_rst)
        err_det <= 1'b1;
    end


// Nack Error 検出

    // radrs_ack_tim
    assign radrs_ack_tim = qe_d8 & (qf_d2 | qf_d3 | qf_d5) & ope_read;

    // byte_wadrs_tim, block_wadrs_tim, wadrs_ack_tim
    assign byte_wadrs_tim = qf_mt1 & qf_lt5 & byte_write;
    assign block_wadrs_tim = qf_mt1 & qf_lt36 & block_write;
    assign wadrs_ack_tim = (byte_wadrs_tim | block_wadrs_tim) & qe_d8;

    // byte_vadrs_tim, block_vadrs_tim, vadrs_ack_tim  (verify)
    assign byte_vadrs_tim = (qf_d8 | qf_d9 | qf_d11) & byte_write;
    assign block_vadrs_tim = (qf_d39 | qf_d40 | qf_d42) & block_write;
    assign vadrs_ack_tim = (byte_vadrs_tim | block_vadrs_tim) & qe_d8;

    // wr_nack, wr_nackp, wr_endp
    assign wr_nack = (radrs_ack_tim | wadrs_ack_tim | vadrs_ack_tim) & sda_din[0];
    assign wr_nackp = wr_nack & sda_readp2;
    assign wr_endp = ((qf_d5 & byte_write) | (qf_d36 & block_write)) & qe_endp;

    // qnack  4bitカウンタ  (nack カウンタ)
    always @(posedge clk) begin
      if(cnt_rst | wr_endp | qf_endp)
        qnack <= 0;
      else if(wr_nackp & ~qnack[3])
        qnack <= qnack + 1;
    end

    // nack_err
    assign nack_err = qnack[3];

    // wr_nack_last
    assign wr_nack_last = qnack[3] & wr_nack;


// Ack-Polling Error 検出

    // poll_ack_tim, poll_nack, poll_nackp, poll_ackp
    assign poll_ack_tim = ((qf_d7 & byte_write) | (qf_d38 & block_write)) & qe_d8;
    assign poll_nack = poll_ack_tim & sda_din[0];
    assign poll_nackp = poll_nack & sda_readp2;
    assign poll_ackp = (poll_ack_tim & ~sda_din[0]) & sda_readp2;

    // qpoll  11bitカウンタ  (polling カウンタ)
    always @(posedge clk) begin
      if(cnt_rst | poll_ackp | qf_endp)
        qpoll <= 0;
      else if(poll_nackp & ~poll_err)
        qpoll <= qpoll + 1;
    end

    // poll_err
    assign poll_err = high_speed ? qpoll[10] : qpoll[9];

    // poll_nack_last
    assign poll_nack_last = poll_err & poll_nack;


// Write data 用 RAM コントロール (128byte RAM)

  // Write コントロール

    // wd_ram_din  8bit
    always @(posedge clk) begin
      wd_ram_din <= bank_write ? wr_dinb : wr_dina;  // xxb : from SRAM, xxa : from 232c
    end

    // wd_ram_rstwc
    assign wd_ram_rstwc = bank_write ? wd_ram_rstwb : wd_ram_rstwa;

    // wd_ram_wec
    assign wd_ram_wec = bank_write ? wd_ram_web : wd_ram_wea;

    // wd_ram_wec1, wd_ram_wec2
    always @(posedge clk) begin
      wd_ram_wec1 <= wd_ram_wec;
      wd_ram_wec2 <= wd_ram_wec1;
    end

    // wd_ram_wed
    assign wd_ram_wed = wd_ram_wec1 & ~wd_ram_wec2;

    // wd_ram_we
    assign wd_ram_we = wd_ram_wed & ~wd_ram_waa[7];

    // wd_ram_waa  8bitカウンタ
    always @(posedge clk) begin
      if(wd_ram_rstwc)
        wd_ram_waa <= 0;
      else if(wd_ram_we)
        wd_ram_waa <= wd_ram_waa + 1;
    end

    // wd_ram_wa  7bit
    assign wd_ram_wa = wd_ram_waa[6:0];


  // Read コントロール

    // mnxd, qf_mn3da, qf_mnxda  16bit
    assign mnxd = byte_write ? 16'hfff5 : 16'hffd6;  // -d11 or -d42
    assign qf_mn3da = qf + 16'hfffd;   // -d3
    assign qf_mnxda = qf + mnxd;       // -d11 or -d42

    // qf_mn3d, qf_mnxd  5bit
    always @(posedge clk) begin
      qf_mn3d <= qf_mn3da[4:0];
      qf_mnxd <= qf_mnxda[4:0];
    end

    // verify_tim
    assign verify_tim = byte_write ? qf_mt5 : qf_mt36;

    // wd_ram_lra  5bit
    always @(posedge clk) begin
      if(~ope_write)
        wd_ram_lra <= 5'h00;
      else if(sda_readp & qe_d8)
        wd_ram_lra <= verify_tim ? qf_mnxd : qf_mn3d;
    end

    // wd_ram_mra  2bit
    assign wd_ram_mra = page_write ? im_32byte_num[1:0] : 2'h0;

    // wd_ram_ra  7bit
    assign wd_ram_ra = {wd_ram_mra, wd_ram_lra};

    // wr_dout  8bit
    always @(posedge clk) begin
      wr_dout <= wd_test ? test_wd : wd_ram_dout;   // RAM 出力データ
    end


  // 8bit x 128 ram module
    uart_ram_mpc  im_wd_buf_mpc(
      .clk    (clk),
      .d      (wd_ram_din),
      .a      (wd_ram_wa),
      .we     (wd_ram_we),
      .dpra   (wd_ram_ra),
      .dpo    (wd_ram_dout)
    );


// Verify Error 検出

    // qf_43to74, verify_data_tim, verify_data_ackp
    assign qf_43to74 = qf_mt42 & qf_lt75;
    assign verify_data_tim = byte_write ? qf_d12 : qf_43to74;
    assign verify_data_ackp = verify_data_tim & qe_d8 & sda_readp & ope_write;

    // verify_nga
    always @(posedge clk) begin
      verify_nga <= ~(sda_din == wr_dout);
    end

    // verify_ng
    always @(posedge clk) begin
      if(~ope_write | qe_endp)
        verify_ng <= 1'b0;
      else if(verify_data_ackp)
        verify_ng <= verify_nga;
    end

    // verify_ngp
    assign verify_ngp = verify_data_ackp & verify_nga;

    // qvrfy  4bitカウンタ  (verify error カウンタ)
    always @(posedge clk) begin
      if(cnt_rst | qf_endp)
        qvrfy <= 0;
      else if(verify_ngp & ~qvrfy[3])
        qvrfy <= qvrfy + 1;
    end

    // verify_err
    assign verify_err = qvrfy[3];

    // verify_ng_last
    assign verify_ng_last = qvrfy[3] & verify_ng;


// scl 出力部

    // scla
    always @(posedge clk) begin
      scla <= qd[1] | cnt_rst | ~busy;
    end

    // scl
    assign scl = scla | startn;


// sda_ot, sda_dir 出力部

    // wr_tim
    assign wr_tim = (qf_lt6 & ope_read) | (qf_lt12 & byte_write) | (qf_lt43 & block_write);

    // qe_d8d, sda_ota, qe_d0d, srst_bit1d, busy1n, busy2n, sda_otb
    always @(posedge clk) begin
      qe_d8d <= qe_d8;
      sda_ota <= (wr_tim & qe_d8d) | (~wr_tim & ~qe_d8d) | ~ope_rd_wr;
      qe_d0d <= qe_d0;
      srst_bit1d <= (~qs[0] & ~qs[1]) & qf_d1 & qe_d0d;
      busy1n <= cnt_rst | ~busy;
      busy2n <= busy1n;
      sda_otb <= (sda_ota & ~st_bit & ~srst_bit1d) | busy2n;
    end

    // sda_ot
    assign sda_ot = sda_otb | startn;

    // sda_dir  (Adaptor BD の 74LV245 の DIR ( 0:入力 / 1:出力 ))
    assign sda_dir = ~sda_ot;


// out_ch_sel 出力部

    // out_ch_sel  3bit  (Adaptor BD の 74LV4052 or 74HCT4051 の SEL (0:out0))
    assign out_ch_sel = (soft_reset | ((bank_write | bank_read) & ~one_im_operate)) ?
                         ql : im_vadrs[2:0];


// Word Address 作成

    // bank_ad  11bit
    assign bank_ad = qg;

    // cmd_mada  11bit
    assign cmd_mada = cmd_ad[15:5] + {9'h000, im_32byte_num[1:0]};

    // word_ad  16bit
    always @(posedge clk) begin
      word_ad <= (bank_write | bank_read) ? {bank_ad, 5'h00} : {cmd_mada, cmd_ad[4:0]};
    end


// rd_sdao 作成

    // high_byte_1d
    // always @(posedge clk) begin
    //   high_byte_1d <= high_byte;
    // end

    // bank_rd_last
    // assign bank_rd_last = high_byte_1d ? qf_im_pix_half_p5 : qf_im_pix_p5;

    assign bank_rd_last = qf_im_pix_x16p5;


    // rd_last_data   (nack出力用)
    assign rd_last_data = (qf_d6 & byte_read) | (qf_d133 & page_read) | (bank_rd_last & bank_read);

    // qf1d  4bit
    always @(posedge clk) begin
      qf1d <= qf[3:0];
    end

    // rd_sdao_sel  3bit
    assign rd_sdao_sel = qf_mt6 ? 3'h6 : qf1d[2:0];

    // dev_ad  3bit  (Device Address)
    assign dev_ad = (soft_reset | ((bank_write | bank_read) & ~one_im_operate)) ?
                     qk : im_hadrs[2:0];

    // rd_sdao  9bit
    always @(posedge clk) begin
      case (rd_sdao_sel)
        3'h0: rd_sdao <= {8'hff, 1'b1};
        3'h1: rd_sdao <= {4'ha, dev_ad, 1'b0, 1'b1};  // Device Address, Write
        3'h2: rd_sdao <= {word_ad[15:8], 1'b1};
        3'h3: rd_sdao <= {word_ad[7:0], 1'b1};
        3'h4: rd_sdao <= {8'hff, 1'b1};
        3'h5: rd_sdao <= {4'ha, dev_ad, 1'b1, 1'b1};  // Device Address, Read
        3'h6: rd_sdao <= {8'hff, rd_last_data};
        3'h7: rd_sdao <= {8'hff, rd_last_data};
      endcase
    end


// wr_sdao 作成

    // wr_last_data   (verify read の nack出力用)
    assign wr_last_data = byte_write ? qf_d12 : qf_d74;

    // qf_4to35, qf_36to42
    assign qf_4to35 = qf_mt3 & qf_lt36;
    assign qf_36to42 = qf_mt35 & qf_lt43;

    // wr_qf_sel  2bit
    assign wr_qf_sel[0] = block_write & (qf_4to35 | qf_mt42);
    assign wr_qf_sel[1] = block_write & (qf_36to42 | qf_mt42);

    // qf_mn31d  16bit
    always @(posedge clk) begin
      qf_mn31d <= qf + 16'hffe1;   // -d31
    end

    // wr_sdao_sel  4bit
    function [3:0] wr_sdao_sel_sel;
    input [1:0] sel;
      case(sel)
        2'h0: wr_sdao_sel_sel = qf1d[3:0];
        2'h1: wr_sdao_sel_sel = 4'h4;
        2'h2: wr_sdao_sel_sel = qf_mn31d[3:0];
        2'h3: wr_sdao_sel_sel = 4'hc;
      endcase
    endfunction

    assign wr_sdao_sel = wr_sdao_sel_sel(wr_qf_sel);

    // wr_sdao  9bit
    always @(posedge clk) begin
      case (wr_sdao_sel)
        4'h0: wr_sdao <= {8'hff, 1'b1};
        4'h1: wr_sdao <= {4'ha, dev_ad, 1'b0, 1'b1};  // Device Address, Write
        4'h2: wr_sdao <= {word_ad[15:8], 1'b1};
        4'h3: wr_sdao <= {word_ad[7:0], 1'b1};
        4'h4: wr_sdao <= {wr_dout, 1'b1};
        4'h5: wr_sdao <= {8'hff, 1'b1};
        4'h6: wr_sdao <= {8'hff, 1'b1};
        4'h7: wr_sdao <= {4'ha, dev_ad, 1'b0, 1'b1};  // Device Address, Write
        4'h8: wr_sdao <= {word_ad[15:8], 1'b1};
        4'h9: wr_sdao <= {word_ad[7:0], 1'b1};
        4'ha: wr_sdao <= {8'hff, 1'b1};
        4'hb: wr_sdao <= {4'ha, dev_ad, 1'b1, 1'b1};  // Device Address, Read
        4'hc: wr_sdao <= {8'hff, wr_last_data};
        4'hd: wr_sdao <= {8'hff, wr_last_data};
        4'he: wr_sdao <= {8'hff, wr_last_data};
        4'hf: wr_sdao <= {8'hff, wr_last_data};
      endcase
    end


// sdao 出力部

    // sdaoa  9bit
    function [8:0] sdaoa_sel;
    input [1:0] sel;
      case(sel)
        2'h0: sdaoa_sel = 9'h1ff;
        2'h1: sdaoa_sel = rd_sdao;
        2'h2: sdaoa_sel = wr_sdao;
        2'h3: sdaoa_sel = wr_sdao;
      endcase
    endfunction

    assign sdaoa = sdaoa_sel({ope_write, ope_read});

    // qe1d, qe2d  4bit
    always @(posedge clk) begin
      qe1d <= qe;
      qe2d <= qe1d;
    end

    // qe_sel  2bit
    assign qe_sel[0] = start_bit | busy2n;
    assign qe_sel[1] = stop_bit | busy2n;

    // sdao_sel  4bit
    function [3:0] sdao_sel_sel;
    input [1:0] sel;
      case(sel)
        2'h0: sdao_sel_sel = qe2d;
        2'h1: sdao_sel_sel = 4'h9;
        2'h2: sdao_sel_sel = 4'ha;
        2'h3: sdao_sel_sel = 4'hb;
      endcase
    endfunction

    assign sdao_sel = sdao_sel_sel(qe_sel);

    // sda_start1, sda_start2
    always @(posedge clk) begin
      sda_start1 <= sda_start;
      sda_start2 <= sda_start1;
    end

    // sda_stop1, sda_stop2
    always @(posedge clk) begin
      sda_stop1 <= sda_stop;
      sda_stop2 <= sda_stop1;
    end

    // sdaob
    always @(posedge clk) begin
      case (sdao_sel)
        4'h0: sdaob <= sdaoa[8];
        4'h1: sdaob <= sdaoa[7];
        4'h2: sdaob <= sdaoa[6];
        4'h3: sdaob <= sdaoa[5];
        4'h4: sdaob <= sdaoa[4];
        4'h5: sdaob <= sdaoa[3];
        4'h6: sdaob <= sdaoa[2];
        4'h7: sdaob <= sdaoa[1];
        4'h8: sdaob <= sdaoa[0];
        4'h9: sdaob <= sda_start & sda_start2;
        4'ha: sdaob <= sda_stop2;
        4'hb: sdaob <= 1'b1;
        4'hc: sdaob <= 1'b1;
        4'hd: sdaob <= 1'b1;
        4'he: sdaob <= 1'b1;
        4'hf: sdaob <= 1'b1;
      endcase
    end

    // sdao
    assign sdao = sdaob | startn;


// Read data 出力部

    // qf_d6a
    assign qf_d6a = qf_d6 & byte_read;

    // qf_6to133a
    assign qf_6to133a = qf_mt5 & qf_lt134 & page_read;

    // qf_6to_im_pix, qf_6to_im_pix_half
    // assign qf_6to_im_pix      = qf_mt5 & qf_lt_im_pix_p6      & ~high_byte_1d & bank_read;
    // assign qf_6to_im_pix_half = qf_mt5 & qf_lt_im_pix_half_p6 &  high_byte_1d & bank_read;

    assign qf_6to_im_pix = qf_mt5 & qf_lt_im_pix_x16p6 & bank_read;


    // rd_data_tim
    always @(posedge clk) begin
      // rd_data_tim <= qf_d6a | qf_6to133a | qf_6to_im_pix | qf_6to_im_pix_half;

      rd_data_tim <= qf_d6a | qf_6to133a | qf_6to_im_pix;
    end

    // rd_latchp
    assign rd_latchp = rd_data_tim & sda_readp & qe_d8;

    // rd_dout  8bit
    always @(posedge clk) begin
      if(rd_latchp)
        rd_dout <= sda_din;
    end

    // rd_latchp1, rd_latchp2, rd_we
    always @(posedge clk) begin
      rd_latchp1 <= rd_latchp;
      rd_latchp2 <= rd_latchp1;
      rd_we <= rd_latchp2;
    end

    // rd_startp
    always @(posedge clk) begin
      rd_startp <= qf_d6 & ope_read & qe_d8 & sda_readp;
    end


// Bank Read での checksum error 検出

    // bank_rd_last_bit
    assign bank_rd_last_bit = bank_read & bank_rd_last & qe_d8;

    // qrerd  2bitカウンタ  (re-read 回数カウンタ)
    always @(posedge clk) begin
      if(cnt_rst | qf_endp)
        qrerd <= 0;
      else if(bank_rd_last_bit & qe_endp & ~qrerd[1])
        qrerd <= qrerd + 1;
    end

    // qrerd_tim0, qrerd_tim1, qrerd_tim2
    assign qrerd_tim0 = (qrerd == 2'h0);
    assign qrerd_tim1 = (qrerd == 2'h1);
    assign qrerd_tim2 = (qrerd == 2'h2);

    // rd_csum_acc  8bit
    always @(posedge clk) begin
      if(cnt_rst | (qf_d0 & sda_readp))
        rd_csum_acc <= 0;
      else if(rd_latchp & bank_read)
        rd_csum_acc <= rd_csum_acc + sda_din;
    end

    // rd_csum0d  8bit
    always @(posedge clk) begin
      if(qrerd_tim0 & bank_rd_last_bit & sda_readp2)
        rd_csum0d <= rd_csum_acc;
    end

    // rd_csum1d  8bit
    always @(posedge clk) begin
      if(qrerd_tim1 & bank_rd_last_bit & sda_readp2)
        rd_csum1d <= rd_csum_acc;
    end

    // rd_csum2d  8bit
    always @(posedge clk) begin
      if(qrerd_tim2 & bank_rd_last_bit & sda_readp2)
        rd_csum2d <= rd_csum_acc;
    end

    // csum_neq0_1, csum_neq0_2, csum_neq1_2
    always @(posedge clk) begin
      csum_neq0_1 <= ~(rd_csum0d == rd_csum1d);
      csum_neq0_2 <= ~(rd_csum0d == rd_csum2d);
      csum_neq1_2 <= ~(rd_csum1d == rd_csum2d);
    end

    // re_read
    assign re_read = (qrerd_tim0 & bank_rd_last_bit) | (qrerd_tim1 & bank_rd_last_bit & csum_neq0_1);

    // download_err
    always @(posedge clk) begin
      if(cnt_rst)
        download_err <= 1'b0;
      else if(qrerd_tim2 & bank_rd_last_bit & qe_endp)
        download_err <= download_err | (csum_neq0_2 & csum_neq1_2);
    end

    // tp1, tp2, tp3, tp4  デバッグ用テストポイント出力
    assign tp1 = cnt_rst_a;
    assign tp2 = im_ope_vadrs[0];
    assign tp3 = im_ope_vadrs[1];
    assign tp4 = im_ope_vadrs[2];
    assign tp5 = sdaob;

endmodule
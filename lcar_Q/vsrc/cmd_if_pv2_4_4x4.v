`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// RS-232C Command interface
//
//
// 2012.09.14 作成
// 2013.01.09 修正 rsp_start信号を遅延
// 2013.03    修正 EMB対応変更 (rsp_data および rsp_start 作成部にEMB用信号追加)
// 2013.04    修正 Impact16用に変更 (名称を cmd_if_x3_a から cmd_if_impact に変更)
// 2013.06    修正 M5対応変更 (rsp_data および rsp_start 作成部にM5用信号追加)
// 2014.06    修正 NPC用Calibration soft対応変更 (Control Register Write/Read 部を
//                 変更し NPC用Calibration softで使われている Byte Memory write コマンド
//                 による動作を可能にする)
//                 また、垂直IM数 v_im_num をパラメータとした
// 2014.11    修正 XT用に変更 (名称を cmd_if_impact から cmd_if_xt に変更) 
// 2015.11    修正 ImpactIIなど用に変更 (名称を cmd_if_xt から cmd_if_impact2 に変更)
// 2017.03    修正 P0,P1をPVII-4,PVII-6用に変更
//                 (名称を cmd_if_impact2 から cmd_if_pv2_m5051b に変更)
// 2017.04    修正 P0をPVII-4(4x4IM)用に変更
//                 (名称を cmd_if_pv2_m5051b から cmd_if_pv2_4_4x4 に変更)
//
// サブモジュール
//   uart_ram_mpc  (Response data buffer)
//   sdp_ram_256byte  (COM buffer)
//

module cmd_if_pv2_4_4x4 (panel_sel, clk, rst, exe_p5, exe_p4, exe_p3, exe_p2, exe_p1, exe_p0,
                     exe_cmd_num, exe_req, rcv_ok, cmd_ram_do,
                     rsp_ram_rd, rsp_ram_rd_rstw, rsp_ram_rd_we,
                     rsp_im_rd, rsp_im_rd_rstw, rsp_im_rd_we,
                     rsp_ram_re, tx_done,
                     // im00_err_det, im01_err_det, im10_err_det, im11_err_det,
                     im_err_det,
                     m4_on, m4_bank1,
                     ct_red, ct_green, ct_blue,
                     gamma, test_pat, fpga_ver, brightness,
                     // im00_busy, im01_busy, im10_busy, im11_busy,
                     im_busy,
                     // im00_copy_correct_busy, im01_copy_correct_busy,
                     // im10_copy_correct_busy, im11_copy_correct_busy,
                     im_copy_correct_busy,
                     rsp_done, tx_busy,
                     dsw_loss_brt100,
                     mem_color_loss,
                     cmd_com_buf_write, cmd_com_buf_wa, cmd_com_buf_we,
                     rx_data, rx_im_download_on,
                     emb_cmd, emb_cmd_rcv_ok,
                     emb_rsp_data,
                     emb_rsp_req,
                     m5_cmd, m5_cmd_rcv_ok,
                     m5_rsp_data,
                     m5_rsp_req,
                     exe_en,
                     ovpx,

                     im_ope_sel, ram_ope_sel, im_cmd_ad, ram_cmd_ad,
                     ram_cmd_rd_we, coeff_offset_we, cmd_ram_ra, ram_cmd_rd, im_cmd_rd,
                     im_cmd_rd_rstw,
                     // im00_cmd_rd_we, im01_cmd_rd_we, im10_cmd_rd_we, im11_cmd_rd_we,
                     im_cmd_rd_we,
                     im_vadrs, im_hadrs,
                     ram_cmd_startp, panel_correct_startp,
                     one_im_to_ram_copy,
                     // im00_cmd_startp, im01_cmd_startp, im10_cmd_startp, im11_cmd_startp,
                     im_cmd_startp,
                     // im00_rd_sel, im01_rd_sel, im10_rd_sel, im11_rd_sel,
                     rsp_data,
                     rsp_req,
                     cmd_ct_red, cmd_ct_green, cmd_ct_blue,
                     cmd_gamma,
                     cmd_reboot_n, cmd_baud_rate,
                     cmd_brightness,
                     pixel1_disp_on, pixel4_disp_on, pixel1_disp_mode, pixel_disp_rgb_on,
                     color_loss,
                     testp_level, rgb_out_zero,
                     sel_test_pat, testp_rgb_en,
                     sel_m4_on, sel_m4_bank1,
                     // panel_correct_im00, panel_correct_im01, panel_correct_im10, panel_correct_im11,
                     panel_correct_im,
                     panel_correct_one_im,
                     rx_im_download_exe_tim,
                     tp1, tp2, tp3);

    input [3:0] panel_sel;
    input clk, rst;
    input [7:0] exe_p5, exe_p4, exe_p3, exe_p2, exe_p1, exe_p0;
    input [5:0] exe_cmd_num;
    input exe_req, rcv_ok;
    input [7:0] cmd_ram_do;
    input [7:0] rsp_ram_rd;
    input rsp_ram_rd_rstw, rsp_ram_rd_we;
    input [7:0] rsp_im_rd;
    input rsp_im_rd_rstw, rsp_im_rd_we;
    input rsp_ram_re, tx_done;
    // input im00_err_det, im01_err_det, im10_err_det, im11_err_det;
    input im_err_det;
    input m4_on, m4_bank1;
    input [3:0] ct_red, ct_green, ct_blue;
    input [2:0] gamma;
    input [7:0] test_pat;
    input [7:0] fpga_ver;
    input [6:0] brightness;
    // input im00_busy, im01_busy, im10_busy, im11_busy;
    input im_busy;
    // input im00_copy_correct_busy, im01_copy_correct_busy;
    // input im10_copy_correct_busy, im11_copy_correct_busy;
    input im_copy_correct_busy;
    input rsp_done, tx_busy;
    input dsw_loss_brt100;
    input [2:0] mem_color_loss;
    input cmd_com_buf_write, cmd_com_buf_we;
    input [7:0] cmd_com_buf_wa;
    input [7:0] rx_data;
    input rx_im_download_on;
    input emb_cmd, emb_cmd_rcv_ok;
    input [79:0] emb_rsp_data;
    input emb_rsp_req;
    input m5_cmd, m5_cmd_rcv_ok;
    input [79:0] m5_rsp_data;
    input m5_rsp_req;
    input exe_en;
    input ovpx;

    output reg [3:0] im_ope_sel;
    output reg [2:0] ram_ope_sel;
    output reg [21:0] ram_cmd_ad;
    output reg [15:0] im_cmd_ad;
    output reg ram_cmd_rd_we;
    output reg coeff_offset_we;
    output [6:0] cmd_ram_ra;
    output reg [7:0] ram_cmd_rd;
    output reg [7:0] im_cmd_rd;
    output reg im_cmd_rd_rstw;
    // output reg im00_cmd_rd_we, im01_cmd_rd_we, im10_cmd_rd_we, im11_cmd_rd_we;
    output reg im_cmd_rd_we;
    output reg [3:0] im_vadrs, im_hadrs;
    output reg ram_cmd_startp;
    output reg panel_correct_startp;
    output one_im_to_ram_copy;
    // output reg im00_cmd_startp, im01_cmd_startp, im10_cmd_startp, im11_cmd_startp;
    output reg im_cmd_startp;
    // output reg im00_rd_sel, im01_rd_sel, im10_rd_sel, im11_rd_sel;
    output reg [79:0] rsp_data;
    output reg rsp_req;
    output reg [3:0] cmd_ct_red, cmd_ct_green, cmd_ct_blue;
    output reg [2:0] cmd_gamma;
    output cmd_reboot_n;
    output reg [1:0] cmd_baud_rate;
    output reg [6:0] cmd_brightness;
    output reg pixel1_disp_on, pixel4_disp_on;
    output reg [23:0] pixel1_disp_mode;
    output [2:0] pixel_disp_rgb_on;
    output reg [2:0] color_loss;
    output reg [7:0] testp_level;
    output reg [2:0] rgb_out_zero;
    output reg [7:0] sel_test_pat;
    output reg [2:0] testp_rgb_en;
    output reg sel_m4_on, sel_m4_bank1;
    // output reg panel_correct_im00, panel_correct_im01, panel_correct_im10, panel_correct_im11;
    output reg panel_correct_im;
    output reg panel_correct_one_im;
    output reg rx_im_download_exe_tim;
    output tp1, tp2, tp3;

    reg [3:0] dec_p5, dec_p4, dec_p3, dec_p2, dec_p1, dec_p0;
    reg com_buf_ctrl, com_im_ctrl;
    reg exe_req1d, exe_req2d, exe_req3d, exe_req4d, exe_req5d, exe_req6d;
    reg exe_req7d, exe_req8d, exe_req9d, exe_req10d, exe_req11d;
    reg startp, exe_latchp;
    reg ram_byte_write, ram_byte_read, ram_block_write, ram_block_read;
    reg ram_bank0to1_copy, ram_bank1to0_copy;
    reg panel_correct;
    reg im_byte_write, im_byte_read, im_page_write, im_page_read;
    reg im_bank0_write, im_bank1_write, im_bank0_1_write;
    reg im_bank0_read, im_bank1_read, im_bank0_1_read;
    reg im1_bank0_1_read;
    reg write_cmd_a;
    reg [8:0] qb;
    reg [7:0] qc;
    reg cnt_stop_a;
    // reg dec_p5_d0, dec_p5_d1, dec_p5_d2, dec_p5_d3;
    reg dec_p4_lt_v_im_num, dec_p5_lt_h_im_num;
    reg ram_start_en;
    reg [7:0] rsp_ram_din;
    reg rsp_rd_rstw;
    reg rsp_rd_we1d, rsp_rd_we2d;
    reg [7:0] qd;
    reg [7:0] rsp_ram_do;
    reg [7:0] qe;
    reg im_rd_err, ram_na_rd;
    reg [6:0] rsp_brt;
    reg [7:0] enc_ram_do_msb, enc_ram_do_lsb;
    reg [7:0] enc_m4_bank;
    reg [7:0] enc_ct_red, enc_ct_green, enc_ct_blue;
    reg [7:0] enc_gamma;
    reg [7:0] enc_test_msb, enc_test_lsb;
    reg [7:0] enc_ver_msb, enc_ver_lsb;
    reg [7:0] enc_brt_msb, enc_brt_lsb;
    reg [7:0] enc_panel_conf_msb, enc_panel_conf_lsb;
    reg im_busy1, im_busy2;
    reg qd_stop1, qd_stop2, qc_stop1, qc_stop2;
    reg copy_correct_busy1, copy_correct_busy2;
    reg rsp_start;
    reg [6:0] qrsp_st;
    reg qrsp_st_b6d1;
    reg exe_tim, exe_tim1, rsp_reqa, rsp_wait, rsp_tx_busy1, rsp_busy;
    reg cmd_m4_on, cmd_m4_bank1;
    reg [7:0] cmd_test_pat;
    reg cmd_reboot;
    reg [7:0] cmd_panel_conf;
    reg [6:0] exe_brt;
    reg [6:0] cmd_brt;
    reg cmd_brt_sel;
    reg pixel_disp_r_on, pixel_disp_g_on, pixel_disp_b_on;
    reg [2:0] cmd_color_loss;
    reg cmd_loss_brt100, cmd_loss_color_sel;
    reg cmd_loss_50hz;
    reg loss_brt100_sel;
    reg [23:0] ctrl_reg_wad;
    reg testp_reg_ce, testp_level_reg_ce, rgb_zero_reg_ce;
    reg [7:0] testp_reg;
    reg m4_on_reg_ce, m4_bank1_reg_ce, ram_enable_ce;
    reg reg_m4_on, reg_m4_bank1, reg_ram_enable;
    reg [23:0] ctrl_reg_rad;
    reg [7:0] ctrl_reg_rd;
    reg [7:0] reg_test_pat;
    reg reg_test_pat_sel;
    reg reg_m4_on_sel, reg_m4_bank1_sel;
    reg cmd_com_buf_read;
    reg [8:0] cmd_com_buf_ra;
    reg [5:0] cmd_com_rb;
    reg [7:0] com_buf_do;
    reg dec_p0_d2;
    reg rx_im_download_on1d, rx_im_download_on2d, rx_im_download_stp;
    reg exe_req_wait, exe_req_wait1d;
    reg exe_req_a;
    reg rx_im_download_st_tim;
    reg exe_en_1d;
    reg ovpx_1d, ovpx_2d, ovp;
    reg [10:0] qrto;
    reg rsp_time_out, rsp_time_out_1d, rsp_time_out_p;

    wire [3:0] h_im_num;
    wire [3:0] v_im_num;
    wire write_cmd, qbc_rst;
    wire qc_ce;
    wire qc_stop;
    wire cmd_wea;
    wire cnt_stop;
    wire [7:0] cmd_ram_buf_do;
    wire fpga2_ad1x;
    wire im_num_ok;
    wire all_im_start_en, one_im_start_en;
    // wire im00_start_en, im01_start_en, im10_start_en, im11_start_en;
    wire im_start_en;
    wire rsp_rd_we;
    wire rsp_ram_we;
    wire [6:0] rsp_ram_wa;
    wire qd_stop;
    // wire no_im_rd_sel;
    wire [7:0] rsp_ram_doa;
    wire [6:0] rsp_ram_ra;
    wire [7:0] ack;
    wire [15:0] rsp_byte_mem_rdata;
    wire [47:0] sel_rsp_data;
    wire [47:0] rsp_data_a;
    wire [79:0] emb_m5_rsp_data_a;
    wire im_busy_done;
    wire no_im_start;
    wire qd_done, qc_done;
    wire copy_correct_done;
    wire rsp_start_dl;
    wire exe_tim_endp;
    wire rsp_tx_busy;
    wire [7:0] raw_brt;
    wire [6:0] dipsw_brt;
    wire fpga1_reg_wr, fpga2_reg_wr;
    wire fpga1_reg_wr_npc, fpga2_reg_wr_npc, fpga_reg_wr_npc;
    wire fpga1_reg_wep, fpga2_reg_wep;
    wire [24:0] ctrl_reg_wad_a;
    wire [7:0] fpga_reg_wdata;
    wire fpga_reg_wad_h012, fpga_reg_wad_h014;
    wire fpga_reg_wad_h00b, fpga_reg_wad_h010, fpga_reg_wad_h011;
    wire fpga1_reg_re, fpga2_reg_re;
    wire fpga1_reg_re_npc, fpga2_reg_re_npc, fpga_reg_re_npc;
    wire [24:0] ctrl_reg_rad_a;
    wire cmd_m4_bank_ce;
    wire com_rcnt_ce;
    wire [7:0] com_buffer_din;
    wire [7:0] com_buffer_wa;
    wire com_buffer_we;
    wire [7:0] com_buffer_ra;
    wire [7:0] com_buffer_do;
    wire panel_correct_no_im;
    wire exe_req_en;


// パラメータ設定

 // P0 : PVII-4(4x4IM)
    parameter  P0_H_IM_NUM = 4'd4;
    parameter  P0_V_IM_NUM = 4'd4;

 // P1 : PVII-6
    parameter  P1_H_IM_NUM = 4'd4;
    parameter  P1_V_IM_NUM = 4'd4;

 // P2 : ImpactII-10
    parameter  P2_H_IM_NUM = 4'd2;
    parameter  P2_V_IM_NUM = 4'd6;

 // P3 : ImpactII-12
    parameter  P3_H_IM_NUM = 4'd4;
    parameter  P3_V_IM_NUM = 4'd6;

 // P4 : ImpactII-16
    parameter  P4_H_IM_NUM = 4'd4;
    parameter  P4_V_IM_NUM = 4'd6;

 // P5 : Pv16i/o-oval
    parameter  P5_H_IM_NUM = 4'd3;
    parameter  P5_V_IM_NUM = 4'd4;

 // P6 : Bv16i/o-oval
    parameter  P6_H_IM_NUM = 4'd4;
    parameter  P6_V_IM_NUM = 4'd3;

 // P7 : Pv20i/o-oval
    parameter  P7_H_IM_NUM = 4'd6;
    parameter  P7_V_IM_NUM = 4'd4;

 // P8 : Pv26i/o-oval
    parameter  P8_H_IM_NUM = 4'd6;
    parameter  P8_V_IM_NUM = 4'd4;

 // P9 : Fv20T
    parameter  P9_H_IM_NUM = 4'd4;
    parameter  P9_V_IM_NUM = 4'd3;

 // P10 : Pv10
    parameter  P10_H_IM_NUM = 4'd4;
    parameter  P10_V_IM_NUM = 4'd4;


 // parameter select

    // h_im_num  4bit  水平IM数
    function [3:0] h_im_num_sel;
    input [3:0] sel;
      case(sel)
        4'h0: h_im_num_sel = P0_H_IM_NUM;
        4'h1: h_im_num_sel = P1_H_IM_NUM;
        4'h2: h_im_num_sel = P2_H_IM_NUM;
        4'h3: h_im_num_sel = P3_H_IM_NUM;
        4'h4: h_im_num_sel = P4_H_IM_NUM;
        4'h5: h_im_num_sel = P5_H_IM_NUM;
        4'h6: h_im_num_sel = P6_H_IM_NUM;
        4'h7: h_im_num_sel = P7_H_IM_NUM;
        4'h8: h_im_num_sel = P8_H_IM_NUM;
        4'h9: h_im_num_sel = P9_H_IM_NUM;
        4'ha: h_im_num_sel = P10_H_IM_NUM;
        default: h_im_num_sel = P0_H_IM_NUM;
      endcase
    endfunction

    assign h_im_num = h_im_num_sel(panel_sel);

    // v_im_num  4bit  水平IM数
    function [3:0] v_im_num_sel;
    input [3:0] sel;
      case(sel)
        4'h0: v_im_num_sel = P0_V_IM_NUM;
        4'h1: v_im_num_sel = P1_V_IM_NUM;
        4'h2: v_im_num_sel = P2_V_IM_NUM;
        4'h3: v_im_num_sel = P3_V_IM_NUM;
        4'h4: v_im_num_sel = P4_V_IM_NUM;
        4'h5: v_im_num_sel = P5_V_IM_NUM;
        4'h6: v_im_num_sel = P6_V_IM_NUM;
        4'h7: v_im_num_sel = P7_V_IM_NUM;
        4'h8: v_im_num_sel = P8_V_IM_NUM;
        4'h9: v_im_num_sel = P9_V_IM_NUM;
        4'ha: v_im_num_sel = P10_V_IM_NUM;
        default: v_im_num_sel = P0_V_IM_NUM;
      endcase
    endfunction

    assign v_im_num = v_im_num_sel(panel_sel);


 // fpga2_ad1x 作成

    // fpga2_ad1x
    assign fpga2_ad1x = com_buf_ctrl ? ({exe_p2[2:0], exe_p5[7:6]} == {3'h2, 2'h2}) :
                                       ({exe_p5[2:0], exe_p4[7:6]} == {3'h2, 2'h2});


 // im_ope_sel, ram_ope_sel 作成

    // Convert from ASCII code to Binary value
    function [3:0] ascii_dec;
    input [7:0] ascii;
      case(ascii)
        8'h30  : ascii_dec = 4'h0;
        8'h31  : ascii_dec = 4'h1;
        8'h32  : ascii_dec = 4'h2;
        8'h33  : ascii_dec = 4'h3;
        8'h34  : ascii_dec = 4'h4;
        8'h35  : ascii_dec = 4'h5;
        8'h36  : ascii_dec = 4'h6;
        8'h37  : ascii_dec = 4'h7;
        8'h38  : ascii_dec = 4'h8;
        8'h39  : ascii_dec = 4'h9;
        8'h41  : ascii_dec = 4'ha;
        8'h61  : ascii_dec = 4'ha;
        8'h42  : ascii_dec = 4'hb;
        8'h62  : ascii_dec = 4'hb;
        8'h43  : ascii_dec = 4'hc;
        8'h63  : ascii_dec = 4'hc;
        8'h44  : ascii_dec = 4'hd;
        8'h64  : ascii_dec = 4'hd;
        8'h45  : ascii_dec = 4'he;
        8'h65  : ascii_dec = 4'he;
        8'h46  : ascii_dec = 4'hf;
        8'h66  : ascii_dec = 4'hf;
        default: ascii_dec = 4'h0;
      endcase
    endfunction

    // dec_p5 -- dec_p0  4bit
    always @(posedge clk) begin
      dec_p5 <= ascii_dec(exe_p5);
      dec_p4 <= ascii_dec(exe_p4);
      dec_p3 <= ascii_dec(exe_p3);
      dec_p2 <= ascii_dec(exe_p2);
      dec_p1 <= ascii_dec(exe_p1);
      dec_p0 <= ascii_dec(exe_p0);
    end

    // im_ope_sel  4bit,   ram_ope_sel  3bit
    always @(posedge clk) begin
      casex({exe_cmd_num, dec_p1, dec_p0, exe_p0, rx_im_download_exe_tim})
                                                      // {dec_p1, dec_p0} for Copy mode select
                                                      // exe_p0 for COM Buffer control mode select
                                                      // rx_im_download_exe_tim = 1 : IM to RAM Bank0&1 Copy
        {6'h04, 4'hx, 4'hx, 8'hxx, 1'b0},
        {6'h11, 4'hx, 4'hx, 8'h50, 1'b0}: begin    // Block Memory Write 
          im_ope_sel  <= 4'h0;
          ram_ope_sel <= 3'h3;
        end
        {6'h05, 4'hx, 4'hx, 8'hxx, 1'b0}: begin    // Byte Memory Write 
          im_ope_sel  <= 4'h0;
          ram_ope_sel <= 3'h1;
        end
        {6'h0a, 4'h0, 4'h6, 8'hxx, 1'b0}: begin    // RAM to IM Bank0 Copy 
          im_ope_sel  <= 4'h8;
          ram_ope_sel <= 3'h0;
        end
        {6'h0a, 4'h0, 4'h7, 8'hxx, 1'b0}: begin    // RAM to IM Bank1 Copy 
          im_ope_sel  <= 4'h9;
          ram_ope_sel <= 3'h0;
        end
        {6'h0a, 4'h0, 4'h8, 8'hxx, 1'b0}: begin    // RAM to IM Bank0&1 Copy 
          im_ope_sel  <= 4'ha;
          ram_ope_sel <= 3'h0;
        end
        {6'h0a, 4'h0, 4'h9, 8'hxx, 1'b0}: begin    // IM to RAM Bank0 Copy 
          im_ope_sel  <= 4'hb;
          ram_ope_sel <= 3'h0;
        end
        {6'h0a, 4'h0, 4'ha, 8'hxx, 1'b0}: begin    // IM to RAM Bank1 Copy 
          im_ope_sel  <= 4'hc;
          ram_ope_sel <= 3'h0;
        end
        {6'h0a, 4'h0, 4'hb, 8'hxx, 1'b0},
        {6'h0a, 4'h1, 4'h0, 8'hxx, 1'b0},
        {6'hxx, 4'hx, 4'hx, 8'hxx, 1'b1}: begin    // IM to RAM Bank0&1 Copy 
          im_ope_sel  <= 4'hd;
          ram_ope_sel <= 3'h0;
        end
        {6'h0a, 4'h0, 4'hc, 8'hxx, 1'b0}: begin    // RAM Bank1 to Bank0 Copy 
          im_ope_sel  <= 4'h0;
          ram_ope_sel <= 3'h6;
        end
        {6'h0a, 4'h0, 4'hd, 8'hxx, 1'b0}: begin    // RAM Bank0 to Bank1 Copy 
          im_ope_sel  <= 4'h0;
          ram_ope_sel <= 3'h5;
        end
        {6'h0d, 4'hx, 4'hx, 8'hxx, 1'b0}: begin    // M4 EEPROM Byte Write 
          im_ope_sel  <= 4'h1;
          ram_ope_sel <= 3'h0;
        end
        {6'h0e, 4'hx, 4'hx, 8'hxx, 1'b0},
        {6'h13, 4'hx, 4'hx, 8'h52, 1'b0}: begin    // M4 EEPROM Page Write 
          im_ope_sel  <= 4'h3;
          ram_ope_sel <= 3'h0;
        end
        {6'h23, 4'hx, 4'hx, 8'hxx, 1'b0},
        {6'h11, 4'hx, 4'hx, 8'h70, 1'b0}: begin    // Block Memory Read 
          im_ope_sel  <= 4'h0;
          ram_ope_sel <= 3'h4;
        end
        {6'h24, 4'hx, 4'hx, 8'hxx, 1'b0}: begin    // Byte Memory Read 
          im_ope_sel  <= 4'h0;
          ram_ope_sel <= 3'h2;
        end
        {6'h28, 4'hx, 4'hx, 8'hxx, 1'b0}: begin    // M4 EEPROM Byte Read
          im_ope_sel  <= 4'h2;
          ram_ope_sel <= 3'h0;
        end
        {6'h29, 4'hx, 4'hx, 8'hxx, 1'b0},
        {6'h13, 4'hx, 4'hx, 8'h72, 1'b0}: begin    // M4 EEPROM Page Read
          im_ope_sel  <= 4'h4;
          ram_ope_sel <= 3'h0;
        end
        {6'h15, 4'hx, 4'h0, 8'hxx, 1'b0},
        {6'h15, 4'hx, 4'h1, 8'hxx, 1'b0},
        {6'h15, 4'hx, 4'h2, 8'hxx, 1'b0}: begin    // Panel Correction
          im_ope_sel  <= 4'h0;
          ram_ope_sel <= 3'h7;
        end

        default: begin
          im_ope_sel  <= 4'h0;
          ram_ope_sel <= 3'h0;
        end
      endcase
    end

    // ram_byte_write -- panel_correct
    always @(posedge clk) begin
      ram_byte_write    <= (ram_ope_sel == 3'h1);
      ram_byte_read     <= (ram_ope_sel == 3'h2);
      ram_block_write   <= (ram_ope_sel == 3'h3);
      ram_block_read    <= (ram_ope_sel == 3'h4);
      ram_bank0to1_copy <= (ram_ope_sel == 3'h5);
      ram_bank1to0_copy <= (ram_ope_sel == 3'h6);
      panel_correct     <= (ram_ope_sel == 3'h7);
    end

    // im_byte_write -- im1_bank0_1_read
    always @(posedge clk) begin
      im_byte_write    <= (im_ope_sel == 4'h1);
      im_byte_read     <= (im_ope_sel == 4'h2);
      im_page_write    <= (im_ope_sel == 4'h3);
      im_page_read     <= (im_ope_sel == 4'h4);
      im_bank0_write   <= (im_ope_sel == 4'h8);
      im_bank1_write   <= (im_ope_sel == 4'h9);
      im_bank0_1_write <= (im_ope_sel == 4'ha);
      im_bank0_read    <= (im_ope_sel == 4'hb);
      im_bank1_read    <= (im_ope_sel == 4'hc);
      im_bank0_1_read  <= (im_ope_sel == 4'hd) & (({dec_p1, dec_p0} == {4'h0, 4'hb}) | rx_im_download_exe_tim);
      im1_bank0_1_read <= (im_ope_sel == 4'hd) & ({dec_p1, dec_p0} == {4'h1, 4'h0}) & ~rx_im_download_exe_tim;
    end

    // one_im_to_ram_copy
    assign one_im_to_ram_copy = im1_bank0_1_read;

 // RAM / IM write control

    // com_buf_ctrl, com_im_ctrl
    always @(posedge clk) begin
      com_buf_ctrl <= (exe_cmd_num == 6'h11);
      com_im_ctrl  <= (exe_cmd_num == 6'h13);
    end

    // ram_cmd_ad  22bit,   im_cmd_ad  16bit
    always @(posedge clk) begin
      ram_cmd_ad <= com_buf_ctrl ? {exe_p5[5:0], exe_p4, exe_p3} : {exe_p4[5:0], exe_p3, exe_p2};
      im_cmd_ad  <= {exe_p3, exe_p2};
    end

    // exe_req1d -- exe_req11d
    always @(posedge clk) begin
      exe_req1d <= exe_req_a;
      exe_req2d <= exe_req1d;
      exe_req3d <= exe_req2d;
      exe_req4d <= exe_req3d;
      exe_req5d <= exe_req4d;
      exe_req6d <= exe_req5d;
      exe_req7d <= exe_req6d;
      exe_req8d <= exe_req7d;
      exe_req9d <= exe_req8d;
      exe_req10d <= exe_req9d;
      exe_req11d <= exe_req10d;
    end

    // startp, exe_latchp
    always @(posedge clk) begin
      startp <= (rcv_ok | rx_im_download_exe_tim) & (exe_req8d | exe_req9d | exe_req10d | exe_req11d);
      exe_latchp  <= (rcv_ok | rx_im_download_exe_tim) & exe_req11d;
    end


    // write_cmd
    assign write_cmd = ram_byte_write | ram_block_write | im_byte_write | im_page_write | panel_correct;

    // write_cmd_a
    always @(posedge clk) begin
      if(rst)
        write_cmd_a <= 1'b0;
      else if(startp)
        write_cmd_a <= write_cmd;
    end

    // qbc_rst
    assign qbc_rst = ~write_cmd | ~write_cmd_a;

    // qb  9bitカウンタ
    always @(posedge clk) begin
      if(startp | qbc_rst | qc_ce)
        qb <= 9'd1;
      else if(~cnt_stop)
        qb <= qb + 1;
    end

    // qc_ce
    assign qc_ce = (ram_byte_write | ram_block_write) ? qb[8] : qb[3];

    // cmd_wea
    assign cmd_wea = qb[2] & (qb < 9'd8);

    // qc  8bitカウンタ
    always @(posedge clk) begin
      if(startp | qbc_rst)
        qc <= 0;
      else if(qc_ce)
        qc <= qc + 1;
    end

    // qc_stop
    function qc_stop_sel;
    input [1:0] sel;
      case(sel)
        2'h0: qc_stop_sel = qc[0];
        2'h1: qc_stop_sel = qc[7];
        2'h2: qc_stop_sel = qc[7];
        2'h3: qc_stop_sel = qc[7];
      endcase
    endfunction

    assign qc_stop = qc_stop_sel({(ram_block_write | panel_correct), im_page_write});

    // cnt_stop_a
    always @(posedge clk) begin
      if(startp)
        cnt_stop_a <= 1'b0;
      else if(~startp & qc_stop)
        cnt_stop_a <= 1'b1;
    end

    // cnt_stop
    assign cnt_stop = qc_stop | cnt_stop_a;

    // cmd_ram_ra  7bit
    assign cmd_ram_ra = qc[6:0];

    // cmd_ram_buf_do  8bit
    assign cmd_ram_buf_do = (com_buf_ctrl | com_im_ctrl | panel_correct) ? com_buf_do : cmd_ram_do;

    // ram_cmd_rd  8bit,   im_cmd_rd  8bit
    always @(posedge clk) begin
      ram_cmd_rd <= ram_byte_write ? exe_p0 : cmd_ram_buf_do;
      im_cmd_rd  <= im_byte_write ? {dec_p1, dec_p0} : cmd_ram_buf_do;
    end


    // ram_cmd_rd_we
    always @(posedge clk) begin
      ram_cmd_rd_we <= cmd_wea & (ram_byte_write | ram_block_write) & fpga2_ad1x;
    end

    // coeff_offset_we
    always @(posedge clk) begin
      coeff_offset_we <= cmd_wea & panel_correct;
    end

    // im_cmd_rd_rstw
    always @(posedge clk) begin
      im_cmd_rd_rstw <= startp & (im_byte_write | im_page_write);
    end

    // dec_p5_d0, dec_p5_d1, dec_p5_d2, dec_p5_d3
    // dec_p4_lt_v_im_num, dec_p5_lt_h_im_num
    always @(posedge clk) begin
      // dec_p5_d0 <= (dec_p5 == 4'h0);   // IM H address = 0
      // dec_p5_d1 <= (dec_p5 == 4'h1);   // IM H address = 1
      // dec_p5_d2 <= (dec_p5 == 4'h2);   // IM H address = 2
      // dec_p5_d3 <= (dec_p5 == 4'h3);   // IM H address = 3
      dec_p4_lt_v_im_num <= (dec_p4 < v_im_num);  // IM V address < v_im_num
      dec_p5_lt_h_im_num <= (dec_p5 < h_im_num);  // IM H address < h_im_num
    end

    // im_num_ok
    assign im_num_ok = dec_p4_lt_v_im_num & dec_p5_lt_h_im_num;

    // im_vadrs, im_hadrs  4bit
    always @(posedge clk) begin
      im_vadrs <= dec_p4;
      im_hadrs <= dec_p5;
    end

    // im00_cmd_rd_we, im01_cmd_rd_we, im10_cmd_rd_we, im11_cmd_rd_we
    // im_cmd_rd_we
    always @(posedge clk) begin
    //   im00_cmd_rd_we <= cmd_wea & (im_byte_write | im_page_write) & dec_p4_lt_v_im_num & dec_p5_d0;
    //   im01_cmd_rd_we <= cmd_wea & (im_byte_write | im_page_write) & dec_p4_lt_v_im_num & dec_p5_d1;
    //   im10_cmd_rd_we <= cmd_wea & (im_byte_write | im_page_write) & dec_p4_lt_v_im_num & dec_p5_d2;
    //   im11_cmd_rd_we <= cmd_wea & (im_byte_write | im_page_write) & dec_p4_lt_v_im_num & dec_p5_d3;
      im_cmd_rd_we <= cmd_wea & (im_byte_write | im_page_write) & im_num_ok;
    end


 // startp 出力

    // ram_start_en, ram_cmd_startp
    always @(posedge clk) begin
      ram_start_en   <= ((ram_byte_write | ram_block_write) & fpga2_ad1x) |
                          ram_byte_read | ram_block_read | ram_bank0to1_copy | ram_bank1to0_copy;
      ram_cmd_startp <= startp & ram_start_en;
    end

    // panel_correct_startp
    always @(posedge clk) begin
      panel_correct_startp <= startp & panel_correct;
    end

    // all_im_start_en, one_im_start_en
    assign all_im_start_en = im_bank0_write | im_bank1_write | im_bank0_1_write |
                             im_bank0_read | im_bank1_read | im_bank0_1_read;

    assign one_im_start_en = im_byte_write | im_byte_read | im_page_write | im_page_read |
                             im1_bank0_1_read;

    // im00_start_en, im01_start_en, im10_start_en, im11_start_en
    // assign im00_start_en = all_im_start_en | (one_im_start_en & dec_p4_lt_v_im_num & dec_p5_d0);
    // assign im01_start_en = all_im_start_en | (one_im_start_en & dec_p4_lt_v_im_num & dec_p5_d1);
    // assign im10_start_en = all_im_start_en | (one_im_start_en & dec_p4_lt_v_im_num & dec_p5_d2);
    // assign im11_start_en = all_im_start_en | (one_im_start_en & dec_p4_lt_v_im_num & dec_p5_d3);

    // im_start_en
    assign im_start_en = all_im_start_en | (one_im_start_en & im_num_ok);

    // im00_cmd_startp, im01_cmd_startp, im10_cmd_startp, im11_cmd_startp
    // always @(posedge clk) begin
    //   im00_cmd_startp <= startp & im00_start_en;
    //   im01_cmd_startp <= startp & im01_start_en;
    //   im10_cmd_startp <= startp & im10_start_en;
    //   im11_cmd_startp <= startp & im11_start_en;
    // end

    // im_cmd_startp
    always @(posedge clk) begin
      im_cmd_startp <= startp & im_start_en;
    end

    // im00_rd_sel, im01_rd_sel, im10_rd_sel, im11_rd_sel
    // always @(posedge clk) begin
    //   im00_rd_sel <= (im_byte_read | im_page_read) & dec_p4_lt_v_im_num & dec_p5_d0;
    //   im01_rd_sel <= (im_byte_read | im_page_read) & dec_p4_lt_v_im_num & dec_p5_d1;
    //   im10_rd_sel <= (im_byte_read | im_page_read) & dec_p4_lt_v_im_num & dec_p5_d2;
    //   im11_rd_sel <= (im_byte_read | im_page_read) & dec_p4_lt_v_im_num & dec_p5_d3;
    // end


 // Response data RAM control

    // rsp_ram_din  8bit,   rsp_rd_rstw
    always @(posedge clk) begin
      rsp_ram_din <= (im_byte_read | im_page_read) ? rsp_im_rd : rsp_ram_rd;
      rsp_rd_rstw <= (im_byte_read | im_page_read) ? rsp_im_rd_rstw : rsp_ram_rd_rstw;
    end

    // rsp_rd_we
    assign rsp_rd_we = (im_byte_read | im_page_read) ? rsp_im_rd_we : rsp_ram_rd_we;

    // rsp_rd_we1d, rsp_rd_we2d
    always @(posedge clk) begin
      rsp_rd_we1d <= rsp_rd_we;
      rsp_rd_we2d <= rsp_rd_we1d;
    end

    // qd  8bitカウンタ
    always @(posedge clk) begin
      if(rsp_rd_rstw)
        qd <= 0;
      else if(rsp_ram_we)
        qd <= qd + 1;
    end

    // rsp_ram_wa  7bit
    assign rsp_ram_wa = qd[6:0];

    // qd_stop
    assign qd_stop = (ram_block_read | im_page_read) ? qd[7] : qd[0];

    // rsp_ram_we
    assign rsp_ram_we = (rsp_rd_we1d & ~rsp_rd_we2d) & ~qd_stop;

    // qe  8bitカウンタ
    always @(posedge clk) begin
      if(~rsp_ram_re)
        qe <= 0;
      else if(rsp_ram_re & tx_done & (ram_block_read | im_page_read) & ~qe[7])
        qe <= qe + 1;
    end

    // rsp_ram_ra  7bit
    assign rsp_ram_ra = qe[6:0];

    // 8bit x 128 ram module
    uart_ram_mpc  rsp_ram_mpc(
      .clk    (clk),
      .d      (rsp_ram_din),
      .a      (rsp_ram_wa),
      .we     (rsp_ram_we),
      .dpra   (rsp_ram_ra),
      .dpo    (rsp_ram_doa)
    );

    // no_im_rd_sel
    // assign no_im_rd_sel = ~im00_rd_sel & ~im01_rd_sel & ~im10_rd_sel & ~im11_rd_sel;

    // im_rd_err
    // always @(posedge clk) begin
    //   im_rd_err <= (im_byte_read | im_page_read) &
    //                ((im00_err_det & im00_rd_sel) | (im01_err_det & im01_rd_sel) |
    //                 (im10_err_det & im10_rd_sel) | (im11_err_det & im11_rd_sel) | no_im_rd_sel);
    // end

    always @(posedge clk) begin
      im_rd_err <= (im_byte_read | im_page_read) & (im_err_det | ~im_num_ok);
    end

    // ram_na_rd
    always @(posedge clk) begin
      ram_na_rd <= (ram_byte_read | (ram_block_read & ~com_buf_ctrl)) & ~fpga2_ad1x;
    end

    // rsp_ram_do
    always @(posedge clk) begin
      case ({im_rd_err, ram_na_rd})
        2'h0: rsp_ram_do <= rsp_ram_doa;
        2'h1: rsp_ram_do <= ctrl_reg_rd;
        2'h2: rsp_ram_do <= 8'h00;
        2'h3: rsp_ram_do <= 8'h00;
      endcase
    end


 // Response data convert to ASCII Code

    // Brightness range conversion for response  (0-100) => (0-95)
    // rsp_brt  7bit
    always @(posedge clk) begin
      if(brightness > 7'h64)            // >100
        rsp_brt <= 7'h5f;               //  95
      else if(brightness > 7'h5a)       // >90
        rsp_brt <= brightness - 7'h05;  //  brightness - 5
      else if(brightness > 7'h46)       // >70
        rsp_brt <= brightness - 7'h04;  //  brightness - 4
      else if(brightness > 7'h32)       // >50
        rsp_brt <= brightness - 7'h03;  //  brightness - 3
      else if(brightness > 7'h1e)       // >30
        rsp_brt <= brightness - 7'h02;  //  brightness - 2
      else if(brightness > 7'h0a)       // >10
        rsp_brt <= brightness - 7'h01;  //  brightness - 1
      else
        rsp_brt <= brightness;
    end

    // Convert from Binary value to ASCII code 
    function [7:0] ascii_enc;
    input [3:0] value;
      case(value)
        4'h0   : ascii_enc = 8'h30;
        4'h1   : ascii_enc = 8'h31;
        4'h2   : ascii_enc = 8'h32;
        4'h3   : ascii_enc = 8'h33;
        4'h4   : ascii_enc = 8'h34;
        4'h5   : ascii_enc = 8'h35;
        4'h6   : ascii_enc = 8'h36;
        4'h7   : ascii_enc = 8'h37;
        4'h8   : ascii_enc = 8'h38;
        4'h9   : ascii_enc = 8'h39;
        4'ha   : ascii_enc = 8'h41;
        4'hb   : ascii_enc = 8'h42;
        4'hc   : ascii_enc = 8'h43;
        4'hd   : ascii_enc = 8'h44;
        4'he   : ascii_enc = 8'h45;
        4'hf   : ascii_enc = 8'h46;
        default: ascii_enc = 8'h30;
      endcase
    endfunction

    // enc_ram_do_msb -- enc_brt_lsb  8bit
    always @(posedge clk) begin
      enc_ram_do_msb <= ascii_enc(rsp_ram_do[7:4]);
      enc_ram_do_lsb <= ascii_enc(rsp_ram_do[3:0]);
      enc_m4_bank    <= ascii_enc({2'h0, (m4_on & m4_bank1), (m4_on & ~m4_bank1)});
      enc_ct_red     <= ascii_enc(ct_red);
      enc_ct_green   <= ascii_enc(ct_green);
      enc_ct_blue    <= ascii_enc(ct_blue);
      enc_gamma      <= ascii_enc({1'b0, gamma});
      enc_test_msb   <= ascii_enc(test_pat[7:4]);
      enc_test_lsb   <= ascii_enc(test_pat[3:0]);
      enc_ver_msb    <= ascii_enc(fpga_ver[7:4]);
      enc_ver_lsb    <= ascii_enc(fpga_ver[3:0]);
      enc_brt_msb    <= ascii_enc({1'b0, rsp_brt[6:4]});
      enc_brt_lsb    <= ascii_enc(rsp_brt[3:0]);
      enc_panel_conf_msb   <= ascii_enc(cmd_panel_conf[7:4]);
      enc_panel_conf_lsb   <= ascii_enc(cmd_panel_conf[3:0]);
    end


 // Response data select

    // ack  8bit
    assign ack = rcv_ok ? 8'h06 : 8'h15;

    // rsp_byte_mem_rdata  16bit
    assign rsp_byte_mem_rdata = fpga_reg_re_npc ? {enc_ram_do_msb, enc_ram_do_lsb} :
                                                  {8'h30, rsp_ram_do};

    // sel_rsp_data  48bit 
    function [47:0] sel_rsp_data_sel;
    input [4:0] sel;
      case(sel)
        5'h00  : sel_rsp_data_sel = {{5{8'h30}}, enc_m4_bank};  // 8'h30 : ASCII Code "0"
        5'h01  : sel_rsp_data_sel = {8'h30, enc_ct_red, 8'h30, enc_ct_green, 8'h30, enc_ct_blue};
        5'h02  : sel_rsp_data_sel = {{5{8'h30}}, enc_gamma};
        5'h03  : sel_rsp_data_sel = {exe_p5, exe_p4, exe_p3, exe_p2, rsp_ram_do, rsp_ram_do};
        5'h04  : sel_rsp_data_sel = {exe_p5, exe_p4, exe_p3, exe_p2, rsp_byte_mem_rdata};
        5'h05  : sel_rsp_data_sel = {{4{8'h30}}, enc_test_msb, enc_test_lsb};
        5'h06  : sel_rsp_data_sel = {{3{8'h30}}, enc_ver_msb, enc_ver_lsb, 8'h30};
        5'h07  : sel_rsp_data_sel = {enc_brt_msb, enc_brt_lsb, {4{8'h30}}};
        5'h08  : sel_rsp_data_sel = {exe_p5, exe_p4, {2{8'h30}}, enc_ram_do_msb, enc_ram_do_lsb};
        5'h09  : sel_rsp_data_sel = {exe_p5, exe_p4, exe_p3, exe_p2, rsp_ram_do, rsp_ram_do};
        5'h0a  : sel_rsp_data_sel = {6{8'h30}};
        5'h0b  : sel_rsp_data_sel = {3'h0, cmd_loss_50hz, ~loss_brt100_sel, color_loss, {5{8'h30}}};
        5'h0c  : sel_rsp_data_sel = {exe_p5, exe_p4, {2{8'h30}}, com_buf_do, com_buf_do};
        5'h0d  : sel_rsp_data_sel = {exe_p5, exe_p4, {2{8'h30}}, com_buf_do, com_buf_do};
        5'h0e  : sel_rsp_data_sel = {{4{8'h30}}, enc_panel_conf_msb, enc_panel_conf_lsb};
        5'h0f  : sel_rsp_data_sel = {6{8'h30}};
        5'h10  : sel_rsp_data_sel = {6{8'h30}};
        5'h11  : sel_rsp_data_sel = {6{8'h30}};
        5'h12  : sel_rsp_data_sel = {6{8'h30}};
        5'h13  : sel_rsp_data_sel = {6{8'h30}};
        5'h14  : sel_rsp_data_sel = {6{8'h30}};
        5'h15  : sel_rsp_data_sel = {6{8'h30}};
        5'h16  : sel_rsp_data_sel = {6{8'h30}};
        5'h17  : sel_rsp_data_sel = {6{8'h30}};
        5'h18  : sel_rsp_data_sel = {6{8'h30}};
        5'h19  : sel_rsp_data_sel = {6{8'h30}};
        5'h1a  : sel_rsp_data_sel = {6{8'h30}};
        5'h1b  : sel_rsp_data_sel = {6{8'h30}};
        5'h1c  : sel_rsp_data_sel = {6{8'h30}};
        5'h1d  : sel_rsp_data_sel = {6{8'h30}};
        5'h1e  : sel_rsp_data_sel = {6{8'h30}};
        5'h1f  : sel_rsp_data_sel = {6{8'h30}};
        default: sel_rsp_data_sel = {6{8'h30}};
      endcase
    endfunction

    assign sel_rsp_data = sel_rsp_data_sel(exe_cmd_num[4:0]);

    // rsp_data_a  48bit
    assign rsp_data_a = (exe_cmd_num[5] & rcv_ok) ? sel_rsp_data : {ack, {5{8'h30}}};

    // emb_m5_rsp_data_a  80bit
    assign emb_m5_rsp_data_a = emb_cmd_rcv_ok ? emb_rsp_data :
                               m5_cmd_rcv_ok ? m5_rsp_data :
                               {32'd0, 8'h15, {5{8'h30}}};  // 8'h15 : NAK 

    // rsp_data  80bit
    always @(posedge clk) begin
      rsp_data <= (emb_cmd | m5_cmd) ? emb_m5_rsp_data_a : {32'd0, rsp_data_a};
    end


 // rsp_req   output timing select

    // im_busy1, im_busy2
    always @(posedge clk) begin
      // im_busy1 <= (im00_busy & im00_start_en) | (im01_busy & im01_start_en) |
      //             (im10_busy & im10_start_en) | (im11_busy & im11_start_en);
      im_busy1 <= im_busy & im_start_en;
      im_busy2 <= im_busy1;
    end

    // im_busy_done
    assign im_busy_done = ~im_busy1 & im_busy2;

    // no_im_start
    // assign no_im_start = (~im00_start_en & ~im01_start_en & ~im10_start_en & ~im11_start_en) &
    //                      one_im_start_en;

    assign no_im_start = ~im_start_en & one_im_start_en;

    // qd_stop1, qd_stop2
    always @(posedge clk) begin
      qd_stop1 <= qd_stop;
      qd_stop2 <= qd_stop1;
    end

    // qd_done
    assign qd_done = qd_stop1 & ~qd_stop2;

    // qc_stop1, qc_stop2
    always @(posedge clk) begin
      qc_stop1 <= qc_stop;
      qc_stop2 <= qc_stop1;
    end

    // qc_done
    assign qc_done = qc_stop1 & ~qc_stop2;

    // copy_correct_busy1, copy_correct_busy2
    always @(posedge clk) begin
      // copy_correct_busy1 <= (im00_copy_correct_busy | im01_copy_correct_busy |
      //                        im10_copy_correct_busy | im11_copy_correct_busy);
      copy_correct_busy1 <= im_copy_correct_busy;
      copy_correct_busy2 <= copy_correct_busy1;
    end

    // copy_correct_done
    assign copy_correct_done = ~copy_correct_busy1 & copy_correct_busy2;

    // rsp_start
    always @(posedge clk) begin
      if(rst)
        rsp_start <= 1'b0;
      else if(emb_cmd) begin
        if(~emb_cmd_rcv_ok)
          rsp_start <= exe_req11d;
        else
          rsp_start <= emb_rsp_req;
      end
      else if(m5_cmd) begin
        if(~m5_cmd_rcv_ok)
          rsp_start <= exe_req11d;
        else
          rsp_start <= m5_rsp_req;
      end
      else if(rx_im_download_exe_tim)
        rsp_start <= im_busy_done;
      else if(~rcv_ok | no_im_start | panel_correct_no_im)
        rsp_start <= exe_req11d;
      else if(all_im_start_en | one_im_start_en)
        rsp_start <= im_busy_done;
      else if(ram_byte_write | ram_block_write)
        rsp_start <= qc_done;
      else if(ram_byte_read | ram_block_read)
        rsp_start <= qd_done;
      else if(ram_bank0to1_copy | ram_bank1to0_copy | panel_correct)
        rsp_start <= copy_correct_done;
      else
        rsp_start <= exe_req11d;
    end

    // qrsp_st  7bitカウンタ
    always @(posedge clk) begin
      if(rst)
        qrsp_st <= 0;
      else if(rsp_start)
        qrsp_st <= 7'h40;
      else if(qrsp_st[6])
        qrsp_st <= qrsp_st + 1;
    end

    // qrsp_st_b6d1
    always @(posedge clk) begin
      qrsp_st_b6d1 <= qrsp_st[6];
    end

    // rsp_start_dl
    assign rsp_start_dl = qrsp_st_b6d1 & ~qrsp_st[6];

    // exe_tim
    always @(posedge clk) begin
      if(rst | rsp_start_dl | rsp_time_out_p)
        exe_tim <= 1'b0;
      else if(exe_req_a)
        exe_tim <= 1'b1;
    end

    // exe_tim1
    always @(posedge clk) begin
      exe_tim1 <= exe_tim;
    end

    // exe_tim_endp
    assign exe_tim_endp = ~exe_tim & exe_tim1;

    // rsp_reqa
    always @(posedge clk) begin
      rsp_reqa <= exe_tim_endp & ~rx_im_download_exe_tim & ~rsp_time_out;
    end

    // rsp_wait
    always @(posedge clk) begin
      if(rst | ~rsp_tx_busy)
        rsp_wait <= 1'b0;
      else if(rsp_reqa & rsp_tx_busy)
        rsp_wait <= 1'b1;
    end

    // rsp_tx_busy1
    always @(posedge clk) begin
      rsp_tx_busy1 <= rsp_tx_busy;
    end

    // rsp_req
    always @(posedge clk) begin
      rsp_req <= (rsp_reqa & ~rsp_tx_busy) | (rsp_wait & (rsp_tx_busy1 & ~rsp_tx_busy));
    end

    // rsp_busy
    always @(posedge clk) begin
      if(rst | rsp_done)
        rsp_busy <= 1'b0;
      else if(rsp_req)
        rsp_busy <= 1'b1;
    end

    // rsp_tx_busy
    assign rsp_tx_busy = rsp_busy | tx_busy;


 // rsp_time_out detect (20秒以上でタイムアウト)

    // ovpx_1d, ovpx_2d, ovp
    always @(posedge clk) begin
      ovpx_1d <= ovpx;
      ovpx_2d <= ovpx_1d;
      ovp     <= ovpx_1d & ~ovpx_2d;
    end

    // qrto  11bitカウンタ
    always @(posedge clk) begin
      if(rst | exe_req_a)
        qrto <= 0;
      else if(exe_tim & ovp & ~rsp_time_out)
        qrto <= qrto + 1;
    end

    // rsp_time_out
    always @(posedge clk) begin
      rsp_time_out <= (qrto >= 11'd1200);  // ovp 60Hz x 20sec = 1200
    end

    // rsp_time_out_1d, rsp_time_out_p
    always @(posedge clk) begin
      rsp_time_out_1d <= rsp_time_out;
      rsp_time_out_p  <= rsp_time_out & ~rsp_time_out_1d;
    end


 // Set Command execute

    // cmd_m4_on, cmd_m4_bank1
    always @(posedge clk) begin
      if(rst) begin
        cmd_m4_on    <= 1'b1;
        cmd_m4_bank1 <= 1'b0;
      end
      else if((exe_cmd_num == 6'h01) & exe_latchp & (dec_p0 == 4'h0)) begin
        cmd_m4_on    <= 1'b0;
        cmd_m4_bank1 <= cmd_m4_bank1;
      end
      else if((exe_cmd_num == 6'h01) & exe_latchp & (dec_p0 == 4'h1)) begin
        cmd_m4_on    <= 1'b1;
        cmd_m4_bank1 <= 1'b0;
      end
      else if((exe_cmd_num == 6'h01) & exe_latchp & (dec_p0 == 4'h2)) begin
        cmd_m4_on    <= 1'b1;
        cmd_m4_bank1 <= 1'b1;
      end
    end

    // cmd_ct_red  4bit
    always @(posedge clk) begin
      if(rst)
        cmd_ct_red <= 4'hf;
      else if((exe_cmd_num == 6'h02) & exe_latchp & (dec_p5 == 4'h0))
        cmd_ct_red <= dec_p4;
    end

    // cmd_ct_green  4bit
    always @(posedge clk) begin
      if(rst)
        cmd_ct_green <= 4'hf;
      else if((exe_cmd_num == 6'h02) & exe_latchp & (dec_p3 == 4'h0))
        cmd_ct_green <= dec_p2;
    end

    // cmd_ct_blue  4bit
    always @(posedge clk) begin
      if(rst)
        cmd_ct_blue <= 4'hf;
      else if((exe_cmd_num == 6'h02) & exe_latchp & (dec_p1 == 4'h0))
        cmd_ct_blue <= dec_p0;
    end

    // cmd_gamma  3bit
    always @(posedge clk) begin
      if(rst)
        cmd_gamma <= 3'h5;
      else if((exe_cmd_num == 6'h03) & exe_latchp & ({dec_p1, dec_p0[3]} == 5'h00))
        cmd_gamma <= dec_p0[2:0];
    end

    // cmd_test_pat  8bit
    always @(posedge clk) begin
      if(rst)
        cmd_test_pat <= 8'h00;
      else if((exe_cmd_num == 6'h06) & exe_latchp)
        cmd_test_pat <= {dec_p1, dec_p0};
    end

    // cmd_reboot
    always @(posedge clk) begin
      if(rst)
        cmd_reboot <= 1'b0;
      else if((exe_cmd_num == 6'h09) & rsp_done)
        cmd_reboot <= 1'b1;
    end

    // cmd_reboot_n
    assign cmd_reboot_n = ~cmd_reboot;

    // cmd_baud_rate  2bit
    always @(posedge clk) begin
      if(rst)
        cmd_baud_rate <= 2'h0;
      else if((exe_cmd_num == 6'h0b) & rsp_done & (dec_p5 == 4'h0) & (dec_p0 < 4'h3))
        cmd_baud_rate <= dec_p0[1:0];
    end

    // cmd_panel_conf  8bit
    always @(posedge clk) begin
      if(rst)
        cmd_panel_conf <= 8'h06;     // Multiplexed 48x36 Panel per IM
      else if((exe_cmd_num == 6'h14) & exe_latchp)
        cmd_panel_conf <= {dec_p1, dec_p0};
    end


    // Brightness range conversion for execute  (0-95) => (0-100)
    // raw_brt  8bit
    assign raw_brt = {dec_p5, dec_p4};

    // exe_brt  7bit
    always @(posedge clk) begin
      if(rst)
        exe_brt <= 7'h64;                 //  100
      else if(raw_brt > 8'h5f)            // >95
        exe_brt <= 7'h64;                 //  100
      else if(raw_brt > 8'h55)            // >85
        exe_brt <= raw_brt[6:0] + 7'h05;  //  raw_brt + 5
      else if(raw_brt > 8'h42)            // >66
        exe_brt <= raw_brt[6:0] + 7'h04;  //  raw_brt + 4
      else if(raw_brt > 8'h2f)            // >47
        exe_brt <= raw_brt[6:0] + 7'h03;  //  raw_brt + 3
      else if(raw_brt > 8'h1c)            // >28
        exe_brt <= raw_brt[6:0] + 7'h02;  //  raw_brt + 2
      else if(raw_brt > 8'h09)            // >9
        exe_brt <= raw_brt[6:0] + 7'h01;  //  raw_brt + 1
      else
        exe_brt <= raw_brt[6:0];
    end

    // dipsw_brt  7bit
    assign dipsw_brt = loss_brt100_sel ? 7'h64 : 7'h19;  // 100% / 25%

    // cmd_brt  7bit,   cmd_brt_sel
    always @(posedge clk) begin
      if(rst) begin
        cmd_brt <= 7'h64;
        cmd_brt_sel <= 1'b0;
      end
      else if((exe_cmd_num == 6'h0c) & exe_latchp) begin
        cmd_brt <= exe_brt;
        cmd_brt_sel <= 1'b1;
      end
    end

    // cmd_brightness  7bit
    always @(posedge clk) begin
      cmd_brightness <= cmd_brt_sel ? cmd_brt : dipsw_brt;
    end

    // pixel1_disp_on, pixel4_disp_on,   pixel1_disp_mode  24bit
    // pixel_disp_r_on, pixel_disp_g_on, pixel_disp_b_on
    always @(posedge clk) begin
      if(rst) begin
        pixel1_disp_on   <= 1'b0;
        pixel4_disp_on   <= 1'b0;
        pixel1_disp_mode <= 24'h000000;
        pixel_disp_r_on  <= 1'b0;
        pixel_disp_g_on  <= 1'b0;
        pixel_disp_b_on  <= 1'b0;
      end
      else if((exe_cmd_num == 6'h07) & exe_latchp & (exe_p3[1:0] != 2'h0)) begin
        pixel1_disp_on   <= 1'b1;
        pixel4_disp_on   <= 1'b0;
        pixel1_disp_mode <= {exe_p5, exe_p4, exe_p3};
        pixel_disp_r_on  <= (dec_p2 == 4'h0) ? 1'b0 : (dec_p2 == 4'h1) ? 1'b1 : pixel_disp_r_on;
        pixel_disp_g_on  <= (dec_p1 == 4'h0) ? 1'b0 : (dec_p1 == 4'h1) ? 1'b1 : pixel_disp_g_on;
        pixel_disp_b_on  <= (dec_p0 == 4'h0) ? 1'b0 : (dec_p0 == 4'h1) ? 1'b1 : pixel_disp_b_on;
      end
      else if((exe_cmd_num == 6'h07) & exe_latchp & (exe_p3[1:0] == 2'h0)) begin
        pixel1_disp_on   <= 1'b0;
        pixel4_disp_on   <= 1'b0;
        pixel1_disp_mode <= {exe_p5, exe_p4, exe_p3};
        pixel_disp_r_on  <= pixel_disp_r_on;
        pixel_disp_g_on  <= pixel_disp_g_on;
        pixel_disp_b_on  <= pixel_disp_b_on;
      end
      else if((exe_cmd_num == 6'h08) & exe_latchp & (exe_p3[1:0] == 2'h1)) begin
        pixel1_disp_on   <= 1'b0;
        pixel4_disp_on   <= 1'b1;
        pixel1_disp_mode <= pixel1_disp_mode;
        pixel_disp_r_on  <= (dec_p2 == 4'h0) ? 1'b0 : (dec_p2 == 4'h1) ? 1'b1 : pixel_disp_r_on;
        pixel_disp_g_on  <= (dec_p1 == 4'h0) ? 1'b0 : (dec_p1 == 4'h1) ? 1'b1 : pixel_disp_g_on;
        pixel_disp_b_on  <= (dec_p0 == 4'h0) ? 1'b0 : (dec_p0 == 4'h1) ? 1'b1 : pixel_disp_b_on;
      end
      else if((exe_cmd_num == 6'h08) & exe_latchp & (exe_p3[1:0] == 2'h0)) begin
        pixel1_disp_on   <= 1'b0;
        pixel4_disp_on   <= 1'b0;
        pixel1_disp_mode <= pixel1_disp_mode;
        pixel_disp_r_on  <= pixel_disp_r_on;
        pixel_disp_g_on  <= pixel_disp_g_on;
        pixel_disp_b_on  <= pixel_disp_b_on;
      end
    end

    // pixel_disp_rgb_on  3bit  for 1pixel & 4pixel 
    assign pixel_disp_rgb_on = {pixel_disp_r_on, pixel_disp_g_on, pixel_disp_b_on};

  // Sync Loss Color

    // cmd_color_loss  3bit, cmd_loss_brt100, cmd_loss_color_sel
    always @(posedge clk) begin
      if(rst) begin
        cmd_color_loss      <= 3'h4;  // Blue
        cmd_loss_brt100     <= 1'b0;  // 25%
        cmd_loss_50hz       <= 1'b0;  // 60Hz
        cmd_loss_color_sel  <= 1'b0;
      end
      else if((exe_cmd_num == 6'h0f) & exe_latchp) begin
        cmd_color_loss      <=  exe_p5[2:0];
        cmd_loss_brt100     <= ~exe_p5[3];
     // cmd_loss_50hz       <=  exe_p5[4];  // 60Hz 固定
        cmd_loss_color_sel  <= 1'b1;
      end
    end

    // color_loss  3bit
    always @(posedge clk) begin
      color_loss <= cmd_loss_color_sel ? cmd_color_loss : mem_color_loss;
    end

    // loss_brt100_sel
    always @(posedge clk) begin
      loss_brt100_sel <= cmd_loss_color_sel ? cmd_loss_brt100 : dsw_loss_brt100;
    end


  // Control Register Write

    // fpga1_reg_wr, fpga2_reg_wr
    assign fpga1_reg_wr = ((ram_block_write & ~com_buf_ctrl) | ram_byte_write)
                          & (exe_p5[2:0] == 3'h1);
    assign fpga2_reg_wr = ((ram_block_write & ~com_buf_ctrl) | ram_byte_write)
                          & (exe_p5[2:0] == 3'h2);

    // fpga1_reg_wr_npc, fpga2_reg_wr_npc, fpga_reg_wr_npc
    assign fpga1_reg_wr_npc = ram_byte_write & (dec_p5 == 4'h6);
    assign fpga2_reg_wr_npc = ram_byte_write & (dec_p5 == 4'h8);
    assign fpga_reg_wr_npc  = fpga1_reg_wr_npc | fpga2_reg_wr_npc;

    // fpga1_reg_wep, fpga2_reg_wep
    assign fpga1_reg_wep = (qb == 9'd6) & (fpga1_reg_wr | fpga1_reg_wr_npc);
    assign fpga2_reg_wep = (qb == 9'd6) & (fpga2_reg_wr | fpga2_reg_wr_npc);

    // ctrl_reg_wad_a  25bit
    assign ctrl_reg_wad_a = {exe_p4, exe_p3, exe_p2} + {17'h00000, qc[6:0]};

    // ctrl_reg_wad  24bit
    always @(posedge clk) begin
      ctrl_reg_wad <= ctrl_reg_wad_a[24] ? 24'hffffff : ctrl_reg_wad_a[23:0];
    end

    // fpga_reg_wdata  8bit
    assign fpga_reg_wdata = fpga_reg_wr_npc ? {dec_p1, dec_p0} : ram_cmd_rd;

    // fpga_reg_wad_h012, fpga_reg_wad_h014
    // fpga_reg_wad_h00b, fpga_reg_wad_h010, fpga_reg_wad_h011
    assign fpga_reg_wad_h012 = fpga_reg_wr_npc ? ({dec_p4, dec_p3, dec_p2} == 12'h012) :
                                                 (ctrl_reg_wad == 24'h000012);

    assign fpga_reg_wad_h014 = fpga_reg_wr_npc ? ({dec_p4, dec_p3, dec_p2} == 12'h014) :
                                                 (ctrl_reg_wad == 24'h000014);

    assign fpga_reg_wad_h00b = fpga_reg_wr_npc ? ({dec_p4, dec_p3, dec_p2} == 12'h00b) :
                                                 (ctrl_reg_wad == 24'h00000b);

    assign fpga_reg_wad_h010 = fpga_reg_wr_npc ? ({dec_p4, dec_p3, dec_p2} == 12'h010) :
                                                 (ctrl_reg_wad == 24'h000010);

    assign fpga_reg_wad_h011 = fpga_reg_wr_npc ? ({dec_p4, dec_p3, dec_p2} == 12'h011) :
                                                 (ctrl_reg_wad == 24'h000011);

    // testp_reg_ce, testp_level_reg_ce, rgb_zero_reg_ce
    // m4_on_reg_ce, m4_bank1_reg_ce, ram_enable_ce
    always @(posedge clk) begin
      testp_reg_ce       <= fpga1_reg_wep & fpga_reg_wad_h012;
      testp_level_reg_ce <= fpga1_reg_wep & fpga_reg_wad_h014;
      rgb_zero_reg_ce    <= fpga2_reg_wep & fpga_reg_wad_h00b;
      m4_on_reg_ce       <= fpga2_reg_wep & fpga_reg_wad_h010;
      m4_bank1_reg_ce    <= fpga2_reg_wep & fpga_reg_wad_h011;
      ram_enable_ce      <= fpga2_reg_wep & fpga_reg_wad_h012;
    end

    // testp_reg  8bit
    always @(posedge clk) begin
      if(rst)
        testp_reg <= 8'h73;      // Test Pattern OFF, RGB enable, Flat Field 
      else if(testp_reg_ce)
        testp_reg <= fpga_reg_wdata;
    end

    // testp_level  8bit
    always @(posedge clk) begin
      if(rst)
        testp_level <= 8'hff;      // 100% 
      else if(testp_level_reg_ce)
        testp_level <= fpga_reg_wdata;
    end

    // rgb_out_zero  3bit
    always @(posedge clk) begin
      if(rst)
        rgb_out_zero <= 3'h0;      // rgb out normal
      else if(rgb_zero_reg_ce)
        rgb_out_zero <= fpga_reg_wdata[2:0];  // r:[2], g:[1]:, b:[0] 
    end

    // reg_m4_on
    always @(posedge clk) begin
      if(rst)
        reg_m4_on <= 1'b1;         // m4 on 
      else if(m4_on_reg_ce)
        reg_m4_on <= fpga_reg_wdata[0];
    end

    // reg_m4_bank1
    always @(posedge clk) begin
      if(rst)
        reg_m4_bank1 <= 1'b0;      // m4 bank0 
      else if(m4_bank1_reg_ce)
        reg_m4_bank1 <= fpga_reg_wdata[0];
    end

    // reg_ram_enable     (not use)
    always @(posedge clk) begin
      if(rst)
        reg_ram_enable <= 1'b0;    // ram update disable 
      else if(ram_enable_ce)
        reg_ram_enable <= fpga_reg_wdata[0];
    end


  // Control Register Read

    // fpga1_reg_re, fpga2_reg_re
    assign fpga1_reg_re = ((ram_block_read & ~com_buf_ctrl) | ram_byte_read) & (exe_p5[2:0] == 3'h1);
    assign fpga2_reg_re = ((ram_block_read & ~com_buf_ctrl) | ram_byte_read) & (exe_p5[2:0] == 3'h2);

    // fpga1_reg_re_npc, fpga2_reg_re_npc, fpga_reg_re_npc
    assign fpga1_reg_re_npc = ram_byte_read & (dec_p5 == 4'h6);
    assign fpga2_reg_re_npc = ram_byte_read & (dec_p5 == 4'h8);
    assign fpga_reg_re_npc  = fpga1_reg_re_npc | fpga2_reg_re_npc;

    // ctrl_reg_rad_a  25bit
    assign ctrl_reg_rad_a = {exe_p4, exe_p3, exe_p2} + {17'h00000, qe[6:0]};

    // ctrl_reg_rad  24bit
    always @(posedge clk) begin
      ctrl_reg_rad <= ctrl_reg_rad_a[24] ? 24'hffffff : ctrl_reg_rad_a[23:0];
    end

    // ctrl_reg_rd  8bit
    always @(posedge clk) begin
      if(rst)
        ctrl_reg_rd <= 8'h00;
      else if( (fpga1_reg_re & (ctrl_reg_rad == 24'h000012)) |
               (fpga1_reg_re_npc & ({dec_p4, dec_p3, dec_p2} == 12'h012)) )
        ctrl_reg_rd <= testp_reg;
      else if( (fpga1_reg_re & (ctrl_reg_rad == 24'h000014)) |
               (fpga1_reg_re_npc & ({dec_p4, dec_p3, dec_p2} == 12'h014)) )
        ctrl_reg_rd <= testp_level;
      else if( (fpga2_reg_re & (ctrl_reg_rad == 24'h00000b)) |
               (fpga2_reg_re_npc & ({dec_p4, dec_p3, dec_p2} == 12'h00b)) )
        ctrl_reg_rd <= {5'h00, rgb_out_zero};
      else if( (fpga2_reg_re & (ctrl_reg_rad == 24'h000010)) |
               (fpga2_reg_re_npc & ({dec_p4, dec_p3, dec_p2} == 12'h010)) )
        ctrl_reg_rd <= {7'h00, reg_m4_on};
      else if( (fpga2_reg_re & (ctrl_reg_rad == 24'h000011)) |
               (fpga2_reg_re_npc & ({dec_p4, dec_p3, dec_p2} == 12'h011)) )
        ctrl_reg_rd <= {7'h00, reg_m4_bank1};
      else if( (fpga2_reg_re & (ctrl_reg_rad == 24'h000012)) |
               (fpga2_reg_re_npc & ({dec_p4, dec_p3, dec_p2} == 12'h012)) )
        ctrl_reg_rd <= {7'h00, reg_ram_enable};
      else
        ctrl_reg_rd <= 8'h00;
    end


  // testp_reg => reg_test_pat Code Conversion

    // reg_test_pat  8bit
    always @(posedge clk) begin
      if(rst)
        reg_test_pat <= 8'h00;      // Test Pattern OFF
      else if(testp_reg[7] & (testp_reg[2:0] == 3'h0))
        reg_test_pat <= 8'h09;      // Rainbow
      else if(testp_reg[7] & (testp_reg[2:0] == 3'h1))
        reg_test_pat <= 8'h0a;      // H Ramp
      else if(testp_reg[7] & (testp_reg[2:0] == 3'h2))
        reg_test_pat <= 8'h0b;      // V Ramp
      else if(testp_reg[7] & (testp_reg[2:0] == 3'h3))
        reg_test_pat <= 8'h07;      // Flat Field, White
      else if(testp_reg[7] & (testp_reg[2:0] == 3'h4))
        reg_test_pat <= 8'h0c;      // Diagonal Gray
      else if(testp_reg[7] & (testp_reg[2:0] == 3'h5))
        reg_test_pat <= 8'h0d;      // H Line
      else if(testp_reg[7] & (testp_reg[2:0] == 3'h6))
        reg_test_pat <= 8'h0e;      // V Line
      else if(testp_reg[7] & (testp_reg[2:0] == 3'h7))
        reg_test_pat <= 8'h0f;      // Fixed 0-63 gray scale
      else
        reg_test_pat <= 8'h00;      // Test Pattern OFF
    end


  // Test pattern command select

    // reg_test_pat_sel
    always @(posedge clk) begin
      if(rst | ((exe_cmd_num == 6'h06) & exe_latchp))
        reg_test_pat_sel <= 1'b0;
      else if(testp_reg_ce)
        reg_test_pat_sel <= 1'b1;
    end

    // sel_test_pat  8bit
    always @(posedge clk) begin
      sel_test_pat <= reg_test_pat_sel ? reg_test_pat : cmd_test_pat;
    end

    // testp_rgb_en  3bit  r:[2], g:[1], b[0]
    always @(posedge clk) begin
      testp_rgb_en <= (reg_test_pat_sel & testp_reg[7]) ? testp_reg[6:4] : 3'h7;
    end


  // m4 bank set command select

    // cmd_m4_bank_ce
    assign cmd_m4_bank_ce = (exe_cmd_num == 6'h01) & exe_latchp
                            & ((dec_p0 == 4'h0) | (dec_p0 == 4'h1) | (dec_p0 == 4'h2));

    // reg_m4_on_sel
    always @(posedge clk) begin
      if(rst | cmd_m4_bank_ce)
        reg_m4_on_sel <= 1'b0;
      else if(m4_on_reg_ce)
        reg_m4_on_sel <= 1'b1;
    end

    // sel_m4_on
    always @(posedge clk) begin
      sel_m4_on <= reg_m4_on_sel ? reg_m4_on : cmd_m4_on;
    end

    // reg_m4_bank1_sel
    always @(posedge clk) begin
      if(rst | cmd_m4_bank_ce)
        reg_m4_bank1_sel <= 1'b0;
      else if(m4_bank1_reg_ce)
        reg_m4_bank1_sel <= 1'b1;
    end

    // sel_m4_bank1
    always @(posedge clk) begin
      sel_m4_bank1 <= reg_m4_bank1_sel ? reg_m4_bank1 : cmd_m4_bank1;
    end


  // COM Buffer

    // com_buffer_din  8bit, com_buffer_wa  8bit, com_buffer_we
    assign com_buffer_din = cmd_com_buf_write ? rx_data : rsp_ram_din;
    assign com_buffer_wa  = cmd_com_buf_write ? cmd_com_buf_wa : {1'b0, rsp_ram_wa};
    assign com_buffer_we  = cmd_com_buf_write ? cmd_com_buf_we :
                                                rsp_ram_we & (com_buf_ctrl | com_im_ctrl);

    // cmd_com_buf_read
    always @(posedge clk) begin
      cmd_com_buf_read <= (exe_cmd_num == 6'h2c) | (exe_cmd_num == 6'h2d);
    end

    // cmd_com_buf_ra  9bitカウンタ
    always @(posedge clk) begin
      if(rst | ~cmd_com_buf_read)
        cmd_com_buf_ra <= 0;
      else if(~rsp_ram_re)
        cmd_com_buf_ra <= {1'b0, dec_p5, dec_p4};
      else if(com_rcnt_ce)
        cmd_com_buf_ra <= cmd_com_buf_ra + 1;
    end

    // cmd_com_rb  6bitカウンタ
    always @(posedge clk) begin
      if((rst | ~cmd_com_buf_read) | ~rsp_ram_re)
        cmd_com_rb <= 0;
      else if(com_rcnt_ce)
        cmd_com_rb <= cmd_com_rb + 1;
    end

    // com_rcnt_ce
    assign com_rcnt_ce = rsp_ram_re & tx_done & ~(cmd_com_buf_ra[8] | cmd_com_rb[5]);

    // com_buffer_ra  8bit
    assign com_buffer_ra = cmd_com_buf_read ? cmd_com_buf_ra[7:0] : {1'b0, cmd_ram_ra};

    // cmd_buf_do  8bit
    always @(posedge clk) begin
      com_buf_do <= com_buffer_do;
    end

    // 8bit x 256 ram module
    sdp_ram_256byte  com_buffer_mpc(
      .clk    (clk),
      .d      (com_buffer_din),
      .a      (com_buffer_wa),
      .we     (com_buffer_we),
      .dpra   (com_buffer_ra),
      .dpo    (com_buffer_do)
    );


  // Panel Correction enable output

    // dec_p0_d2
    always @(posedge clk) begin
      dec_p0_d2 <= (dec_p0 == 4'h2);  // 1 : IM select mode
    end

    // panel_correct_im00, panel_correct_im01, panel_correct_im10, panel_correct_im11
    // always @(posedge clk) begin
    //   panel_correct_im00 <= panel_correct & (~dec_p0_d2 | (dec_p4_lt_v_im_num & dec_p5_d0));
    //   panel_correct_im01 <= panel_correct & (~dec_p0_d2 | (dec_p4_lt_v_im_num & dec_p5_d1));
    //   panel_correct_im10 <= panel_correct & (~dec_p0_d2 | (dec_p4_lt_v_im_num & dec_p5_d2));
    //   panel_correct_im11 <= panel_correct & (~dec_p0_d2 | (dec_p4_lt_v_im_num & dec_p5_d3));
    // end

    // panel_correct_im
    always @(posedge clk) begin
      panel_correct_im <= panel_correct & (~dec_p0_d2 | im_num_ok);
    end

    // panel_correct_one_im
    always @(posedge clk) begin
      panel_correct_one_im <= panel_correct & dec_p0_d2;
    end

    // panel_correct_no_im
    // assign panel_correct_no_im = (panel_correct & dec_p0_d2) &
    //                              ( ~(dec_p4_lt_v_im_num & dec_p5_d0) &
    //                                ~(dec_p4_lt_v_im_num & dec_p5_d1) &
    //                                ~(dec_p4_lt_v_im_num & dec_p5_d2) &
    //                                ~(dec_p4_lt_v_im_num & dec_p5_d3) );

    assign panel_correct_no_im = (panel_correct & dec_p0_d2) & ~im_num_ok;


 // SDI信号からの IM Download 制御

    // exe_en_1d
    always @(posedge clk) begin
      exe_en_1d <= exe_en;
    end

    // rx_im_download_on1d, rx_im_download_on2d, rx_im_download_stp
    always @(posedge clk) begin
      rx_im_download_on1d <= rx_im_download_on;
      rx_im_download_on2d <= rx_im_download_on1d;
      rx_im_download_stp  <= rx_im_download_on1d & ~rx_im_download_on2d & exe_en_1d;
    end

    // exe_req_en
    assign exe_req_en = exe_req & exe_en_1d;

    // exe_req_wait
    always @(posedge clk) begin
      if(rst | ~exe_tim)
        exe_req_wait <= 1'b0;
      else if((exe_req_en | rx_im_download_stp) & exe_tim & ~rst)
        exe_req_wait <= 1'b1;
    end

    // exe_req_wait1d
    always @(posedge clk) begin
      exe_req_wait1d <= exe_req_wait;
    end

    // exe_req_a
    always @(posedge clk) begin
      exe_req_a <= ((exe_req_en | rx_im_download_stp) & ~exe_tim) | (~exe_req_wait & exe_req_wait1d);
    end

    // rx_im_download_st_tim
    always @(posedge clk) begin
      if(rst | exe_req_a | exe_req_en)
        rx_im_download_st_tim <= 1'b0;
      else if(rx_im_download_stp)
        rx_im_download_st_tim <= 1'b1;
    end

    // rx_im_download_exe_tim
    always @(posedge clk) begin
      if(rst | exe_tim_endp)
        rx_im_download_exe_tim <= 1'b0;
      else if(exe_req_a & rx_im_download_st_tim)
        rx_im_download_exe_tim <= 1'b1;
    end


  // Test point output for debug

    // tp1, tp2, tp3
    assign tp1 = exe_req_a;
    assign tp2 = exe_tim;
    assign tp3 = rx_im_download_exe_tim;

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// Receiver BD
// M4係数用SDRAM制御
//
// サブモジュール
//   m4_mem_wctrl_im_pv2_m5051b
//   m4_mem_wctrl_rs_impact2
//   m4_mem_wctrl_clear_xt
//   m4_mem_rctrl_im_pv2_m5051b
//   m4_mem_rctrl_rs_impact2

module m4_mem_ctrl_pv2_4_4x4 (c_done_dly, mem_cycle_stp, mem_m4_cmd_cycle,
                       bank_read, bank_write,
                       ram_ope_sel,
                       panel_correct_im, panel_correct_one_im,
                       panel_correct_im_vad, panel_correct_im_had,
                       panel_correct_startp, coeff_offset_we,
                       rs_din,
                       im_cf_ad, im_ope_vadrs, im_ope_hadrs,
                       im_we_in, im_ram_rstw, im_din,
                       cmd_startp,
                       mem_din,
                       rs_we_in, cmd_ad,
                       im_ram_rstr, im_32byte_num,
                       clk,

                       copy_correct_busy,
                       mem_clear_done_n,
                       wadrs, wdata, we, wr_bank1, wr_dqm,
                       im_rstwo, im_weo, im_rdata,
                       rs_rstwo, rs_weo, rs_rdata,
                       re, rd_bank1, radrs,
                       tp1, tp2, tp3, tp4, tp5);

    input c_done_dly;
    input mem_cycle_stp;
    input mem_m4_cmd_cycle;
    input bank_read;
    input bank_write;
    input [2:0] ram_ope_sel;
    input panel_correct_im;
    input panel_correct_one_im;
    input [3:0] panel_correct_im_vad;
    input [3:0] panel_correct_im_had;
    input panel_correct_startp;
    input coeff_offset_we;
    input [7:0] rs_din;
    input [4:0] im_cf_ad;
    input [3:0] im_ope_vadrs;
    input [3:0] im_ope_hadrs;
    input im_we_in;
    input im_ram_rstw;
    input [7:0] im_din;
    input cmd_startp;
    input [31:0] mem_din;
    input rs_we_in;
    input [21:0] cmd_ad;
    input im_ram_rstr;
    input [10:0] im_32byte_num;
    input clk;     // 125MHz

    output copy_correct_busy;
    output mem_clear_done_n;
    output reg [18:0] wadrs;
    output reg [31:0] wdata;
    output reg we;
    output reg wr_bank1;
    output reg [3:0] wr_dqm;
    output im_rstwo;
    output im_weo;
    output [7:0] im_rdata;
    output rs_rstwo;
    output rs_weo;
    output [7:0] rs_rdata;
    output reg re;
    output reg rd_bank1;
    output reg [18:0] radrs;
    output tp1;
    output tp2;
    output tp3;
    output tp4;
    output tp5;


    reg c_done_dly_n1d;
    reg mem_cycle_stp_1d, m4_cmd_cycle_stp;
    reg mem_m4_cmd_cycle_1d, m4_cmd_cycle;
    reg [6:0] qa;
    reg com_do_ce_a, com_do_ce;
    reg copy_from_im, copy_to_im, im_bank_rd_wr;
    reg [2:0] ram_ope_sel_1d;
    reg byte_write, byte_read, block_write, block_read;
    reg ram_bank0to1_copy, ram_bank1to0_copy, ram_bank_copy;
    reg pnl_correct_im, pnl_correct_one_im;
    reg [3:0] pnl_correct_im_vad, pnl_correct_im_had;
    reg panel_correct_startp1, panel_correct_startp2;
    reg coeff_offset_we1, coeff_offset_we2;
    reg [5:0] qpc;
    reg qpc_eq0, qpc_eq1, qpc_eq2, qpc_eq3, qpc_eq4, qpc_eq5, qpc_eq6, qpc_eq7, qpc_eq8, qpc_eq9;
    reg qpc_eq10, qpc_eq11, qpc_eq12, qpc_eq13, qpc_eq14, qpc_eq15, qpc_eq16, qpc_eq17;
    reg qpc_stop, qpc_stop_1d;
    reg pnl_correct_startp;
    reg [7:0] rs_din1d;
    reg [15:0] cf0_offset, cf1_offset, cf2_offset;
    reg [15:0] cf3_offset, cf4_offset, cf5_offset;
    reg [15:0] cf6_offset, cf7_offset, cf8_offset;

    wire rst;
    wire qa_stop;
    wire [2:0] ram_ope_sela;
    wire coeff_offset_wep;
    wire im_we;
    wire [18:0] im_wad;
    wire im_wr_bank1;
    wire [3:0] im_dqm;
    wire [31:0] im_wdata;
    wire im_high_byte;
    wire [3:0] im_cf_num;
    wire ram_bank_copy_pnl_correct;
    wire ram_bank_copy_re;
    wire [18:0] ram_bank_copy_rad;
    wire ram_bank_copy_rd_bank1;
    wire rs_we;
    wire [18:0] rs_wad;
    wire rs_wr_bank1;
    wire [3:0] rs_dqm;
    wire [31:0] rs_wdata;
    wire clear_we;
    wire [18:0] clear_wad;
    wire clear_wr_bank1;
    wire [3:0] clear_dqm;
    wire [31:0] clear_wdata;
    wire mem_clear_done;
    wire [18:0] im_rs_wad;
    wire [31:0] im_rs_wdata;
    wire im_rs_we;
    wire im_rs_wr_bank1;
    wire [3:0] im_rs_dqm;
    wire im_re;
    wire [18:0] im_rad;
    wire im_rd_bank1;
    wire rs_re;
    wire [18:0] rs_rad;
    wire rs_rd_bank1;
    wire rs_rd_cnt_stop;
    wire im_com_re;
    wire im_com_rd_bank1;
    wire [18:0] im_com_rad;


// 共用信号作成

    // c_done_dly_n1d
    always @(posedge clk) begin
      c_done_dly_n1d <= ~c_done_dly;
    end

    // rst
    assign rst = ~c_done_dly | c_done_dly_n1d;


    // mem_cycle_stp_1d, m4_cmd_cycle_stp
    always @(posedge clk) begin
      mem_cycle_stp_1d <= mem_cycle_stp;
      m4_cmd_cycle_stp <= mem_cycle_stp_1d & mem_m4_cmd_cycle;
    end

    // mem_m4_cmd_cycle_1d, m4_cmd_cycle
    always @(posedge clk) begin
      mem_m4_cmd_cycle_1d <= mem_m4_cmd_cycle;
      m4_cmd_cycle <= mem_m4_cmd_cycle_1d;
    end


    // qa  7bitカウンタ
    always @(posedge clk) begin
      if(mem_cycle_stp)
        qa <= 0;
      else if(~qa_stop)
        qa <= qa + 1;
    end

    // qa_stop
    assign qa_stop = qa[6] & qa[3];  // 64+6=72

    // com_do_ce_a, com_do_ce
    always @(posedge clk) begin
 //   com_do_ce_a <= (qa == 7'd59);
      com_do_ce_a <= (qa == 7'd56);
      com_do_ce   <= com_do_ce_a & mem_m4_cmd_cycle;
    end


// 制御モードデコード

    // copy_from_im, copy_to_im, im_bank_rd_wr
    always @(posedge clk) begin
      copy_from_im  <= bank_read;
      copy_to_im    <= bank_write;
      im_bank_rd_wr <= bank_read | bank_write;
    end

    // ram_ope_sel_1d  3bit
    always @(posedge clk) begin
      ram_ope_sel_1d <= ram_ope_sel;
    end

    // ram_ope_sela  3bit
    assign ram_ope_sela = im_bank_rd_wr ? 3'h0 : ram_ope_sel_1d;

    // byte_write -- block_read, ram_bank0to1_copy, ram_bank1to0_copy, ram_bank_copy
    always @(posedge clk) begin
      byte_write        <= (ram_ope_sela == 3'h1);
      byte_read         <= (ram_ope_sela == 3'h2);
      block_write       <= (ram_ope_sela == 3'h3);
      block_read        <= (ram_ope_sela == 3'h4);
      ram_bank0to1_copy <= (ram_ope_sela == 3'h5);
      ram_bank1to0_copy <= (ram_ope_sela == 3'h6);
      ram_bank_copy     <= (ram_ope_sela == 3'h5) | (ram_ope_sela == 3'h6);
    end


// Panel Correction用 offset data 受信 from COM Buffer

    // pnl_correct_im
    always @(posedge clk) begin
      pnl_correct_im <= panel_correct_im;
    end

    // pnl_correct_one_im
    always @(posedge clk) begin
      pnl_correct_one_im <= panel_correct_one_im;
    end

    // pnl_correct_im_vad  3bit
    always @(posedge clk) begin
      pnl_correct_im_vad <= panel_correct_im_vad;
    end

    // pnl_correct_im_had  3bit
    always @(posedge clk) begin
      pnl_correct_im_had <= panel_correct_im_had;
    end


    // panel_correct_startp1, panel_correct_startp2
    always @(posedge clk) begin
      panel_correct_startp1 <= panel_correct_startp;
      panel_correct_startp2 <= panel_correct_startp1;
    end

    // coeff_offset_we1, coeff_offset_we2
    always @(posedge clk) begin
      coeff_offset_we1 <= coeff_offset_we;
      coeff_offset_we2 <= coeff_offset_we1;
    end

    // coeff_offset_wep
    assign coeff_offset_wep = (coeff_offset_we1 & ~coeff_offset_we2) & ~qpc_stop;

    // qpc  6bitカウンタ
    always @(posedge clk) begin
      if(~pnl_correct_im | (panel_correct_startp1 & ~panel_correct_startp2))
        qpc <= 0;
      else if(coeff_offset_wep)
        qpc <= qpc + 1;
    end

    // qpc_eq0 -- qpc_eq17, qpc_stop
    always @(posedge clk) begin
      qpc_eq0  <= (qpc == 6'h00);
      qpc_eq1  <= (qpc == 6'h01);
      qpc_eq2  <= (qpc == 6'h02);
      qpc_eq3  <= (qpc == 6'h03);
      qpc_eq4  <= (qpc == 6'h04);
      qpc_eq5  <= (qpc == 6'h05);
      qpc_eq6  <= (qpc == 6'h06);
      qpc_eq7  <= (qpc == 6'h07);
      qpc_eq8  <= (qpc == 6'h08);
      qpc_eq9  <= (qpc == 6'h09);
      qpc_eq10 <= (qpc == 6'h0a);
      qpc_eq11 <= (qpc == 6'h0b);
      qpc_eq12 <= (qpc == 6'h0c);
      qpc_eq13 <= (qpc == 6'h0d);
      qpc_eq14 <= (qpc == 6'h0e);
      qpc_eq15 <= (qpc == 6'h0f);
      qpc_eq16 <= (qpc == 6'h10);
      qpc_eq17 <= (qpc == 6'h11);
      qpc_stop <= (qpc >  6'h11);
    end

    // qpc_stop_1d
    always @(posedge clk) begin
      qpc_stop_1d <= qpc_stop;
    end

    // pnl_correct_startp
    always @(posedge clk) begin
      pnl_correct_startp <= qpc_stop & ~qpc_stop_1d;
    end


    // rs_din1d  8bit
    always @(posedge clk) begin
      rs_din1d <= rs_din;
    end

    // cf0_offset  下位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq0)
        cf0_offset[7:0] <= rs_din1d;
    end

    // cf1_offset  下位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq1)
        cf1_offset[7:0] <= rs_din1d;
    end

    // cf2_offset  下位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq2)
        cf2_offset[7:0] <= rs_din1d;
    end

    // cf3_offset  下位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq3)
        cf3_offset[7:0] <= rs_din1d;
    end

    // cf4_offset  下位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq4)
        cf4_offset[7:0] <= rs_din1d;
    end

    // cf5_offset  下位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq5)
        cf5_offset[7:0] <= rs_din1d;
    end

    // cf6_offset  下位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq6)
        cf6_offset[7:0] <= rs_din1d;
    end

    // cf7_offset  下位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq7)
        cf7_offset[7:0] <= rs_din1d;
    end

    // cf8_offset  下位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq8)
        cf8_offset[7:0] <= rs_din1d;
    end

    // cf0_offset  上位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq9)
        cf0_offset[15:8] <= rs_din1d;
    end

    // cf1_offset  上位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq10)
        cf1_offset[15:8] <= rs_din1d;
    end

    // cf2_offset  上位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq11)
        cf2_offset[15:8] <= rs_din1d;
    end

    // cf3_offset  上位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq12)
        cf3_offset[15:8] <= rs_din1d;
    end

    // cf4_offset  上位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq13)
        cf4_offset[15:8] <= rs_din1d;
    end

    // cf5_offset  上位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq14)
        cf5_offset[15:8] <= rs_din1d;
    end

    // cf6_offset  上位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq15)
        cf6_offset[15:8] <= rs_din1d;
    end

    // cf7_offset  上位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq16)
        cf7_offset[15:8] <= rs_din1d;
    end

    // cf8_offset  上位8bit
    always @(posedge clk) begin
      if(coeff_offset_wep & qpc_eq17)
        cf8_offset[15:8] <= rs_din1d;
    end


// SDRAM 書き込み制御部

  // サブモジュール IMからのSDRAM書き込み制御

    m4_mem_wctrl_im_pv2_m5051b  m4_mem_wctrl_im_pv2_m5051b_0(
      .im_cf_ad             (im_cf_ad),
      .copy_from_im         (copy_from_im),
      .im_ope_vadrs         (im_ope_vadrs),
      .im_ope_hadrs         (im_ope_hadrs),
      .im_we_in             (im_we_in),
      .m4_cmd_cycle_stp     (m4_cmd_cycle_stp),
      .m4_cmd_cycle         (m4_cmd_cycle),
      .ram_bank_copy        (ram_bank_copy),
      .pnl_correct_im       (pnl_correct_im),
      .cmd_startp           (cmd_startp),
      .im_ram_rstw          (im_ram_rstw),
      .pnl_correct_startp   (pnl_correct_startp),
      .pnl_correct_one_im   (pnl_correct_one_im),
      .rst                  (rst),
      .pnl_correct_im_vad   (pnl_correct_im_vad),
      .pnl_correct_im_had   (pnl_correct_im_had),
      .ram_bank0to1_copy    (ram_bank0to1_copy),
      .ram_bank1to0_copy    (ram_bank1to0_copy),
      .im_din               (im_din),
      .mem_din              (mem_din),
      .com_do_ce            (com_do_ce),
      .cf0_offset           (cf0_offset),
      .cf1_offset           (cf1_offset),
      .cf2_offset           (cf2_offset),
      .cf3_offset           (cf3_offset),
      .cf4_offset           (cf4_offset),
      .cf5_offset           (cf5_offset),
      .cf6_offset           (cf6_offset),
      .cf7_offset           (cf7_offset),
      .cf8_offset           (cf8_offset),
      .clk                  (clk),

      .im_high_byte         (im_high_byte),
      .im_cf_num            (im_cf_num),
      .ram_bank_copy_pnl_correct  (ram_bank_copy_pnl_correct),
      .ram_bank_copy_re     (ram_bank_copy_re),
      .copy_correct_busy    (copy_correct_busy),
      .we                   (im_we),
      .wad                  (im_wad),
      .wr_bank1             (im_wr_bank1),
      .ram_bank_copy_rad    (ram_bank_copy_rad),
      .ram_bank_copy_rd_bank1  (ram_bank_copy_rd_bank1),
      .dqm                  (im_dqm),
      .wdata                (im_wdata)
    );


  // サブモジュール RS-232CからのSDRAM書き込み制御

    m4_mem_wctrl_rs_impact2  m4_mem_wctrl_rs_impact2_0(
      .rs_we_in             (rs_we_in),
      .m4_cmd_cycle_stp     (m4_cmd_cycle_stp),
      .m4_cmd_cycle         (m4_cmd_cycle),
      .cmd_startp           (cmd_startp),
      .byte_write           (byte_write),
      .block_write          (block_write),
      .cmd_ad               (cmd_ad),
      .rs_din               (rs_din),
      .rst                  (rst),
      .clk                  (clk),

      .we                   (rs_we),
      .wad                  (rs_wad),
      .dqm                  (rs_dqm),
      .wr_bank1             (rs_wr_bank1),
      .wdata                (rs_wdata)
    );


  // サブモジュール SDRAMクリア(データ 0 書き込み制御)

    m4_mem_wctrl_clear_xt  m4_mem_wctrl_clear_xt_0(
      .c_done_dly           (c_done_dly),
      .m4_cmd_cycle_stp     (m4_cmd_cycle_stp),
      .m4_cmd_cycle         (m4_cmd_cycle),
      .clk                  (clk),

      .wad                  (clear_wad),
      .wr_bank1             (clear_wr_bank1),
      .mem_clear_done       (mem_clear_done),
      .we                   (clear_we),
      .dqm                  (clear_dqm),
      .wdata                (clear_wdata)
    );


    // im_rs_wad  19bit
    assign im_rs_wad = (byte_write | block_write) ? rs_wad : im_wad;

    // wadrs  19bit
    always @(posedge clk) begin
      wadrs <= mem_clear_done ? im_rs_wad : clear_wad;
    end


    // im_rs_wdata  32bit
    assign im_rs_wdata = (byte_write | block_write) ? rs_wdata : im_wdata;

    // wdata  32bit
    always @(posedge clk) begin
      wdata <= mem_clear_done ? im_rs_wdata : clear_wdata;
    end


    // im_rs_we
    assign im_rs_we = (byte_write | block_write) ? rs_we : im_we;

    // we
    always @(posedge clk) begin
      we <= mem_clear_done ? im_rs_we : clear_we;
    end


    // im_rs_wr_bank1
    assign im_rs_wr_bank1 = (byte_write | block_write) ? rs_wr_bank1 : im_wr_bank1;

    // wr_bank1
    always @(posedge clk) begin
      wr_bank1 <= mem_clear_done ? im_rs_wr_bank1 : clear_wr_bank1;
    end


    // im_rs_dqm  4bit
    assign im_rs_dqm = (byte_write | block_write) ? rs_dqm : im_dqm;

    // wr_dqm  4bit
    always @(posedge clk) begin
      wr_dqm <= mem_clear_done ? im_rs_dqm : clear_dqm;
    end


    // mem_clear_done_n
    assign mem_clear_done_n = ~mem_clear_done;


// SDRAM 読み出し制御部

  // サブモジュール SDRAMからIMへの読み出し制御

    m4_mem_rctrl_im_pv2_m5051b  m4_mem_rctrl_im_pv2_m5051b_0(
      .im_ram_rstr          (im_ram_rstr),
      .copy_to_im           (copy_to_im),
      .m4_cmd_cycle_stp     (m4_cmd_cycle_stp),
      .im_high_byte         (im_high_byte),
      .rst                  (rst),
      .m4_cmd_cycle         (m4_cmd_cycle),
      .im_32byte_num        (im_32byte_num),
      .im_ope_vadrs         (im_ope_vadrs),
      .im_ope_hadrs         (im_ope_hadrs),
      .im_cf_num            (im_cf_num),
      .mem_din              (mem_din),
      .com_do_ce            (com_do_ce),
      .clk                  (clk),

      .rstwo                (im_rstwo),
      .weo                  (im_weo),
      .re                   (im_re),
      .rad                  (im_rad),
      .rd_bank1             (im_rd_bank1),
      .rdata                (im_rdata)
    );


  // サブモジュール SDRAMからRS-232Cへの読み出し制御

    m4_mem_rctrl_rs_impact2  m4_mem_rctrl_rs_impact2_0(
      .cmd_startp           (cmd_startp),
      .byte_read            (byte_read),
      .block_read           (block_read),
      .cycle_stp            (m4_cmd_cycle_stp),
      .cmd_ad               (cmd_ad),
      .rst                  (rst),
      .m4_cmd_cycle         (m4_cmd_cycle),
      .mem_din              (mem_din),
      .com_do_ce            (com_do_ce),
      .clk                  (clk),

      .rstwo                (rs_rstwo),
      .rad                  (rs_rad),
      .rd_bank1             (rs_rd_bank1),
      .re                   (rs_re),
      .weo                  (rs_weo),
      .rdata                (rs_rdata),
      .cnt_stop             (rs_rd_cnt_stop)
    );


    // im_com_re
    assign im_com_re = ram_bank_copy_pnl_correct ? ram_bank_copy_re : im_re;

    // re
    always @(posedge clk) begin
      re <= (byte_read | block_read) ? rs_re : im_com_re;
    end


    // im_com_rd_bank1
    assign im_com_rd_bank1 = ram_bank_copy_pnl_correct ? ram_bank_copy_rd_bank1 : im_rd_bank1;

    // rd_bank1
    always @(posedge clk) begin
      rd_bank1 <= (byte_read | block_read) ? rs_rd_bank1 : im_com_rd_bank1;
    end


    // im_com_rad  19bit
    assign im_com_rad = ram_bank_copy_pnl_correct ? ram_bank_copy_rad : im_rad;

    // radrs_a  19bit
    always @(posedge clk) begin
      radrs <= (byte_read | block_read) ? rs_rad : im_com_rad;
    end


// デバッグ用テストポイント

    // tp1, tp2, tp3, tp4, tp5
    assign tp1 = byte_read;
    assign tp2 = com_do_ce;
    assign tp3 = rs_rd_cnt_stop;
    assign tp4 = m4_cmd_cycle_stp;
    assign tp5 = m4_cmd_cycle;

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// Receiver BD
// M4係数用SRAM書き込み制御
// (IM EEPROMからのデータ用および bank copy, panel correctの制御)
//
// サブモジュール
//   panel_correct_on_axis_xt2p5_a
//   panel_correct_off_axis_xt2p5_a

module m4_mem_wctrl_im_pv2_m5051b (im_cf_ad, copy_from_im, im_ope_vadrs, im_ope_hadrs,
                           im_we_in, m4_cmd_cycle_stp, m4_cmd_cycle,
                           ram_bank_copy, pnl_correct_im,
                           cmd_startp, im_ram_rstw, pnl_correct_startp, pnl_correct_one_im,
                           rst,
                           pnl_correct_im_vad, pnl_correct_im_had,
                           ram_bank0to1_copy, ram_bank1to0_copy,
                           im_din, mem_din, com_do_ce,
                           cf0_offset, cf1_offset, cf2_offset, cf3_offset, cf4_offset,
                           cf5_offset, cf6_offset, cf7_offset, cf8_offset,
                           clk,

                           im_high_byte, im_cf_num,
                           ram_bank_copy_pnl_correct, ram_bank_copy_re,
                           copy_correct_busy,
                           we, wad, wr_bank1,
                           ram_bank_copy_rad, ram_bank_copy_rd_bank1,
                           dqm, wdata);

    input [4:0] im_cf_ad;
    input copy_from_im;
    input [3:0] im_ope_vadrs;        // XTでは下位1bitのみ有効 (0:上IM  1:下IM)
    input [3:0] im_ope_hadrs;        // XTでは下位1bitのみ有効 (0:左IM  1:右IM)
    input im_we_in;
    input m4_cmd_cycle_stp;
    input m4_cmd_cycle;
    input ram_bank_copy;
    input pnl_correct_im;
    input cmd_startp;
    input im_ram_rstw;
    input pnl_correct_startp;
    input pnl_correct_one_im;
    input rst;
    input [3:0] pnl_correct_im_vad;  // XTでは下位1bitのみ有効 (0:上IM  1:下IM)
    input [3:0] pnl_correct_im_had;  // XTでは下位1bitのみ有効 (0:左IM  1:右IM)
    input ram_bank0to1_copy;
    input ram_bank1to0_copy;
    input [7:0] im_din;    // from im_eeprom_ctrl
    input [31:0] mem_din;  // SDRAM output data
    input com_do_ce;
    input [15:0] cf0_offset, cf1_offset, cf2_offset, cf3_offset, cf4_offset;
    input [15:0] cf5_offset, cf6_offset, cf7_offset, cf8_offset;
    input clk;

    output reg im_high_byte;
    output reg [3:0] im_cf_num;
    output ram_bank_copy_pnl_correct;
    output reg ram_bank_copy_re;
    output copy_correct_busy;
    output reg we;
    output reg [18:0] wad;
    output reg wr_bank1;
    output reg [18:0] ram_bank_copy_rad;
    output reg ram_bank_copy_rd_bank1;
    output reg [3:0] dqm;
    output reg [31:0] wdata;


    reg [4:0] im_cf_ad_1d;
    reg im_high_byte_a;
    reg [3:0] im_cf_ad_2d;
    reg [3:0] im_cf_m9d_1d;
    reg im_high_byte_wr;
    reg [3:0] im_cf_num_wr;
    reg [3:0] im_ope_vad_wr;
    reg [3:0] im_ope_had_wr;
    reg we_in1, we_in2, wep, we1t, we2t;
    reg im_high_byte_odd_pix;
    reg ram_bank_copy_pnl_correct_1d;
    reg west, weo1d_a;
    reg rstw_in1, rstw_in2, cnt_st;
    reg [19:0] qa;
    reg cnt_stop_b;
    reg [18:0] qa1d;
    reg cnt_enable1d;
    reg qa_l4b_eq1, qa_l4b_eq3, qa_l4b_eq4, qa_l4b_eq6, qa_l4b_eq8;
    reg qa_l4b_eq9, qa_l4b_eq11, qa_l4b_eq12, qa_l4b_eq14, qa_l4b_eq15;
    reg [3:0] qb;
    reg [3:0] copy_from_im_cf_num;
    reg [7:0] im_dina, im_dinb, im_dinc;
    reg [12:0] im_dind;
    reg [12:0] copy_from_im_even_cf_wd, copy_from_im_odd_cf_wd;
    reg [15:0] lsb_cf_offset, msb_cf_offset;
    reg [31:0] mem_com_din, mem_com_din1d, mem_com_din2d;
    reg [31:0] pnl_correct_wdata;

    wire [4:0] im_cf_m9d;
    wire [3:0] im_cf_num_a;
    wire im_wep;
    wire wes, wesp, cnt_ce, weo, weo1d;
    wire cmd_wstp, cnt_startp_a, cnt_startp;
    wire [1:0] cnt_stop_sel;
    wire cnt_stop_a;
    wire cnt_stop;
    wire copy_from_im_wr_ena;
    wire im_we, ram_bank_copy_we;
    wire [18:0] copy_from_im_wad;
    wire [18:0] pnl_correct_wad;
    wire [18:0] ram_bank_copy_wad;
    wire [1:0] wad_sel;
    wire [1:0] ram_bank_copy_sel;
    wire [31:0] copy_from_im_wdata;
    wire [2:0] cf_offset_sel;
    wire [15:0] lsb_correct_do_on_axis, lsb_correct_do_off_axis, msb_correct_do_off_axis;


 // IM coefficient num 作成

    // im_cf_ad_1d  5bit
    always @(posedge clk) begin
      im_cf_ad_1d <= im_cf_ad;
    end

    // im_high_byte_a
    always @(posedge clk) begin
      im_high_byte_a <= (im_cf_ad_1d > 5'h08);
    end

    // im_cf_ad_2d  4bit
    always @(posedge clk) begin
      im_cf_ad_2d <= im_cf_ad_1d[3:0];
    end

    // im_cf_m9d  5bit  (im_cf_ad - 9)
    assign im_cf_m9d = im_cf_ad_1d + 5'h17;

    // im_cf_m9d_1d  4bit
    always @(posedge clk) begin
      im_cf_m9d_1d <= im_cf_m9d[3:0];
    end

    // im_high_byte
    always @(posedge clk) begin
      im_high_byte <= im_high_byte_a;
    end

    // im_wep
    assign im_wep = wep & copy_from_im;

    // im_high_byte_wr
    always @(posedge clk) begin
      if(im_wep)
        im_high_byte_wr <= im_high_byte_a;
    end

    // im_cf_num_a  4bit
    assign im_cf_num_a = im_high_byte_a ? im_cf_m9d_1d : im_cf_ad_2d;

    // im_cf_num  4bit
    always @(posedge clk) begin
      im_cf_num <= im_cf_num_a;
    end

    // im_cf_num_wr  4bit
    always @(posedge clk) begin
      if(im_wep)
        im_cf_num_wr <= im_cf_num_a;
    end


    // im_ope_vad_wr  4bit
    always @(posedge clk) begin
      if(im_wep)
        im_ope_vad_wr <= im_ope_vadrs;
    end

    // im_ope_had_wr  4bit
    always @(posedge clk) begin
      if(im_wep)
        im_ope_had_wr <= im_ope_hadrs;
    end


 // ライトアドレス作成

    // we_in1, we_in2, wep
    always @(posedge clk) begin
      we_in1 <= im_we_in;
      we_in2 <= we_in1;
      wep <= (we_in1 & ~we_in2);
    end

    // we1t
    always @(posedge clk) begin
      if(wep)
        we1t <= 1'b1;
      else if(m4_cmd_cycle_stp)
        we1t <= 1'b0;
    end

    // we2t
    always @(posedge clk) begin
      if(wep)
        we2t <= 1'b1;
      else if(~we1t & m4_cmd_cycle_stp)
        we2t <= 1'b0;
    end

    // im_high_byte_odd_pix
    always @(posedge clk) begin
      if(wep)
        im_high_byte_odd_pix <= 1'b0;
      else if((~wep & ~we1t & m4_cmd_cycle_stp) & (copy_from_im & im_high_byte_wr))
        im_high_byte_odd_pix <= 1'b1;
    end

    // wes
    assign wes = (copy_from_im & im_high_byte_wr) ? we2t : we1t;

    // ram_bank_copy_pnl_correct
    assign ram_bank_copy_pnl_correct = ram_bank_copy | pnl_correct_im;

    // ram_bank_copy_pnl_correct_1d
    always @(posedge clk) begin
      if(cnt_startp)
        ram_bank_copy_pnl_correct_1d <= ram_bank_copy_pnl_correct;
    end

    // wesp
    assign wesp = (wes | (ram_bank_copy_pnl_correct & ram_bank_copy_pnl_correct_1d)) & m4_cmd_cycle_stp;

    // west
    always @(posedge clk) begin
      if(wesp)
        west <= 1'b1;
      else if(m4_cmd_cycle_stp)
        west <= 1'b0;
    end

    // cnt_ce
    assign cnt_ce = west & m4_cmd_cycle_stp;

    // weo
    assign weo = west & ~cnt_stop & m4_cmd_cycle;

    // ram_bank_copy_re
    always @(posedge clk) begin
      ram_bank_copy_re <= weo;
    end

    // weo1d_a
    always @(posedge clk) begin
      if(cnt_ce)
        weo1d_a <= west & ~cnt_stop;
    end

    // weo1d
    assign weo1d = weo1d_a & m4_cmd_cycle;


    // cmd_wstp
    assign cmd_wstp = cmd_startp & ram_bank_copy;

    // rstw_in1, rstw_in2
    always @(posedge clk) begin
      rstw_in1 <= copy_from_im ? im_ram_rstw : cmd_wstp;
      rstw_in2 <= rstw_in1;
    end

    // cnt_startp_a
    assign cnt_startp_a = pnl_correct_im ? pnl_correct_startp : (rstw_in1 & ~rstw_in2);

    // cnt_st
    always @(posedge clk) begin
      if(cnt_startp_a)
        cnt_st <= 1'b1;
      else if(m4_cmd_cycle_stp)
        cnt_st <= 1'b0;
    end

    // cnt_startp
    assign cnt_startp = ram_bank_copy_pnl_correct ? (cnt_st & m4_cmd_cycle_stp) : cnt_startp_a;

    // qa  20bitカウンタ
    always @(posedge clk) begin
      if(cnt_startp)
        qa <= 0;
      else if(cnt_ce & ~cnt_stop)
        qa <= qa + 1;
    end

    // qa1d  19bit
    always @(posedge clk) begin
      if(cnt_ce)
        qa1d <= qa[18:0];
    end

    // cnt_stop_sel  2bit
    assign cnt_stop_sel[0] = pnl_correct_one_im & pnl_correct_im;
    assign cnt_stop_sel[1] = pnl_correct_im | ram_bank_copy;

    // cnt_stop_a
    function cnt_stop_a_sel;
    input [1:0] sel;
      case(sel)
 //     2'h0: cnt_stop_a_sel = (qa[19:14] > 6'd0);
 //     2'h1: cnt_stop_a_sel = (qa[19:14] > 6'd0);
 //     2'h2: cnt_stop_a_sel = qa[19];
 //     2'h3: cnt_stop_a_sel = (qa[19:13] > 7'd0);

        2'h0: cnt_stop_a_sel = (qa[19:16] > 4'd0);
        2'h1: cnt_stop_a_sel = (qa[19:16] > 4'd0);
        2'h2: cnt_stop_a_sel = qa[19];
        2'h3: cnt_stop_a_sel = (qa[19:15] > 5'd0);
      endcase
    endfunction

    assign cnt_stop_a = cnt_stop_a_sel(cnt_stop_sel);

    // cnt_stop_b
    always @(posedge clk) begin
      if(~rst & cnt_startp)
        cnt_stop_b <= 1'b0;
      else if(rst | cnt_stop_a)
        cnt_stop_b <= 1'b1;
    end

    // cnt_stop
    assign cnt_stop = cnt_stop_b | (rst | cnt_stop_a);

    // cnt_enable1d
    always @(posedge clk) begin
      if(cnt_ce)
        cnt_enable1d <= ~cnt_stop;
    end

    // copy_correct_busy
    assign copy_correct_busy = cnt_enable1d & ram_bank_copy_pnl_correct;


    // qa_l4b_eq1 -- qa_l4b_eq15
    always @(posedge clk) begin
      qa_l4b_eq1  <= (qa[3:0] == 4'd1);
      qa_l4b_eq3  <= (qa[3:0] == 4'd3);
      qa_l4b_eq4  <= (qa[3:0] == 4'd4);
      qa_l4b_eq6  <= (qa[3:0] == 4'd6);
      qa_l4b_eq8  <= (qa[3:0] == 4'd8);
      qa_l4b_eq9  <= (qa[3:0] == 4'd9);
      qa_l4b_eq11 <= (qa[3:0] == 4'd11);
      qa_l4b_eq12 <= (qa[3:0] == 4'd12);
      qa_l4b_eq14 <= (qa[3:0] == 4'd14);
      qa_l4b_eq15 <= (qa[3:0] == 4'd15);
    end

    // copy_from_im_wr_ena
    assign copy_from_im_wr_ena = qa_l4b_eq1 | qa_l4b_eq3 | qa_l4b_eq4 |
                                 qa_l4b_eq6 | qa_l4b_eq8 | qa_l4b_eq9 |
                                 qa_l4b_eq11 | qa_l4b_eq12 | qa_l4b_eq14;

    // qb  4bitカウンタ  (copy_from_im での coef num セレクト用)
    always @(posedge clk) begin
      if(cnt_startp | (qa_l4b_eq15 & cnt_ce))
        qb <= 0;
      else if(copy_from_im_wr_ena & cnt_ce & ~cnt_stop & copy_from_im)
        qb <= qb + 1;
    end

    // copy_from_im_cf_num  4bit
    always @(posedge clk) begin
      case (qb)
        4'h0: copy_from_im_cf_num <= 4'd0;  // coeff.0
        4'h1: copy_from_im_cf_num <= 4'd3;  // coeff.3
        4'h2: copy_from_im_cf_num <= 4'd6;  // coeff.6
        4'h3: copy_from_im_cf_num <= 4'd1;  // coeff.1
        4'h4: copy_from_im_cf_num <= 4'd4;  // coeff.4
        4'h5: copy_from_im_cf_num <= 4'd7;  // coeff.7
        4'h6: copy_from_im_cf_num <= 4'd2;  // coeff.2
        4'h7: copy_from_im_cf_num <= 4'd5;  // coeff.5
        4'h8: copy_from_im_cf_num <= 4'd8;  // coeff.8
        default: copy_from_im_cf_num <= 4'hf;
      endcase
    end


 // ライトイネーブル出力部

    // im_we, ram_bank_copy_we
    assign im_we = weo & copy_from_im_wr_ena & copy_from_im;
    assign ram_bank_copy_we = weo1d & (ram_bank_copy | pnl_correct_im);

    // we
    always @(posedge clk) begin
      we <= im_we | ram_bank_copy_we;
    end


 // ライトアドレス出力部

    // copy_from_im_wad  19bit
 // assign copy_from_im_wad = {im_ope_vad_wr[2:0], im_ope_had_wr[2:0],
 //                            qa[13:4],
 //                            copy_from_im_cf_num[3:1]};

    assign copy_from_im_wad = {im_ope_vad_wr[1:0], im_ope_had_wr[1:0],
                               qa[15:4],
                               copy_from_im_cf_num[3:1]};

    // pnl_correct_wad  19bit
 // assign pnl_correct_wad = pnl_correct_one_im ?
 //                          {pnl_correct_im_vad[2:0], pnl_correct_im_had[2:0], qa1d[12:0]} : qa1d;

    assign pnl_correct_wad = pnl_correct_one_im ?
                             {pnl_correct_im_vad[1:0], pnl_correct_im_had[1:0], qa1d[14:0]} : qa1d;


    // ram_bank_copy_wad  19bit
    assign ram_bank_copy_wad = qa1d;

    // wad_sel  2bit
    assign wad_sel[0] = copy_from_im | pnl_correct_im;
    assign wad_sel[1] = pnl_correct_im | ram_bank_copy;

    // wad  19bit
    always @(posedge clk) begin
      case (wad_sel)
        2'h0: wad <= 19'd0;
        2'h1: wad <= copy_from_im_wad;
        2'h2: wad <= ram_bank_copy_wad;
        2'h3: wad <= pnl_correct_wad;
      endcase
    end

    // wr_bank1
    always @(posedge clk) begin
      case (wad_sel)
        2'h0: wr_bank1 <= 1'b0;
        2'h1: wr_bank1 <= 1'b0;
        2'h2: wr_bank1 <= ram_bank0to1_copy;
        2'h3: wr_bank1 <= 1'b0;
      endcase
    end


 // ram_bank_copy, pnl_correct 用リードアドレス出力部

    // ram_bank_copy_sel  2bit
    assign ram_bank_copy_sel[0] = ram_bank_copy | pnl_correct_one_im;
    assign ram_bank_copy_sel[1] = pnl_correct_one_im | pnl_correct_im;

    // ram_bank_copy_rad  19bit
    always @(posedge clk) begin
      case (ram_bank_copy_sel)
        2'h0: ram_bank_copy_rad <= 19'd0;
        2'h1: ram_bank_copy_rad <= qa[18:0];
        2'h2: ram_bank_copy_rad <= qa[18:0];
 //     2'h3: ram_bank_copy_rad <= {pnl_correct_im_vad[2:0], pnl_correct_im_had[2:0], qa[12:0]};
        2'h3: ram_bank_copy_rad <= {pnl_correct_im_vad[1:0], pnl_correct_im_had[1:0], qa[14:0]};
      endcase
    end

    // ram_bank_copy_rd_bank1
    always @(posedge clk) begin
      case (ram_bank_copy_sel)
        2'h0: ram_bank_copy_rd_bank1 <= 1'b0;
        2'h1: ram_bank_copy_rd_bank1 <= ram_bank1to0_copy;
        2'h2: ram_bank_copy_rd_bank1 <= 1'b0;
        2'h3: ram_bank_copy_rd_bank1 <= 1'b0;
      endcase
    end


 // dqm 出力部

    // dqm  4bit
    // [0] Coeff.No. 偶数, 下位 8bit
    // [1] Coeff.No. 偶数, 上位 4bit
    // [2] Coeff.No. 奇数, 下位 8bit
    // [3] Coeff.No. 奇数, 上位 4bit
    always @(posedge clk) begin
      dqm[0] <= ~(~copy_from_im_cf_num[0] & copy_from_im) & ~(ram_bank_copy | pnl_correct_im);
      dqm[1] <= ~(~copy_from_im_cf_num[0] & copy_from_im) & ~(ram_bank_copy | pnl_correct_im);
      dqm[2] <= ~( copy_from_im_cf_num[0] & copy_from_im) & ~(ram_bank_copy | pnl_correct_im);
      dqm[3] <= ~( copy_from_im_cf_num[0] & copy_from_im) & ~(ram_bank_copy | pnl_correct_im);
    end


 // ライトデータ出力部

    // im_dina  8bit
    always @(posedge clk) begin
      im_dina <= im_din;  // from im_eeprom_ctrl
    end

    // im_dinb, im_dinc  8bit
    always @(posedge clk) begin
      if(cnt_ce) begin
        im_dinb <= im_dina;
        im_dinc <= im_dinb;
      end
    end

    // im_dind  13bit
    always @(posedge clk) begin
      case (qb)
        4'h0: im_dind <= {im_dina[4:0], im_dinb[7:0]};
        4'h1: im_dind <= {im_dina[1:0], im_dinb[7:0], im_dinc[7:5]};
        4'h2: im_dind <= {im_dina[6:0], im_dinb[7:2]};
        4'h3: im_dind <= {im_dina[3:0], im_dinb[7:0], im_dinc[7]};
        4'h4: im_dind <= {im_dina[0], im_dinb[7:0], im_dinc[7:4]};
        4'h5: im_dind <= {im_dina[5:0], im_dinb[7:1]};
        4'h6: im_dind <= {im_dina[2:0], im_dinb[7:0], im_dinc[7:6]};
        4'h7: im_dind <= {im_dina[7:0], im_dinb[7:3]};
        4'h8: im_dind <= {im_dina[4:0], im_dinb[7:0]};
        default: im_dind <= 13'd0;
      endcase
    end

    // copy_from_im_even_cf_wd  13bit
    always @(posedge clk) begin
      copy_from_im_even_cf_wd[7:0]  <= dqm[0] ? 8'd0 : im_dind[7:0];
      copy_from_im_even_cf_wd[12:8] <= dqm[1] ? 5'd0 : im_dind[12:8];
    end

    // copy_from_im_odd_cf_wd  13bit
    always @(posedge clk) begin
      copy_from_im_odd_cf_wd[7:0]  <= dqm[2] ? 8'd0 : im_dind[7:0];
      copy_from_im_odd_cf_wd[12:8] <= dqm[3] ? 5'd0 : im_dind[12:8];
    end

    // copy_from_im_wdata  32bit
    assign copy_from_im_wdata = {3'd0, copy_from_im_odd_cf_wd, 3'd0, copy_from_im_even_cf_wd};


    // cf_offset_sel  3bit
    assign cf_offset_sel = pnl_correct_im ? pnl_correct_wad[2:0] : 3'h7;

    // lsb_cf_offset  16bit
    always @(posedge clk) begin
      case (cf_offset_sel)
        3'h0: lsb_cf_offset <= cf0_offset;
        3'h1: lsb_cf_offset <= cf2_offset;
        3'h2: lsb_cf_offset <= cf4_offset;
        3'h3: lsb_cf_offset <= cf6_offset;
        3'h4: lsb_cf_offset <= cf8_offset;
        3'h5: lsb_cf_offset <= 16'd0;
        3'h6: lsb_cf_offset <= 16'd0;
        3'h7: lsb_cf_offset <= 16'd0;
      endcase
    end

    // msb_cf_offset  16bit
    always @(posedge clk) begin
      case (cf_offset_sel)
        3'h0: msb_cf_offset <= cf1_offset;
        3'h1: msb_cf_offset <= cf3_offset;
        3'h2: msb_cf_offset <= cf5_offset;
        3'h3: msb_cf_offset <= cf7_offset;
        3'h4: msb_cf_offset <= 16'd0;
        3'h5: msb_cf_offset <= 16'd0;
        3'h6: msb_cf_offset <= 16'd0;
        3'h7: msb_cf_offset <= 16'd0;
      endcase
    end


    // mem_com_din  32bit
    always @(posedge clk) begin
      if(com_do_ce & (ram_bank_copy | pnl_correct_im))
        mem_com_din <= mem_din;  // SDRAM output data
    end

    // mem_com_din1d, mem_com_din2d  32bit
    always @(posedge clk) begin
      mem_com_din1d <= mem_com_din;
      mem_com_din2d <= mem_com_din1d;
    end


    // サブモジュール  on_axis offset演算 (Coeff.No. 偶数用)
    panel_correct_on_axis_xt2p5_a  panel_correct_on_axis_xt2p5_a_0(
      .clk                  (clk),
      .din                  (mem_com_din[15:0]),       // 16bit
      .offset               (lsb_cf_offset),           // 16bit
      .dout                 (lsb_correct_do_on_axis)   // 16bit
    );

    // サブモジュール  off_axis offset演算 (Coeff.No. 偶数用)
    panel_correct_off_axis_xt2p5_a  panel_correct_off_axis_xt2p5_a_0(
      .clk                  (clk),
      .din                  (mem_com_din[15:0]),       // 16bit
      .offset               (lsb_cf_offset),           // 16bit
      .dout                 (lsb_correct_do_off_axis)  // 16bit
    );

    // サブモジュール  off_axis offset演算 (Coeff.No. 奇数用)
    panel_correct_off_axis_xt2p5_a  panel_correct_off_axis_xt2p5_a_1(
      .clk                  (clk),
      .din                  (mem_com_din[31:16]),      // 16bit
      .offset               (msb_cf_offset),           // 16bit
      .dout                 (msb_correct_do_off_axis)  // 16bit
    );


    // pnl_correct_wdata  32bit
    always @(posedge clk) begin
      case (cf_offset_sel)
        3'h0: pnl_correct_wdata <= {msb_correct_do_off_axis, lsb_correct_do_on_axis};
        3'h1: pnl_correct_wdata <= {msb_correct_do_off_axis, lsb_correct_do_off_axis};
        3'h2: pnl_correct_wdata <= {msb_correct_do_off_axis, lsb_correct_do_on_axis};
        3'h3: pnl_correct_wdata <= {msb_correct_do_off_axis, lsb_correct_do_off_axis};
        3'h4: pnl_correct_wdata <= {msb_correct_do_off_axis, lsb_correct_do_on_axis};
        3'h5: pnl_correct_wdata <= mem_com_din2d;
        3'h6: pnl_correct_wdata <= mem_com_din2d;
        3'h7: pnl_correct_wdata <= mem_com_din2d;
      endcase
    end


    // wdata  32bit
    always @(posedge clk) begin
      case (wad_sel)
        2'h0: wdata <= 32'd0;
        2'h1: wdata <= copy_from_im_wdata;  // copy_from_im
        2'h2: wdata <= pnl_correct_wdata;   // ram_bank_copy
        2'h3: wdata <= pnl_correct_wdata;   // pnl_correct
      endcase
    end

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// Receiver BD
// M4係数用SRAM読み出し制御
// (RS-232Cへのデータ出力用)

module m4_mem_rctrl_rs_impact2 (cmd_startp, byte_read, block_read, cycle_stp,
                                cmd_ad, rst, m4_cmd_cycle,
                                mem_din,
                                com_do_ce, clk,

                                rstwo, rad, rd_bank1, re, weo,
                                rdata,
                                cnt_stop);

    input cmd_startp;
    input byte_read;
    input block_read;
    input cycle_stp;
    input [21:0] cmd_ad;
    input rst;
    input m4_cmd_cycle;
    input [31:0] mem_din;
    input com_do_ce;
    input clk;

    output reg rstwo;
    output [18:0] rad;
    output rd_bank1;
    output reg re;
    output reg weo;
    output reg [7:0] rdata;
    output cnt_stop;         // チェック用

    reg rstr1, rstr2;
    reg rstrp1d, rstrp2d, rstrp3d, rstrp4d;
    reg re_st;
    reg [21:0] qa;
    reg high_byte;
    reg cf_num_lsb;
    reg [7:0] qb;
    reg cnt_stop_b;
    reg cnt_stop1dn;
    reg [3:0] qc;
    reg [31:0] mem_dina;

    wire rstrp;
    wire cnt_startp;
    wire cnt_stop_a;


 // リードアドレス, タイミング信号作成

    // rstr1, rstr2
    always @(posedge clk) begin
      rstr1 <= cmd_startp & (byte_read | block_read);
      rstr2 <= rstr1;
    end

    // rstrp
    assign rstrp = rstr1 & ~rstr2;

    // rstrp1d, rstrp2d, rstrp3d, rstwo
    always @(posedge clk) begin
      rstrp1d <= rstrp;
      rstrp2d <= rstrp1d;
      rstrp3d <= rstrp2d;
      rstrp4d <= rstrp3d;
      rstwo <= rstrp | rstrp1d | rstrp2d | rstrp3d;
    end

    // re_st
    always @(posedge clk) begin
      if(rstrp4d)
        re_st <= 1'b1;
      else if(cycle_stp)
        re_st <= 1'b0;
    end

    // cnt_startp
    assign cnt_startp = re_st & cycle_stp;

    // qa  22bitカウンタ
    always @(posedge clk) begin
      if(cnt_startp)
        qa <= cmd_ad;
      else if(cycle_stp & ~cnt_stop)
        qa <= qa + 1;
    end

    // rad  19bit
    assign rad = {qa[15:0], qa[19:17]};

    // rd_bank1
    assign rd_bank1 = qa[20];

    // high_byte
    always @(posedge clk) begin
      if(cycle_stp)
        high_byte <= qa[21];
    end

    // cf_num_lsb
    always @(posedge clk) begin
      if(cycle_stp)
        cf_num_lsb <= qa[16];
    end

    // qb  8bitカウンタ
    always @(posedge clk) begin
      if(cnt_startp)
        qb <= 0;
      else if(cycle_stp & ~cnt_stop)
        qb <= qb + 1;
    end

    // cnt_stop_a
    assign cnt_stop_a = (qb[0] & byte_read) | (qb[7] & block_read);

    // cnt_stop_b
    always @(posedge clk) begin
      if(~rst & cnt_startp)
        cnt_stop_b <= 1'b0;
      else if(rst | cnt_stop_a)
        cnt_stop_b <= 1'b1;
    end

    // cnt_stop
    assign cnt_stop = cnt_stop_b | (rst | cnt_stop_a);

    // re
    always @(posedge clk) begin
      re <= ~cnt_stop & (byte_read | block_read) & m4_cmd_cycle;
    end

    // cnt_stop1dn
    always @(posedge clk) begin
      if(cycle_stp)
        cnt_stop1dn <= ~cnt_stop;
    end

    // qc  4bitカウンタ
    always @(posedge clk) begin
      if(cycle_stp)
        qc <= 0;
      else if(cnt_stop1dn & ~qc[3])
        qc <= qc + 1;
    end

    // weo
    always @(posedge clk) begin
      weo <= qc[2] & cnt_stop1dn & (byte_read | block_read);
    end


 // データ出力部

    // mem_dina  32bit
    always @(posedge clk) begin
      if(com_do_ce & (byte_read | block_read))
        mem_dina <= mem_din;  // from SDRAM出力
    end

    // rdata  8bit
    always @(posedge clk) begin
      case ({cf_num_lsb, high_byte})
        2'h0: rdata <= mem_dina[7:0];
        2'h1: rdata <= mem_dina[15:8];
        2'h2: rdata <= mem_dina[23:16];
        2'h3: rdata <= mem_dina[31:24];
      endcase
    end

endmodule
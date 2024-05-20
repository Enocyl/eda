`timescale 1ns / 1ns
// `default_nettype none

// Receiver BD
// M4係数用SRAM読み出し制御
// (IM EEPROMへのデータ出力用)

module m4_mem_rctrl_im_pv2_m5051b (im_ram_rstr, copy_to_im, m4_cmd_cycle_stp,
                           im_high_byte, rst, m4_cmd_cycle,
                           im_32byte_num, im_ope_vadrs, im_ope_hadrs,
                           im_cf_num,
                           mem_din,
                           com_do_ce, clk,

                           rstwo, re, weo,
                           rad, rd_bank1, rdata);

    input im_ram_rstr;
    input copy_to_im;
    input m4_cmd_cycle_stp;
    input im_high_byte;
    input rst;
    input m4_cmd_cycle;
    input [10:0] im_32byte_num;
    input [3:0] im_ope_vadrs;
    input [3:0] im_ope_hadrs;
    input [3:0] im_cf_num;
    input [31:0] mem_din;
    input com_do_ce;
    input clk;

    output reg rstwo;
    output reg weo;
    output reg re;
    output reg [18:0] rad;
    output rd_bank1;
    output reg [7:0] rdata;

    reg rstr1, rstr2;
    reg re_st;
    reg cnt_startp_1d, cnt_startp_2d, cnt_startp_3d, cnt_startp_4d;
    reg cnt_startp_5d, cnt_startp_6d, cnt_startp_7d;
    reg [6:0] qa;
    reg qa_eq0;
    reg cnt_stop_b;
    reg [4:0] qb;
    reg cnt_stop_1d;
    reg qa_l4b_eq0, qa_l4b_eq1, qa_l4b_eq3, qa_l4b_eq4, qa_l4b_eq6;
    reg qa_l4b_eq8, qa_l4b_eq9, qa_l4b_eq11, qa_l4b_eq13;
    reg [2:0] cf_addr;
    reg [10:0] im_32byte_numa;
    reg [3:0] im_ope_vad;
    reg [3:0] im_ope_had;
    reg [31:0] mem_dina, mem_dinb;
    reg [3:0] qa_1d;

    wire rstrp;
    wire cnt_startp;
    wire qa_ce;
    wire cnt_stop_a;
    wire cnt_stop;
    wire mem_rd_cycle;
    wire [11:0] lad;
    wire din_ce;


 // リードアドレス, タイミング信号作成

    // rstr1, rstr2
    always @(posedge clk) begin
      rstr1 <= im_ram_rstr & copy_to_im;
      rstr2 <= rstr1;
    end

    // rstrp
    assign rstrp = rstr1 & ~rstr2;

    // re_st
    always @(posedge clk) begin
      if(rstrp)
        re_st <= 1'b1;
      else if(m4_cmd_cycle_stp)
        re_st <= 1'b0;
    end

    // cnt_startp
    assign cnt_startp = re_st & m4_cmd_cycle_stp;

    // cnt_startp_1d -- cnt_startp_7d, rstwo
    always @(posedge clk) begin
      cnt_startp_1d <= cnt_startp;
      cnt_startp_2d <= cnt_startp_1d;
      cnt_startp_3d <= cnt_startp_2d;
      cnt_startp_4d <= cnt_startp_3d;
      cnt_startp_5d <= cnt_startp_4d;
      cnt_startp_6d <= cnt_startp_5d;
      cnt_startp_7d <= cnt_startp_6d;
      rstwo <= cnt_startp | cnt_startp_1d | cnt_startp_2d | cnt_startp_3d | 
               cnt_startp_4d | cnt_startp_5d | cnt_startp_6d | cnt_startp_7d;
    end

    // qa  7bitカウンタ
    always @(posedge clk) begin
      if(cnt_startp)
        qa <= 0;
      else if(qa_ce)
        qa <= qa + 1;
    end

    // qa_ce
    assign qa_ce = m4_cmd_cycle_stp & ~cnt_stop;

    // qa_eq0
    always @(posedge clk) begin
      qa_eq0 <= (qa == 7'd0);
    end

    // cnt_stop_a
    assign cnt_stop_a = im_high_byte ? qa[6] : qa[5];

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
      re <= ~cnt_stop & copy_to_im & m4_cmd_cycle;
    end

    // qb  5bitカウンタ
    always @(posedge clk) begin
      if(qa_ce)
        qb <= 0;
      else if(~qb[4])
        qb <= qb + 1;
    end

    // cnt_stop_1d
    always @(posedge clk) begin
      if(m4_cmd_cycle_stp)
        cnt_stop_1d <= cnt_stop;
    end

    // weo
    always @(posedge clk) begin
      weo <= qb[3] & ~cnt_stop_1d & ~qa_eq0 & ~(qa[0] & im_high_byte) & copy_to_im;
    end


    // qa_l4b_eq0 -- qa_l4b_eq13
    always @(posedge clk) begin
      qa_l4b_eq0  <= (qa[3:0] == 4'd0);
      qa_l4b_eq1  <= (qa[3:0] == 4'd1);
      qa_l4b_eq3  <= (qa[3:0] == 4'd3);
      qa_l4b_eq4  <= (qa[3:0] == 4'd4);
      qa_l4b_eq6  <= (qa[3:0] == 4'd6);
      qa_l4b_eq8  <= (qa[3:0] == 4'd8);
      qa_l4b_eq9  <= (qa[3:0] == 4'd9);
      qa_l4b_eq11 <= (qa[3:0] == 4'd11);
      qa_l4b_eq13 <= (qa[3:0] == 4'd13);
    end

    // mem_rd_cycle
    assign mem_rd_cycle = qa_l4b_eq0 | qa_l4b_eq1 | qa_l4b_eq3 | qa_l4b_eq4 | qa_l4b_eq6 |
                          qa_l4b_eq8 | qa_l4b_eq9 | qa_l4b_eq11 | qa_l4b_eq13;


    // cf_addr  3bit  (Memory read address の下位bit)
    always @(posedge clk) begin
      case (qa[3:0])
        4'h0: cf_addr <= 3'd0;
        4'h1: cf_addr <= 3'd1;
        4'h2: cf_addr <= 3'd1;
        4'h3: cf_addr <= 3'd3;
        4'h4: cf_addr <= 3'd0;
        4'h5: cf_addr <= 3'd0;
        4'h6: cf_addr <= 3'd2;
        4'h7: cf_addr <= 3'd2;
        4'h8: cf_addr <= 3'd3;
        4'h9: cf_addr <= 3'd1;
        4'ha: cf_addr <= 3'd1;
        4'hb: cf_addr <= 3'd2;
        4'hc: cf_addr <= 3'd2;
        4'hd: cf_addr <= 3'd4;
        4'he: cf_addr <= 3'd4;
        4'hf: cf_addr <= 3'd4;
      endcase
    end


    // im_32byte_numa  11bit
    always @(posedge clk) begin
      im_32byte_numa <= im_32byte_num;
    end

    // im_ope_vad  3bit
    always @(posedge clk) begin
      im_ope_vad <= im_ope_vadrs;
    end

    // im_ope_had  3bit
    always @(posedge clk) begin
      im_ope_had <= im_ope_hadrs;
    end

    // lad  12bit
    // assign lad = im_high_byte ? {im_32byte_numa[5:0], qa[5:0]} :
    //                             {im_32byte_numa[6:0], qa[4:0]};

    // assign lad = {im_32byte_numa[8:0], qa[4]};

       assign lad = {im_32byte_numa[10:0], qa[4]};

    // rad  19bit
    // always @(posedge clk) begin
    //   rad <= {im_ope_vad[2:0], im_ope_had[2:0], lad, cf_addr};
    // end

    always @(posedge clk) begin
      rad <= {im_ope_vad[1:0], im_ope_had[1:0], lad, cf_addr};
    end


    // rd_bank1
    assign rd_bank1 = 1'b0;


 // データ出力部

    // din_ce
    assign din_ce = com_do_ce & mem_rd_cycle & copy_to_im;

    // mem_dina, mem_dinb  32bit
    always @(posedge clk) begin
      if(din_ce) begin
        mem_dina <= mem_din;  // from SDRAM出力
        mem_dinb <= mem_dina;
      end
    end

    // qa_1d  4bit
    always @(posedge clk) begin
      if(com_do_ce)
        qa_1d <= qa[3:0];
    end

    // rdata  8bit
    always @(posedge clk) begin
      case (qa_1d)
        4'h0: rdata <= mem_dina[7:0];
        4'h1: rdata <= {mem_dina[18:16], mem_dinb[12:8]};
        4'h2: rdata <= mem_dina[26:19];
        4'h3: rdata <= {mem_dina[5:0], mem_dinb[28:27]};
        4'h4: rdata <= {mem_dina[16], mem_dinb[12:6]};
        4'h5: rdata <= mem_dina[24:17];
        4'h6: rdata <= {mem_dina[3:0], mem_dinb[28:25]};
        4'h7: rdata <= mem_dina[11:4];
        4'h8: rdata <= {mem_dina[22:16], mem_dinb[12]};
        4'h9: rdata <= {mem_dina[1:0], mem_dinb[28:23]};
        4'ha: rdata <= mem_dina[9:2];
        4'hb: rdata <= {mem_dina[20:16], mem_dinb[12:10]};
        4'hc: rdata <= mem_dina[28:21];
        4'hd: rdata <= mem_dina[7:0];
        4'he: rdata <= {3'h7, mem_dina[12:8]};
        4'hf: rdata <= 8'hff;
      endcase
    end

endmodule
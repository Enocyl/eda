`timescale 1ns / 1ns
// `default_nettype none

// Receiver BD
// M4係数用SRAM書き込み制御
// (RS-232Cからのデータ用)

module m4_mem_wctrl_rs_impact2 (rs_we_in, m4_cmd_cycle_stp, m4_cmd_cycle, cmd_startp,
                                byte_write, block_write, cmd_ad, rs_din,
                                rst, clk,
                                we, wad, dqm, wr_bank1, wdata);

    input rs_we_in;
    input m4_cmd_cycle_stp;
    input m4_cmd_cycle;
    input cmd_startp;
    input byte_write;
    input block_write;
    input [21:0] cmd_ad;
    input [7:0] rs_din;
    input rst;
    input clk;

    output reg we;
    output reg [18:0] wad;
    output reg [3:0] dqm;
    output reg wr_bank1;
    output reg [31:0] wdata;

    reg we_in1, we_in2, wep, wet, weo;
    reg rstw_in1, rstw_in2, cnt_startp;
    reg [22:0] qa;
    reg [7:0] qb;
    reg cnt_stop_b;

    wire wesp, cnt_ce;
    wire cnt_stop_a;
    wire cnt_stop;
    wire dqm0a, dqm1a, dqm2a, dqm3a;


    // we_in1, we_in2, wep
    always @(posedge clk) begin
      we_in1 <= rs_we_in;
      we_in2 <= we_in1;
      wep <= (we_in1 & ~we_in2);
    end

    // wet
    always @(posedge clk) begin
      if(wep)
        wet <= 1'b1;
      else if(m4_cmd_cycle_stp)
        wet <= 1'b0;
    end

    // wesp
    assign wesp = wet & m4_cmd_cycle_stp;

    // weo
    always @(posedge clk) begin
      if(wesp)
        weo <= 1'b1;
      else if(m4_cmd_cycle_stp)
        weo <= 1'b0;
    end

    // cnt_ce
    assign cnt_ce = weo & m4_cmd_cycle_stp;

    // rstw_in1, rstw_in2, cnt_startp
    always @(posedge clk) begin
      rstw_in1   <= cmd_startp & (byte_write | block_write);
      rstw_in2   <= rstw_in1;
      cnt_startp <= rstw_in1 & ~rstw_in2;
    end

    // qa  23bitカウンタ
    always @(posedge clk) begin
      if(cnt_startp)
        qa <= {1'b0, cmd_ad};
      else if(cnt_ce & ~cnt_stop)
        qa <= qa + 1;
    end

    // wad  19bit
    always @(posedge clk) begin      // qa[15:13] : V IM No.   qa[12:10] : H IM No.
      wad <= {qa[15:0], qa[19:17]};  // qa[9:0]  : Pixel No.
    end                              // qa[19:17] : Coeff. No. MSB side

    // qb  8bitカウンタ
    always @(posedge clk) begin
      if(cnt_startp)
        qb <= 0;
      else if(cnt_ce & ~cnt_stop)
        qb <= qb + 1;
    end

    // cnt_stop_a
    assign cnt_stop_a = (qb[0] & byte_write) | (qb[7] & block_write) | qa[22];

    // cnt_stop_b
    always @(posedge clk) begin
      if(~rst & cnt_startp)
        cnt_stop_b <= 1'b0;
      else if(rst | cnt_stop_a)
        cnt_stop_b <= 1'b1;
    end

    // cnt_stop
    assign cnt_stop = cnt_stop_b | (rst | cnt_stop_a);

    // we
    always @(posedge clk) begin
      we <= weo & ~cnt_stop & (byte_write | block_write) & m4_cmd_cycle;
    end


    // dqm0a, dqm1a, dqm2a, dqm3a  (qa[16] : Coeff.No. LSB, qa[21] : high_byte)
    assign dqm0a = ~(({qa[16], qa[21]} == 2'd0) & (byte_write | block_write));
    assign dqm1a = ~(({qa[16], qa[21]} == 2'd1) & (byte_write | block_write));
    assign dqm2a = ~(({qa[16], qa[21]} == 2'd2) & (byte_write | block_write));
    assign dqm3a = ~(({qa[16], qa[21]} == 2'd3) & (byte_write | block_write));

    // dqm  4bit
    always @(posedge clk) begin
      dqm <= {dqm3a, dqm2a, dqm1a, dqm0a};
    end

    // wr_bank1
    always @(posedge clk) begin
      wr_bank1 <= qa[20];       // 0 のみ使用
    end

    // wdata  32bit
    always @(posedge clk) begin
      wdata[7:0]   <= dqm0a ? 8'd0 : rs_din;
      wdata[15:8]  <= dqm1a ? 8'd0 : rs_din;
      wdata[23:16] <= dqm2a ? 8'd0 : rs_din;
      wdata[31:24] <= dqm3a ? 8'd0 : rs_din;
    end

endmodule
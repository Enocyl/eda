`timescale 1ns / 1ns
// `default_nettype none

// XT
// M4係数用SRAM書き込み制御
// (電源立ち上げ時のクリア用 全アドレスに 32'd0 を書き込む)

module m4_mem_wctrl_clear_xt (c_done_dly, m4_cmd_cycle_stp, m4_cmd_cycle, clk,
                              wad, wr_bank1, mem_clear_done, we, dqm, wdata);

    input c_done_dly;
    input m4_cmd_cycle_stp;
    input m4_cmd_cycle;
    input clk;

    output [18:0] wad;
    output wr_bank1;
    output mem_clear_done;
    output reg we;
    output [3:0] dqm;
    output [31:0] wdata;


    reg c_done_dly_1d;
    reg [20:0] qa;

    wire mem_clear_st;


    // c_done_dly_1d
    always @(posedge clk) begin
      if(m4_cmd_cycle_stp)
        c_done_dly_1d <= c_done_dly;
    end

    // mem_clear_st
    assign mem_clear_st = c_done_dly & c_done_dly_1d;

    // qa  21bitカウンタ
    always @(posedge clk) begin
      if(~mem_clear_st)
        qa <= 0;
      else if(m4_cmd_cycle_stp & ~mem_clear_done)
        qa <= qa + 1;
    end

    // wad  19bit
    // wr_bank1
    // mem_clear_done
    assign wad = qa[18:0];
    assign wr_bank1 = qa[19];
    assign mem_clear_done = qa[20];

    // we
    always @(posedge clk) begin
      we <= m4_cmd_cycle & mem_clear_st & ~mem_clear_done;
    end

    // dqm  4bit
    assign dqm = 4'd0;

    // wdata  32bit
    assign wdata = 32'd0;

endmodule
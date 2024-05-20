`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board for PVII-4,-6 with MBI5051B
// GCLK出力

module gclkout_lcar_m5353Q_14b43Hz (blank, f50hz, xgclk,
                           c_done, m4_set_done, ovp, clk,
                           gclk, gclkout_start);

    input blank;
    input f50hz;
    input xgclk;   // GCLK作成用クロック

    input c_done;
    input m4_set_done;
    input ovp;
    input clk;     // 25MHz

    output gclk;
    output reg gclkout_start;

    reg blank_1d, blank_2d;
    reg [12:0] qa;
    reg [1:0] qb;
    reg [3:0] qc;
    reg gs_dout_last_tim_1d;
    reg gclkout_start_1d;

    wire [12:0] cnt_stop_m1;
    wire blank_endp;
    wire qa_stop;
    wire qb_ce;
    wire qb_ld;
    wire set_done;
    wire qc_stop;


// gclk作成

    // cnt_stop_m1  13bit
    //assign cnt_stop_m1 = f50hz ? 13'd2058 : 13'd2060;  // xgclkカウントのストップ値-1
    //assign cnt_stop_m1 = f50hz ? 13'd2058 : 13'd2064;  // xgclkカウントのストップ値-1
    //assign cnt_stop_m1 = 13'd1040;  					 // 14bits gray 256+1 gclks
    assign cnt_stop_m1 = 13'd1027;  					 // deadtime high > 300ns

    // blank_1d, blank_2d  [xgclk]
    always @(posedge xgclk) begin
      blank_1d <= blank;
      blank_2d <= blank_1d;
    end

    // blank_endp  (blankの立下り)
    assign blank_endp = ~blank_1d & blank_2d;

    // qa  13bitカウンタ  (xgclkカウント)  [xgclk]
    always @(posedge xgclk) begin
      if(blank_endp)
        qa <= 0;
      else if(~qa_stop)
        qa <= qa + 1;
    end

    // qa_stop
    assign qa_stop = (qa > cnt_stop_m1);

    // qb_ce
    //assign qb_ce = (qa < 13'd2048);
    assign qb_ce = (qa < 13'd1024);

    // qb_ld
    assign qb_ld = (qa == cnt_stop_m1);


    // gclkout_start_1d  [xgclk]
    always @(posedge xgclk) begin
      gclkout_start_1d <= gclkout_start;
    end


    // qb  2bitカウンタ  (gclk作成 1/4分周)  [xgclk]
    always @(posedge xgclk) begin
      if(blank_endp & gclkout_start_1d)
        qb <= 0;
      else if(qb_ld | ~gclkout_start_1d)
        qb <= 2'd3;
      else if(qb_ce)
        qb <= qb + 1;
    end

    // gclk
    assign gclk = ~qb[1];


// 起動時gclk出力停止信号作成  (以下 [clk])

    // set_done
    assign set_done = c_done & m4_set_done;

    // qc  4bitカウンタ
    always @(posedge clk) begin
      if(~set_done)
        qc <= 0;
      else if(ovp & ~qc_stop)
        qc <= qc + 1;
    end

    // qc_stop
    assign qc_stop = qc[3];  // 8

    // gclkout_start
    always @(posedge clk) begin
      gclkout_start <= qc_stop & set_done;
    end

endmodule
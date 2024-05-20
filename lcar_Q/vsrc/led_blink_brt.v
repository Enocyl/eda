`timescale 1ns / 1ns
// `default_nettype none

// LEAP_Receiver BD
// Input status LED の ブリンク輝度制御用
// Port A, Port B 共に入力有りの場合、表示に使用されていない側のブリンク輝度を下げる

module led_blink_brt (c_done, pa_rx_ok, pb_rx_ok, clk,
                      blink_on_time);

    input c_done;
    input pa_rx_ok;
    input pb_rx_ok;
    input clk;        // 25MHz

    output reg blink_on_time;

    reg [12:0] qa;
    //reg [4:0] qb;

    wire tp100us;


// blink_on_time 作成 (非選択chの点灯時間)

    // qa  13bitカウンタ (100us interval pulse 作成カウンタ)
    always @(posedge clk) begin
      if(~c_done | ~(pa_rx_ok & pb_rx_ok) | tp100us)
        qa <= 13'd1597;
      else
        qa <= qa + 1;
    end

    // tp100us
    assign tp100us = qa[12];  // 4096

	reg[9:0] qb;
    // qb  5bitカウンタ (100us interval pulse カウンタ)
    always @(posedge clk) begin
      if(~c_done | ~(pa_rx_ok & pb_rx_ok))
        qb <= 0;
      else if(tp100us)
        qb <= qb + 1;
    end

    // blink_on_time
    always @(posedge clk) begin
      //blink_on_time <= (qb == 5'd0);
      blink_on_time <= (qb == 10'd0);
    end

endmodule
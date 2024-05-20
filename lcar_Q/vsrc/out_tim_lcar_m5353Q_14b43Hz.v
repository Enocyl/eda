`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board for PVII-4,-6 with MBI5051B
// 出力タイミング作成
//
// サブモジュール
//   out_period_data_gen_a
//   (点灯サイクルの長さ設定用カウンタのロードデータ作成)
//

module out_tim_lcar_m5353Q_14b43Hz (frame_alt, fr_rate, f50hz, clk,
                             ov_stp, ovt, blanka);

    input frame_alt;
    input [15:0] fr_rate;
    input f50hz;
    input clk;        // 25MHz

    output reg ov_stp;
    output reg ovt;
    output blanka;

    reg frame_alt_1d, frame_alt_2d;
    reg long_period_sel;
    reg [12:0] qa;
    reg [10:0] qb;
    reg [6:0] qc;

    wire [10:0] period_num_m1;
    wire [11:0] period_num_a;
    wire [15:0] period_num;
    wire [11:0] period_d_a;
    wire [11:0] long_period_d_a;
    wire [15:0] long_period_num;
    wire [11:0] period_d;
    wire qa_endp;
    wire qb_eq1;
    wire qb_stop;
    wire blank_start_ena;
    wire qb_ce;
    wire disp_stp;


    // frame_alt_1d, frame_alt_2d, ov_stp
    always @(posedge clk) begin
      frame_alt_1d <= frame_alt;
      frame_alt_2d <= frame_alt_1d;
      ov_stp       <= frame_alt_1d ^ frame_alt_2d;
    end


    // period_num_m1  11bit
    // period_num_a  12bit
    // period_num  16bit
    //assign period_num_m1 = 11'd319;  // (1フレームの点灯サイクル数)-1
    assign period_num_m1 = 11'd1023;  // (1フレームの点灯サイクル数)-1
    //assign period_num_m1 = 11'd511;  // (1フレームの点灯サイクル数)-1
    assign period_num_a = period_num_m1 + 11'd1;
    assign period_num = {4'd0, period_num_a};


// サブモジュール out_period_data_gen_a

    out_period_data_gen_a  out_period_data_gen_a_0(
      .fr_rate           (fr_rate),     // 16bit  1.25MHzクロックでの1フレームカウント値
      .period_num        (period_num),  // 16bit  1フレームの点灯サイクル数
      .ov_stp            (ov_stp),      // スタートパルス
      .f50hz             (f50hz),       // 1:50Hz  0:60Hz
      .rst               (1'b0),        // リセット
      .clk               (clk),         // クロック

      .period_d          (period_d_a),       // 12bit 点灯サイクルの長さ設定用カウンタのロード値
      .long_period_d     (long_period_d_a),  // 12bit (period_d)-1 : 1clk分長い点灯サイクル作成用
      .long_period_num   (long_period_num)   // 16bit long_period_d を使用する点灯サイクル数/フレーム
    );


    // long_period_sel
    always @(posedge clk) begin
      long_period_sel <= ({5'd0, qb} < long_period_num);
    end

    // period_d  12bit
    assign period_d = long_period_sel ? long_period_d_a : period_d_a;

    // qa  13bitカウンタ  (点灯サイクルの長さ設定)
    always @(posedge clk) begin
      if(ov_stp | qa_endp)
        qa <= {1'b0, period_d};
      else
        qa <= qa + 1;
    end

    // qa_endp
    assign qa_endp = qa[12];  // 4096


    // qb  11bitカウンタ  (点灯periodカウント)
    always @(posedge clk) begin
      if(ov_stp)
        qb <= 0;
      else if(qb_ce)
        qb <= qb + 1;
    end

    // qb_eq1, qb_stop, blank_start_ena
    assign qb_eq1 = (qb == 11'd1);
 // assign qb_stop = (qb == period_num_m1);
    assign qb_stop = (qb > period_num_m1);
    assign blank_start_ena = (qb < period_num_m1);

    // qb_ce
    assign qb_ce = qa_endp & ~qb_stop;


    // ovt
    always @(posedge clk) begin
      if(ov_stp)
        ovt <= 1;
      else if(qa_endp & qb_eq1)
        ovt <= 0;
    end


    // disp_stp
 // assign disp_stp = ov_stp | qb_ce;
    assign disp_stp = (ov_stp & qb_stop) | (qa_endp & blank_start_ena);

    // qc  7bitカウンタ  (blanka作成)
    always @(posedge clk) begin
      if(disp_stp)
        //qc <= f50hz ? 7'd83 : 7'd90;  // MSB=1
        qc <= f50hz ? 7'd83 : 7'd80;  // MSB=1				//Hasco 2021.10
      else if(blanka)
        qc <= qc + 1;
    end

    // blanka
    assign blanka = qc[6];  // 64

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// LEAP Receiver BD
// 点灯サイクルの長さ設定用カウンタのロードデータ作成
//
// サブモジュール
//   div_28b_16b_int
//   (除算器 28bit / 16bit 正の整数) 

module out_period_data_gen_a (fr_rate, period_num, ov_stp, f50hz, rst, clk,
                              period_d, long_period_d, long_period_num);

    input [15:0] fr_rate;     // LEAP-HD processorからのframe rate情報データ
                              // 1.25MHzクロックでの1フレームカウント値
    input [15:0] period_num;  // 1フレームの点灯サイクル数
    input ov_stp;
    input f50hz;
    input rst;
    input clk;

    output reg [11:0] period_d;         // 点灯サイクルの長さ設定用カウンタのロード値
    output reg [11:0] long_period_d;    // (period_d)-1 : 1clk分長い点灯サイクル作成用
    output reg [15:0] long_period_num;  // long_period_d を使用する点灯サイクル数/フレーム

    reg [15:0] fr_rate_d;
    reg [15:0] f60_rate;
    reg [15:0] f50_rate;
    reg [15:0] fr_dat;
    reg [20:0] fr_dat_b;
    reg ov_stp_1d, ov_stp_2d, ov_stp_3d, ov_stp_4d, ov_stp_5d;
    reg calc_busy_1d;
    reg [11:0] period;
    reg [15:0] long_period_num_b;

    wire [31:0] fr_dat_a;
    wire [27:0] period_a;
    wire [15:0] long_period_num_a;
    wire calc_busy;
    wire calc_done;
    wire [12:0] period_d_a;
    wire [12:0] long_period_d_a;


    // fr_rate_d  16bit
    always @(posedge clk) begin
      if(ov_stp)
        fr_rate_d <= fr_rate;
    end

    // f60_rate  16bit
    always @(posedge clk) begin
      if(fr_rate_d < 16'd20491)
        f60_rate <= 16'd20491;
      else if(fr_rate_d > 16'd21245)
        f60_rate <= 16'd21245;
      else
        f60_rate <= fr_rate_d;
    end

    // f50_rate  16bit
    always @(posedge clk) begin
      if(fr_rate_d < 16'd24509)
        f50_rate <= 16'd24509;
      else if(fr_rate_d > 16'd25511)
        f50_rate <= 16'd25511;
      else
        f50_rate <= fr_rate_d;
    end

    // fr_dat  16bit
    always @(posedge clk) begin
      fr_dat <= f50hz ? f50_rate : f60_rate;
    end

    // fr_dat_a  32bit
    assign fr_dat_a = fr_dat * 16'd40940;

    // fr_dat_b  21bit
    always @(posedge clk) begin
      //fr_dat_b <= fr_dat_a[31:11];
      //fr_dat_b <= 21'd1666667;						//Hasco 2021.09  - 15HZ
      //fr_dat_b <= 21'd833333;							//Hasco 2021.09  - 30HZ
      //fr_dat_b <= 21'd1152000;							//Hasco 2021.09  - 21HZ
      //fr_dat_b <= 21'd1249999;							//Hasco 2021.09  - 21HZ
      fr_dat_b <= 21'd585728;							//Hasco 2021.09  - 43HZ
    end

    // ov_stp_1d, ov_stp_2d, ov_stp_3d, ov_stp_4d, ov_stp_5d
    always @(posedge clk) begin
      ov_stp_1d <= ov_stp;
      ov_stp_2d <= ov_stp_1d;
      ov_stp_3d <= ov_stp_2d;
      ov_stp_4d <= ov_stp_3d;
      ov_stp_5d <= ov_stp_4d;
    end


// サブモジュール div_28b_16b_int  (除算器 28bit / 16bit 正の整数)

    div_28b_16b_int  div_28b_16b_int_0(
      .z       ({7'd0, fr_dat_b}),   // 28bit 被除数
      .d       (period_num),         // 16bit 除数
      .startp  (ov_stp_5d),          // スタートパルス
      .rst     (rst),                // リセット
      .clk     (clk),                // クロック

      .q       (period_a),           // 28bit 商
      .r       (long_period_num_a),  // 16bit 余
      .busy    (calc_busy)           // 計算中
    );


    // calc_busy_1d
    always @(posedge clk) begin
      calc_busy_1d <= calc_busy;
    end

    // calc_done
    assign calc_done = ~calc_busy & calc_busy_1d;

    // period  12bit
    always @(posedge clk) begin
      if(calc_done)
        period <= (period_a[27:12] == 16'd0) ? period_a[11:0] : 12'hfff;
    end

    // long_period_num_b  16bit
    always @(posedge clk) begin
      if(calc_done)
        long_period_num_b <= long_period_num_a;
    end

    // long_period_num  16bit
    always @(posedge clk) begin
      long_period_num <= long_period_num_b;
    end


    // period_d_a  13bit
    assign period_d_a = {1'b0, ~period} + 13'd2;

    // period_d  12bit
    always @(posedge clk) begin
      period_d <= period_d_a[12] ? 12'hfff : period_d_a[11:0];
    end


    // long_period_d_a  13bit
    assign long_period_d_a = {1'b0, ~period} + 13'd1;

    // long_period_d  12bit
    always @(posedge clk) begin
      long_period_d <= long_period_d_a[12] ? 12'hfff : long_period_d_a[11:0];
    end

endmodule
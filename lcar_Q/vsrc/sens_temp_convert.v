`timescale 1ns / 1ns
// `default_nettype none

// MPC-II for Nasdaq
// EMBからの温度データを
// LCM processor へのリターンデータフォーマットへ変換
//
// サブモジュール
//   div_28b_16b_int
//   (除算器 28bit / 16bit 正の整数) 

module sens_temp_convert(temp_din, data_startp, rst, clk,
                         temp_dout, calc_done);

    input  [15:0] temp_din;
    input  data_startp, rst, clk;

    output [11:0] temp_dout;
    output        calc_done;

    reg [15:0] dinb;
    reg [27:0] dinc;
    reg data_startp_1d, data_startp_2d;
    reg calc_busy_1d;

    wire [16:0] dina;
    wire over_temp;
    wire [27:0] doa;
    wire calc_busy;


    // dina  17bit  入力データ 2'c を STB に変換後 18688 を引く(16'hb700 足す)
    assign dina = {~temp_din[15], temp_din[14:0]} + 16'hb700;

    // over_temp  +125degC をオーバー
    assign over_temp = (dina[15:0] > 16'd46080);

    // dinb  16bit  OF/UF (-55degC -- +125degC)
    always @(posedge clk) begin
      case ({dina[16], over_temp})
        2'h0: dinb <= 16'd0;
        2'h1: dinb <= 16'd0;
        2'h2: dinb <= dina[15:0];
        2'h3: dinb <= 16'd46080;
      endcase
    end

    // dinc  28bit  (dinb * 4095) = (dinb * 4096 - dinb)
    always @(posedge clk) begin
      dinc <= {dinb, 12'h000} + {12'hfff, ~dinb} + 28'd1;
    end

    // data_startp_1d, data_startp_2d
    always @(posedge clk) begin
      data_startp_1d <= data_startp;
      data_startp_2d <= data_startp_1d;
    end


// サブモジュール div_28b_16b_int  (除算器 28bit / 16bit 正の整数)

    div_28b_16b_int  div_28b_16b_int_0(
      .z                 (dinc),           // 28bit 被除数
      .d                 (16'hb400),       // 16bit 除数 (16'd46080)
      .startp            (data_startp_2d), // スタートパルス
      .rst               (rst),            // リセット
      .clk               (clk),            // クロック

      .q                 (doa),            // 28bit 商
      .r                 (),               // 16bit 余
      .busy              (calc_busy)       // 計算中
    );


    // temp_dout  12bit  出力データ
    assign temp_dout = doa[11:0];


    // calc_busy_1d
    always @(posedge clk) begin
      calc_busy_1d <= calc_busy;
    end

    // calc_done
    assign calc_done = ~calc_busy & calc_busy_1d;

endmodule
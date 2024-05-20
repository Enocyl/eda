`timescale 1ns / 1ns
// `default_nettype none

// MPC-II
// 除算 28bit/16bit 正の整数
//
//  z / d = q .. r
//

module div_28b_16b_int(
    z      ,  // 被除数
    d      ,  // 除数
    startp ,  // スタートパルス
    clk    ,  // クロック
    rst    ,  // リセット

    q      ,  // 商
    r      ,  // 余
    busy   ); // 計算中

    input  [27:0]  z      ;
    input  [15:0]  d      ;
    input          startp ;
    input          clk    ;
    input          rst    ;

    output [27:0]  q      ;
    output [15:0]  r      ;
    output         busy   ;

    reg    [ 4:0]  i      ;
    reg    [43:0]  zr     ;
    reg    [15:0]  dr     ;

    wire           en_seq ;
    wire   [16:0]  pr     ;
    wire   [16:0]  sb     ;
    wire           pq     ;
    wire   [15:0]  mx     ;
    wire   [43:0]  zw     ;


 // sequence (シーケンサ)

    // en_seq
    assign en_seq = (i > 0);

    // i  5bit
    always @(posedge clk) begin
      if(rst)
        i <= 5'h00;
      else if(startp)
        i <= 5'h1c;
      else if(en_seq)
        i <= i - 1'b1;
    end


 // function (演算処理部)

    // pr  17bit  前サイクルのシフトアップ済み部分余
    assign pr = zr[43:27];

    // sb  17bit  部分余 - 除数
    assign sb = pr - {1'b0, dr};

    // pq         減算結果の符号を反転し部分商とする
    assign pq = ~sb[16];

    // mx  16bit  減算前と後を減算結果により選択
    assign mx = (sb[16]) ? pr[15:0] : sb[15:0];

    // zw  44bit  次サイクル用zrレジスタ内容
    assign zw = {mx, zr[26:0], pq};

    // zr  44bit  被除数,商,余 格納レジスタ
    always @(posedge clk) begin
      if(startp)
        zr <= {16'h0000, z};
      else if(en_seq)
        zr <= zw;
    end

    // dr  16bit  除数 格納レジスタ
    always @(posedge clk) begin
      if(startp)
        dr <= d;
    end

    // q  商  28bit
    assign q = zr[27:0];

    // r  余  16bit
    assign r = zr[43:28];

    // busy  計算中
    assign busy = en_seq;

endmodule
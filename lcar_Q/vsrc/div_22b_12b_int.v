`timescale 1ns / 1ns
// `default_nettype none

// MPC-II
// 除算 22bit/12bit 正の整数
//
//  z / d = q .. r
//

module div_22b_12b_int(
    z      ,  // 被除数
    d      ,  // 除数
    startp ,  // スタートパルス
    clk    ,  // クロック
    rst    ,  // リセット

    q      ,  // 商
    r      ,  // 余
    busy   ); // 計算中

    input  [21:0]  z      ;
    input  [11:0]  d      ;
    input          startp ;
    input          clk    ;
    input          rst    ;

    output [21:0]  q      ;
    output [11:0]  r      ;
    output         busy   ;

    reg    [ 4:0]  i      ;
    reg    [33:0]  zr     ;
    reg    [11:0]  dr     ;

    wire           en_seq ;
    wire   [12:0]  pr     ;
    wire   [12:0]  sb     ;
    wire           pq     ;
    wire   [11:0]  mx     ;
    wire   [33:0]  zw     ;


 // sequence (シーケンサ)

    // en_seq
    assign en_seq = (i > 0);

    // i  5bit
    always @(posedge clk) begin
      if(rst)
        i <= 5'h00;
      else if(startp)
        i <= 5'h16;
      else if(en_seq)
        i <= i - 1'b1;
    end


 // function (演算処理部)

    // pr  13bit  前サイクルのシフトアップ済み部分余
    assign pr = zr[33:21];

    // sb  13bit  部分余 - 除数
    assign sb = pr - {1'b0, dr};

    // pq         減算結果の符号を反転し部分商とする
    assign pq = ~sb[12];

    // mx  12bit  減算前と後を減算結果により選択
    assign mx = (sb[12]) ? pr[11:0] : sb[11:0];

    // zw  34bit  次サイクル用zrレジスタ内容
    assign zw = {mx, zr[20:0], pq};

    // zr  34bit  被除数,商,余 格納レジスタ
    always @(posedge clk) begin
      if(startp)
        zr <= {12'h000, z};
      else if(en_seq)
        zr <= zw;
    end

    // dr  12bit  除数 格納レジスタ
    always @(posedge clk) begin
      if(startp)
        dr <= d;
    end

    // q  商
    assign q = zr[21:0];

    // r  余
    assign r = zr[33:22];

    // busy  計算中
    assign busy = en_seq;

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board for ImapctIII-6
// Test pattern 用 Line memory
//
// サブモジュール
//   sdp_bram_a8b_d30b  (Line memory)
//

module test_pat_mem_impact3_6 (din, lm_wa, lm_we, wclk, vwa,
                     fm_cycle_stp_adv, frame_alt, clk,
                     dout, fm_iv_wr_cycle, fm_wr_adrs, pad_adrs);

    input [29:0] din;        // Test pattern 入力  R(29:20), G(19:10), B(9:0)
    input [7:0] lm_wa;       // Line memory write address
    input lm_we;             // Line memory write enable
    input wclk;              // Line memory write clock 25MHz
    input [7:0] vwa;         // 書き込み側 垂直アドレス

    input fm_cycle_stp_adv;  // Frame memory 処理 cycle pulse, 72clock周期
    input frame_alt;         // Frame alternate
    input clk;               // 125MHz

    output reg [29:0] dout;         // Test pattern 出力  R(29:20), G(19:10), B(9:0)
    output reg fm_iv_wr_cycle;      // Frame memory input video write cycle
    output reg [16:0] fm_wr_adrs;   // Frame memory write address
    output [15:0] pad_adrs;         // Panel address display 用 read address


    reg lm_we_1d, lm_we_2d;
    reg fm_wr_req;
    reg [4:0] qra;
    reg [4:0] qrb;
    reg [3:0] qrb_1d, qrb_2d;
    reg frm_alt_d;
    reg [7:0] vra;
    reg [7:0] fm_wr_adrs_a;

    wire [29:0] lm_dout;
    wire lm_wr_endp;
    wire qra_rst;
    wire qra_stop;
    wire qrb_stop;
    wire [7:0] lm_ra;


// ラインメモリ

  // サブモジュール Block RAM 

    sdp_bram_a8b_d30b  sdp_bram_a8b_d30b_0(
      .dina   (din),      // 30bit
      .wea    (lm_we),    // 1bit
      .addra  (lm_wa),    // 8bit
      .clka   (wclk),     // 25MHz
      .doutb  (lm_dout),  // 30bit
      .addrb  (lm_ra),    // 8bit
      .clkb   (clk)       // 125MHz
    );


// データ出力

    // dout  30bit  {r, g, b} 各10bit
    always @(posedge clk) begin
      dout <= lm_dout;
    end


// Line Memory Read Control

    // lm_we_1d, lm_we_2d
    always @(posedge clk) begin
      lm_we_1d <= lm_we;
      lm_we_2d <= lm_we_1d;
    end

    // lm_wr_endp
    assign lm_wr_endp = ~lm_we_1d & lm_we_2d;

    // fm_wr_req
    always @(posedge clk) begin
      if(lm_wr_endp)
        fm_wr_req <= 1;
      else if(fm_cycle_stp_adv)
        fm_wr_req <= 0;
    end

    // qra_rst
    assign qra_rst = fm_wr_req & fm_cycle_stp_adv;

    // qra  5bitカウンタ (Frame memory 処理 cycle カウンタ, Line memory read address 上位 bit)
    always @(posedge clk) begin
      if(qra_rst)
        qra <= 0;
      else if(fm_cycle_stp_adv & ~qra_stop)
        qra <= qra + 1;
    end

    // qra_stop
    assign qra_stop = (qra > 5'd15);

    // fm_iv_wr_cycle
    always @(posedge clk) begin
      fm_iv_wr_cycle <= ~qra_stop;
    end


    // qrb  5bitカウンタ (Line memory read address 下位 bit)
    always @(posedge clk) begin
      if(fm_cycle_stp_adv)
        qrb <= 0;
      else if(~qra_stop & ~qrb_stop)
        qrb <= qrb + 1;
    end

    // qrb_stop
    assign qrb_stop = qrb[4];  // 16


    // qrb_1d, qrb_2d  4bit
    always @(posedge clk) begin
      qrb_1d <= qrb[3:0];
      qrb_2d <= qrb_1d;
    end

    // lm_ra  8bit  (Line memory read address)
    assign lm_ra = {qra, qrb_2d};


// Frame memory write address 出力

    // frm_alt_d
    always @(posedge clk) begin
      if(qra_rst)
        frm_alt_d <= frame_alt;
    end

    // vra  8bit (v read address)
    always @(posedge clk) begin
      if(qra_rst)
        vra <= vwa;
    end

    // fm_wr_adrs_a  8bit
    always @(posedge clk) begin
      fm_wr_adrs_a <= lm_ra[7:0];
    end

    // fm_wr_adrs  17bit (Frame memory write address)
    always @(posedge clk) begin
      fm_wr_adrs[16:8] <= {frm_alt_d, vra};  // 9bit Row address
      fm_wr_adrs[7:0]  <= fm_wr_adrs_a;      // 8bit Column address
    end


// Panel address display 用 read address 出力

    // pad_adrs  16bit
    assign pad_adrs = {vra, qra[3:0], qrb[3:0]};

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// pac_stp generator

module pac_stp_gen (int_vp, rx_pac_stp, rx_vp_sel, clk,
                    pac_stp);

    input int_vp;      // internal frame start timing pulse (1clk width pulse (125MHz clk))
    input rx_pac_stp;  // RX Packet start pulse
    input rx_vp_sel;   // RX timing signal select
    input clk;         // 125MHz

    output reg pac_stp;  // Packet start pulse


    reg [11:0] qa;
    reg qa_endp;
    reg [11:0] qb;
    reg [10:0] qc;
    reg video_packet;

    wire int_pac_stp;
    wire cnt_en;


// タイミング作成 (int_pac_stp 作成)

    // qa  12bitカウンタ (Byte カウンタ)
    always @(posedge clk) begin
      if(int_pac_stp)
        qa <= 0;
      else if(cnt_en)
        qa <= qa + 1;
    end

    // qa_endp
    always @(posedge clk) begin
      qa_endp <= video_packet ? (qa == 12'd1942) : (qa == 12'd2070);
    end

    // int_pac_stp
    assign int_pac_stp = int_vp | qa_endp;

    // qb  12bitカウンタ (カウントイネーブル作成)
    always @(posedge clk) begin
      if(int_vp)
        qb <= 12'd3055;  // MSB=1
      else if(qa_endp)
        qb <= qb + 1;
    end

    // cnt_en
    assign cnt_en = qb[11];

    // qc  11bitカウンタ (Packet カウンタ)
    always @(posedge clk) begin
      if(int_vp)
        qc <= 0;
      else if(qa_endp)
        qc <= qc + 1;
    end

    // video_packet
    always @(posedge clk) begin
      video_packet <= (qc >= 11'd16);
    end


// pac_stp 選択出力

    // pac_stp
    always @(posedge clk) begin
      pac_stp <= rx_vp_sel ? rx_pac_stp : int_pac_stp;
    end

endmodule
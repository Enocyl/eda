`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// Video 入力処理
//
// サブモジュール
//   sdp_bram_a14b_d30b  (Video 64 Line memory)
//

module video_input_256x256 (pac_stp, vp, h_size, v_size, hstp, vstp, d,
                    fm_cycle_stp_adv, frame_alt, clk,
                    dout, video_st_pac, fm_iv_wr_cycle, fm_wr_adrs, pad_adrs,
                    pix_ce, video_stp, lm_wr_stp, lm_we);

    input pac_stp;           // Packet start pulse, Preamble の 1clock 前, 1clock幅
    input vp;                // V start pulse, pac_stp と同相, 1clock幅
    input [10:0] h_size;     // Video 入力の (水平pixel数 - 1)
    input [10:0] v_size;     // Video 入力の (垂直pixel数 - 1)
    input [10:0] hstp;       // Video 入力からの水平取り込み開始位置
    input [10:0] vstp;       // Video 入力からの垂直取り込み開始位置
    input [7:0] d;           // Packet data (Video 入力)
    input fm_cycle_stp_adv;  // Frame memory 処理 cycle pulse, 72clock周期
    input frame_alt;         // Frame alternate
    input clk;               // 125MHz

    output reg [29:0] dout;        // Video 出力
    output reg video_st_pac;       // Video start packet
    output reg fm_iv_wr_cycle;     // Frame memory input video write cycle
    output reg [16:0] fm_wr_adrs;  // Frame memory write address
    output     [15:0] pad_adrs;    // Panel display read address

// チェック用出力
    output reg pix_ce;
    output     video_stp;
    output     lm_wr_stp;
    output reg lm_we;


    reg [4:0] qa;
    reg dat_stp;
    reg [3:0] qb;
    reg qb_end;
    reg [7:0] qc;
    reg [1:0] pix_cycle;
    reg [10:0] pn;
    reg [10:0] h_pix;
    reg h_pix_end;
    reg [11:0] v_pix;
    reg pix_cnt_stop;
    reg h_wr_st, v_wr_st;
    reg hv_wr_st_1d;
    reg [10:0] hwa;
    reg hwa_over;
    reg hwa_end;
    reg h_wr_last;
    reg [8:0] vwa;
    reg [13:0] lm_wa;
    reg [11:0] hbl;
    reg hblk;
    reg [11:0] vbl;
    reg vblk;
    reg [7:0] d_1d, d_2d, d_3d, d_4d, d_5d;
    reg [9:0] rin, gin, bin;
    reg lm_wr_1st;
    reg lm_rd_vt;
    reg lm_wr_h_end;
    reg [4:0] qra;
    reg qra_end;
    reg [4:0] qrb;
    reg [3:0] qrb_1d, qrb_2d;
    reg [8:0] vra;
    reg lm_wr_fast;
    reg h_rd_wait;
    reg frm_alt;
    reg frm_alt_d;
    reg [7:0] fm_wr_adrs_a;

    wire qa_stop;
    wire qb_eq2, qb_eq5, qb_eq9, qb_eq13;
    wire qb_rst;
    wire qb_stop;
    wire pn_stop;
    wire h_pix_rst;
    wire h_pix_endp;
    wire hv_wr_st;
    wire hwa_rst;
    wire hwa_endp;
    wire h_wr_lastp;
    wire vwa_over;
    wire blk;
    wire [29:0] lm_din;
    wire lm_wr_1st_endp;
    wire lm_rd_vstp;
    wire lm_wr_h_endp;
    wire qra_rst;
    wire qra_stop;
    wire h_rd_endp;
    wire qrb_stop;
    wire vra_over;
    wire [8:0] vra_p1;
    wire h_rd_stp;
    wire [13:0] lm_ra;
    wire [29:0] lm_dout;


// タイミング信号作成

    // qa  5bitカウンタ (パケットデータスタートタイミング設定)
    always @(posedge clk) begin
      if(pac_stp)
        qa <= 0;
      else if(~qa_stop)
        qa <= qa + 1;
    end

    // qa_stop
    assign qa_stop = qa[4];  // 16

    // dat_stp
    always @(posedge clk) begin
      dat_stp <= (qa == 5'd8);
    end

    // qb  4bitカウンタ (パケットデータ部 15分周, 4pixels / 15Bytes)
    always @(posedge clk) begin
      if(qb_rst)
        qb <= 0;
      else if(~qb_stop)
        qb <= qb + 1;
    end

    // qb_eq2, qb_eq5, qb_eq9, qb_eq13
    assign qb_eq2  = (qb == 4'd2);
    assign qb_eq5  = (qb == 4'd5);
    assign qb_eq9  = (qb == 4'd9);
    assign qb_eq13 = (qb == 4'd13);

    // pix_ce 　(pixelデータ取込みタイミング)
    always @(posedge clk) begin
      pix_ce <= (qb_eq2 | qb_eq5 | qb_eq9 | qb_eq13);
    end

    // qb_end
    always @(posedge clk) begin
      qb_end <= qb_eq13;
    end

    // qb_rst
    assign qb_rst = dat_stp | qb_end;

    // qc  8bitカウンタ (パケットデータ長 15x128=1920 Bytes)
    always @(posedge clk) begin
      if(dat_stp)
        qc <= 0;
      else if(qb_end)
        qc <= qc + 1;
    end

    // qb_stop
    assign qb_stop = qc[7];  // 128


    // pix_cycle  2bitカウンタ (4pixel識別信号)
    always @(posedge clk) begin
      if(dat_stp)
        pix_cycle <= 0;
      else if(pix_ce)
        pix_cycle <= pix_cycle + 1;
    end


    // pn  11bitカウンタ  (Packet Number 作成)
    always @(posedge clk) begin
      if(vp)
        pn <= 0;
      else if(pac_stp & ~pn_stop)
        pn <= pn + 1;
    end

    // pn_stop
    assign pn_stop = pn[10] & pn[9];  // 1024+512=1536

    // video_st_pac  (Video start packet)
    always @(posedge clk) begin
      video_st_pac <= (pn == 11'd16);
    end

    // video_stp  (Video start pulse)
    assign video_stp = dat_stp & video_st_pac;


    // h_pix  11bitカウンタ  (h pixelカウンタ)
    always @(posedge clk) begin
      if(h_pix_rst)
        h_pix <= 0;
      else if(pix_ce & ~pix_cnt_stop)
        h_pix <= h_pix + 1;
    end

    // h_pix_end
    always @(posedge clk) begin
      h_pix_end <= (h_pix == h_size);
    end

    // h_pix_endp
    assign h_pix_endp = pix_ce & h_pix_end;

    // h_pix_rst
    assign h_pix_rst = video_stp | h_pix_endp;

    // v_pix  12bitカウンタ  (v pixelカウンタ)
    always @(posedge clk) begin
      if(video_stp)
        v_pix <= 0;
      else if(h_pix_endp)
        v_pix <= v_pix + 1;
    end

    // pix_cnt_stop
    always @(posedge clk) begin
      pix_cnt_stop <= (v_pix > {1'b0, v_size});
    end


// Line Memory Write Control

    // h_wr_st, v_wr_st
    always @(posedge clk) begin
      h_wr_st <= (h_pix == hstp);
      v_wr_st <= (v_pix == {1'b0, vstp});
    end

    // hv_wr_st
    assign hv_wr_st = h_wr_st & v_wr_st;

    // hv_wr_st_1d
    always @(posedge clk) begin
      hv_wr_st_1d <= hv_wr_st;
    end

    // lm_wr_stp
    assign lm_wr_stp = hv_wr_st & ~hv_wr_st_1d;


    // hwa  11bitカウンタ  (h write addressカウンタ)
    always @(posedge clk) begin
      if(hwa_rst)
        hwa <= 0;
      else if(pix_ce & ~vwa_over)
        hwa <= hwa + 1;
    end

    // hwa_over
    always @(posedge clk) begin
      hwa_over <= (hwa > 11'd255);
    end

    // hwa_end
    always @(posedge clk) begin
      hwa_end <= (hwa == h_size);
    end

    // hwa_endp
    assign hwa_endp = pix_ce & hwa_end;

    // hwa_rst
    assign hwa_rst = lm_wr_stp | hwa_endp;


    // h_wr_last
    always @(posedge clk) begin
      h_wr_last <= (hwa == 11'd255);
    end

    // h_wr_lastp
    assign h_wr_lastp = pix_ce & h_wr_last;


    // vwa  9bitカウンタ  (v write addressカウンタ)
    always @(posedge clk) begin
      if(lm_wr_stp)
        vwa <= 0;
      else if(h_wr_lastp)
        vwa <= vwa + 1;
    end

    // vwa_over
    assign vwa_over = vwa[8];  // 256

    // lm_we  (Line memory write enable)
    always @(posedge clk) begin
      lm_we <= pix_ce & ~hwa_over & ~vwa_over;
    end

    // lm_wa  14bit  (64 Line memory write address)
    always @(posedge clk) begin
      lm_wa <= {vwa[5:0], hwa[7:0]};
    end


// Line memory 入力 video データ用 blanking 信号作成

    // hbl  12bitカウンタ  (h blanking 作成用カウンタ)
    always @(posedge clk) begin
      if(hwa_rst)
        hbl <= {1'b0, hstp};
      else if(pix_ce & ~hblk)
        hbl <= hbl + 1;
    end

    // hblk
    always @(posedge clk) begin
      hblk <= (hbl > {1'b0, h_size}) & ~hwa_rst;
    end

    // vbl  12bitカウンタ  (v blanking 作成用カウンタ)
    always @(posedge clk) begin
      if(lm_wr_stp)
        vbl <= {1'b0, vstp};
      else if(h_wr_lastp & ~vblk)
        vbl <= vbl + 1;
    end

    // vblk
    always @(posedge clk) begin
      vblk <= (vbl > {1'b0, v_size}) & ~lm_wr_stp;
    end

    // blk
    assign blk = hblk | vblk;



// Video データ入力

    // d_1d, d_2d, d_3d, d_4d, d_5d  8bit
    always @(posedge clk) begin
      d_1d <= d;
      d_2d <= d_1d;
      d_3d <= d_2d;
      d_4d <= d_3d;
      d_5d <= d_4d;
    end

    // rin  10bit
    always @(posedge clk) begin
      if(pix_ce) begin
        case ({blk, pix_cycle})
          3'h0:    rin <= {d_4d[1:0], d_5d[7:0]};
          3'h1:    rin <= {d_4d[7:0], d_5d[7:6]};
          3'h2:    rin <= {d_4d[5:0], d_5d[7:4]};
          3'h3:    rin <= {d_4d[3:0], d_5d[7:2]};
          default: rin <= 10'd0;
        endcase
      end
    end

    // gin  10bit
    always @(posedge clk) begin
      if(pix_ce) begin
        case ({blk, pix_cycle})
          3'h0:    gin <= {d_3d[3:0], d_4d[7:2]};
          3'h1:    gin <= {d_2d[1:0], d_3d[7:0]};
          3'h2:    gin <= {d_3d[7:0], d_4d[7:6]};
          3'h3:    gin <= {d_3d[5:0], d_4d[7:4]};
          default: gin <= 10'd0;
        endcase
      end
    end

    // bin  10bit
    always @(posedge clk) begin
      if(pix_ce) begin
        case ({blk, pix_cycle})
          3'h0:    bin <= {d_2d[5:0], d_3d[7:4]};
          3'h1:    bin <= {d_1d[3:0], d_2d[7:2]};
          3'h2:    bin <= {d_1d[1:0], d_2d[7:0]};
          3'h3:    bin <= {d_2d[7:0], d_3d[7:6]};
          default: bin <= 10'd0;
        endcase
      end
    end

    // lm_din  30bit  (Line memory data input)
    assign lm_din = {rin, gin, bin};


// Line Memory Read Control

    // lm_wr_1st
    always @(posedge clk) begin
      if(lm_wr_stp)
        lm_wr_1st <= 1;
      else if(h_wr_lastp)
        lm_wr_1st <= 0;
    end

    // lm_wr_1st_endp
    assign lm_wr_1st_endp = lm_wr_1st & h_wr_lastp;

    // lm_rd_vt
    always @(posedge clk) begin
      if(lm_wr_1st_endp)
        lm_rd_vt <= 1;
      else if(fm_cycle_stp_adv)
        lm_rd_vt <= 0;
    end

    // lm_rd_vstp
    assign lm_rd_vstp = lm_rd_vt & fm_cycle_stp_adv;


    // lm_wr_h_end
    always @(posedge clk) begin
      if(h_wr_lastp)
        lm_wr_h_end <= 1;
      else if(fm_cycle_stp_adv)
        lm_wr_h_end <= 0;
    end

    // lm_wr_h_endp
    assign lm_wr_h_endp = lm_wr_h_end & fm_cycle_stp_adv;


    // qra_rst
    assign qra_rst = lm_rd_vstp | (h_rd_stp & ~vra_over);

    // qra  5bitカウンタ (Frame memory 処理 cycle カウンタ, Line memory read address 上位 bit)
    always @(posedge clk) begin
      if(qra_rst)
        qra <= 0;
      else if(fm_cycle_stp_adv & ~qra_stop & ~vra_over)
        qra <= qra + 1;
    end

    // qra_stop
    assign qra_stop = qra[4];  // 16

    // fm_iv_wr_cycle
    always @(posedge clk) begin
      fm_iv_wr_cycle <= ~qra_stop;
    end


    // qra_end
    always @(posedge clk) begin
      qra_end <= (qra == 5'd15);
    end

    // h_rd_endp
    assign h_rd_endp = qra_end & fm_cycle_stp_adv;


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


    // vra  9bitカウンタ (v read address)
    always @(posedge clk) begin
      if(lm_rd_vstp)
        vra <= 0;
      else if(h_rd_endp)
        vra <= vra + 1;
    end

    // vra_over
    assign vra_over = vra[8];  // 256


    // vra_p1  9bit
    assign vra_p1 = vra + 9'd1;

    // lm_wr_fast
    always @(posedge clk) begin
      lm_wr_fast <= (vwa > vra_p1);
    end


    // h_rd_wait
    always @(posedge clk) begin
      if(lm_rd_vstp)
        h_rd_wait <= 0;
      else if(h_rd_endp & ~lm_wr_fast)
        h_rd_wait <= 1;
      else if(lm_wr_h_endp)
        h_rd_wait <= 0;
    end

    // h_rd_stp
    assign h_rd_stp = (h_rd_endp & lm_wr_fast) | (lm_wr_h_endp & h_rd_wait);


    // lm_ra  14bit  (64 Line memory read address)
    assign lm_ra = {vra[5:0], qra[3:0], qrb_2d};


// ラインメモリ

  // サブモジュール Block RAM 

    sdp_bram_a14b_d30b  sdp_bram_a14b_d30b_0(
      .dina   (lm_din),   // 30bit
      .wea    (lm_we),    // 1bit
      .addra  (lm_wa),    // 14bit
      .clka   (clk),
      .doutb  (lm_dout),  // 30bit
      .addrb  (lm_ra),    // 14bit
      .clkb   (clk)
    );


// Video データ出力

    // dout  30bit  {r, g, b} 各10bit
    always @(posedge clk) begin
      dout <= lm_dout;
    end


// Frame memory write address 出力

    // frm_alt
    always @(posedge clk) begin
      if(lm_wr_stp)
        frm_alt <= frame_alt;
    end

    // frm_alt_d
    always @(posedge clk) begin
      if(qra_rst)
        frm_alt_d <= frm_alt;
    end


    // fm_wr_adrs_a  8bit
    always @(posedge clk) begin
      fm_wr_adrs_a <= lm_ra[7:0];
    end

    // fm_wr_adrs  17bit (Frame memory write address)
    always @(posedge clk) begin
      fm_wr_adrs[16:8] <= {frm_alt_d, vra[7:0]};  // 9bit Row address
      fm_wr_adrs[7:0]  <= fm_wr_adrs_a;           // 8bit Column address
    end


// Panel address display 用 read address 出力

    // pad_adrs  16bit
    assign pad_adrs = {vra[7:0], qra[3:0], qrb[3:0]};

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// Frame memory output video write

module fm_out_video_write_pv2_4_4x4

      (fm_cycle_stp_adv, fm_iv_rd_cycle, fm_iv_wr_cycle, fm_ov_rd_cycle, ovp, frame_alt,
       r_din, g_din, b_din, clk, 
       fm_ov_wr_adrs, fm_ov_wr_cycle, fm_ov_wr_d);

    input fm_cycle_stp_adv;        // Frame memory 処理 cycle pulse, 72clock周期
    input fm_iv_rd_cycle;          // Frame memory input video read cycle
    input fm_iv_wr_cycle;          // Frame memory input video write cycle
    input fm_ov_rd_cycle;          // Frame memory output video read cycle
    input ovp;                     // V start pulse, 1clock幅
    input frame_alt;               // Frame alternate
    input [15:0] r_din;            // Red data
    input [15:0] g_din;            // Green data
    input [15:0] b_din;            // Blue data
    input clk;                     // 125MHz

    output [18:0] fm_ov_wr_adrs;   // Frame memory output video write address
    output fm_ov_wr_cycle;         // Frame memory input video read cycle
    output reg [31:0] fm_ov_wr_d;  // Frame memory output video write data

    reg fm_cycle_stp_adv_1d;
    reg fm_cycle_stp;
    reg [6:0] qa;
    reg fm_iv_rd_ena_cycle_1d;
    reg latch1_tim, latch2_tim, latch3_tim, latch4_tim, rgb_stp;
    reg latch1, latch2, latch3, latch4;
    reg ovt;
    reg [14:0] qd;
    reg [1:0] qe;
    reg [1:0] qe_1d;
    reg [1:0] qf;
    reg qf0_1d;
    reg fm_cycle_ovp_1d;
    reg fm_wr_bank;
    reg [31:0] r0_doa, g0_doa, b0_doa;
    reg [31:0] r1_doa, g1_doa, b1_doa;
    reg [31:0] r0_do, g0_do, b0_do;
    reg [31:0] r1_do, g1_do, b1_do;

    wire qa_stop;
    wire fm_iv_rd_ena_cycle;
    wire fm_cycle_ovp;
    wire qd_ce;
    wire qd_stop;
    wire qe_endp;
    wire qe_stop;


// タイミング信号作成

    // fm_cycle_stp_adv_1d, fm_cycle_stp
    always @(posedge clk) begin
      fm_cycle_stp_adv_1d <= fm_cycle_stp_adv;
      fm_cycle_stp        <= fm_cycle_stp_adv_1d;
    end

    // qa  7bitカウンタ (ltach 作成用)
    always @(posedge clk) begin
      if(fm_cycle_stp)
        qa <= 0;
      else if(~qa_stop)
        qa <= qa + 1;
    end

    // qa_stop
    assign qa_stop = qa[6] & qa[3];  // 64+8=72


    // fm_iv_rd_ena_cycle
    assign fm_iv_rd_ena_cycle = fm_iv_rd_cycle & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle;

    // fm_iv_rd_ena_cycle_1d
    always @(posedge clk) begin
      if(fm_cycle_stp)
        fm_iv_rd_ena_cycle_1d <= fm_iv_rd_ena_cycle;
    end


    // latch1_tim -- latch4_tim, rgb_stp
    always @(posedge clk) begin
      latch1_tim <= (qa == 7'd33);
      latch2_tim <= (qa == 7'd45);
      latch3_tim <= (qa == 7'd57);
      latch4_tim <= (qa == 7'd69);
      rgb_stp <= (qa == 7'd63);
    end

    // latch1 -- latch4
    always @(posedge clk) begin
      latch1 <= latch1_tim & fm_iv_rd_ena_cycle;
      latch2 <= latch2_tim & fm_iv_rd_ena_cycle;
      latch3 <= latch3_tim & fm_iv_rd_ena_cycle;
      latch4 <= latch4_tim & fm_iv_rd_ena_cycle;
    end

    // ovt
    always @(posedge clk) begin
      if(ovp)
        ovt <= 1;
      else if(fm_cycle_stp)
        ovt <= 0;
    end

    // fm_cycle_ovp
    assign fm_cycle_ovp = ovt & fm_cycle_stp;


    // qd  15bitカウンタ (fm address 作成)
    always @(posedge clk) begin
      if(fm_cycle_ovp)
        qd <= 0;
      else if(qd_ce)
        qd <= qd + 1;
    end

    // qd_stop
    assign qd_stop = qd[14];  // 16384

    // qd_ce
    assign qd_ce = fm_cycle_stp & ~qd_stop & fm_iv_rd_ena_cycle_1d;

    // qe  2bitカウンタ (fm address, 出力RGB選択)
    always @(posedge clk) begin
      if(rgb_stp | qe_endp)
        qe <= 0;
      else if(~qe_stop)
        qe <= qe + 1;
    end

    // qe_endp
    assign qe_endp = qe[1];  // 2

    // qf  2bitカウンタ (fm address, 出力2pixel選択)
    always @(posedge clk) begin
      if(rgb_stp)
        qf <= 0;
      else if(qe_endp)
        qf <= qf + 1;
    end

    // qe_stop
    assign qe_stop = qf[1];  // 2

    // qe_1d  2bit
    always @(posedge clk) begin
      qe_1d <= qe;
    end

    // qf0_1d
    always @(posedge clk) begin
      qf0_1d <= qf[0];
    end


    // fm_cycle_ovp_1d
    always @(posedge clk) begin
      fm_cycle_ovp_1d <= fm_cycle_ovp;
    end

    // fm_wr_bank
    always @(posedge clk) begin
      if(fm_cycle_ovp_1d)
        fm_wr_bank <= ~frame_alt;
    end


    // fm_ov_wr_adrs  19bit
    assign fm_ov_wr_adrs = {fm_wr_bank,
                            1'b0,
                            qd[13:0], qf0_1d,  // pixel  15bit
                            qe_1d};            // RGB  2bit

    // fm_ov_wr_cycle
    assign fm_ov_wr_cycle = fm_iv_rd_ena_cycle_1d;


// video data 取り込み, 出力

    // r0_doa, g0_doa, b0_goa  32bit (latch 取り込み)
    always @(posedge clk) begin
      if(latch1) begin
        r0_doa[31:16] <= r_din;
        g0_doa[31:16] <= g_din;
        b0_doa[31:16] <= b_din;
      end
    end

    always @(posedge clk) begin
      if(latch2) begin
        r0_doa[15:0] <= r_din;
        g0_doa[15:0] <= g_din;
        b0_doa[15:0] <= b_din;
      end
    end

    // r1_doa, g1_doa, b1_goa  32bit (latch 取り込み)
    always @(posedge clk) begin
      if(latch3) begin
        r1_doa[31:16] <= r_din;
        g1_doa[31:16] <= g_din;
        b1_doa[31:16] <= b_din;
      end
    end

    always @(posedge clk) begin
      if(latch4) begin
        r1_doa[15:0] <= r_din;
        g1_doa[15:0] <= g_din;
        b1_doa[15:0] <= b_din;
      end
    end


    // r0_do -- b1_go  32bit (2段 latch)
    always @(posedge clk) begin
      if(latch1_tim) begin
        r0_do <= r0_doa;
        g0_do <= g0_doa;
        b0_do <= b0_doa;
        r1_do <= r1_doa;
        g1_do <= g1_doa;
        b1_do <= b1_doa;
      end
    end


    // fm_ov_wr_d  32bit
    always @(posedge clk) begin
        case ({qf,qe})
          4'd0:  fm_ov_wr_d <= r0_do;
          4'd1:  fm_ov_wr_d <= g0_do;
          4'd2:  fm_ov_wr_d <= b0_do;
          4'd4:  fm_ov_wr_d <= r1_do;
          4'd5:  fm_ov_wr_d <= g1_do;
          4'd6:  fm_ov_wr_d <= b1_do;
          default: fm_ov_wr_d <= 32'd0;
        endcase
    end

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// ADC (MAX11647), ADC2 (ADS1013), Sensor (Si7020) 制御
//
// サブモジュール
//   sens_crc
//

module adc_sensor_ctrl_b (startn_in, sda_in, frame_alt, clk, 

                         cnt_rst, busy, adc_err_det, adc2_err_det, sens_err_det,
                         scl, sda_ot, sdao,
                         volt_dout, rh_dout, tmp_dout,
                         rh_csum_ok_p, tmp_csum_ok_p);

    input startn_in;
    input sda_in;
    input frame_alt;
    input clk;        // 25MHz

    output cnt_rst;
    output reg busy;
    output reg adc_err_det;
    output reg adc2_err_det;
    output reg sens_err_det;
    output scl;
    output sda_ot;
    output sdao;
    output [15:0] volt_dout;
    output [15:0] rh_dout;
    output [15:0] tmp_dout;
    output reg rh_csum_ok_p;
    output reg tmp_csum_ok_p;

    reg startn_in_1d;
    reg [15:0] sens_cycle_qa;
    reg [10:0] sens_cycle_qb;
    reg [ 4:0] sens_cycle_qc;
    reg sens_cycle_start_ena_1d;
    reg sens_pwr_up;
    reg busy_1d;
    reg sens_start_wait;
    reg [7:0] qc;
    reg [1:0] qd;
    reg [3:0] qe;
    reg [10:0] qf;
    reg [2:0] qg;
    reg [1:0] qh;
    reg qf_d0, qf_d1, qf_d2, qf_d3, qf_d4, qf_d5, qf_d6, qf_d7, qf_d8, qf_d511;
    reg qf_mt1, qf_mt3, qf_mt4, qf_mt5, qf_mt8;
    reg qf_lt5;
    reg srst_tim, adc_wr_tim, adc_rd_tim;
    reg adc2_wr_tim, adc2_rd_adrs_wr_tim, adc2_rd1_tim, adc2_rd2_tim, adc2_rd3_tim, adc2_tim;
    reg reset_tim, msr_rh_tim, msr_tmp_tim, sens_tim;
    reg start_bit, stop_bit, last_stop_bit;
    reg qsda_in_rst;
    reg [5:0] qsda_in;
    reg [7:0] sda_din;
    reg sda_readp_1d, sda_readp_2d;
    reg [3:0] qnack;
    reg [9:0] qpoll;
    reg reset_wait_tim;
    reg scla;
    reg qe_d8_1d;
    reg sda_ota;
    reg qe_d0_1d, srst_bit1d;
    reg busy1n, busy2n;
    reg sda_otb, sda_otb_1d, sda_otb_2d;
    reg [3:0] qf1d;
    reg [8:0] adc_wr_sdao;
    reg [8:0] adc_rd_sdao;
    reg [8:0] adc2_wr_sdao;
    reg [8:0] adc2_rd_adrs_wr_sdao;
    reg [8:0] adc2_rd_sdao;
    reg [8:0] reset_sdao;
    reg [8:0] msr_rh_sdao, msr_tmp_sdao;
    reg [4:0] qhqg_1d, qhqg_2d;
    reg sda_start_1d, sda_start_2d, sda_stop_1d, sda_stop_2d;
    reg [3:0] qe1d, qe2d;
    reg sdaob, sdaob_1d, sdaob_2d;
    reg [9:0] adc_volt1_rda, adc_volt2_rda, adc_volt3_rda;
    reg [10:0] adc2_volt1_rda, adc2_volt2_rda, adc2_volt3_rda;
    reg [9:0] volt1_rda, volt2_rda, volt3_rda;
    reg [15:0] rh_rx_data, tmp_rx_data;
    reg [7:0] rh_rx_csum, tmp_rx_csum;
    reg v1_gt_v2, v2_gt_v3, v3_gt_v1;
    reg [9:0] volt_rdata;
    reg volt_rd_low;
    reg rh_lsb_latchp_1d, tmp_lsb_latchp_1d;
    reg rh_csum_latchp_1d, tmp_csum_latchp_1d;
    reg rh_out_startn;
    reg tmp_out_startn;
    reg [15:0] rh_rdata, tmp_rdata;
    reg [9:0] volt_do2a;
    reg [8:0] volt_doa;
    reg [14:0] rh_rdb;
    reg rh_rd_uf, rh_rd_of;
    reg [14:0] rh_rdc;
    reg [14:0] rh_rdd;
    reg [14:0] rh_do2a;
    reg [13:0] rh_doa;
    reg [30:0] tmp_rdb;
    reg [13:0] tmp_do2a;
    reg [11:0] tmp_doa;
    reg [9:0] volt_dob;
    reg [14:0] rh_dob;
    reg [12:0] tmp_dob;
    reg frame_alt_1d, frame_alt_2d, ovp;
    reg [9:0] volt_doc;
    reg [14:0] rh_doc;
    reg [12:0] tmp_doc;

    wire startn;
    wire sens_cycle_cnt_ld;
    wire sens_cycle_qa_endp;
    wire sens_cycle_qb_end;
    wire sens_cycle_qb_endp;
    wire sens_cycle_start_ena;
    wire sens_cycle_start_tp;
    wire sens_cycle_start_tp_1st;
    wire sens_cycle_start_tp_a;
    wire busy_endp;
    wire sens_cycle_startp;
    wire qc_endp, sda_readp, qd_end, sda_start, sda_stop, qd_endp;
    wire qe_d8, qe_d0, qe_end, qe_endp;
    wire [10:0] qf_lda_a, qf_lda;
    wire qf_endp, wr_nack_ld, poll_nack_ld, qf_ld;
    wire adc_qg_end, adc2_qg_end, sens_qg_end;
    wire qg_end_a, qg_end, qg_endp;
    wire qh_end, qh_endp;
    wire qf_mt3_a, reset_tim_a;
    wire adc_tim, measure_tim;
    wire polling_tim;
    wire srst_s, srst_p, adc_s, adc_wr_p, adc_rd_p, rst_s, rst_p, rst_last;
    wire adc2_s, adc2_wr_p, adc2_rd_adrs_wr_p, adc2_rd_p;
    wire measure_s, measure_p;
    wire st_bit;
    wire sda_in_high;
    wire reset_ack_tim, adc_wr_ack_tim, adc_rd_ack_tim, msr_ack_tim;
    wire adc2_wr_ack_tim, adc2_rd_adrs_wr_ack_tim, adc2_rd_ack_tim;
    wire wr_nack, wr_nackp;
    wire qnack_stop, wr_nack_last;
    wire poll_ack_tim, poll_nack, poll_nackp, poll_ackp;
    wire qpoll_stop, poll_nack_last;
    wire adc_err_rst, adc2_err_rst, sens_err_rst, err_rst;
    wire reset_wait_tim_a;
    wire adc_wr_sda_ot, adc_rd_sda_ot, reset_sda_ot, msr_sda_ot;
    wire adc2_wr_sda_ot, adc2_rd_adrs_wr_sda_ot, adc2_rd_sda_ot;
    wire [6:0] adc_slave_adrs;
    wire [6:0] slave_adrs;
    wire [6:0] adc2_slave_adrs;
    wire [7:0] adc2_config_reg_adrs;
    wire [7:0] adc2_convt_reg_adrs;
    wire [15:0] adc2_config_data;
    wire [7:0] reset_cmd, msr_rh_cmd, msr_tmp_cmd;
    wire [7:0] adc_setup_data, adc_config_data;
    wire [2:0] adc_wr_sdao_sel;
    wire [3:0] adc_rd_sdao_sel;
    wire [2:0] adc2_wr_sdao_sel;
    wire [1:0] adc2_rd_adrs_wr_sdao_sel;
    wire [2:0] adc2_rd_sdao_sel;
    wire [1:0] reset_sdao_sel;
    wire [3:0] msr_sdao_sel;
    wire [8:0] sdaoa;
    wire [1:0] qe_sel;
    wire [3:0] sdao_sel;
    wire adc_volt1_msb_latchp, adc_volt1_lsb_latchp;
    wire adc_volt2_msb_latchp, adc_volt2_lsb_latchp;
    wire adc_volt3_msb_latchp, adc_volt3_lsb_latchp;
    wire adc2_volt1_msb_latchp, adc2_volt1_lsb_latchp;
    wire adc2_volt2_msb_latchp, adc2_volt2_lsb_latchp;
    wire adc2_volt3_msb_latchp, adc2_volt3_lsb_latchp;
    wire rh_msb_latchp, rh_lsb_latchp, rh_csum_latchp;
    wire tmp_msb_latchp, tmp_lsb_latchp, tmp_csum_latchp;
    wire [9:0] adc2_volt1_rdb, adc2_volt2_rdb, adc2_volt3_rdb;
    wire sel_volt2, sel_volt3;
    wire sens_crc_clr, sens_crc_ce;
    wire [2:0] sens_crc_dsel;
    wire [7:0] sens_crc_din;
    wire [7:0] sens_crc_out;
    wire [25:0] volt_do1a;
    wire [22:0] rh_rda;
    wire [31:0] rh_do1a;
    wire [30:0] tmp_rda;
    wire [31:0] tmp_do1a;
    wire [12:0] tmp_do3a;


// センサー読み出し周期設定カウンタ

    // startn_in_1d
    always @(posedge clk) begin
      startn_in_1d <= startn_in;
    end

    // startn
    assign startn = startn_in | startn_in_1d;

    // sens_cycle_cnt_ld
    assign sens_cycle_cnt_ld = startn | sens_cycle_startp;


    // sens_cycle_qa  16bitカウンタ  1ms周期作成
    always @(posedge clk) begin
      if(sens_cycle_cnt_ld | sens_cycle_qa_endp)
        sens_cycle_qa <= 16'd7769;
      else if(~sens_cycle_start_ena)
        sens_cycle_qa <= sens_cycle_qa + 1;
    end

    // sens_cycle_qa_endp
    assign sens_cycle_qa_endp = sens_cycle_qa[15];  // 32768

    // sens_cycle_qb  11bitカウンタ  1s周期作成
    always @(posedge clk) begin
      if(sens_cycle_cnt_ld | sens_cycle_qb_endp)
        sens_cycle_qb <= 11'd25;
      else if(sens_cycle_qa_endp)
        sens_cycle_qb <= sens_cycle_qb + 1;
    end

    // sens_cycle_qb_end
    assign sens_cycle_qb_end = sens_cycle_qb[10];  // 1024

    // sens_cycle_qb_endp
    assign sens_cycle_qb_endp = sens_cycle_qa_endp & sens_cycle_qb_end;

    // sens_cycle_qc  5bitカウンタ  5s周期作成
    always @(posedge clk) begin
      if(sens_cycle_cnt_ld)
        sens_cycle_qc <= startn ? 5'd15 : 5'd11;
      else if(sens_cycle_qb_endp)
        sens_cycle_qc <= sens_cycle_qc + 1;
    end

    // sens_cycle_start_ena
    assign sens_cycle_start_ena = sens_cycle_qc[4];  // 16


    // sens_cycle_start_ena_1d
    always @(posedge clk) begin
      sens_cycle_start_ena_1d <= sens_cycle_start_ena;
    end

    // sens_cycle_start_tp
    assign sens_cycle_start_tp = sens_cycle_start_ena & ~sens_cycle_start_ena_1d;

    // sens_pwr_up
    always @(posedge clk) begin
      if(startn)
        sens_pwr_up <= 1'b0;
      else if(sens_cycle_start_tp)
        sens_pwr_up <= 1'b1;
    end

    // sens_cycle_start_tp_1st
    assign sens_cycle_start_tp_1st = sens_cycle_start_tp & ~sens_pwr_up;

    // sens_cycle_start_tp_a
    assign sens_cycle_start_tp_a = sens_cycle_start_tp & sens_pwr_up;

    // busy_1d
    always @(posedge clk) begin
      busy_1d <= busy;
    end

    // busy_endp
    assign busy_endp = ~busy & busy_1d;

    // sens_start_wait
    always @(posedge clk) begin
      if(startn | busy_endp)
        sens_start_wait <= 1'b0;
      else if(busy & sens_cycle_start_tp_a)
        sens_start_wait <= 1'b1;
    end


    // sens_cycle_startp
    assign sens_cycle_startp = sens_cycle_start_tp_1st | (sens_cycle_start_tp_a & ~busy) |
                               (busy_endp & sens_start_wait);


// タイミング作成カウンタ部

    // cnt_rst
    assign cnt_rst = startn | ~sens_pwr_up | sens_cycle_startp;

    // qc  8bitカウンタ  (100clkサイクル, 25MHz)
    always @(posedge clk) begin
      if(cnt_rst | qc_endp)
        qc <= 8'd29;
      else if(busy)
        qc <= qc + 1;
    end

    // qc_endp
    assign qc_endp = qc[7];  // 128

    // qd  2bitカウンタ  (SCL 作成)
    always @(posedge clk) begin
      if(cnt_rst | qd_endp)
        qd <= 0;
      else if(qc_endp)
        qd <= qd + 1;
    end

    // sda_readp, qd_end, sda_start, sda_stop
    assign sda_readp = ~qd[0] & qd[1] & qc_endp;
    assign qd_end = qd[0] & qd[1];
    assign sda_start = ~qd_end;
    assign sda_stop = qd_end;

    // qd_endp
    assign qd_endp = qc_endp & qd_end;

    // qe  4bitカウンタ  (1 or 9 ビットサイクル)
    always @(posedge clk) begin
      if(cnt_rst | qe_endp)
        qe <= 0;
      else if(qd_endp)
        qe <= qe + 1;
    end

    // qe_d8, qe_d0, qe_end
    assign qe_d8 = (qe == 4'h8);
    assign qe_d0 = (qe == 4'h0);
    assign qe_end = st_bit ? qe_d0 : qe_d8;

    // qe_endp
    assign qe_endp = qd_endp & qe_end;

    // qf_lda_a  11bit
    assign qf_lda_a = polling_tim ? 11'd3 : 11'd0;

    // qf_lda  11bit
    assign qf_lda = err_rst ? 11'd0 : qf_lda_a;

    // qf_endp, wr_nack_ld, poll_nack_ld, qf_ld
    assign qf_endp = (last_stop_bit | err_rst) & qe_endp;
    assign wr_nack_ld = wr_nack & qe_endp;
    assign poll_nack_ld = poll_nack & qe_endp;
    assign qf_ld = cnt_rst | qf_endp | wr_nack_ld | poll_nack_ld;

    // qf  11bitカウンタ  (byteカウンタ)
    always @(posedge clk) begin
      if(qf_ld)
        qf <= qf_lda;
      else if(qe_endp)
        qf <= qf + 1;
    end

    // qg  3bitカウンタ  (operation カウンタ)
    always @(posedge clk) begin
      if(cnt_rst | qg_endp)
        qg <= 0;
      else if(qf_endp)
        qg <= qg + 1;
    end

    // adc_qg_end, adc2_qg_end, sens_qg_end, qg_end_a, qg_end, qg_endp
    assign adc_qg_end = (qg == 3'd2);
    assign adc2_qg_end = (qg == 3'd4);
    assign sens_qg_end = (qg == 3'd2);
    assign qg_end_a = qh[1] ? sens_qg_end : (qh[0] ? adc2_qg_end : adc_qg_end);
    assign qg_end = qg_end_a | err_rst;
    assign qg_endp = qf_endp & qg_end;

    // qh  2bitカウンタ  (device セレクト)
    always @(posedge clk) begin
      if(cnt_rst | qh_endp)
        qh <= 0;
      else if(qg_endp)
        qh <= qh + 1;
    end

    // qh_end, qh_endp
    assign qh_end = (qh >= 2'd2);
    assign qh_endp = qg_endp & qh_end;

    // busy
    always @(posedge clk) begin
      if(cnt_rst)
        busy <= 1'b1;
      else if(qh_endp)
        busy <= 1'b0;
    end


// qf デコード部

    always @(posedge clk) begin
      qf_d0 <= (qf == 11'h000);
      qf_d1 <= (qf == 11'h001);
      qf_d2 <= (qf == 11'h002);
      qf_d3 <= (qf == 11'h003);
      qf_d4 <= (qf == 11'h004);
      qf_d5 <= (qf == 11'h005);
      qf_d6 <= (qf == 11'h006);
      qf_d7 <= (qf == 11'h007);
      qf_d8 <= (qf == 11'h008);
      qf_d511 <= (qf == 11'd511);

      qf_mt1 <= (qf > 11'h001);
      qf_mt3 <= (qf > 11'h003);
      qf_mt4 <= (qf > 11'h004);
      qf_mt5 <= (qf > 11'h005);
      qf_mt8 <= (qf > 11'h008);

      qf_lt5 <= (qf < 11'h005);
    end

    // qf_mt3_a
    assign qf_mt3_a = (qf > 11'h003);


// qg, qh デコード部 (operation 設定)

    // reset_tim_a
    assign reset_tim_a = (qh == 2'd2) & (qg == 3'd0);

    // srst_tim, adc_wr_tim, adc_rd_tim
    // adc2_wr_tim, adc2_rd_adrs_wr_tim, adc2_rd1_tim, adc2_rd2_tim, adc2_rd3_tim, adc2_tim
    // reset_tim, msr_rh_tim, msr_tmp_tim, sens_tim
    always @(posedge clk) begin
      srst_tim   <= (qh == 2'd0) & (qg == 3'd0);
      adc_wr_tim <= (qh == 2'd0) & (qg == 3'd1);
      adc_rd_tim <= (qh == 2'd0) & (qg == 3'd2);

      adc2_wr_tim         <= (qh == 2'd1) & (qg == 3'd0);
      adc2_rd_adrs_wr_tim <= (qh == 2'd1) & (qg == 3'd1);
      adc2_rd1_tim        <= (qh == 2'd1) & (qg == 3'd2);
      adc2_rd2_tim        <= (qh == 2'd1) & (qg == 3'd3);
      adc2_rd3_tim        <= (qh == 2'd1) & (qg == 3'd4);

      adc2_tim <= (qh == 2'b1);

      reset_tim   <= reset_tim_a;
      msr_rh_tim  <= (qh == 2'd2) & (qg == 3'd1);
      msr_tmp_tim <= (qh == 2'd2) & (qg == 3'd2);

      sens_tim <= (qh == 2'd2);
    end

    // adc_tim, measure_tim
    assign adc_tim = adc_wr_tim | adc_rd_tim;
    assign measure_tim = msr_rh_tim | msr_tmp_tim;


// polling_tim 作成

    // polling_tim
    assign polling_tim = measure_tim & qf_d4;


// start_bit, stop_bit 作成

    // srst_s, srst_p, adc_s, adc_p
    // rst_s, rst_p, rst_last
    // adc2_s, adc2_wr_p, adc2_rd_adrs_wr_p, adc2_rd_p
    // measure_s, measure_p
    assign srst_s = qf_d0 | qf_d2;
    assign srst_p = qf_d3;
    assign adc_s = qf_d0;
    assign adc_wr_p = qf_d4;
    assign adc_rd_p = qf_d8;
    assign rst_s = qf_d0;
    assign rst_p = qf_d3;
    assign rst_last = qf_d511;
    assign adc2_s = qf_d0;
    assign adc2_wr_p = qf_d5;
    assign adc2_rd_adrs_wr_p = qf_d3;
    assign adc2_rd_p = qf_d4;

    assign measure_s = qf_d0 | qf_d3;
    assign measure_p = qf_d8;

    // start_bit
    always @(posedge clk) begin
      case ({qh, qg})
        5'd0 : start_bit <= srst_s;
        5'd1 : start_bit <= adc_s;
        5'd2 : start_bit <= adc_s;

        5'd8 : start_bit <= adc2_s;
        5'd9 : start_bit <= adc2_s;
        5'd10: start_bit <= adc2_s;
        5'd11: start_bit <= adc2_s;
        5'd12: start_bit <= adc2_s;

        5'd16: start_bit <= rst_s;
        5'd17: start_bit <= measure_s;
        5'd18: start_bit <= measure_s;

        default: start_bit <=1'b0;
      endcase
    end

    // stop_bit
    always @(posedge clk) begin
      case ({qh, qg})
        5'd0 : stop_bit <= srst_p;
        5'd1 : stop_bit <= adc_wr_p;
        5'd2 : stop_bit <= adc_rd_p;

        5'd8 : stop_bit <= adc2_wr_p;
        5'd9 : stop_bit <= adc2_rd_adrs_wr_p;
        5'd10: stop_bit <= adc2_rd_p;
        5'd11: stop_bit <= adc2_rd_p;
        5'd12: stop_bit <= adc2_rd_p;

        5'd16: stop_bit <= rst_p;
        5'd17: stop_bit <= measure_p;
        5'd18: stop_bit <= measure_p;

        default: stop_bit <= 1'b0;
      endcase
    end

    // st_bit
    assign st_bit = start_bit | stop_bit;

    // last_stop_bit
    always @(posedge clk) begin
      case ({qh, qg})
        5'd0 : last_stop_bit <= srst_p;
        5'd1 : last_stop_bit <= adc_wr_p;
        5'd2 : last_stop_bit <= adc_rd_p;

        5'd8 : last_stop_bit <= adc2_wr_p;
        5'd9 : last_stop_bit <= adc2_rd_adrs_wr_p;
        5'd10: last_stop_bit <= adc2_rd_p;
        5'd11: last_stop_bit <= adc2_rd_p;
        5'd12: last_stop_bit <= adc2_rd_p;

        5'd16: last_stop_bit <= rst_last;
        5'd17: last_stop_bit <= measure_p;
        5'd18: last_stop_bit <= measure_p;

        default: last_stop_bit <= 1'b0;
      endcase
    end


// sda_in 入力のノイズ除去 多数決処理

    // qsda_in_rst
    always @(posedge clk) begin
      qsda_in_rst <= ~qd[1] | startn | ~busy;
    end

    // qsda_in  6bitカウンタ  (sda_in の high レベルカウンタ)
    always @(posedge clk) begin
      if(qsda_in_rst)
        qsda_in <= 0;
      else if(sda_in & ~sda_in_high)
        qsda_in <= qsda_in + 1;
    end

    // sda_in_high
    assign sda_in_high = (qsda_in > 6'd48);


// Nack Error 検出

    // sda_din  8bit (シリアルデータ入力シフトレジスタ)
    always @(posedge clk) begin
      if(sda_readp)
        sda_din <= {sda_din, sda_in_high};
    end


    // adc_wr_ack_tim, adc_rd_ack_tim, reset_ack_tim, msr_ack_tim
    // adc2_wr_ack_tim, adc2_rd_adrs_wr_ack_tim, adc2_rd_ack_tim
    assign adc_wr_ack_tim = qe_d8 & (qf_d1 | qf_d2 | qf_d3) & adc_wr_tim;
    assign adc_rd_ack_tim = qe_d8 & qf_d1 & adc_rd_tim;

    assign adc2_wr_ack_tim = qe_d8 & (qf_d1 | qf_d2 | qf_d3 | qf_d4) & adc2_wr_tim;
    assign adc2_rd_adrs_wr_ack_tim = qe_d8 & (qf_d1 | qf_d2) & adc2_rd_adrs_wr_tim;
    assign adc2_rd_ack_tim = qe_d8 & qf_d1 & (adc2_rd1_tim | adc2_rd2_tim | adc2_rd3_tim);

    assign reset_ack_tim  = qe_d8 & (qf_d1 | qf_d2) & reset_tim;
    assign msr_ack_tim    = qe_d8 & (qf_d1 | qf_d2) & measure_tim;

    // sda_readp_1d, sda_readp_2d
    always @(posedge clk) begin
      sda_readp_1d <= sda_readp;
      sda_readp_2d <= sda_readp_1d;
    end

    // wr_nack, wr_nackp
    assign wr_nack = (adc_wr_ack_tim | adc_rd_ack_tim |
                      adc2_wr_ack_tim | adc2_rd_adrs_wr_ack_tim | adc2_rd_ack_tim |
                      reset_ack_tim | msr_ack_tim) & sda_din[0];
    assign wr_nackp = wr_nack & sda_readp_2d;

    // qnack  4bitカウンタ  (nack カウンタ)
    always @(posedge clk) begin
      if(cnt_rst | qf_endp)
        qnack <= 0;
      else if(wr_nackp & ~qnack_stop)
        qnack <= qnack + 1;
    end

    // qnack_stop
    assign qnack_stop = qnack[3];

    // wr_nack_last
    assign wr_nack_last = qnack_stop & wr_nack;


// Ack-Polling Error 検出

    // poll_ack_tim, poll_nack, poll_nackp, poll_ackp
    assign poll_ack_tim = polling_tim & qe_d8;
    assign poll_nack = poll_ack_tim & sda_din[0];
    assign poll_nackp = poll_nack & sda_readp_2d;
    assign poll_ackp = (poll_ack_tim & ~sda_din[0]) & sda_readp_2d;

    // qpoll  10bitカウンタ  (polling カウンタ)
    always @(posedge clk) begin
      if(cnt_rst | poll_ackp | qf_endp)
        qpoll <= 0;
      else if(poll_nackp & ~qpoll_stop)
        qpoll <= qpoll + 1;
    end

    // qpoll_stop
    assign qpoll_stop = qpoll[9];

    // poll_nack_last
    assign poll_nack_last = qpoll_stop & poll_nack;


// Error 検出情報統合

    // adc_err_rst
    assign adc_err_rst = wr_nack_last & adc_tim;

    // adc_err_det
    always @(posedge clk) begin
      if(cnt_rst)
        adc_err_det <= 1'b0;
      else if(adc_err_rst)
        adc_err_det <= 1'b1;
    end


    // adc2_err_rst
    assign adc2_err_rst = wr_nack_last & adc2_tim;

    // adc2_err_det
    always @(posedge clk) begin
      if(cnt_rst)
        adc2_err_det <= 1'b0;
      else if(adc2_err_rst)
        adc2_err_det <= 1'b1;
    end

    // sens_err_rst
    assign sens_err_rst = (wr_nack_last | poll_nack_last) & sens_tim;

    // sens_err_det
    always @(posedge clk) begin
      if(cnt_rst)
        sens_err_det <= 1'b0;
      else if(sens_err_rst)
        sens_err_det <= 1'b1;
    end

    // err_rst
    assign err_rst = adc_err_rst | adc2_err_rst | sens_err_rst;


// scl 出力部

    // reset_wait_tim_a
    assign reset_wait_tim_a = reset_tim_a & qf_mt3_a;

    // reset_wait_tim
    always @(posedge clk) begin
      reset_wait_tim <= reset_wait_tim_a;
    end

    // scla
    always @(posedge clk) begin
      scla <= qd[1] | startn | ~sens_pwr_up | ~busy | reset_wait_tim_a;
    end

    // scl
    assign scl = scla | startn;


// sda_ot 出力部

    // qe_d8_1d
    always @(posedge clk) begin
      qe_d8_1d <= qe_d8;
    end

    // adc_wr_sda_ot, adc_rd_sda_ot, reset_sda_ot, msr_sda_ot
    // adc2_wr_sda_ot, adc2_rd_adrs_wr_sda_ot, adc2_rd_sda_ot;
    assign adc_wr_sda_ot = adc_wr_tim & qe_d8_1d;
    assign adc_rd_sda_ot = adc_rd_tim & ((qe_d8_1d & qf_d1) | (~qe_d8_1d & qf_mt1));

    assign adc2_wr_sda_ot = adc2_wr_tim & qe_d8_1d;
    assign adc2_rd_adrs_wr_sda_ot = adc2_rd_adrs_wr_tim & qe_d8_1d;
    assign adc2_rd_sda_ot = (adc2_rd1_tim | adc2_rd2_tim | adc2_rd3_tim) &
                            ((qe_d8_1d & qf_d1) | (~qe_d8_1d & qf_mt1));

    assign reset_sda_ot = reset_tim & (qe_d8_1d | reset_wait_tim);
    assign msr_sda_ot = measure_tim & ((qe_d8_1d & qf_lt5) | (~qe_d8_1d & qf_mt4));

    // sda_ota
    always @(posedge clk) begin
      sda_ota <= (srst_tim | adc_wr_sda_ot | adc_rd_sda_ot |
                  adc2_wr_sda_ot | adc2_rd_adrs_wr_sda_ot | adc2_rd_sda_ot |
                  reset_sda_ot | msr_sda_ot);
    end

    // qe_d0_1d, srst_bit1d
    always @(posedge clk) begin
      qe_d0_1d <= qe_d0;
      srst_bit1d <= srst_tim & qf_d1 & qe_d0_1d;
    end

    // busy1n, busy2n
    always @(posedge clk) begin
      busy1n <= startn | ~sens_pwr_up | ~busy;
      busy2n <= busy1n;
    end

    // sda_otb, sda_otb_1d, sda_otb_2d
    always @(posedge clk) begin
      sda_otb <= (sda_ota & ~st_bit & ~srst_bit1d) | busy2n;
      sda_otb_1d <= sda_otb;
      sda_otb_2d <= sda_otb_1d;
    end

    // sda_ot
    assign sda_ot = sda_otb_2d | startn;


// slave_adrs, command code 設定

    // adc_slave_adrs  7bit
    assign adc_slave_adrs = 7'h36;

    // slave_adrs  7bit
    assign slave_adrs = 7'h40;

    // reset_cmd, msr_rh_cmd, msr_tmp_cmd  8bit
    assign reset_cmd = 8'hfe;
    assign msr_rh_cmd = 8'hf5;
    assign msr_tmp_cmd = 8'hf3;

    // adc_setup_data, adc_config_data  8bit
    assign adc_setup_data  = 8'b11011010;
    assign adc_config_data = 8'b01100001;

    // adc2_slave_adrs  7bit
    assign adc2_slave_adrs = 7'h48;

    // adc2_config_reg_adrs, adc2_convt_reg_adrs  8bit
    assign adc2_config_reg_adrs = 8'h01;
    assign adc2_convt_reg_adrs = 8'h00;

    // adc2_config_data  16bit
    assign adc2_config_data  = 16'h84e3;


// adc_wr_sdao 作成

    // adc_wr_sdao_sel  3bit
    assign adc_wr_sdao_sel = qf_mt4 ? 3'd4 : qf1d[2:0];

    // adc_wr_sdao  9bit
    always @(posedge clk) begin
      case (adc_wr_sdao_sel)
        3'h0: adc_wr_sdao <= {8'hff, 1'b1};
        3'h1: adc_wr_sdao <= {adc_slave_adrs, 1'b0, 1'b1};
        3'h2: adc_wr_sdao <= {adc_setup_data, 1'b1};
        3'h3: adc_wr_sdao <= {adc_config_data, 1'b1};
        3'h4: adc_wr_sdao <= {8'hff, 1'b1};
        3'h5: adc_wr_sdao <= {8'hff, 1'b1};
        3'h6: adc_wr_sdao <= {8'hff, 1'b1};
        3'h7: adc_wr_sdao <= {8'hff, 1'b1};
      endcase
    end


// adc_rd_sdao 作成

    // adc_rd_sdao_sel  4bit
    assign adc_rd_sdao_sel = qf_mt8 ? 4'd8 : qf1d[3:0];

    // adc_rd_sdao  9bit
    always @(posedge clk) begin
      case (adc_rd_sdao_sel)
        4'h0: adc_rd_sdao <= {8'hff, 1'b1};
        4'h1: adc_rd_sdao <= {adc_slave_adrs, 1'b1, 1'b1};
        4'h2: adc_rd_sdao <= {8'hff, 1'b0};  // ACK
        4'h3: adc_rd_sdao <= {8'hff, 1'b0};  // ACK
        4'h4: adc_rd_sdao <= {8'hff, 1'b0};  // ACK
        4'h5: adc_rd_sdao <= {8'hff, 1'b0};  // ACK
        4'h6: adc_rd_sdao <= {8'hff, 1'b0};  // ACK
        4'h7: adc_rd_sdao <= {8'hff, 1'b1};  // NACK
        4'h8: adc_rd_sdao <= {8'hff, 1'b1};
        default: adc_rd_sdao <= {8'hff, 1'b1};
      endcase
    end


// adc2_wr_sdao 作成

    // adc2_wr_sdao_sel  3bit
    assign adc2_wr_sdao_sel = qf_mt5 ? 3'd5 : qf1d[2:0];

    // adc2_wr_sdao  9bit
    always @(posedge clk) begin
      case (adc2_wr_sdao_sel)
        3'h0: adc2_wr_sdao <= {8'hff, 1'b1};
        3'h1: adc2_wr_sdao <= {adc2_slave_adrs, 1'b0, 1'b1};
        3'h2: adc2_wr_sdao <= {adc2_config_reg_adrs, 1'b1};
        3'h3: adc2_wr_sdao <= {adc2_config_data[15:8], 1'b1};
        3'h4: adc2_wr_sdao <= {adc2_config_data[7:0], 1'b1};
        3'h5: adc2_wr_sdao <= {8'hff, 1'b1};
        3'h6: adc2_wr_sdao <= {8'hff, 1'b1};
        3'h7: adc2_wr_sdao <= {8'hff, 1'b1};
      endcase
    end


// adc2_rd_adrs_wr_sdao 作成

    // adc2_rd_adrs_wr_sdao_sel  2bit
    assign adc2_rd_adrs_wr_sdao_sel = qf_mt3 ? 3'd3 : qf1d[1:0];

    // adc2_rd_adrs_wr_sdao  9bit
    always @(posedge clk) begin
      case (adc2_rd_adrs_wr_sdao_sel)
        2'h0: adc2_rd_adrs_wr_sdao <= {8'hff, 1'b1};
        2'h1: adc2_rd_adrs_wr_sdao <= {adc2_slave_adrs, 1'b0, 1'b1};
        2'h2: adc2_rd_adrs_wr_sdao <= {adc2_convt_reg_adrs, 1'b1};
        2'h3: adc2_rd_adrs_wr_sdao <= {8'hff, 1'b1};
      endcase
    end


// adc2_rd_sdao 作成

    // adc2_rd_sdao_sel  3bit
    assign adc2_rd_sdao_sel = qf_mt4 ? 3'd4 : qf1d[2:0];

    // adc2_rd_sdao  9bit
    always @(posedge clk) begin
      case (adc2_rd_sdao_sel)
        3'h0: adc2_rd_sdao <= {8'hff, 1'b1};
        3'h1: adc2_rd_sdao <= {adc2_slave_adrs, 1'b1, 1'b1};
        3'h2: adc2_rd_sdao <= {8'hff, 1'b0};  // ACK
        3'h3: adc2_rd_sdao <= {8'hff, 1'b1};  // NACK
        3'h4: adc2_rd_sdao <= {8'hff, 1'b1};
        3'h5: adc2_rd_sdao <= {8'hff, 1'b1};
        3'h6: adc2_rd_sdao <= {8'hff, 1'b1};
        3'h7: adc2_rd_sdao <= {8'hff, 1'b1};
      endcase
    end


// reset_sdao 作成

    // qf1d  4bit
    always @(posedge clk) begin
      qf1d <= qf[3:0];
    end

    // reset_sdao_sel  2bit
    assign reset_sdao_sel = qf_mt3 ? 2'd3 : qf1d[1:0];

    // reset_sdao  9bit
    always @(posedge clk) begin
      case (reset_sdao_sel)
        2'h0: reset_sdao <= {8'hff, 1'b1};
        2'h1: reset_sdao <= {slave_adrs, 1'b0, 1'b1};
        2'h2: reset_sdao <= {reset_cmd, 1'b1};
        2'h3: reset_sdao <= {8'hff, 1'b1};
      endcase
    end


// measure sdao 作成

    // msr_sdao_sel  4bit
    assign msr_sdao_sel = qf_mt8 ? 4'd8 : qf1d[3:0];

    // msr_rh_sdao  9bit
    always @(posedge clk) begin
      case (msr_sdao_sel)
        4'h0: msr_rh_sdao <= {8'hff, 1'b1};
        4'h1: msr_rh_sdao <= {slave_adrs, 1'b0, 1'b1};
        4'h2: msr_rh_sdao <= {msr_rh_cmd, 1'b1};
        4'h3: msr_rh_sdao <= {8'hff, 1'b1};
        4'h4: msr_rh_sdao <= {slave_adrs, 1'b1, 1'b1};
        4'h5: msr_rh_sdao <= {8'hff, 1'b0};  // ACK
        4'h6: msr_rh_sdao <= {8'hff, 1'b0};  // ACK
        4'h7: msr_rh_sdao <= {8'hff, 1'b1};  // NACK
        4'h8: msr_rh_sdao <= {8'hff, 1'b1};
        default: msr_rh_sdao <= {8'hff, 1'b1};
      endcase
    end

    // msr_tmp_sdao  9bit
    always @(posedge clk) begin
      case (msr_sdao_sel)
        4'h0: msr_tmp_sdao <= {8'hff, 1'b1};
        4'h1: msr_tmp_sdao <= {slave_adrs, 1'b0, 1'b1};
        4'h2: msr_tmp_sdao <= {msr_tmp_cmd, 1'b1};
        4'h3: msr_tmp_sdao <= {8'hff, 1'b1};
        4'h4: msr_tmp_sdao <= {slave_adrs, 1'b1, 1'b1};
        4'h5: msr_tmp_sdao <= {8'hff, 1'b0};  // ACK
        4'h6: msr_tmp_sdao <= {8'hff, 1'b0};  // ACK
        4'h7: msr_tmp_sdao <= {8'hff, 1'b1};  // NACK
        4'h8: msr_tmp_sdao <= {8'hff, 1'b1};
        default: msr_tmp_sdao <= {8'hff, 1'b1};
      endcase
    end


// sdao 出力部

    // qhqg_1d, qhqg_2d  5bit
    always @(posedge clk) begin
      qhqg_1d <= {qh, qg};
      qhqg_2d <= qhqg_1d;
    end

    // sdaoa  9bit
    function [8:0] sdaoa_sel;
    input [4:0] sel;
      case(sel)
        5'd0 : sdaoa_sel = 9'h1ff;
        5'd1 : sdaoa_sel = adc_wr_sdao;
        5'd2 : sdaoa_sel = adc_rd_sdao;

        5'd8 : sdaoa_sel = adc2_wr_sdao;
        5'd9 : sdaoa_sel = adc2_rd_adrs_wr_sdao;
        5'd10: sdaoa_sel = adc2_rd_sdao;
        5'd11: sdaoa_sel = adc2_rd_sdao;
        5'd12: sdaoa_sel = adc2_rd_sdao;

        5'd16: sdaoa_sel = reset_sdao;
        5'd17: sdaoa_sel = msr_rh_sdao;
        5'd18: sdaoa_sel = msr_tmp_sdao;

        default: sdaoa_sel = 9'h1ff;
      endcase
    endfunction

    assign sdaoa = sdaoa_sel(qhqg_2d);

    // qe1d, qe2d  4bit
    always @(posedge clk) begin
      qe1d <= qe;
      qe2d <= qe1d;
    end

    // qe_sel  2bit
    assign qe_sel[0] = start_bit | busy2n;
    assign qe_sel[1] = stop_bit | busy2n;

    // sdao_sel  4bit
    function [3:0] sdao_sel_sel;
    input [1:0] sel;
      case(sel)
        2'h0: sdao_sel_sel = qe2d;
        2'h1: sdao_sel_sel = 4'h9;
        2'h2: sdao_sel_sel = 4'ha;
        2'h3: sdao_sel_sel = 4'hb;
      endcase
    endfunction

    assign sdao_sel = sdao_sel_sel(qe_sel);

    // sda_start_1d, sda_start_2d
    always @(posedge clk) begin
      sda_start_1d <= sda_start;
      sda_start_2d <= sda_start_1d;
    end

    // sda_stop_1d, sda_stop_2d
    always @(posedge clk) begin
      sda_stop_1d <= sda_stop;
      sda_stop_2d <= sda_stop_1d;
    end

    // sdaob
    always @(posedge clk) begin
      case (sdao_sel)
        4'h0: sdaob <= sdaoa[8];
        4'h1: sdaob <= sdaoa[7];
        4'h2: sdaob <= sdaoa[6];
        4'h3: sdaob <= sdaoa[5];
        4'h4: sdaob <= sdaoa[4];
        4'h5: sdaob <= sdaoa[3];
        4'h6: sdaob <= sdaoa[2];
        4'h7: sdaob <= sdaoa[1];
        4'h8: sdaob <= sdaoa[0];
        4'h9: sdaob <= sda_start_2d;
        4'ha: sdaob <= sda_stop_2d;
        4'hb: sdaob <= 1'b1;
        4'hc: sdaob <= 1'b1;
        4'hd: sdaob <= 1'b1;
        4'he: sdaob <= 1'b1;
        4'hf: sdaob <= 1'b1;
      endcase
    end

    // sdaob_1d, sdaob_2d
    always @(posedge clk) begin
      sdaob_1d <= sdaob;
      sdaob_2d <= sdaob_1d;
    end

    // sdao
    assign sdao = sdaob_2d | startn;


// read data latch 部

    // adc_volt1_msb_latchp, adc_volt1_lsb_latchp
    // adc_volt2_msb_latchp, adc_volt2_lsb_latchp
    // adc_volt3_msb_latchp, adc_volt3_lsb_latchp 
    // adc2_volt1_msb_latchp, adc2_volt1_lsb_latchp
    // adc2_volt2_msb_latchp, adc2_volt2_lsb_latchp
    // adc2_volt3_msb_latchp, adc2_volt3_lsb_latchp 
    // rh_msb_latchp, rh_lsb_latchp, rh_csum_latchp
    // tmp_msb_latchp, tmp_lsb_latchp, tmp_csum_latchp

    assign adc_volt1_msb_latchp = adc_rd_tim & qf_d2 & qe_d8 & sda_readp;
    assign adc_volt1_lsb_latchp = adc_rd_tim & qf_d3 & qe_d8 & sda_readp;
    assign adc_volt2_msb_latchp = adc_rd_tim & qf_d4 & qe_d8 & sda_readp;
    assign adc_volt2_lsb_latchp = adc_rd_tim & qf_d5 & qe_d8 & sda_readp;
    assign adc_volt3_msb_latchp = adc_rd_tim & qf_d6 & qe_d8 & sda_readp;
    assign adc_volt3_lsb_latchp = adc_rd_tim & qf_d7 & qe_d8 & sda_readp;

    assign adc2_volt1_msb_latchp = adc2_rd1_tim & qf_d2 & qe_d8 & sda_readp;
    assign adc2_volt1_lsb_latchp = adc2_rd1_tim & qf_d3 & qe_d8 & sda_readp;
    assign adc2_volt2_msb_latchp = adc2_rd2_tim & qf_d2 & qe_d8 & sda_readp;
    assign adc2_volt2_lsb_latchp = adc2_rd2_tim & qf_d3 & qe_d8 & sda_readp;
    assign adc2_volt3_msb_latchp = adc2_rd3_tim & qf_d2 & qe_d8 & sda_readp;
    assign adc2_volt3_lsb_latchp = adc2_rd3_tim & qf_d3 & qe_d8 & sda_readp;

    assign rh_msb_latchp = msr_rh_tim & qf_d5 & qe_d8 & sda_readp;
    assign rh_lsb_latchp = msr_rh_tim & qf_d6 & qe_d8 & sda_readp;
    assign rh_csum_latchp = msr_rh_tim & qf_d7 & qe_d8 & sda_readp;

    assign tmp_msb_latchp = msr_tmp_tim & qf_d5 & qe_d8 & sda_readp;
    assign tmp_lsb_latchp = msr_tmp_tim & qf_d6 & qe_d8 & sda_readp;
    assign tmp_csum_latchp = msr_tmp_tim & qf_d7 & qe_d8 & sda_readp;

    // adc_volt1_rda  10bit
    always @(posedge clk) begin
      if(adc_volt1_msb_latchp)
        adc_volt1_rda[9:8] <= sda_din[1:0];
    end

    always @(posedge clk) begin
      if(adc_volt1_lsb_latchp)
        adc_volt1_rda[7:0] <= sda_din;
    end

    // adc_volt2_rda  10bit
    always @(posedge clk) begin
      if(adc_volt2_msb_latchp)
        adc_volt2_rda[9:8] <= sda_din[1:0];
    end

    always @(posedge clk) begin
      if(adc_volt2_lsb_latchp)
        adc_volt2_rda[7:0] <= sda_din;
    end

    // adc_volt3_rda  10bit
    always @(posedge clk) begin
      if(adc_volt3_msb_latchp)
        adc_volt3_rda[9:8] <= sda_din[1:0];
    end

    always @(posedge clk) begin
      if(adc_volt3_lsb_latchp)
        adc_volt3_rda[7:0] <= sda_din;
    end


    // adc2_volt1_rda  11bit 2'c
    always @(posedge clk) begin
      if(adc2_volt1_msb_latchp)
        adc2_volt1_rda[10:3] <= sda_din;
    end

    always @(posedge clk) begin
      if(adc2_volt1_lsb_latchp)
        adc2_volt1_rda[2:0] <= sda_din[7:5];
    end

    // adc2_volt1_rdb  10bit
    assign adc2_volt1_rdb = adc2_volt1_rda[10] ? 10'd0 : adc2_volt1_rda[9:0];  // UF


    // adc2_volt2_rda  11bit 2'c
    always @(posedge clk) begin
      if(adc2_volt2_msb_latchp)
        adc2_volt2_rda[10:3] <= sda_din;
    end

    always @(posedge clk) begin
      if(adc2_volt2_lsb_latchp)
        adc2_volt2_rda[2:0] <= sda_din[7:5];
    end

    // adc2_volt2_rdb  10bit
    assign adc2_volt2_rdb = adc2_volt2_rda[10] ? 10'd0 : adc2_volt2_rda[9:0];  // UF


    // adc2_volt3_rda  11bit 2'c
    always @(posedge clk) begin
      if(adc2_volt3_msb_latchp)
        adc2_volt3_rda[10:3] <= sda_din;
    end

    always @(posedge clk) begin
      if(adc2_volt3_lsb_latchp)
        adc2_volt3_rda[2:0] <= sda_din[7:5];
    end

    // adc2_volt3_rdb  10bit
    assign adc2_volt3_rdb = adc2_volt3_rda[10] ? 10'd0 : adc2_volt3_rda[9:0];  // UF


    // volt1_rda, volt2_rda, volt3_rda  10bit
    always @(posedge clk) begin
      volt1_rda <= adc_err_det ? adc2_volt1_rdb : adc_volt1_rda;
      volt2_rda <= adc_err_det ? adc2_volt2_rdb : adc_volt2_rda;
      volt3_rda <= adc_err_det ? adc2_volt3_rdb : adc_volt3_rda;
    end


    // rh_rx_data  16bit
    always @(posedge clk) begin
      if(rh_msb_latchp)
        rh_rx_data[15:8] <= sda_din;
    end

    always @(posedge clk) begin
      if(rh_lsb_latchp)
        rh_rx_data[7:0] <= sda_din;
    end

    // rh_rx_csum  8bit
    always @(posedge clk) begin
      if(rh_csum_latchp)
        rh_rx_csum <= sda_din;
    end


    // tmp_rx_data  16bit
    always @(posedge clk) begin
      if(tmp_msb_latchp)
        tmp_rx_data[15:8] <= sda_din;
    end

    always @(posedge clk) begin
      if(tmp_lsb_latchp)
        tmp_rx_data[7:0] <= sda_din;
    end

    // tmp_rx_csum  8bit
    always @(posedge clk) begin
      if(tmp_csum_latchp)
        tmp_rx_csum <= sda_din;
    end


// Voltage Read data 処理

    // v1_gt_v2, v2_gt_v3, v3_gt_v1
    always @(posedge clk) begin
      v1_gt_v2 <= (volt1_rda > volt2_rda);
      v2_gt_v3 <= (volt2_rda > volt3_rda);
      v3_gt_v1 <= (volt3_rda > volt1_rda);
    end

    // sel_volt2, sel_volt3
    // assign sel_volt2 = ~v1_gt_v2 & v2_gt_v3;
    // assign sel_volt3 = ~v2_gt_v3 & v3_gt_v1;
    assign sel_volt2 = ~(v1_gt_v2 ^ v2_gt_v3) & (v2_gt_v3 ^ v3_gt_v1);
    assign sel_volt3 = (v1_gt_v2 ^ v2_gt_v3) & ~(v2_gt_v3 ^ v3_gt_v1);

    // volt_rdata  10bit
    always @(posedge clk) begin
      case ({sel_volt3, sel_volt2})
        2'h0: volt_rdata <= volt1_rda;
        2'h1: volt_rdata <= volt2_rda;
        2'h2: volt_rdata <= volt3_rda;
        2'h3: volt_rdata <= volt3_rda;
      endcase
    end

    // volt_rd_low
    always @(posedge clk) begin
      volt_rd_low <= ~volt_rdata[8] & ~volt_rdata[9];
    end


// Sensor Read data の CRC チェック

    // rh_lsb_latchp_1d, tmp_lsb_latchp_1d
    always @(posedge clk) begin
      rh_lsb_latchp_1d <= rh_lsb_latchp;
      tmp_lsb_latchp_1d <= tmp_lsb_latchp;
    end

    // sens_crc_clr
    assign sens_crc_clr = rh_lsb_latchp | tmp_lsb_latchp;

    // sens_crc_ce
    assign sens_crc_ce = sens_crc_clr | rh_lsb_latchp_1d | tmp_lsb_latchp_1d;

    // sens_crc_dsel  3bit
    assign sens_crc_dsel[0] = rh_lsb_latchp | tmp_lsb_latchp;
    assign sens_crc_dsel[1] = rh_lsb_latchp_1d | tmp_lsb_latchp;
    assign sens_crc_dsel[2] = tmp_lsb_latchp_1d;

    // sens_crc_din  8bit
    function [7:0] sens_crc_din_sel;
    input [2:0] sel;
      case(sel)
        3'h0: sens_crc_din_sel = 8'd0;
        3'h1: sens_crc_din_sel = rh_rx_data[15:8];
        3'h2: sens_crc_din_sel = rh_rx_data[7:0];
        3'h3: sens_crc_din_sel = tmp_rx_data[15:8];
        3'h4: sens_crc_din_sel = tmp_rx_data[7:0];
        default: sens_crc_din_sel = 8'd0;
      endcase
    endfunction

    assign sens_crc_din = sens_crc_din_sel(sens_crc_dsel);


    // サブモジュール sens_crc (CRC演算)
    sens_crc  sens_crc_0(
      .clk            (clk),
      .ce             (sens_crc_ce),
      .rst            (~sens_pwr_up),
      .clr            (sens_crc_clr),
      .d              (sens_crc_din),    // 8bit データ入力

      .crc_out        (sens_crc_out)     // 8bit データ出力
    );


    // rh_csum_latchp_1d, tmp_csum_latchp_1d
    always @(posedge clk) begin
      rh_csum_latchp_1d <= rh_csum_latchp;
      tmp_csum_latchp_1d <= tmp_csum_latchp;
    end


    // rh_csum_ok_p
    always @(posedge clk) begin
      rh_csum_ok_p <= (sens_crc_out == rh_rx_csum) & rh_csum_latchp_1d;
    end

    // rh_rdata  16bit
    always @(posedge clk) begin
      if(rh_csum_ok_p)
        rh_rdata <= rh_rx_data;
    end

    // rh_out_startn
    always @(posedge clk) begin
      if(~sens_pwr_up)
        rh_out_startn <= 1'b1;
      else if(rh_csum_ok_p)
        rh_out_startn <= 1'b0;
    end


    // tmp_csum_ok_p
    always @(posedge clk) begin
      tmp_csum_ok_p <= (sens_crc_out == tmp_rx_csum) & tmp_csum_latchp_1d;
    end

    // tmp_rdata  16bit
    always @(posedge clk) begin
      if(tmp_csum_ok_p)
        tmp_rdata <= tmp_rx_data;
    end

    // tmp_out_startn
    always @(posedge clk) begin
      if(~sens_pwr_up)
        tmp_out_startn <= 1'b1;
      else if(tmp_csum_ok_p)
        tmp_out_startn <= 1'b0;
    end


// Voltage data 変換

    // volt_do1a  26bit
    assign volt_do1a = volt_rdata * 16'd53687;

    // volt_do2a  10bit
    always @(posedge clk) begin
      volt_do2a <= volt_do1a[25:16];
    end

    // volt_doa  9bit
    always @(posedge clk) begin
      volt_doa <= volt_do2a[9:1] + {8'd0, volt_do2a[0]};  // RND
    end


// RH data 変換

    // rh_rda  23bit
    assign rh_rda = rh_rdata * 7'd125;

    // rh_rdb  15bit  (小数点以下8bit)
    always @(posedge clk) begin
      rh_rdb <= rh_rda[22:8];
    end

    // rh_rd_uf, rh_rd_of
    always @(posedge clk) begin
      rh_rd_uf <= (rh_rdb < 15'h0600);
      rh_rd_of <= (rh_rdb > 15'h6a00);
    end

    // rh_rdc  15bit
    always @(posedge clk) begin
      rh_rdc <= rh_rdb + 15'h7a00;  // -6
    end

    // rh_rdd  15bit
    always @(posedge clk) begin
      case ({rh_rd_of, rh_rd_uf})
        2'h0: rh_rdd <= rh_rdc;
        2'h1: rh_rdd <= 15'h0000;
        2'h2: rh_rdd <= 15'h6400;
        2'h3: rh_rdd <= 15'h6400;
      endcase
    end

    // rh_do1a  32bit
    assign rh_do1a = rh_rdd * 17'd83881;

    // rh_do2a  15bit
    always @(posedge clk) begin
      rh_do2a <= rh_do1a[31:17];
    end

    // rh_doa  14bit
    always @(posedge clk) begin
      rh_doa <= rh_do2a[14] ? 14'h3fff : rh_do2a[13:0];  // OF
    end


// Temperature data 変換

    // tmp_rda  31bit
    assign tmp_rda = tmp_rdata * 15'd31981;

    // tmp_rdb  31bit  (小数点以下19bit)
    always @(posedge clk) begin
      tmp_rdb <= tmp_rda;
    end

    // tmp_do1a  32bit
    assign tmp_do1a = tmp_rdb + {4'd0, 27'd97209549};

    // tmp_do2a  14bit
    always @(posedge clk) begin
      tmp_do2a <= tmp_do1a[31:18];
    end

    // tmp_do3a  13bit
    assign tmp_do3a = tmp_do2a[12:1] + {11'd0, tmp_do2a[0]};  // RND

    // tmp_doa  12bit
    always @(posedge clk) begin
      tmp_doa <= (tmp_do2a[13] | tmp_do3a[12]) ? 12'hfff : tmp_do3a[11:0];  // OF
    end


// データ出力部

    // frame_alt_1d, frame_alt_2d, ovp
    always @(posedge clk) begin
      frame_alt_1d <= frame_alt;
      frame_alt_2d <= frame_alt_1d;
      ovp <= frame_alt_1d ^ frame_alt_2d;
    end

    // volt_dob  10bit
    // rh_dob    15bit
    // tmp_dob   13bit
    always @(posedge clk) begin
      if(qh_endp) begin
        volt_dob <= ((adc_err_det & adc2_err_det) | volt_rd_low) ? 10'd0 : {1'b1, volt_doa};
        rh_dob   <= (sens_err_det | rh_out_startn) ? 15'd0 : {1'b1, rh_doa};  // MSB : Sensor working
        tmp_dob  <= (sens_err_det | tmp_out_startn) ? 13'd0 : {1'b1, tmp_doa};  // MSB : Sensor working
      end
    end

    // volt_doc  10bit
    // rh_doc    15bit
    // tmp_doc   13bit
    always @(posedge clk) begin
      if(ovp) begin
        volt_doc <= volt_dob;
        rh_doc   <= rh_dob;
        tmp_doc  <= tmp_dob;
      end
    end

    // volt_dout, rh_dout, tmp_dout  16bit
    assign volt_dout = {volt_doc[9], 6'd0, volt_doc[8:0]};
    assign rh_dout   = {rh_doc[14], 1'd0, rh_doc[13:0]};
    assign tmp_dout  = {tmp_doc[12], 3'd0, tmp_doc[11:0]};

endmodule
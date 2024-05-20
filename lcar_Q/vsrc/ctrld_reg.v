`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// Control data register
//
// 2016.02.10 Added "backup"

module ctrld_reg (ovp, pac_stp, rx_dv, d, rx_er, sel_port_b, c_done, rx_ok, clk,
                  mem_pad, mem_pad_ena, dsw_pad_update, pixel_disp_on,
                  test_dsw, cmd_test_pat, cmd_brightness, cmd_gamma,
                  cmd_ct_red, cmd_ct_green, cmd_ct_blue, cmd_m4_on, cmd_m4_bank1,
                  m4_set_done,

                  ctrld_csum_ok,
                  total_panel, out_ch, h_size, v_size, color_loss,
                  panel_num, rx_fan_on, rx_im_download, pac1_ok,
                  pnl_adrs_update, update_pnl_num,
                  reboot_n, er_update, update_er_on,
                  hstp, vstp, color_loss_on_n,
                  brightness, gamma, ct_red, ct_green, ct_blue,
                  m4_on, m4_bank1, m4_brt, test_pat, fr_rate, backup);

    input ovp;        // V start puls, pac_stp と同相, 1clock幅
    input pac_stp;    // Packet start pulse, Preamble の 1clock 前, 1clock幅
    input rx_dv;      // RX data valid
    input [7:0] d;    // Packet data
    input rx_er;      // RX data error
    input sel_port_b; // Port B 入力選択
    input c_done;     // FPGA Configuration done
    input rx_ok;      // RX signal is OK
    input clk;        // 125MHz
    input [9:0] mem_pad;      // Memory出力の Panel address
    input mem_pad_ena;        // Memory出力の Panel address イネーブル
    input dsw_pad_update;     // DIP switch による Panel address update
    input pixel_disp_on;      // Pixel display ON
    input [3:0] test_dsw;     // DIP switch による Test pattern 設定
    input [7:0] cmd_test_pat;    // Command Test pattern 設定
    input [6:0] cmd_brightness;  // Command Brightness 設定
    input [2:0] cmd_gamma;       // Command Gamma 設定
    input [3:0] cmd_ct_red;      // Command Color temperature Red 設定
    input [3:0] cmd_ct_green;    // Command Color temperature Green 設定
    input [3:0] cmd_ct_blue;     // Command Color temperature Blue 設定
    input cmd_m4_on;             // Command M4 ON 設定
    input cmd_m4_bank1;          // Command M4 Bank 1 設定
    input m4_set_done;           // 起動時の IM download 終了

    output reg ctrld_csum_ok;
    output reg [9:0] total_panel;
    output reg [2:0] out_ch;
    output reg [10:0] h_size;
    output reg [10:0] v_size;
    output reg [2:0] color_loss;
    output reg [9:0] panel_num;
    output reg rx_fan_on;
    output reg rx_im_download;
    output pac1_ok;
    output reg pnl_adrs_update;
    output reg [9:0] update_pnl_num;
    output reboot_n;
    output reg er_update;
    output reg update_er_on;
    output reg [10:0] hstp;
    output reg [10:0] vstp;
    output reg color_loss_on_n;
    output reg [6:0] brightness;
    output reg [2:0] gamma;
    output reg [3:0] ct_red;
    output reg [3:0] ct_green;
    output reg [3:0] ct_blue;
    output reg m4_on;
    output reg m4_bank1;
    output reg [6:0] m4_brt;
    output reg [7:0] test_pat;
    output reg [15:0] fr_rate;
    output reg backup;

    reg [10:0] pn;
    reg pn_eq1, pn_eq2;
    reg pac_stp_1d, pac_stp_2d;
    reg qa_rstp;
    reg rx_dv_1d, rx_dv_2d, rx_dv_3d, rx_dv_4d;
    reg pn1_dv_endp_1d, pn2_dv_endp_1d;
    reg [11:0] qa;
    reg header1_time, header2_time;
    reg pn1_word1_time, pn1_word2_time, pn1_word3_time, pn1_word4_time, pn1_word5_time;
    reg pn1_word6_time, pn1_word7_time, pn1_word8_time, pn1_word9_time, pn1_word10_time;
    reg pn1_word11_time, pn1_word12_time, pn1_word13_time, pn1_word14_time, pn1_word15_time;
    reg pn1_word16_time, pn1_word17_time, pn1_word18_time, pn1_word19_time, pn1_word20_time;
    reg pn1_word25_time, pn1_word26_time;
    reg pn1_word33_time;
    reg pnl_ctrld_stp;
    reg start_posi_stp;
    reg word2049_time, word2050_time;
    reg header2_time_1d, pn1_word33_time_1d, word2050_time_1d;
    reg pn1_dv_leng_ok, pn2_dv_leng_ok;
    reg [7:0] d_1d;
    reg [15:0] rx_pac_num;
    reg [7:0] rx_ctrld_csum;
    reg [15:0] rx_pac_csum;
    reg qa_gt4, qa_lt37;
    reg qa_gt0, qa_lt2053;
    reg [7:0] ctrld_accum;
    reg [15:0] pac_accum;
    reg pn1_pac_csum_ok, pn2_pac_csum_ok;
    reg pn1_pac_num_ok, pn2_pac_num_ok;
    reg rx_er_1d, rx_er_2d, rx_er_3d;
    reg rx_er_ok_a;
    reg pn1_rx_er_ok, pn2_rx_er_ok;
    reg sel_port_b_1d, sel_port_b_2d;
    reg [4:0] qb;
    reg pn1_out_ce;
    reg [7:0] pn1_wd1d;
    reg [1:0] pn1_wd2d;
    reg pn1_wd2d6b;
    reg [7:0] pn1_wd3d;
    reg [1:0] pn1_wd4d10;
    reg pn1_wd4d7;
    reg [2:0] pn1_wd5d;
    reg [7:0] pn1_wd6d;
    reg [2:0] pn1_wd7d;
    reg [7:0] pn1_wd8d;
    reg [2:0] pn1_wd9d;
    reg [6:0] pn1_wd11d;
    reg [2:0] pn1_wd12d;
    reg [3:0] pn1_wd13d;
    reg [3:0] pn1_wd14d;
    reg [3:0] pn1_wd15d;
    reg [3:0] pn1_wd16d;
    reg [7:0] pn1_wd17d;
    reg [2:0] pn1_wd18d;
    reg [6:0] pn1_wd19d;
    reg [6:0] pn1_wd20d;
    reg [7:0] pn1_wd25d;
    reg [7:0] pn1_wd26d;
    reg [9:0] rx_panel_num;
    reg rx_pad_update;
    reg [6:0] rx_brt;
    reg [2:0] rx_gam;
    reg [3:0] rx_ct_r, rx_ct_g, rx_ct_b;
    reg [3:0] m4er_onoff;
    reg [7:0] rx_test_pat;
    reg [6:0] rx_m4on_brt, rx_m4off_brt;
    reg [15:0] rx_fr_rate;
    reg rx_backup;
    reg [8:0] pnl_num;
    reg [9:0] qc;
    reg qc_stop_1d;
    reg pnl_ctrld_ce;
    reg rx_reboot_a, rx_fan_on_a, rx_im_download_a;
    reg rx_reboot, rx_fan_on_b, rx_im_download_b;
    reg pn1_ok_1d;
    reg [15:0] pn1_ok_d;
    reg pn1_ok_v16;
    reg dsw_pad_up_1d, dsw_pad_up_2d;
    reg pad_update_req;
    reg [15:0] rx_pad_up;
    reg [3:0] pad_up;
    reg exp_pad_up;
    reg exp_pad_up_1d;
    reg pad_update_req_1d;
    reg [15:0] rx_rbt;
    reg [15:0] rx_er_up;
    reg [3:0] er_up;
    reg exp_er_up;
    reg exp_er_up_1d;
    reg rx_er_update_1d;
    reg pn2_out_ce;
    reg [11:0] qd;
    reg qd_stop_1d;
    reg h_posi_l_ce, h_posi_m_ce, v_posi_l_ce, v_posi_m_ce;
    reg [10:0] h_posi, v_posi;
    reg [7:0] cmd_testp;
    reg [7:0] no_in_test_pat;
    reg [6:0] cmd_brt;
    reg [2:0] cmd_gam;
    reg [3:0] cmd_ct_r, cmd_ct_g, cmd_ct_b;
    reg cmd_m4_on_d, cmd_m4_bank1_d;
    reg m4_on_a;
    reg m4_set_done_1d;
    reg [6:0] m4_off_brt, m4_on_brt;
    reg [7:0] test_pat_a;

    wire pn_stop;
    wire qa_stop;
    wire dv_endp;
    wire pn1_dv_endp, pn2_dv_endp;
    wire ctrld_time;
    wire pac_data_time;
    wire qb_rstp;
    wire qb_stop;
    wire in_change;
    wire pn1_ok;
    wire qc_stop;
    wire update_pnl_num_ce;
    wire rx_er_update;
    wire update_er_on_ce;
    wire pn2_ok;
    wire qd_stop;
    wire dsw_test_pat_on;
    wire cmd_test_pat_on;
    wire [7:0] dsw_test_pat;


// タイミング信号作成

    // pn  11bitカウンタ  (Packet Number 作成)
    always @(posedge clk) begin
      if(ovp)
        pn <= 0;
      else if(pac_stp & ~pn_stop)
        pn <= pn + 1;
    end

    // pn_stop
    assign pn_stop = pn[10] & pn[9];  // 1024+512=1536

    // pn_eq1, pn_eq2
    always @(posedge clk) begin
      pn_eq1 <= (pn == 11'd1);
      pn_eq2 <= (pn == 11'd2);
    end

    // pac_stp_1d, pac_stp_2d
    always @(posedge clk) begin
      pac_stp_1d <= pac_stp;
      pac_stp_2d <= pac_stp_1d;
    end

    // qa_rstp
    always @(posedge clk) begin
      qa_rstp <= (pn_eq1 | pn_eq2) & pac_stp_2d;
    end


    // rx_dv_1d, rx_dv_2d, rx_dv_3d, rx_dv_4d
    always @(posedge clk) begin
      rx_dv_1d <= rx_dv;
      rx_dv_2d <= rx_dv_1d;
      rx_dv_3d <= rx_dv_2d;
      rx_dv_4d <= rx_dv_3d;
    end

    // dv_endp, pn1_dv_endp, pn2_dv_endp
    assign dv_endp = ~rx_dv_3d & rx_dv_4d;
    assign pn1_dv_endp = dv_endp & pn_eq1;
    assign pn2_dv_endp = dv_endp & pn_eq2;

    // pn1_dv_endp_1d, pn2_dv_endp_1d
    always @(posedge clk) begin
      pn1_dv_endp_1d <= pn1_dv_endp;
      pn2_dv_endp_1d <= pn2_dv_endp;
    end


    // qa  12bitカウンタ  (Byte Number 作成)
    always @(posedge clk) begin
      if(qa_rstp)
        qa <= 0;
      else if(rx_dv_3d & ~qa_stop)
        qa <= qa + 1;
    end

    // qa_stop
    assign qa_stop = qa[11] & qa[4];  // 2048+16=2064

    // header1_time, header2_time -- word2049_time, word2050_time
    always @(posedge clk) begin
      header1_time    <= (qa == 12'd1  );           // Packet Number LSB
      header2_time    <= header1_time;              // Packet Number MSB
      pn1_word1_time  <= (qa == 12'd5  ) & pn_eq1;
      pn1_word2_time  <= pn1_word1_time;
      pn1_word3_time  <= pn1_word2_time;
      pn1_word4_time  <= pn1_word3_time;
      pn1_word5_time  <= pn1_word4_time;
      pn1_word6_time  <= pn1_word5_time;
      pn1_word7_time  <= pn1_word6_time;
      pn1_word8_time  <= pn1_word7_time;
      pn1_word9_time  <= pn1_word8_time;
      pn1_word10_time <= pn1_word9_time;
      pn1_word11_time <= pn1_word10_time;
      pn1_word12_time <= pn1_word11_time;
      pn1_word13_time <= pn1_word12_time;
      pn1_word14_time <= pn1_word13_time;
      pn1_word15_time <= pn1_word14_time;
      pn1_word16_time <= pn1_word15_time;
      pn1_word17_time <= pn1_word16_time;
      pn1_word18_time <= pn1_word17_time;
      pn1_word19_time <= pn1_word18_time;
      pn1_word20_time <= pn1_word19_time;
      pn1_word25_time <= (qa == 12'd29  ) & pn_eq1;
      pn1_word26_time <= pn1_word25_time;
      pn1_word33_time <= (qa == 12'd37  ) & pn_eq1;  // Control data Checksum
      pnl_ctrld_stp   <= (qa == 12'd1026) & pn_eq1;
      start_posi_stp  <= (qa == 12'd2   ) & pn_eq2;
      word2049_time   <= (qa == 12'd2053);           // Packet1 Checksum LSB
      word2050_time   <= word2049_time;              // Packet1 Checksum MSB
    end

    // header2_time_1d, pn1_word33_time_1d, word2050_time_1d
    always @(posedge clk) begin
      header2_time_1d    <= header2_time;
      pn1_word33_time_1d <= pn1_word33_time;
      word2050_time_1d   <= word2050_time;
    end


// RX_DV の長さチェック

    // pn1_dv_leng_ok  RX_DVの長さが2060
    always @(posedge clk) begin
      if(pn1_dv_endp)
        pn1_dv_leng_ok <= (qa == 12'd2060);
    end

    // pn2_dv_leng_ok  RX_DVの長さが2060
    always @(posedge clk) begin
      if(pn2_dv_endp)
        pn2_dv_leng_ok <= (qa == 12'd2060);
    end


// Packet Number, Checksum data register

    // d_1d  8bit
    always @(posedge clk) begin
      d_1d  <= d;
    end

    // rx_pac_num  16bit  Packet Number
    always @(posedge clk) begin
      if(header1_time)
        rx_pac_num[7:0] <= d_1d;
    end

    always @(posedge clk) begin
      if(header2_time)
        rx_pac_num[15:8] <= d_1d;
    end

    // rx_ctrld_csum  8bit  Control data Checksum
    always @(posedge clk) begin
      if(pn1_word33_time)
        rx_ctrld_csum <= d_1d;
    end

    // rx_pac_csum  16bit  Packet Checksum
    always @(posedge clk) begin
      if(word2049_time)
        rx_pac_csum[7:0] <= d_1d;
    end

    always @(posedge clk) begin
      if(word2050_time)
        rx_pac_csum[15:8] <= d_1d;
    end


// Checksum 検査

    // qa_gt4, qa_lt37
    always @(posedge clk) begin
      qa_gt4  <= (qa > 12'd4);
      qa_lt37 <= (qa < 12'd37);
    end

    // ctrld_time
    assign ctrld_time = qa_gt4 & qa_lt37 & pn_eq1;

    // qa_gt0, qa_lt2053
    always @(posedge clk) begin
      qa_gt0    <= (qa > 12'd0);
      qa_lt2053 <= (qa < 12'd2053);
    end

    // pac_data_time
    assign pac_data_time = qa_gt0 & qa_lt2053;

    // ctrld_accum  8bit  Control data Checksum 算出
    always @(posedge clk) begin
      if(qa_rstp)
        ctrld_accum <= 0;
      else if(ctrld_time)
        ctrld_accum <= d_1d + ctrld_accum;
    end

    // pac_accum  16bit  Packet1 Checksum 算出
    always @(posedge clk) begin
      if(qa_rstp)
        pac_accum <= 0;
      else if(pac_data_time)
        pac_accum <= {8'd0, d_1d} + pac_accum;
    end

    // ctrld_csum_ok  Control data Checksum OK
    always @(posedge clk) begin
      if(pn1_word33_time_1d)
        ctrld_csum_ok <= (ctrld_accum == rx_ctrld_csum);
    end

    // pn1_pac_csum_ok  Packet1 Checksum OK
    always @(posedge clk) begin
      if(word2050_time_1d & pn_eq1)
        pn1_pac_csum_ok <= (pac_accum == rx_pac_csum);
    end

    // pn2_pac_csum_ok  Packet2 Checksum OK
    always @(posedge clk) begin
      if(word2050_time_1d & pn_eq2)
        pn2_pac_csum_ok <= (pac_accum == rx_pac_csum);
    end


// Packet Number 検査

    // pn1_pac_num_ok  Packet Number OK
    always @(posedge clk) begin
      if(header2_time_1d & pn_eq1)
        pn1_pac_num_ok <= ({5'd0, pn} == rx_pac_num); 
    end

    // pn2_pac_num_ok  Packet Number OK
    always @(posedge clk) begin
      if(header2_time_1d & pn_eq2)
        pn2_pac_num_ok <= ({5'd0, pn} == rx_pac_num); 
    end


// PX ER 検査

    // rx_er_1d, rx_er_2d, rx_er_3d
    always @(posedge clk) begin
      rx_er_1d <= rx_er;
      rx_er_2d <= rx_er_1d;
      rx_er_3d <= rx_er_2d;
    end

    // rx_er_ok_a
    always @(posedge clk) begin
      if(qa_rstp)
        rx_er_ok_a <= 1;
      else if(rx_er_3d)
        rx_er_ok_a <= 0;
    end

    // pn1_rx_er_ok
    always @(posedge clk) begin
      if(pn1_dv_endp)
        pn1_rx_er_ok <= rx_er_ok_a; 
    end

    // pn2_rx_er_ok
    always @(posedge clk) begin
      if(pn2_dv_endp)
        pn2_rx_er_ok <= rx_er_ok_a; 
    end


// 入力ポート変化検出

    // sel_port_b_1d, sel_port_b_2d
    always @(posedge clk) begin
      sel_port_b_1d <= sel_port_b;
      sel_port_b_2d <= sel_port_b_1d;
    end

    // qb_rstp
    assign qb_rstp = sel_port_b_1d ^ sel_port_b_2d;

    // qb  5bitカウンタ  (入力ポート変化時 16V カウント)
    always @(posedge clk) begin
      if(qb_rstp)
        qb <= 0;
      else if(ovp & ~qb_stop)
        qb <= qb + 1;
    end

    // qb_stop
    assign qb_stop = qb[4];  // 16

    // in_change
    assign in_change = ~qb_stop;


// Control data register

    // pn1_ok
    assign pn1_ok = c_done &
                    rx_ok &
					
                   //~in_change &
                    pn1_dv_leng_ok &
                   // ctrld_csum_ok &
                   // pn1_pac_csum_ok &
                    pn1_pac_num_ok &
                    pn1_rx_er_ok;

    // pn1_out_ce
    always @(posedge clk) begin
      pn1_out_ce <= pn1_dv_endp_1d & pn1_ok;
    end


    // pn1_wd1d  8bit  (rx_panel_num [LSB])
    always @(posedge clk) begin
      if(pn1_word1_time)
        pn1_wd1d <= d_1d;
    end

    // pn1_wd2d  2bit  (rx_panel_num [MSB]),  pn1_wd2d6b  (rx_backup)
    always @(posedge clk) begin
      if(pn1_word2_time) begin
        pn1_wd2d <= d_1d[1:0];
        pn1_wd2d6b <= d_1d[6];
      end
    end

    // pn1_wd3d  8bit  (total_panel [LSB])
    always @(posedge clk) begin
      if(pn1_word3_time)
        pn1_wd3d <= d_1d;
    end

    // pn1_wd4d10  2bit  (total_panel [MSB]),  pn1_wd4d7  (rx_pad_update)
    always @(posedge clk) begin
      if(pn1_word4_time) begin
        pn1_wd4d10 <= d_1d[1:0];
        pn1_wd4d7  <= d_1d[7];
      end
    end

    // pn1_wd5d  3bit  (out_ch)
    always @(posedge clk) begin
      if(pn1_word5_time)
        pn1_wd5d <= d_1d[2:0];
    end

    // pn1_wd6d  8bit  (h_size [LSB])
    always @(posedge clk) begin
      if(pn1_word6_time)
        pn1_wd6d <= d_1d;
    end

    // pn1_wd7d  3bit  (h_size [MSB])
    always @(posedge clk) begin
      if(pn1_word7_time)
        pn1_wd7d <= d_1d[2:0];
    end

    // pn1_wd8d  8bit  (v_size [LSB])
    always @(posedge clk) begin
      if(pn1_word8_time)
        pn1_wd8d <= d_1d;
    end

    // pn1_wd9d  3bit  (v_size [MSB])
    always @(posedge clk) begin
      if(pn1_word9_time)
        pn1_wd9d <= d_1d[2:0];
    end

    // pn1_wd11d  7bit  (rx_brt)
    always @(posedge clk) begin
      if(pn1_word11_time)
        pn1_wd11d <= d_1d[6:0];
    end

    // pn1_wd12d  3bit  (rx_gam)
    always @(posedge clk) begin
      if(pn1_word12_time)
        pn1_wd12d <= d_1d[2:0];
    end

    // pn1_wd13d  4bit  (rx_ct_r)
    always @(posedge clk) begin
      if(pn1_word13_time)
        pn1_wd13d <= d_1d[3:0];
    end

    // pn1_wd14d  4bit  (rx_ct_g)
    always @(posedge clk) begin
      if(pn1_word14_time)
        pn1_wd14d <= d_1d[3:0];
    end

    // pn1_wd15d  4bit  (rx_ct_b)
    always @(posedge clk) begin
      if(pn1_word15_time)
        pn1_wd15d <= d_1d[3:0];
    end

    // pn1_wd16d  4bit  (m4er_onoff)
    always @(posedge clk) begin
      if(pn1_word16_time)
        pn1_wd16d <= d_1d[3:0];
    end

    // pn1_wd17d  8bit  (rx_test_pat)
    always @(posedge clk) begin
      if(pn1_word17_time)
        pn1_wd17d <= d_1d;
    end

    // pn1_wd18d  3bit  (color_loss)
    always @(posedge clk) begin
      if(pn1_word18_time)
        pn1_wd18d <= d_1d[2:0];
    end

    // pn1_wd19d  7bit  (rx_m4on_brt)
    always @(posedge clk) begin
      if(pn1_word19_time)
        pn1_wd19d <= d_1d[6:0];
    end

    // pn1_wd20d  7bit  (rx_m4off_brt)
    always @(posedge clk) begin
      if(pn1_word20_time)
        pn1_wd20d <= d_1d[6:0];
    end

    // pn1_wd25d  8bit  (fr_rate [LSB])
    always @(posedge clk) begin
      if(pn1_word25_time)
        pn1_wd25d <= d_1d;
    end

    // pn1_wd26d  8bit  (fr_rate [MSB])
    always @(posedge clk) begin
      if(pn1_word26_time)
        pn1_wd26d <= d_1d;
    end

    // rx_panel_num -- rx_fr_rate
    always @(posedge clk) begin
      if(pn1_out_ce) begin
        rx_panel_num  <= {pn1_wd2d, pn1_wd1d};       // 10bit
        rx_backup     <= pn1_wd2d6b;                 // 1bit
        total_panel   <= {pn1_wd4d10, pn1_wd3d};     // 10bit
        rx_pad_update <= pn1_wd4d7;                  // 1bit
        out_ch        <= pn1_wd5d;                   // 3bit
        h_size        <= {pn1_wd7d, pn1_wd6d};       // 11bit
        v_size        <= {pn1_wd9d, pn1_wd8d};       // 11bit
        rx_brt        <= pn1_wd11d;                  // 7bit
        rx_gam        <= pn1_wd12d;                  // 3bit
        rx_ct_r       <= pn1_wd13d;                  // 4bit
        rx_ct_g       <= pn1_wd14d;                  // 4bit
        rx_ct_b       <= pn1_wd15d;                  // 4bit
        m4er_onoff    <= pn1_wd16d;                  // 4bit
        rx_test_pat   <= pn1_wd17d;                  // 8bit
        color_loss    <= pn1_wd18d;                  // 3bit
        rx_m4on_brt   <= pn1_wd19d;                  // 7bit
        rx_m4off_brt  <= pn1_wd20d;                  // 7bit
        rx_fr_rate    <= {pn1_wd26d, pn1_wd25d};     // 16bit
      end
    end


// Panel Control data register

    // panel_num  10bit
    always @(posedge clk) begin
      panel_num <= mem_pad_ena ? mem_pad : rx_panel_num; 
    end

    // pnl_num  9bit
    always @(posedge clk) begin
      pnl_num <= panel_num[9] ? 9'h1ff : panel_num[8:0]; 
    end


    // qc  10bitカウンタ
    always @(posedge clk) begin
      if(pnl_ctrld_stp)
        qc <= {1'b0, ~pnl_num};
      else if(~qc_stop)
        qc <= qc + 1;
    end

    // qc_stop
    assign qc_stop = qc[9];  // 512

    // qc_stop_1d
    always @(posedge clk) begin
      qc_stop_1d <= qc_stop; 
    end

    // pnl_ctrld_ce
    always @(posedge clk) begin
      pnl_ctrld_ce <= qc_stop & ~qc_stop_1d; 
    end


    // rx_reboot_a, rx_fan_on_a, rx_im_download_a
    always @(posedge clk) begin
      if(pnl_ctrld_ce) begin
        rx_reboot_a      <= d_1d[0];
        rx_fan_on_a      <= d_1d[2];
        rx_im_download_a <= d_1d[5];
      end
    end

    // rx_reboot, rx_fan_on_b, rx_im_download_b
    always @(posedge clk) begin
      if(pn1_out_ce) begin
        rx_reboot        <= rx_reboot_a; 
        rx_fan_on_b      <= rx_fan_on_a;
        rx_im_download_b <= rx_im_download_a;
      end
    end

    // rx_fan_on
    always @(posedge clk) begin
      rx_fan_on <= rx_fan_on_b | ~rx_ok;
    end

    // rx_im_download
    always @(posedge clk) begin
      rx_im_download <= rx_im_download_b & rx_ok;
    end


// pnl_adrs_update 出力処理

    // pn1_ok_1d
    always @(posedge clk) begin
      if(~c_done)
        pn1_ok_1d <= 1'b0;
      else 
        pn1_ok_1d <= pn1_ok; 
    end

    // pac1_ok
    assign pac1_ok = pn1_ok_1d;

    // pn1_ok_d[0]
    always @(posedge clk) begin
      if(~pn1_ok_1d)
        pn1_ok_d[0] <= 1'b0;
      else if(ovp)
        pn1_ok_d[0] <= 1'b1;
    end

    // pn1_ok_d[15:1]
    always @(posedge clk) begin
      if(~c_done)
        pn1_ok_d[15:1] <= 15'd0;
      else if(ovp)
        pn1_ok_d[15:1] <= pn1_ok_d[14:0];
    end

    // pn1_ok_v16
    always @(posedge clk) begin
      if(~c_done)
        pn1_ok_v16 <= 1'b0;
      else
        pn1_ok_v16 <= ({pn1_ok_d, pn1_ok_1d} == 17'h1ffff); 
    end


    // dsw_pad_up_1d, dsw_pad_up_2d
    always @(posedge clk) begin
      if(~c_done) begin
        dsw_pad_up_1d <= 1'b0;
        dsw_pad_up_2d <= 1'b0;
      end
      else if(ovp) begin
        dsw_pad_up_1d <= dsw_pad_update;
        dsw_pad_up_2d <= dsw_pad_up_1d;
      end
    end

    // pad_update_req, pad_update_req_1d
    always @(posedge clk) begin
      if(~c_done) begin
        pad_update_req    <= 1'b0;
        pad_update_req_1d <= 1'b0;
      end
      else
        pad_update_req    <= rx_pad_update | (dsw_pad_up_1d & ~dsw_pad_up_2d);
        pad_update_req_1d <= pad_update_req;
    end

    // update_pnl_num_ce
    assign update_pnl_num_ce = pad_update_req & ~pad_update_req_1d;

    // update_pnl_num  10bit
    always @(posedge clk) begin
      if(~c_done)
        update_pnl_num <= 10'd0;
      else if(update_pnl_num_ce)
        update_pnl_num <= rx_panel_num;
    end


    // rx_pad_up  16bit
    always @(posedge clk) begin
      if(~c_done)
        rx_pad_up <= 16'd0;
      else if(ovp) begin
        rx_pad_up[0]  <= pad_update_req & pn1_ok_v16;
        rx_pad_up[1]  <= rx_pad_up[0]   & pn1_ok_v16;
        rx_pad_up[2]  <= rx_pad_up[1]   & pn1_ok_v16;
        rx_pad_up[3]  <= rx_pad_up[2]   & pn1_ok_v16;
        rx_pad_up[4]  <= rx_pad_up[3]   & pn1_ok_v16;
        rx_pad_up[5]  <= rx_pad_up[4]   & pn1_ok_v16;
        rx_pad_up[6]  <= rx_pad_up[5]   & pn1_ok_v16;
        rx_pad_up[7]  <= rx_pad_up[6]   & pn1_ok_v16;
        rx_pad_up[8]  <= rx_pad_up[7]   & pn1_ok_v16;
        rx_pad_up[9]  <= rx_pad_up[8]   & pn1_ok_v16;
        rx_pad_up[10] <= rx_pad_up[9]   & pn1_ok_v16;
        rx_pad_up[11] <= rx_pad_up[10]  & pn1_ok_v16;
        rx_pad_up[12] <= rx_pad_up[11]  & pn1_ok_v16;
        rx_pad_up[13] <= rx_pad_up[12]  & pn1_ok_v16;
        rx_pad_up[14] <= rx_pad_up[13]  & pn1_ok_v16;
        rx_pad_up[15] <= rx_pad_up[14]  & pn1_ok_v16;
      end
    end

    // pad_up  4bit
    always @(posedge clk) begin
      if(~c_done)
        pad_up <= 4'd0;
      else if(ovp) begin
        pad_up[0] <= rx_pad_up[15] & pn1_ok_v16;
        pad_up[1] <= pad_up[0];
        pad_up[2] <= pad_up[1];
        pad_up[3] <= pad_up[2];
      end
    end

    // exp_pad_up
    always @(posedge clk) begin
      if(~c_done)
        exp_pad_up <= 1'b0;
      else
        exp_pad_up <= pad_up[0] | pad_up[1] | pad_up[2] | pad_up[3]; 
    end

    // exp_pad_up_1d, pnl_adrs_update
    always @(posedge clk) begin
      if(~c_done) begin
        exp_pad_up_1d   <= 1'b0;
        pnl_adrs_update <= 1'b0;
      end
      else if(ovp) begin
        exp_pad_up_1d   <= exp_pad_up;
        pnl_adrs_update <= exp_pad_up & ~exp_pad_up_1d;
      end
    end


// reboot 出力処理

    // rx_rbt  16bit
    always @(posedge clk) begin
      if(~c_done)
        rx_rbt <= 16'd0;
      else if(ovp) begin
        rx_rbt[0]  <= rx_reboot   & pn1_ok_v16;
        rx_rbt[1]  <= rx_rbt[0]   & pn1_ok_v16;
        rx_rbt[2]  <= rx_rbt[1]   & pn1_ok_v16;
        rx_rbt[3]  <= rx_rbt[2]   & pn1_ok_v16;
        rx_rbt[4]  <= rx_rbt[3]   & pn1_ok_v16;
        rx_rbt[5]  <= rx_rbt[4]   & pn1_ok_v16;
        rx_rbt[6]  <= rx_rbt[5]   & pn1_ok_v16;
        rx_rbt[7]  <= rx_rbt[6]   & pn1_ok_v16;
        rx_rbt[8]  <= rx_rbt[7]   & pn1_ok_v16;
        rx_rbt[9]  <= rx_rbt[8]   & pn1_ok_v16;
        rx_rbt[10] <= rx_rbt[9]   & pn1_ok_v16;
        rx_rbt[11] <= rx_rbt[10]  & pn1_ok_v16;
        rx_rbt[12] <= rx_rbt[11]  & pn1_ok_v16;
        rx_rbt[13] <= rx_rbt[12]  & pn1_ok_v16;
        rx_rbt[14] <= rx_rbt[13]  & pn1_ok_v16;
        rx_rbt[15] <= rx_rbt[14]  & pn1_ok_v16;
      end
    end

    // reboot_n
    assign reboot_n = ~(rx_rbt[15]  & pn1_ok_v16);


// er_update 出力処理

    // rx_er_update
    assign rx_er_update = m4er_onoff[3];

    // rx_er_update_1d
    always @(posedge clk) begin
      if(~c_done)
        rx_er_update_1d <= 1'b0;
      else
        rx_er_update_1d <= rx_er_update;
    end

    // update_er_on_ce
    assign update_er_on_ce = rx_er_update & ~rx_er_update_1d;

    // update_er_on
    always @(posedge clk) begin
      if(~c_done)
        update_er_on <= 1'b0;
      else if(update_er_on_ce)
        update_er_on <= m4er_onoff[2];
    end


    // rx_er_up  16bit
    always @(posedge clk) begin
      if(~c_done)
        rx_er_up <= 16'd0;
      else if(ovp) begin
        rx_er_up[0]  <= rx_er_update  & pn1_ok_v16;
        rx_er_up[1]  <= rx_er_up[0]   & pn1_ok_v16;
        rx_er_up[2]  <= rx_er_up[1]   & pn1_ok_v16;
        rx_er_up[3]  <= rx_er_up[2]   & pn1_ok_v16;
        rx_er_up[4]  <= rx_er_up[3]   & pn1_ok_v16;
        rx_er_up[5]  <= rx_er_up[4]   & pn1_ok_v16;
        rx_er_up[6]  <= rx_er_up[5]   & pn1_ok_v16;
        rx_er_up[7]  <= rx_er_up[6]   & pn1_ok_v16;
        rx_er_up[8]  <= rx_er_up[7]   & pn1_ok_v16;
        rx_er_up[9]  <= rx_er_up[8]   & pn1_ok_v16;
        rx_er_up[10] <= rx_er_up[9]   & pn1_ok_v16;
        rx_er_up[11] <= rx_er_up[10]  & pn1_ok_v16;
        rx_er_up[12] <= rx_er_up[11]  & pn1_ok_v16;
        rx_er_up[13] <= rx_er_up[12]  & pn1_ok_v16;
        rx_er_up[14] <= rx_er_up[13]  & pn1_ok_v16;
        rx_er_up[15] <= rx_er_up[14]  & pn1_ok_v16;
      end
    end

    // er_up  4bit
    always @(posedge clk) begin
      if(~c_done)
        er_up <= 4'd0;
      else if(ovp) begin
        er_up[0] <= rx_er_up[15] & pn1_ok_v16;
        er_up[1] <= er_up[0];
        er_up[2] <= er_up[1];
        er_up[3] <= er_up[2];
      end
    end

    // exp_er_up
    always @(posedge clk) begin
      if(~c_done)
        exp_er_up <= 1'b0;
      else
        exp_er_up <= er_up[0] | er_up[1] | er_up[2] | er_up[3]; 
    end

    // exp_er_up_1d, er_update
    always @(posedge clk) begin
      if(~c_done) begin
        exp_er_up_1d <= 1'b0;
        er_update    <= 1'b0;
      end
      else if(ovp) begin
        exp_er_up_1d <= exp_er_up;
        er_update    <= exp_er_up & ~exp_er_up_1d;
      end
    end


// Start position data register

    // pn2_ok
    assign pn2_ok = c_done &
                    rx_ok &
                   //~in_change &
                    pn2_dv_leng_ok &
                   // pn2_pac_csum_ok &
                    pn2_pac_num_ok &
                    pn2_rx_er_ok;

    // pn2_out_ce
    always @(posedge clk) begin
      pn2_out_ce <= pn2_dv_endp_1d & pn2_ok;
    end


    // qd  12bitカウンタ
    always @(posedge clk) begin
      if(start_posi_stp)
        qd <= {1'b0, ~pnl_num, 2'b11};
      else if(~qd_stop)
        qd <= qd + 1;
    end

    // qd_stop
    assign qd_stop = qd[11];  // 2048

    // qd_stop_1d
    always @(posedge clk) begin
      qd_stop_1d <= qd_stop; 
    end

    // h_posi_l_ce, h_posi_m_ce, v_posi_l_ce, v_posi_m_ce
    always @(posedge clk) begin
      h_posi_l_ce <= qd_stop & ~qd_stop_1d;
      h_posi_m_ce <= h_posi_l_ce;
      v_posi_l_ce <= h_posi_m_ce;
      v_posi_m_ce <= v_posi_l_ce;
    end


    // h_posi  11bit
    always @(posedge clk) begin
      if(h_posi_l_ce)
        h_posi[7:0] <= d_1d; 
    end

    always @(posedge clk) begin
      if(h_posi_m_ce)
        h_posi[10:8] <= d_1d[2:0]; 
    end

    // v_posi  11bit
    always @(posedge clk) begin
      if(v_posi_l_ce)
        v_posi[7:0] <= d_1d; 
    end

    always @(posedge clk) begin
      if(v_posi_m_ce)
        v_posi[10:8] <= d_1d[2:0]; 
    end

    // hstp, vstp  11bit
    always @(posedge clk) begin
      if(pn2_out_ce) begin
        hstp <= h_posi; 
        vstp <= v_posi;
      end
    end


// Sync Loss Color ON 設定

    // dsw_test_pat_on
    assign dsw_test_pat_on = test_dsw[0] | test_dsw[1] | test_dsw[2] | test_dsw[3];

    // cmd_testp  8bit
    always @(posedge clk) begin
      cmd_testp <= cmd_test_pat;
    end

    // cmd_test_pat_on
    assign cmd_test_pat_on = ((cmd_testp[6:4] == 3'h0) | (cmd_testp[6:4] == 3'h1) |
                              (cmd_testp[6:4] == 3'h2) | (cmd_testp[6:4] == 3'h4)) &
                              (cmd_testp[0] | cmd_testp[1] | cmd_testp[2] | cmd_testp[3]);

    // color_loss_on_n
    always @(posedge clk) begin
      color_loss_on_n <= ~(~rx_ok & ~pixel_disp_on & ~dsw_test_pat_on & ~cmd_test_pat_on);
    end

    // dsw_test_pat  8bit
    assign dsw_test_pat = {4'h0, test_dsw[0], test_dsw[1], test_dsw[2], test_dsw[3]};

    // no_in_test_pat  8bit
    always @(posedge clk) begin
      no_in_test_pat <= cmd_test_pat_on ? cmd_testp : dsw_test_pat;
    end


// 無入力時の Control data 設定

    // cmd_brt -- cmd_m4_bank1_d
    always @(posedge clk) begin
      cmd_brt        <= cmd_brightness;  // 7bit
      cmd_gam        <= cmd_gamma;       // 3bit
      cmd_ct_r       <= cmd_ct_red;      // 4bit
      cmd_ct_g       <= cmd_ct_green;    // 4bit
      cmd_ct_b       <= cmd_ct_blue;     // 4bit
      cmd_m4_on_d    <= cmd_m4_on;       // 1bit
      cmd_m4_bank1_d <= cmd_m4_bank1;    // 1bit
    end

    // brightness -- m4_bank1
    always @(posedge clk) begin
      brightness <= rx_ok ? rx_brt        : cmd_brt;         // 7bit
      gamma      <= rx_ok ? rx_gam        : cmd_gam;         // 3bit
      ct_red     <= rx_ok ? rx_ct_r       : cmd_ct_r;        // 4bit
      ct_green   <= rx_ok ? rx_ct_g       : cmd_ct_g;        // 4bit
      ct_blue    <= rx_ok ? rx_ct_b       : cmd_ct_b;        // 4bit
      m4_on_a    <= rx_ok ? m4er_onoff[0] : cmd_m4_on_d;     // 1bit
      m4_bank1   <= rx_ok ? m4er_onoff[1] : cmd_m4_bank1_d;  // 1bit
    end


    // m4_set_done_1d
    always @(posedge clk) begin
      if(ovp)
        m4_set_done_1d <= m4_set_done; 
    end

    // m4_on
    always @(posedge clk) begin
      m4_on <= m4_on_a & m4_set_done_1d;
    end


    // m4_on_brt, m4_off_brt  7bit
    always @(posedge clk) begin
      m4_on_brt  <= rx_ok ? rx_m4on_brt   : 7'h64;  // 100%
      m4_off_brt <= rx_ok ? rx_m4off_brt  : 7'h64;  // 100%
    end

    // m4_brt  7bit
    always @(posedge clk) begin
      //m4_brt <= m4_on ? m4_on_brt : m4_off_brt;
      m4_brt <= 7'h64;								//Hasco 2021.10
    end


    // test_pat_a  8bit
    always @(posedge clk) begin
      test_pat_a <= rx_ok ? rx_test_pat : no_in_test_pat;
    end

    // test_pat  8bit
    always @(posedge clk) begin
      test_pat <= pixel_disp_on ? 8'h00 : test_pat_a;
    end

    // fr_rate  16bit
    always @(posedge clk) begin
      fr_rate <= rx_ok ? rx_fr_rate : 16'd20854;  // 59.94Hz (=1.25M/59.94)
    end

    // backup
    always @(posedge clk) begin
      backup <= rx_backup & rx_ok;
    end

endmodule
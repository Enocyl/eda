`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board for PVII-4 (4x4 IM, MBI5051B)
// Data output for IM
//
// サブモジュール
//   sdp_bram_a11b_d32b  (video data buffer)
//
// 2017.04 作成
// 2017.09 変更 MBI5051BのConfiguration Register Setting変更(M4 OFF時の縦縞対策)
//

module data_out_lcar_m5353Q_14b43Hz (fm_cycle_stp, frame_alt_frz, frame_alt,
                           clk, fm_rd_d, oclk,
                           blank, rgb_out_zero, gclkout_start,
                           fm_ov_rd_adrs, fm_ov_rd_cycle,
                           scan_line, r_out, g_out, b_out, le_out, dclk_out,
                           r_we, g_we, b_we
						   //,cnt_scano
						   );

    input fm_cycle_stp;        // Frame memory 処理 cycle pulse, 72clock周期
    input frame_alt_frz;       // Frame alternate Freeze
    input frame_alt;           // Frame alternate
    input clk;                 // 125MHz
    input [31:0] fm_rd_d;      // Frame memory read video data
    input oclk;                // 125MHz
    input blank;               // blank timing
    input [2:0] rgb_out_zero;  // [2] R, [1] G, [0] B
    input gclkout_start;       // GCLK output start

    output [18:0] fm_ov_rd_adrs;  // Frame memory output video read address
    output fm_ov_rd_cycle;        // Frame memory output video read cycle
    //output [2:0] scan_line;       // Scan line select for IM
    output [3:0] scan_line;       // Scan line select for IM			//Hasco 2021.09
    output reg [15:0] r_out;      // Red data for IM
    output reg [15:0] g_out;      // Green data for IM
    output reg [15:0] b_out;      // Blue data for IM
    output reg le_out;            // LE for IM
    output reg dclk_out;          // DCLK for IM

 // チェック用出力
    output reg r_we;
    output reg g_we;
    output reg b_we;
	//output cnt_scano;
	
    reg frame_alt_1d, frame_alt_2d, ovp;
    reg ovt;
    reg fm_cycle_ovp;
    reg gs_odat_alt_1d, gs_odat_alt_2d, gs_odat_stp;
    reg gs_odat_st_tim;
    reg fm_cycle_gs_stp;
    //reg [7:0] qb;
    reg [9:0] qb;
    reg [6:0] qe;
    reg fm_rd_stp;
    reg [1:0] qf;
    reg [3:0] qg;
    reg [6:0] qh;
    reg [12:0] fm_pix_ad_ma;
    reg [12:0] fm_pix_ad_mb;
    reg fm_rd_bank;
    reg fm_d_wstp;
    reg [1:0] qk;
    reg [3:0] ql;
    reg [2:0] ql_1d;
    reg bram_wr_bank;
    reg [31:0] fm_rd_d_1d;
    reg [31:0] bram_ro, bram_go, bram_bo;
    reg frame_alt_oc_1d, frame_alt_oc_2d, ovp_oc;
    //reg [2:0] cnt_ock;
    reg [4:0] cnt_ock;
    reg cnt_ock_endp;
    reg [10:0] cnt_odt;
    reg odt_seq_end;
    //reg [7:0] cnt_odt_seq;
    reg [9:0] cnt_odt_seq;
    reg cf1_tim, cf2_tim, cf3_tim, gs_tim, cf_tim, dmy_tim;
    reg gs_odat_alt_oc;
    reg [9:0] bram_ra;
    reg cf_dclk_tim, cf1_le_tim, cf2_le_tim, cf3_le_tim, cf_dat_tim, gs_le_tim;
    reg blank_1d, blank_2d;
    reg blank_stp;
    reg blank_v_tim;
    reg blank_v_stp;
    //reg [7:0] cnt_blank;
    reg [10:0] cnt_blank;
    reg vsync_period;
    reg [5:0] cnt_vs_tim;
    reg vsync_stp;
    //reg [2:0] cnt_vs_ock;
    reg [4:0] cnt_vs_ock;
    reg cnt_vs_ock_endp;
    reg [1:0] cnt_vs_le;
    //reg [2:0] scan_line_a;
    reg [3:0] scan_line_a;
    reg [6:0] cnt_scan_tim;
    reg scan_timp;
    //reg [2:0] scan_line_b;
    reg [3:0] scan_line_b;
    reg gclkout_start_1d;
    reg gclkout_start_vd;
    reg gs_blank;
    reg r_out_zero, g_out_zero, b_out_zero;
    reg r_gs_blank;
    reg g_gs_blank;
    reg b_gs_blank;
    //reg [2:0] cnt_ock_1d;
    reg [4:0] cnt_ock_1d;
    //reg [3:0] cnt_odt_1d;
    reg [5:0] cnt_odt_1d;							//Hasco 2021.09
    reg [7:0] gs_lat_1d, gs_lat_2d, gs_lat_3d;
    reg [15:0] roa_1d, rob_1d, goa_1d, gob_1d, boa_1d, bob_1d;
    //reg [15:0] rout0d, rout1d, rout2d, rout3d, rout4d, rout5d, rout6d, rout7d;
    reg [47:0] rout0d, rout1d, rout2d, rout3d, rout4d, rout5d, rout6d, rout7d;			//Hasco 2021.09
    //reg [15:0] rout8d, rout9d, rout10d, rout11d, rout12d, rout13d, rout14d, rout15d;
    reg [47:0] rout8d, rout9d, rout10d, rout11d, rout12d, rout13d, rout14d, rout15d;	//Hasco 2021.09
    reg [15:0] gout0d, gout1d, gout2d, gout3d, gout4d, gout5d, gout6d, gout7d;
    reg [15:0] gout8d, gout9d, gout10d, gout11d, gout12d, gout13d, gout14d, gout15d;
    reg [15:0] bout0d, bout1d, bout2d, bout3d, bout4d, bout5d, bout6d, bout7d;
    reg [15:0] bout8d, bout9d, bout10d, bout11d, bout12d, bout13d, bout14d, bout15d;
    //reg [15:0] r_config_dat;
    reg [47:0] r_config_dat;			//Hasco 2021.09
    reg [15:0] g_config_dat;
    reg [15:0] b_config_dat;
    reg cnt_ock_endp_1d;
    //reg [3:0] cnt_cf_bit;				//Hasco 2021.09
    reg [5:0] cnt_cf_bit;
    reg r_config_sd_1d, r_config_sd_2d, r_config_sd_3d, r_config_sd_4d;
    reg r_config_sd_5d, r_config_sd_6d, r_config_sd_7d, r_config_sd_8d;
    reg r_config_sd_9d, r_config_sd_10d, r_config_sd_11d;
    reg g_config_sd_1d, g_config_sd_2d, g_config_sd_3d, g_config_sd_4d;
    reg g_config_sd_5d, g_config_sd_6d, g_config_sd_7d, g_config_sd_8d;
    reg g_config_sd_9d, g_config_sd_10d, g_config_sd_11d;
    reg b_config_sd_1d, b_config_sd_2d, b_config_sd_3d, b_config_sd_4d;
    reg b_config_sd_5d, b_config_sd_6d, b_config_sd_7d, b_config_sd_8d;
    reg b_config_sd_9d, b_config_sd_10d, b_config_sd_11d;
    //reg [3:0] obit_sel_1d, obit_sel_2d, obit_sel_3d, obit_sel_4d;
    reg [5:0] obit_sel_1d, obit_sel_2d, obit_sel_3d, obit_sel_4d;
    //reg [3:0] obit_sel_5d, obit_sel_6d, obit_sel_7d, obit_sel_8d;
    reg [5:0] obit_sel_5d, obit_sel_6d, obit_sel_7d, obit_sel_8d;
    //reg [3:0] obit_sel_9d, obit_sel_10d, obit_sel_11d;
    reg [5:0] obit_sel_9d, obit_sel_10d, obit_sel_11d;
    reg rout0_sd_5d, rout0_sd_6d, rout0_sd_7d, rout0_sd_8d, rout0_sd_9d, rout0_sd_10d, rout0_sd_11d;
    reg rout1_sd_5d, rout1_sd_6d, rout1_sd_7d, rout1_sd_8d, rout1_sd_9d, rout1_sd_10d, rout1_sd_11d;
    reg rout2_sd_6d, rout2_sd_7d, rout2_sd_8d, rout2_sd_9d, rout2_sd_10d, rout2_sd_11d;
    reg rout3_sd_6d, rout3_sd_7d, rout3_sd_8d, rout3_sd_9d, rout3_sd_10d, rout3_sd_11d;
    reg rout4_sd_7d, rout4_sd_8d, rout4_sd_9d, rout4_sd_10d, rout4_sd_11d;
    reg rout5_sd_7d, rout5_sd_8d, rout5_sd_9d, rout5_sd_10d, rout5_sd_11d;
    reg rout6_sd_8d, rout6_sd_9d, rout6_sd_10d, rout6_sd_11d;
    reg rout7_sd_8d, rout7_sd_9d, rout7_sd_10d, rout7_sd_11d;
    reg rout8_sd_9d, rout8_sd_10d, rout8_sd_11d;
    reg rout9_sd_9d, rout9_sd_10d, rout9_sd_11d;
    reg rout10_sd_10d, rout10_sd_11d;
    reg rout11_sd_10d, rout11_sd_11d;
    reg rout12_sd_11d;
    reg rout13_sd_11d;
    reg gout0_sd_5d, gout0_sd_6d, gout0_sd_7d, gout0_sd_8d, gout0_sd_9d, gout0_sd_10d, gout0_sd_11d;
    reg gout1_sd_5d, gout1_sd_6d, gout1_sd_7d, gout1_sd_8d, gout1_sd_9d, gout1_sd_10d, gout1_sd_11d;
    reg gout2_sd_6d, gout2_sd_7d, gout2_sd_8d, gout2_sd_9d, gout2_sd_10d, gout2_sd_11d;
    reg gout3_sd_6d, gout3_sd_7d, gout3_sd_8d, gout3_sd_9d, gout3_sd_10d, gout3_sd_11d;
    reg gout4_sd_7d, gout4_sd_8d, gout4_sd_9d, gout4_sd_10d, gout4_sd_11d;
    reg gout5_sd_7d, gout5_sd_8d, gout5_sd_9d, gout5_sd_10d, gout5_sd_11d;
    reg gout6_sd_8d, gout6_sd_9d, gout6_sd_10d, gout6_sd_11d;
    reg gout7_sd_8d, gout7_sd_9d, gout7_sd_10d, gout7_sd_11d;
    reg gout8_sd_9d, gout8_sd_10d, gout8_sd_11d;
    reg gout9_sd_9d, gout9_sd_10d, gout9_sd_11d;
    reg gout10_sd_10d, gout10_sd_11d;
    reg gout11_sd_10d, gout11_sd_11d;
    reg gout12_sd_11d;
    reg gout13_sd_11d;
    reg bout0_sd_5d, bout0_sd_6d, bout0_sd_7d, bout0_sd_8d, bout0_sd_9d, bout0_sd_10d, bout0_sd_11d;
    reg bout1_sd_5d, bout1_sd_6d, bout1_sd_7d, bout1_sd_8d, bout1_sd_9d, bout1_sd_10d, bout1_sd_11d;
    reg bout2_sd_6d, bout2_sd_7d, bout2_sd_8d, bout2_sd_9d, bout2_sd_10d, bout2_sd_11d;
    reg bout3_sd_6d, bout3_sd_7d, bout3_sd_8d, bout3_sd_9d, bout3_sd_10d, bout3_sd_11d;
    reg bout4_sd_7d, bout4_sd_8d, bout4_sd_9d, bout4_sd_10d, bout4_sd_11d;
    reg bout5_sd_7d, bout5_sd_8d, bout5_sd_9d, bout5_sd_10d, bout5_sd_11d;
    reg bout6_sd_8d, bout6_sd_9d, bout6_sd_10d, bout6_sd_11d;
    reg bout7_sd_8d, bout7_sd_9d, bout7_sd_10d, bout7_sd_11d;
    reg bout8_sd_9d, bout8_sd_10d, bout8_sd_11d;
    reg bout9_sd_9d, bout9_sd_10d, bout9_sd_11d;
    reg bout10_sd_10d, bout10_sd_11d;
    reg bout11_sd_10d, bout11_sd_11d;
    reg bout12_sd_11d;
    reg bout13_sd_11d;
    reg cf_tim_1d, cf_tim_2d, cf_tim_3d;
    reg config1_le, config2_le, config3_le, gs_le, vsync_le;
    reg le_2d, le_3d, le_4d, le_5d, le_6d, le_7d, le_8d, le_9d, le_10d, le_11d;
    reg dclk_1d, dclk_2d, dclk_3d, dclk_4d, dclk_5d, dclk_6d, dclk_7d, dclk_8d, dclk_9d, dclk_10d;

    wire [6:0] drv_ic_num;
    wire [6:0] drv_ic_num_m1;
    //wire [3:0] duty;
    wire [4:0] duty;
    //wire [2:0] duty_m1;
    wire [3:0] duty_m1;
    wire fm_cycle_ovp_a;
    wire fm_cycle_gs_stp_a;
    wire qb_stop;
    wire qe_stop;
    wire qf_endp;
    wire qf_stop;
    wire qh_stop;
    wire qk_endp;
    wire qk_eq0, qk_eq1, qk_eq2;
    wire qk_stop;
    wire [10:0] bram_wr_addr;
    wire [31:0] bram_r_dout, bram_g_dout, bram_b_dout;
    wire [10:0] cf_end_num;
    wire [10:0] gs_end_num;
    wire [10:0] dmy_end_num;
    //wire [7:0] odt_seq_num;
    wire [9:0] odt_seq_num;
    wire odt_seq_endp;
    wire gs_tim_a;
    wire cnt_ock_stop;
    wire bram_rd_bank;
    wire [2:0] bram_lra;
    wire [10:0] bram_rd_addr;
    wire [10:0] cf1_le_st_num, cf2_le_st_num, cf3_le_st_num, cf_le_end_num;
    wire blank_stp_a;
    //wire [7:0] vsync_period_num;
    wire [10:0] vsync_period_num;
    wire [5:0] vsync_tim_num;
    wire cnt_blank_stop;
    wire cnt_vs_tim_stop;
    wire cnt_vs_ock_stop;
    wire vsync_le_a;
    wire scan_line_a_end;
    wire [6:0] scan_tim_num;
    wire cnt_scan_tim_stop;
    wire gs_dout_start;
    wire [15:0] roa, rob, goa, gob, boa, bob;
    wire [5:0] c_gain;
    wire [15:0] config1_dat;
    wire [15:0] config2_dat;
    //wire [15:0] r_config3_dat;
    //wire [15:0] g_config3_dat;
    //wire [15:0] b_config3_dat;
    wire cf_blank;
    wire r_config_sd, g_config_sd, b_config_sd;
    wire rout0_sd, rout1_sd, rout2_sd, rout3_sd, rout4_sd, rout5_sd, rout6_sd, rout7_sd;
    wire rout8_sd, rout9_sd, rout10_sd, rout11_sd, rout12_sd, rout13_sd, rout14_sd, rout15_sd;
    wire gout0_sd, gout1_sd, gout2_sd, gout3_sd, gout4_sd, gout5_sd, gout6_sd, gout7_sd;
    wire gout8_sd, gout9_sd, gout10_sd, gout11_sd, gout12_sd, gout13_sd, gout14_sd, gout15_sd;
    wire bout0_sd, bout1_sd, bout2_sd, bout3_sd, bout4_sd, bout5_sd, bout6_sd, bout7_sd;
    wire bout8_sd, bout9_sd, bout10_sd, bout11_sd, bout12_sd, bout13_sd, bout14_sd, bout15_sd;
    wire rout14_sd_11d, rout15_sd_11d;
    wire gout14_sd_11d, gout15_sd_11d;
    wire bout14_sd_11d, bout15_sd_11d;
    wire dout_cf_tim;
    wire sd_dclk;
    wire vs_dclk;


// 各データラインのDriver IC数

    // drv_ic_num, drv_ic_num_m1  7bit
    //assign drv_ic_num = 7'd48;     // PVII-4 (4x4IM) : 12(IC/IM) x 4(IM)
    assign drv_ic_num = 7'd16;     // PVII-4 (4x4IM) : 12(IC/IM) x 4(IM)

    //assign drv_ic_num_m1 = 7'd47;  // drv_ic_num - 1
    assign drv_ic_num_m1 = 7'd15;  // drv_ic_num - 1

// Duty (scan line number)

    // duty  5bit
    //assign duty = 4'd5;     // 1/5 duty
    assign duty = 5'd16;     // 1/5 duty

    // duty_m1  4bit
    //assign duty_m1 = 3'd4;  // 5-1
    assign duty_m1 = 4'd15;  // 5-1


// タイミング作成

    // frame_alt_1d, frame_alt_2d, ovp
    always @(posedge clk) begin
      frame_alt_1d <= frame_alt;
      frame_alt_2d <= frame_alt_1d;
      ovp <= frame_alt_1d ^ frame_alt_2d;
    end

    // ovt
    always @(posedge clk) begin
      if(ovp)
        ovt <= 1;
      else if(fm_cycle_stp)
        ovt <= 0;
    end

    // fm_cycle_ovp_a
    assign fm_cycle_ovp_a = ovt & fm_cycle_stp;

    // fm_cycle_ovp
    always @(posedge clk) begin
      fm_cycle_ovp <= fm_cycle_ovp_a;
    end


    // gs_odat_alt_1d, gs_odat_alt_2d, gs_odat_stp
    always @(posedge clk) begin
      gs_odat_alt_1d <= gs_odat_alt_oc;
      gs_odat_alt_2d <= gs_odat_alt_1d;
      gs_odat_stp <= gs_odat_alt_1d ^ gs_odat_alt_2d;
    end

    // gs_odat_st_tim
    always @(posedge clk) begin
      if(gs_odat_stp)
        gs_odat_st_tim <= 1;
      else if(fm_cycle_stp)
        gs_odat_st_tim <= 0;
    end

    // fm_cycle_gs_stp_a
    assign fm_cycle_gs_stp_a = (gs_odat_st_tim & fm_cycle_stp) | fm_cycle_ovp_a;

    // fm_cycle_gs_stp
    always @(posedge clk) begin
      fm_cycle_gs_stp <= fm_cycle_gs_stp_a;
    end


    // qb  10bitカウンタ (Driver ICの出力ch x Scan line カウンタ)
    always @(posedge clk) begin
      if(fm_cycle_ovp_a)
        qb <= 0;
      else if(fm_cycle_gs_stp_a & ~qb_stop)
        qb <= qb + 1;
    end

    // qb_stop
    //assign qb_stop = (qb >= {duty, 4'd0});  // 64 = 16ch x 4scan line
    assign qb_stop = (qb >= {1'b0, duty, 4'd0});  // 256 = 16ch x 16scan line


    // qe  7bitカウンタ (fm cycle 内カウント 0 -- 71)
    always @(posedge clk) begin
      if(fm_cycle_stp)
        qe <= 0;
      else if(~qe_stop & ~qh_stop)
        qe <= qe + 1;
    end

    // qe_stop
    assign qe_stop = qe[6] & qe[3];  // 64+8=72

    // fm_rd_stp
    always @(posedge clk) begin
      fm_rd_stp <= (qe == 7'd22);
    end

    // qf  2bitカウンタ (fm read address, RGB 選択)
    always @(posedge clk) begin
      if(fm_rd_stp | qf_endp)
        qf <= 0;
      else if(~qf_stop)
        qf <= qf + 1;
    end

    // qf_endp
    assign qf_endp = qf[1];  // 2

    // qg  4bitカウンタ (fm read address, fm cycle 内カウント 0 -- 8)
    always @(posedge clk) begin
      if(fm_rd_stp)
        qg <= 0;
      else if(qf_endp)
        qg <= qg + 1;
    end

    // qf_stop
    assign qf_stop = qg[3];  // 8
    //assign qf_stop = (qg == 5);  // 5

    // qh  7bitカウンタ (fm read address, fm cycle カウント 0 -- 6)
    always @(posedge clk) begin
      if(fm_cycle_gs_stp_a)
        qh <= 0;
      else if(fm_cycle_stp & ~qh_stop)
        qh <= qh + 1;
    end

    // qh_stop
    assign qh_stop = (qh >= drv_ic_num);


// Frame memory read address 作成

    // fm_pix_ad_ma  13bit
    always @(posedge clk) begin
      fm_pix_ad_ma <= drv_ic_num * qb;
    end

    // fm_pix_ad_mb  13bit
    always @(posedge clk) begin
      fm_pix_ad_mb <= fm_pix_ad_ma + qh;
    end

    // fm_rd_bank
    always @(posedge clk) begin
      if(fm_cycle_ovp)
        fm_rd_bank <= frame_alt_frz;
    end

    // fm_ov_rd_adrs  19bit (Frame memory output video read address)
    assign fm_ov_rd_adrs = {fm_rd_bank,
                            fm_pix_ad_mb, qg[2:0],  // pixel 14bit
                            qf};                    // RGB 2bit

    // fm_ov_rd_cycle  (Frame memory output video read cycle)
    assign fm_ov_rd_cycle = ~qb_stop & ~qh_stop;


// Data input from Frame memory

    // fm_d_wstp
    always @(posedge clk) begin
      fm_d_wstp <= (qe == 7'd29);
    end

    // qk  2bitカウンタ (RGB選択用 0 -- 2)
    always @(posedge clk) begin
      if(fm_d_wstp | qk_endp)
        qk <= 0;
      else if(~qk_stop)
        qk <= qk + 1;
    end

    // qk_endp
    assign qk_endp = qk[1];  // 2

    // qk_eq0, qk_eq1, qk_eq2
    assign qk_eq0 = (qk == 2'd0);
    assign qk_eq1 = (qk == 2'd1);
    assign qk_eq2 = (qk == 2'd2);

    // ql  4bitカウンタ (fm cycle 内アドレス 0 -- 8)
    always @(posedge clk) begin
      if(fm_d_wstp)
        ql <= 0;
      else if(qk_endp)
        ql <= ql + 1;
    end

    // qk_stop
    assign qk_stop = ql[3];  // 8

    // r_we, g_we, b_we
    always @(posedge clk) begin
      r_we <= qk_eq0 & ~qk_stop & ~qh_stop & ~qb_stop;
      g_we <= qk_eq1 & ~qk_stop & ~qh_stop & ~qb_stop;
      b_we <= qk_eq2 & ~qk_stop & ~qh_stop & ~qb_stop;
    end

    // ql_1d  3bit
    always @(posedge clk) begin
      ql_1d <= ql[2:0];
    end

    // bram_wr_bank
    always @(posedge clk) begin
      if(fm_cycle_gs_stp)
        bram_wr_bank <= gs_odat_alt_1d;
    end

    // bram_wr_addr  11bit
    assign bram_wr_addr = {bram_wr_bank, qh, ql_1d};


// Block RAM, Frame memory output data buffer

    // fm_rd_d_1d  32bit
    always @(posedge clk) begin
      fm_rd_d_1d <= fm_rd_d;
    end


  // サブモジュール Block RAM (R)

    sdp_bram_a11b_d32b  sdp_bram_a11b_d32b_r(
      .dina   (fm_rd_d_1d),    // 32bit
      .wea    (r_we),          // 1bit
      .addra  (bram_wr_addr),  // 11bit
      .clka   (clk),
      .doutb  (bram_r_dout),   // 32bit
      .addrb  (bram_rd_addr),  // 11bit
      .clkb   (oclk)
    );

  // サブモジュール Block RAM (G)

    sdp_bram_a11b_d32b  sdp_bram_a11b_d32b_g(
      .dina   (fm_rd_d_1d),    // 32bit
      .wea    (g_we),          // 1bit
      .addra  (bram_wr_addr),  // 11bit
      .clka   (clk),
      .doutb  (bram_g_dout),   // 32bit
      .addrb  (bram_rd_addr),  // 11bit
      .clkb   (oclk)
    );

  // サブモジュール Block RAM (B)

    sdp_bram_a11b_d32b  sdp_bram_a11b_d32b_b(
      .dina   (fm_rd_d_1d),    // 32bit
      .wea    (b_we),          // 1bit
      .addra  (bram_wr_addr),  // 11bit
      .clka   (clk),
      .doutb  (bram_b_dout),   // 32bit
      .addrb  (bram_rd_addr),  // 11bit
      .clkb   (oclk)
    );


    // bram_ro, bram_go, bram_bo  32bit  [oclk]
    always @(posedge oclk) begin
      bram_ro <= bram_r_dout;
      bram_go <= bram_g_dout;
      bram_bo <= bram_b_dout;
    end


// 出力側タイミング作成  (以下 oclk)

    // frame_alt_oc_1d, frame_alt_oc_2d, ovp_oc  [oclk]
    always @(posedge oclk) begin
      frame_alt_oc_1d <= frame_alt;
      frame_alt_oc_2d <= frame_alt_oc_1d;
      ovp_oc <= frame_alt_oc_1d ^ frame_alt_oc_2d;
    end

    // cnt_ock  5bitカウンタ (DCLK作成 1/24分周) [oclk]
    always @(posedge oclk) begin
      //if(ovp_oc)
      if(ovp_oc | ock_z)
        cnt_ock <= 0;
      else if(~cnt_ock_stop)
        cnt_ock <= cnt_ock + 1;
    end

	wire ock_z = (cnt_ock == 23);

    // cnt_ock_endp  [oclk]
    always @(posedge oclk) begin
      //cnt_ock_endp <= (cnt_ock == 3'd6);
      //cnt_ock_endp <= (cnt_ock == 5'd30);				
      cnt_ock_endp <= (cnt_ock == 5'd22);						
    end


  // 各データの期間設定パラメータ
    // cf_end_num, dc_end_num, gs_end_num, err_end_num  11bit
    //assign cf_end_num = {drv_ic_num, 4'd15};     // 16bit x drv_ic_num + 15
    assign cf_end_num = {drv_ic_chns, 4'd15};     // 48bit x drv_ic_num + 15
    //assign gs_end_num = {drv_ic_num_m1, 4'd15};  // 16bit x drv_ic_num_m1 + 15
    assign gs_end_num = {drv_ic_chns, 4'd0} + 11'h7ff;  	  // 48bit x drv_ic_num - 1
    assign dmy_end_num = 11'd0;                  // 0

  // データ出力シーケンス数パラメータ
    // odt_seq_num  10bit
    //assign odt_seq_num = {duty, 4'd3};  // duty x 16 +3
    assign odt_seq_num = {1'b0, duty, 4'd4};  // duty x 16 +4


    // cnt_odt  11bitカウンタ (各データの期間設定) [oclk]
    always @(posedge oclk) begin
      if(ovp_oc | odt_seq_endp)
        cnt_odt <= 0;
      //else if(cnt_ock_endp)
      else if(odt_pt)								//Hasco 2021.09
        cnt_odt <= cnt_odt + 1;
    end

	//wire odt_pt = (cnt_ock == 15) | cnt_ock_endp;	//Hasco 2021.09
	wire odt_pt = (cnt_ock == 11) | cnt_ock_endp;	//Hasco 2021.10

    // odt_seq_end  [oclk]
    always @(posedge oclk) begin
      case (cnt_odt_seq)
        //8'd0   : odt_seq_end <= (cnt_odt == cf_end_num);
        //8'd1   : odt_seq_end <= (cnt_odt == cf_end_num);
        //8'd2   : odt_seq_end <= (cnt_odt == cf_end_num);
        10'd0   : odt_seq_end <= (cnt_odt == cf_end_num);
        10'd1   : odt_seq_end <= (cnt_odt == cf_end_num);
        10'd2   : odt_seq_end <= (cnt_odt == cf_end_num);		
        10'd3   : odt_seq_end <= (cnt_odt == cf_end_num);		
        odt_seq_num  : odt_seq_end <= (cnt_odt == dmy_end_num);
        default: odt_seq_end <= (cnt_odt == gs_end_num);
      endcase
    end

    // odt_seq_endp
    //assign odt_seq_endp = odt_seq_end & cnt_ock_endp;
    assign odt_seq_endp = odt_seq_end & odt_pt;


    // cnt_odt_seq  10bitカウンタ (各データの期間識別) [oclk]
    always @(posedge oclk) begin
      if(ovp_oc)
        cnt_odt_seq <= 0;
      else if(odt_seq_endp)
        cnt_odt_seq <= cnt_odt_seq + 1;
    end

    // cnt_ock_stop
    assign cnt_ock_stop = (cnt_odt_seq > odt_seq_num);


  // 各データの期間識別タイミング
    // gs_tim_a
    //assign gs_tim_a = (cnt_odt_seq > 8'd2) & (cnt_odt_seq < odt_seq_num);   // Gray Scale data
    assign gs_tim_a = (cnt_odt_seq > 10'd3) & (cnt_odt_seq < odt_seq_num);   // Gray Scale data

	reg cf4_tim;

    // cf1_tim, cf2_tim, cf3_tim, gs_tim, cf_tim, dmy_tim  [oclk]
    always @(posedge oclk) begin
      //cf1_tim <= (cnt_odt_seq == 8'd0);
      //cf2_tim <= (cnt_odt_seq == 8'd1);
      //cf3_tim <= (cnt_odt_seq == 8'd2);
      //cf_tim <= (cnt_odt_seq < 8'd3);
      cf1_tim <= (cnt_odt_seq == 10'd0);
      cf2_tim <= (cnt_odt_seq == 10'd1);
      cf3_tim <= (cnt_odt_seq == 10'd2);
      cf4_tim <= (cnt_odt_seq == 10'd3);
      cf_tim  <= (cnt_odt_seq  < 10'd4);	  
      gs_tim  <=  gs_tim_a;
      dmy_tim <= (cnt_odt_seq == odt_seq_num);
    end


  // bram read address

    // gs_odat_alt_oc  (Gray Scale Data 出力256データ毎に反転)  [oclk]
    always @(posedge oclk) begin
      //gs_odat_alt_oc <= cnt_odt_seq[0] & gs_tim_a;
      gs_odat_alt_oc <= ~cnt_odt_seq[0] & gs_tim_a;
    end

    // bram_rd_bank
    assign bram_rd_bank = ~gs_odat_alt_oc;


	reg[5:0] cnt_bra;										//Hasco 202109
    always @(posedge oclk) begin
      if(ovp_oc | bra_ot | odt_seq_endp)
        cnt_bra <= 16;
      //else if(cnt_ock_endp)
      else if(odt_pt)
        cnt_bra <= cnt_bra + 1;
    end

	//wire bra_ot = &cnt_bra && cnt_ock_endp;   //47	
	wire bra_ot = &cnt_bra && odt_pt;   //47	
    // bram_lra  3bit
    //assign bram_lra = (cnt_odt[3:0] == 4'd0) ? cnt_ock : 3'd0;
    //assign bram_lra = (cnt_odt[3:0] == 4'd0) ? cnt_ock[2:0] : 3'd0;
    assign bram_lra = (cnt_bra == 16 & cnt_ock < 8) ? cnt_ock[2:0] : 3'd0;			//Hasco 202109

	reg[6:0] bram_odt;													//Hasco 202109
	always @(posedge oclk) begin
		if(ovp_oc | odt_seq_endp)
			bram_odt <= 0;
		else if(bra_ot)
			bram_odt <= bram_odt + 1;
	end

	//wire bram_odt_en = (cnt_bra == 16) & (cnt_ock == 0);
	
    // bram_ra  10bit  [oclk]
    always @(posedge oclk) begin
      //bram_ra <= gs_tim_a ? {cnt_odt[10:4], bram_lra} : 10'd0;
      bram_ra <= gs_tim_a ? {bram_odt, bram_lra} : 10'd0;
    end

    // bram_rd_addr  11bit
    assign bram_rd_addr = {bram_rd_bank, bram_ra};


// 出力信号用タイミング作成
	wire[6:0] drv_ic_chns = 7'd48;				//16ch*3(RGB) bit/IC
	
	wire[10:0] cf4_le_st_num;
	
    // cf1_le_st_num, cf2_le_st_num, cf3_le_st_num, cf_le_end_num  11bit
    //assign cf1_le_st_num = {drv_ic_num, 4'd10};     // 16bit x drv_ic_num + 10
    assign cf1_le_st_num = {drv_ic_chns, 4'd10};      // 48bit x drv_ic_num + 10
    //assign cf2_le_st_num = {drv_ic_num, 4'd6};      // 16bit x drv_ic_num + 6
    assign cf2_le_st_num = {drv_ic_chns, 4'd10};      // 48bit x drv_ic_num + 10
    //assign cf3_le_st_num = {drv_ic_num_m1, 4'd14};  // 16bit x drv_ic_num_m1 + 14
    assign cf3_le_st_num = {drv_ic_chns, 4'd10};  	  // 48bit x drv_ic_num + 10
    assign cf4_le_st_num = {drv_ic_chns, 4'd10};  	  // 48bit x drv_ic_num + 10
    //assign cf_le_end_num = {drv_ic_num, 4'd13};     // 16bit x drv_ic_num + 13
    assign cf_le_end_num = {drv_ic_chns, 4'd13};      // 48bit x drv_ic_num + 13

	reg cf4_le_tim;

    // cf_dclk_tim -- gs_le_tim  [oclk]
    always @(posedge oclk) begin
      cf_dclk_tim <= (cnt_odt <= cf_le_end_num);
      cf1_le_tim  <= (cnt_odt < 11'd14) | ((cnt_odt >= cf1_le_st_num) & (cnt_odt <= cf_le_end_num));
      cf2_le_tim  <= (cnt_odt < 11'd14) | ((cnt_odt >= cf2_le_st_num) & (cnt_odt <= cf_le_end_num));
      cf3_le_tim  <= (cnt_odt < 11'd14) | ((cnt_odt >= cf3_le_st_num) & (cnt_odt <= cf_le_end_num));
      cf4_le_tim  <= (cnt_odt < 11'd14) | ((cnt_odt >= cf4_le_st_num) & (cnt_odt <= cf_le_end_num));
      cf_dat_tim  <= (cnt_odt > 11'd13) & (cnt_odt <= cf_le_end_num);
      gs_le_tim   <= (cnt_odt == gs_end_num);
    end


// vsync 作成

    // blank_1d, blank_2d  [oclk]
    always @(posedge oclk) begin
      blank_1d <= blank;
      blank_2d <= blank_1d;
    end

    // blank_stp_a
    assign blank_stp_a = blank_1d & ~blank_2d;

    // blank_stp  [oclk]
    always @(posedge oclk) begin
      blank_stp <= blank_stp_a;
    end
	
    // blank_v_tim  [oclk]
    always @(posedge oclk) begin
      if(ovp_oc)
        blank_v_tim <= 1;
      else if(blank_stp_a)
        blank_v_tim <= 0;
    end

    // blank_v_stp  [oclk]
    always @(posedge oclk) begin
      blank_v_stp <= blank_stp_a & blank_v_tim;
    end


    // vsync_period_num  8bit
    //assign vsync_period_num = 8'd85;  // vsyncを出力する点灯period指定
    //assign vsync_period_num = 11'd405;  // vsyncを出力する点灯period指定
    //assign vsync_period_num = 11'd523;  // vsyncを出力する点灯period指定
    assign vsync_period_num = 11'd838;  // vsyncを出力する点灯period指定

    // cnt_blank  11bitカウンタ (点灯periodカウント) [oclk]
    always @(posedge oclk) begin
      if(blank_v_stp)
        cnt_blank <= 0;
      else if(blank_stp & ~cnt_blank_stop)
        cnt_blank <= cnt_blank + 1;
    end

    // cnt_blank_stop
    //assign cnt_blank_stop = cnt_blank[7];  // 128
    assign cnt_blank_stop = cnt_blank[10];  // 1024

    // vsync_period  [oclk]
    always @(posedge oclk) begin
      vsync_period <= (cnt_blank == vsync_period_num);
    end


    // vsync_tim_num  6bit
    assign vsync_tim_num = 6'd8;  // vsync出力タイミング指定

    // cnt_vs_tim  6bitカウンタ (vsync出力タイミング設定用クロックカウンタ) [oclk]
    always @(posedge oclk) begin
      if(blank_stp & vsync_period)
        cnt_vs_tim <= 0;
      else if(~cnt_vs_tim_stop)
        cnt_vs_tim <= cnt_vs_tim + 1;
    end

    // cnt_vs_tim_stop
    assign cnt_vs_tim_stop = cnt_vs_tim[5];  // 32

    // vsync_stp  [oclk]
    always @(posedge oclk) begin
      vsync_stp <= (cnt_vs_tim == vsync_tim_num);
    end


    // cnt_vs_ock  3bitカウンタ (vsync用DCLK作成 1/8分周) [oclk]
    // cnt_vs_ock  5bitカウンタ (vsync用DCLK作成 1/32分周) [oclk]
    always @(posedge oclk) begin
      if(vsync_stp)
        cnt_vs_ock <= 0;
      else if(~cnt_vs_ock_stop)
        cnt_vs_ock <= cnt_vs_ock + 1;
    end

    // cnt_vs_ock_endp  [oclk]
    always @(posedge oclk) begin
      //cnt_vs_ock_endp <= (cnt_vs_ock == 3'd6);
      //cnt_vs_ock_endp <= (cnt_vs_ock == 5'd30);
      //cnt_vs_ock_endp <= (cnt_vs_ock == 5'd14) | (cnt_vs_ock == 5'd30);		//Hasco 2021.09
      cnt_vs_ock_endp <= (cnt_vs_ock == 5'd10) | (cnt_vs_ock == 5'd22);		//Hasco 2021.10
    end

    // cnt_vs_le  2bitカウンタ (vsync用LE作成) [oclk]
    always @(posedge oclk) begin
      if(vsync_stp)
        cnt_vs_le <= 0;
      else if(cnt_vs_ock_endp)
        cnt_vs_le <= cnt_vs_le + 1;
    end

    // cnt_vs_ock_stop
    assign cnt_vs_ock_stop = cnt_vs_le[1];  // 2

    // vsync_le_a
    assign vsync_le_a = ~cnt_vs_le[1];


// scan_line 作成

    // scan_line_a  4bitカウンタ (scan_line作成) [oclk]
    always @(posedge oclk) begin
      if(blank_stp & (vsync_period | scan_line_a_end))
        scan_line_a <= 0;
      else if(blank_stp)
        scan_line_a <= scan_line_a + 1;
    end

    // scan_line_a_end
    assign scan_line_a_end = (scan_line_a == duty_m1);


	reg[10:0] cnt_scanl;
	always @(posedge oclk) begin
      if(blank_stp & (vsync_period | cnt_scanl_end))
        cnt_scanl <= 0;
      else if(blank_stp)
        cnt_scanl <= cnt_scanl + 1;		
	end

	wire cnt_scanl_end = cnt_scanl[10] & cnt_scanl[3];	//1024+8
	
	reg[10:0] cnt_scans;
    // scan_line_b  4bit  [oclk]
    always @(posedge oclk) begin
      if(scan_timp)
        cnt_scans <= cnt_scanl;
    end
	
	reg[10:0] cnt_scans_d1, cnt_scans_d2;
	always @(posedge oclk) begin
		cnt_scans_d1 <= cnt_scans;
		cnt_scans_d2 <= cnt_scans_d1;
	end
	
	wire[10:0] cnt_scano = cnt_scans_d2;
	
    // scan_tim_num  7bit
    //assign scan_tim_num = 7'd36;  // scan_line変化タイミング指定
    assign scan_tim_num = 7'd64;   // Hasco 2021.10 MBI5353Q scanline change in middle of gclk deadtime low

    // cnt_scan_tim  7bitカウンタ (scan_line変化タイミング設定用クロックカウンタ) [oclk]
    always @(posedge oclk) begin
      if(blank_stp)
        cnt_scan_tim <= 0;
      else if(~cnt_scan_tim_stop)
        cnt_scan_tim <= cnt_scan_tim + 1;
    end

    // cnt_scan_tim_stop
    //assign cnt_scan_tim_stop = cnt_scan_tim[6];  // 64
    assign cnt_scan_tim_stop = &cnt_scan_tim;  // 127

    // scan_timp  [oclk]
    always @(posedge oclk) begin
      scan_timp <= (cnt_scan_tim == scan_tim_num);
    end

    // scan_line_b  4bit  [oclk]
    always @(posedge oclk) begin
      if(scan_timp)
        scan_line_b <= scan_line_a;
    end

    // scan_line  4bit
    assign scan_line = scan_line_b;


// Gray Scaleデータ出力

  // gsデータ用ブランキング信号作成

    // gclkout_start_1d  [oclk]
    always @(posedge oclk) begin
      gclkout_start_1d <= gclkout_start;
    end

    // gclkout_start_vd  [oclk]
    always @(posedge oclk) begin
      if(ovp_oc)
        gclkout_start_vd <= gclkout_start_1d;
    end

    // gs_dout_start
    assign gs_dout_start = gclkout_start_1d & gclkout_start_vd;

    // gs_blank  [oclk]
    always @(posedge oclk) begin
      gs_blank <= (~gs_dout_start | ~gs_tim);
    end

    // r_out_zero, g_out_zero, b_out_zero  [oclk]
    always @(posedge oclk) begin
      r_out_zero <= rgb_out_zero[2];
      g_out_zero <= rgb_out_zero[1];
      b_out_zero <= rgb_out_zero[0];
    end

    // r_gs_blank, g_gs_blank, b_gs_blank  [oclk]
    always @(posedge oclk) begin
      r_gs_blank <= gs_blank | r_out_zero;
      g_gs_blank <= gs_blank | g_out_zero;
      b_gs_blank <= gs_blank | b_out_zero;
    end


  // gsデータ用ラッチ信号作成

    // cnt_ock_1d  5bit  [oclk]					//Hasco 2021.09
    always @(posedge oclk) begin
      cnt_ock_1d <= cnt_ock;
    end
	
	reg[5:0] cnt_obit;

    // cnt_obit  6bit  [oclk]
    always @(posedge oclk) begin
		cnt_obit <= cnt_bra;
    end

	//wire odt_1d_end = (cnt_odt[5:0] == 48 & cnt_ock == 0) | (cnt_odt == 0);

    // cnt_odt_1d  6bit  [oclk]						//Hasco 2021.09
    always @(posedge oclk) begin
		cnt_odt_1d <= bram_odt;						//Hasco 2021.09
    end

    // gs_lat_1d  8bit  [oclk]
    always @(posedge oclk) begin
      //gs_lat_1d[0] <= (cnt_ock_1d == 3'd0) & (cnt_odt_1d == 4'd0) & (gs_tim | dmy_tim);
      //gs_lat_1d[1] <= (cnt_ock_1d == 3'd1) & (cnt_odt_1d == 4'd0) & (gs_tim | dmy_tim);
      //gs_lat_1d[2] <= (cnt_ock_1d == 3'd2) & (cnt_odt_1d == 4'd0) & (gs_tim | dmy_tim);
      //gs_lat_1d[3] <= (cnt_ock_1d == 3'd3) & (cnt_odt_1d == 4'd0) & (gs_tim | dmy_tim);
      //gs_lat_1d[4] <= (cnt_ock_1d == 3'd4) & (cnt_odt_1d == 4'd0) & (gs_tim | dmy_tim);
      //gs_lat_1d[5] <= (cnt_ock_1d == 3'd5) & (cnt_odt_1d == 4'd0) & (gs_tim | dmy_tim);
      //gs_lat_1d[6] <= (cnt_ock_1d == 3'd6) & (cnt_odt_1d == 4'd0) & (gs_tim | dmy_tim);
      //gs_lat_1d[7] <= (cnt_ock_1d == 3'd7) & (cnt_odt_1d == 4'd0) & (gs_tim | dmy_tim);
	  
      gs_lat_1d[0] <= (cnt_ock_1d == 5'd0) & (cnt_obit == 6'd16) & (gs_tim | dmy_tim);			//Hasco 2021.09
      gs_lat_1d[1] <= (cnt_ock_1d == 5'd1) & (cnt_obit == 6'd16) & (gs_tim | dmy_tim);
      gs_lat_1d[2] <= (cnt_ock_1d == 5'd2) & (cnt_obit == 6'd16) & (gs_tim | dmy_tim);
      gs_lat_1d[3] <= (cnt_ock_1d == 5'd3) & (cnt_obit == 6'd16) & (gs_tim | dmy_tim);
      gs_lat_1d[4] <= (cnt_ock_1d == 5'd4) & (cnt_obit == 6'd16) & (gs_tim | dmy_tim);
      gs_lat_1d[5] <= (cnt_ock_1d == 5'd5) & (cnt_obit == 6'd16) & (gs_tim | dmy_tim);
      gs_lat_1d[6] <= (cnt_ock_1d == 5'd6) & (cnt_obit == 6'd16) & (gs_tim | dmy_tim);
      gs_lat_1d[7] <= (cnt_ock_1d == 5'd7) & (cnt_obit == 6'd16) & (gs_tim | dmy_tim);	  
    end

    // gs_lat_2d, gs_lat_3d  8bit  [oclk]
    always @(posedge oclk) begin
      gs_lat_2d <= gs_lat_1d;
      gs_lat_3d <= gs_lat_2d;
    end


  // Block RAM出力データ16bit化

    // roa, rob, goa, gob, boa, bob  16bit
    assign roa = bram_ro[31:16];
    assign rob = bram_ro[15:0];
	
    assign goa = bram_go[31:16];
    assign gob = bram_go[15:0];
	
    assign boa = bram_bo[31:16];
    assign bob = bram_bo[15:0];

	//For Test
    //assign roa = 16'h1478;
    //assign rob = 16'h1478;
	//
    //assign goa = 16'd0;
    //assign gob = 16'd0;
	//
    //assign boa = 16'd0;
    //assign bob = 16'd0;

    // roa_1d, rob_1d, goa_1d, gob_1d, boa_1d, bob_1d  16bit  [oclk]
    //always @(posedge oclk) begin
    //  roa_1d <= r_gs_blank ? 16'd0 : roa;
    //  rob_1d <= r_gs_blank ? 16'd0 : rob;
	//
    //  goa_1d <= g_gs_blank ? 16'd0 : goa;
    //  gob_1d <= g_gs_blank ? 16'd0 : gob;
	//
    //  boa_1d <= b_gs_blank ? 16'd0 : boa;
    //  bob_1d <= b_gs_blank ? 16'd0 : bob;
    //end

	// High 14bits Grayscale Mode
    always @(posedge oclk) begin
      roa_1d <= r_gs_blank ? 16'd0 : {roa[15:2], 2'b0};				//Hasco 2021.09 
      rob_1d <= r_gs_blank ? 16'd0 : {rob[15:2], 2'b0};				//14bit GrayScale Mode
	
      goa_1d <= g_gs_blank ? 16'd0 : {goa[15:2], 2'b0};
      gob_1d <= g_gs_blank ? 16'd0 : {gob[15:2], 2'b0};
	
      boa_1d <= b_gs_blank ? 16'd0 : {boa[15:2], 2'b0};
      bob_1d <= b_gs_blank ? 16'd0 : {bob[15:2], 2'b0};
    end
  // 出力ch別データラッチ

    // gout0d, gout1d, bout0d, bout1d  16bit  [oclk]
    // rout0d, rout1d 48bit  [oclk]					//Hasco 2021.09
    always @(posedge oclk) begin
      if(gs_lat_3d[0]) begin
        rout0d <= {roa_1d, goa_1d, boa_1d};			//Hasco 2021.09
        rout1d <= {rob_1d, gob_1d, bob_1d};			//Hasco 2021.09

        gout0d <= goa_1d;
        gout1d <= gob_1d;

        bout0d <= boa_1d;
        bout1d <= bob_1d;
      end
    end

    // rout2d, rout3d 48bit  [oclk]
    always @(posedge oclk) begin
      if(gs_lat_3d[1]) begin
        rout2d <= {roa_1d, goa_1d, boa_1d};			//Hasco 2021.09
        rout3d <= {rob_1d, gob_1d, bob_1d};			//Hasco 2021.09

        gout2d <= goa_1d;
        gout3d <= gob_1d;

        bout2d <= boa_1d;
        bout3d <= bob_1d;
      end
    end

    // rout4d, rout5d 48bit  [oclk]
    always @(posedge oclk) begin
      if(gs_lat_3d[2]) begin
        rout4d <= {roa_1d, goa_1d, boa_1d};			//Hasco 2021.09
        rout5d <= {rob_1d, gob_1d, bob_1d};			//Hasco 2021.09

        gout4d <= goa_1d;
        gout5d <= gob_1d;

        bout4d <= boa_1d;
        bout5d <= bob_1d;
      end
    end

    // rout6d, rout7d 48bit  [oclk]
    always @(posedge oclk) begin
      if(gs_lat_3d[3]) begin
        rout6d <= {roa_1d, goa_1d, boa_1d};			//Hasco 2021.09
        rout7d <= {rob_1d, gob_1d, bob_1d};			//Hasco 2021.09

        gout6d <= goa_1d;
        gout7d <= gob_1d;

        bout6d <= boa_1d;
        bout7d <= bob_1d;
      end
    end

    // rout8d, rout9d 48bit  [oclk]
    always @(posedge oclk) begin
      if(gs_lat_3d[4]) begin
        rout8d <= {roa_1d, goa_1d, boa_1d};			//Hasco 2021.09
        rout9d <= {rob_1d, gob_1d, bob_1d};			//Hasco 2021.09

        gout8d <= goa_1d;
        gout9d <= gob_1d;

        bout8d <= boa_1d;
        bout9d <= bob_1d;
      end
    end

    // rout10d, rout11d 48bit  [oclk]
    always @(posedge oclk) begin
      if(gs_lat_3d[5]) begin
        rout10d <= {roa_1d, goa_1d, boa_1d};			//Hasco 2021.09
        rout11d <= {rob_1d, gob_1d, bob_1d};			//Hasco 2021.09

        gout10d <= goa_1d;
        gout11d <= gob_1d;

        bout10d <= boa_1d;
        bout11d <= bob_1d;
      end
    end

    // rout12d, rout13d 48bit  [oclk]
    always @(posedge oclk) begin
      if(gs_lat_3d[6]) begin
        rout12d <= {roa_1d, goa_1d, boa_1d};			//Hasco 2021.09
        rout13d <= {rob_1d, gob_1d, bob_1d};			//Hasco 2021.09

        gout12d <= goa_1d;
        gout13d <= gob_1d;

        bout12d <= boa_1d;
        bout13d <= bob_1d;
      end
    end

    // rout14d, rout15d, gout14d, gout15d, bout14d, bout15d  16bit  [oclk]
    always @(posedge oclk) begin
      if(gs_lat_3d[7]) begin
        rout14d <= {roa_1d, goa_1d, boa_1d};			//Hasco 2021.09
        rout15d <= {rob_1d, gob_1d, bob_1d};			//Hasco 2021.09

        gout14d <= goa_1d;
        gout15d <= gob_1d;

        bout14d <= boa_1d;
        bout15d <= bob_1d;
      end
    end


// Config data作成


	//Hasco 2021.09  0x29E0
    assign config1_dat = {	2'b00,		//Register type code: 00 - Global
							//2'b00,		//Grayscale mode select - 2'b00: 16bit 65536 GCLKS/1 PWM cycle
							2'b10,		//Grayscale mode select - 2'b10: 14bit 
							//2'b00,  	//SPWM Mode 64sections 16bit Grayscale
							2'b10,  	//SPWM Mode 64sections 14bit Grayscale
                            5'b01111,   //Number of Scan Lines - 16lines
							//1'b1,       //GCLK Multipler Enable	
							1'b0,       //GCLK Multipler Disable	
                            4'b0000     //Reserved
						 };
	//Hasco 2021.09	 0x0A00					
    assign config2_dat = {	4'b0000,	//Reserved
							1'b1,		//Rext Short Detection Enable
							2'b01,		//Global Current Gain1
							//3'b100,  		//Global Current Gain2
							3'b000,  	//Global Current Gain2
                            1'b0,   	//Reserved
							2'b00,      //No Stagger
                            2'b00,     	//Reserved
							1'b0		//Power Saving Mode Disable
						 };
	//Hasco 2021.09  0x0000
	wire[15:0] config3_dat = 16'b0000_0000_0000_0000;	//Hasco 2021.09
		
			//0x42FC
    //wire[15:0] r_config1_dat = 16'b01_000_01_0111111_00;  	// Hasco 2021.09
    wire[15:0] r_config1_dat = 16'b01_000_01_1111111_00;  	// Hasco 2021.09
			//0x0F00
    wire[15:0] r_config2_dat = 16'h0f00;  				// Hasco 2021.09
			//0x0000
    wire[15:0] r_config3_dat = 16'd0;  					// Hasco 2021.09

			//0x82FC
    //wire[15:0] g_config1_dat = 16'b10_000_01_0111111_00;  	// Hasco 2021.09
    wire[15:0] g_config1_dat = 16'b10_000_01_1111111_00;  	// Hasco 2021.09
	wire[15:0] g_config2_dat = 16'h0f00;
	wire[15:0] g_config3_dat = 16'd0;

			//0xC2FC
    //wire[15:0] b_config1_dat = 16'b11_000_01_0111111_00;  	// Hasco 2021.09
    wire[15:0] b_config1_dat = 16'b11_000_01_1111111_00;  	// Hasco 2021.09
	wire[15:0] b_config2_dat = 16'h0f00;
	wire[15:0] b_config3_dat = 16'd0;

  // Config data選択出力

    // r_config_dat  48bit  [oclk]						//Hasco 2021.09
    always @(posedge oclk) begin
      if(cf1_tim)
        r_config_dat <= {config1_dat, config2_dat, config3_dat};		
      else if(cf2_tim)
        r_config_dat <= {r_config1_dat, r_config2_dat, r_config3_dat};	
      else if(cf3_tim)
        r_config_dat <= {g_config1_dat, g_config2_dat, g_config3_dat};	
      else if(cf4_tim)		
        r_config_dat <= {b_config1_dat, b_config2_dat, b_config3_dat};	
      else
        r_config_dat <= 48'd0;											
    end

    // g_config_dat  16bit  [oclk]
    always @(posedge oclk) begin
      if(cf1_tim)
        g_config_dat <= config1_dat;
      else if(cf2_tim)
        g_config_dat <= config2_dat;
      else if(cf3_tim)
        g_config_dat <= g_config3_dat;
      else
        g_config_dat <= 16'd0;
    end

    // b_config_dat  16bit  [oclk]
    always @(posedge oclk) begin
      if(cf1_tim)
        b_config_dat <= config1_dat;
      else if(cf2_tim)
        b_config_dat <= config2_dat;
      else if(cf3_tim)
        b_config_dat <= b_config3_dat;
      else
        b_config_dat <= 16'd0;
    end


  // パラシリ変換, ブランキング, 出力タイミング調整

    // cnt_ock_endp_1d  [oclk]
    always @(posedge oclk) begin
      //cnt_ock_endp_1d <= cnt_ock_endp;
      cnt_ock_endp_1d <= odt_pt;						//Hasco 2021.09
    end

    // cf_blank
    assign cf_blank = ~cf_dat_tim | ~cf_tim;

    // cnt_cf_bit  6bitカウンタ (Config dataの出力bit選択信号作成) [oclk]  //Hasco 2021.09
    always @(posedge oclk) begin
      //if(cf_blank)
      if(cf_blank | cf_bit_rst)				//Hasco 2021.09
        //cnt_cf_bit <= 0;
        cnt_cf_bit <= 6'd16;				//Hasco 2021.09
      else if(cnt_ock_endp_1d)
        cnt_cf_bit <= cnt_cf_bit + 1;
    end

	wire cf_bit_rst = (&cnt_cf_bit) & cnt_ock_endp_1d;	//63→16   Hasco 2021.09

    // r_config_sd, g_config_sd, b_config_sd  (48:1パラシリ変換, ブランキング)		//Hasco 2021.09
    assign r_config_sd = r_config_dat[~cnt_cf_bit] & ~cf_blank;
    assign g_config_sd = g_config_dat[~cnt_cf_bit] & ~cf_blank;
    assign b_config_sd = b_config_dat[~cnt_cf_bit] & ~cf_blank;


    // r_config_sd_11d -- b_config_sd_11d  (出力タイミング調整用レジスタ)  [oclk]
    always @(posedge oclk) begin
      r_config_sd_1d <= r_config_sd;
      r_config_sd_2d <= r_config_sd_1d;
      r_config_sd_3d <= r_config_sd_2d;
      r_config_sd_4d <= r_config_sd_3d;
      r_config_sd_5d <= r_config_sd_4d;
      r_config_sd_6d <= r_config_sd_5d;
      r_config_sd_7d <= r_config_sd_6d;
      r_config_sd_8d <= r_config_sd_7d;
      r_config_sd_9d <= r_config_sd_8d;
      r_config_sd_10d <= r_config_sd_9d;
      r_config_sd_11d <= r_config_sd_10d;
    end

    always @(posedge oclk) begin
      g_config_sd_1d <= g_config_sd;
      g_config_sd_2d <= g_config_sd_1d;
      g_config_sd_3d <= g_config_sd_2d;
      g_config_sd_4d <= g_config_sd_3d;
      g_config_sd_5d <= g_config_sd_4d;
      g_config_sd_6d <= g_config_sd_5d;
      g_config_sd_7d <= g_config_sd_6d;
      g_config_sd_8d <= g_config_sd_7d;
      g_config_sd_9d <= g_config_sd_8d;
      g_config_sd_10d <= g_config_sd_9d;
      g_config_sd_11d <= g_config_sd_10d;
    end

    always @(posedge oclk) begin
      b_config_sd_1d <= b_config_sd;
      b_config_sd_2d <= b_config_sd_1d;
      b_config_sd_3d <= b_config_sd_2d;
      b_config_sd_4d <= b_config_sd_3d;
      b_config_sd_5d <= b_config_sd_4d;
      b_config_sd_6d <= b_config_sd_5d;
      b_config_sd_7d <= b_config_sd_6d;
      b_config_sd_8d <= b_config_sd_7d;
      b_config_sd_9d <= b_config_sd_8d;
      b_config_sd_10d <= b_config_sd_9d;
      b_config_sd_11d <= b_config_sd_10d;
    end


  // Gray Scaleデータ パラシリ変換, 出力chタイミング合わせ

    // obit_sel_1d -- obit_sel_11d  6bit  [oclk]	//Hasco 2021.09	
    always @(posedge oclk) begin
      //obit_sel_1d <= cnt_odt_1d;
      obit_sel_1d <= cnt_obit;
      obit_sel_2d <= obit_sel_1d;
      obit_sel_3d <= obit_sel_2d;
      obit_sel_4d <= obit_sel_3d;
      obit_sel_5d <= obit_sel_4d;
      obit_sel_6d <= obit_sel_5d;
      obit_sel_7d <= obit_sel_6d;
      obit_sel_8d <= obit_sel_7d;
      obit_sel_9d <= obit_sel_8d;
      obit_sel_10d <= obit_sel_9d;
      obit_sel_11d <= obit_sel_10d;
    end

    // rout0_sd -- bout7_sd  (48:1パラシリ変換)     //Hasco 2021.09
    assign rout0_sd = rout0d[~obit_sel_4d];
    assign rout1_sd = rout1d[~obit_sel_4d];

    assign rout2_sd = rout2d[~obit_sel_5d];
    assign rout3_sd = rout3d[~obit_sel_5d];

    assign rout4_sd = rout4d[~obit_sel_6d];
    assign rout5_sd = rout5d[~obit_sel_6d];

    assign rout6_sd = rout6d[~obit_sel_7d];
    assign rout7_sd = rout7d[~obit_sel_7d];

    assign rout8_sd = rout8d[~obit_sel_8d];
    assign rout9_sd = rout9d[~obit_sel_8d];

    assign rout10_sd = rout10d[~obit_sel_9d];
    assign rout11_sd = rout11d[~obit_sel_9d];

    assign rout12_sd = rout12d[~obit_sel_10d];
    assign rout13_sd = rout13d[~obit_sel_10d];

    assign rout14_sd = rout14d[~obit_sel_11d];
    assign rout15_sd = rout15d[~obit_sel_11d];


    assign gout0_sd = gout0d[~obit_sel_4d];
    assign gout1_sd = gout1d[~obit_sel_4d];

    assign gout2_sd = gout2d[~obit_sel_5d];
    assign gout3_sd = gout3d[~obit_sel_5d];

    assign gout4_sd = gout4d[~obit_sel_6d];
    assign gout5_sd = gout5d[~obit_sel_6d];

    assign gout6_sd = gout6d[~obit_sel_7d];
    assign gout7_sd = gout7d[~obit_sel_7d];

    assign gout8_sd = gout8d[~obit_sel_8d];
    assign gout9_sd = gout9d[~obit_sel_8d];

    assign gout10_sd = gout10d[~obit_sel_9d];
    assign gout11_sd = gout11d[~obit_sel_9d];

    assign gout12_sd = gout12d[~obit_sel_10d];
    assign gout13_sd = gout13d[~obit_sel_10d];

    assign gout14_sd = gout14d[~obit_sel_11d];
    assign gout15_sd = gout15d[~obit_sel_11d];


    assign bout0_sd = bout0d[~obit_sel_4d];
    assign bout1_sd = bout1d[~obit_sel_4d];

    assign bout2_sd = bout2d[~obit_sel_5d];
    assign bout3_sd = bout3d[~obit_sel_5d];

    assign bout4_sd = bout4d[~obit_sel_6d];
    assign bout5_sd = bout5d[~obit_sel_6d];

    assign bout6_sd = bout6d[~obit_sel_7d];
    assign bout7_sd = bout7d[~obit_sel_7d];

    assign bout8_sd = bout8d[~obit_sel_8d];
    assign bout9_sd = bout9d[~obit_sel_8d];

    assign bout10_sd = bout10d[~obit_sel_9d];
    assign bout11_sd = bout11d[~obit_sel_9d];

    assign bout12_sd = bout12d[~obit_sel_10d];
    assign bout13_sd = bout13d[~obit_sel_10d];

    assign bout14_sd = bout14d[~obit_sel_11d];
    assign bout15_sd = bout15d[~obit_sel_11d];


    // rout0_sd_11d -- bout7_sd_11d  (16ch出力タイミング合わせ用レジスタ)  [oclk]
    always @(posedge oclk) begin
      rout0_sd_5d <= rout0_sd;
      rout0_sd_6d <= rout0_sd_5d;
      rout0_sd_7d <= rout0_sd_6d;
      rout0_sd_8d <= rout0_sd_7d;
      rout0_sd_9d <= rout0_sd_8d;
      rout0_sd_10d <= rout0_sd_9d;
      rout0_sd_11d <= rout0_sd_10d;
    end

    always @(posedge oclk) begin
      rout1_sd_5d <= rout1_sd;
      rout1_sd_6d <= rout1_sd_5d;
      rout1_sd_7d <= rout1_sd_6d;
      rout1_sd_8d <= rout1_sd_7d;
      rout1_sd_9d <= rout1_sd_8d;
      rout1_sd_10d <= rout1_sd_9d;
      rout1_sd_11d <= rout1_sd_10d;
    end

    always @(posedge oclk) begin
      rout2_sd_6d <= rout2_sd;
      rout2_sd_7d <= rout2_sd_6d;
      rout2_sd_8d <= rout2_sd_7d;
      rout2_sd_9d <= rout2_sd_8d;
      rout2_sd_10d <= rout2_sd_9d;
      rout2_sd_11d <= rout2_sd_10d;
    end

    always @(posedge oclk) begin
      rout3_sd_6d <= rout3_sd;
      rout3_sd_7d <= rout3_sd_6d;
      rout3_sd_8d <= rout3_sd_7d;
      rout3_sd_9d <= rout3_sd_8d;
      rout3_sd_10d <= rout3_sd_9d;
      rout3_sd_11d <= rout3_sd_10d;
    end

    always @(posedge oclk) begin
      rout4_sd_7d <= rout4_sd;
      rout4_sd_8d <= rout4_sd_7d;
      rout4_sd_9d <= rout4_sd_8d;
      rout4_sd_10d <= rout4_sd_9d;
      rout4_sd_11d <= rout4_sd_10d;
    end

    always @(posedge oclk) begin
      rout5_sd_7d <= rout5_sd;
      rout5_sd_8d <= rout5_sd_7d;
      rout5_sd_9d <= rout5_sd_8d;
      rout5_sd_10d <= rout5_sd_9d;
      rout5_sd_11d <= rout5_sd_10d;
    end

    always @(posedge oclk) begin
      rout6_sd_8d <= rout6_sd;
      rout6_sd_9d <= rout6_sd_8d;
      rout6_sd_10d <= rout6_sd_9d;
      rout6_sd_11d <= rout6_sd_10d;
    end

    always @(posedge oclk) begin
      rout7_sd_8d <= rout7_sd;
      rout7_sd_9d <= rout7_sd_8d;
      rout7_sd_10d <= rout7_sd_9d;
      rout7_sd_11d <= rout7_sd_10d;
    end

    always @(posedge oclk) begin
      rout8_sd_9d <= rout8_sd;
      rout8_sd_10d <= rout8_sd_9d;
      rout8_sd_11d <= rout8_sd_10d;
    end

    always @(posedge oclk) begin
      rout9_sd_9d <= rout9_sd;
      rout9_sd_10d <= rout9_sd_9d;
      rout9_sd_11d <= rout9_sd_10d;
    end

    always @(posedge oclk) begin
      rout10_sd_10d <= rout10_sd;
      rout10_sd_11d <= rout10_sd_10d;
    end

    always @(posedge oclk) begin
      rout11_sd_10d <= rout11_sd;
      rout11_sd_11d <= rout11_sd_10d;
    end

    always @(posedge oclk) begin
      rout12_sd_11d <= rout12_sd;
    end

    always @(posedge oclk) begin
      rout13_sd_11d <= rout13_sd;
    end

    assign rout14_sd_11d = rout14_sd;
    assign rout15_sd_11d = rout15_sd;


    always @(posedge oclk) begin
      gout0_sd_5d <= gout0_sd;
      gout0_sd_6d <= gout0_sd_5d;
      gout0_sd_7d <= gout0_sd_6d;
      gout0_sd_8d <= gout0_sd_7d;
      gout0_sd_9d <= gout0_sd_8d;
      gout0_sd_10d <= gout0_sd_9d;
      gout0_sd_11d <= gout0_sd_10d;
    end

    always @(posedge oclk) begin
      gout1_sd_5d <= gout1_sd;
      gout1_sd_6d <= gout1_sd_5d;
      gout1_sd_7d <= gout1_sd_6d;
      gout1_sd_8d <= gout1_sd_7d;
      gout1_sd_9d <= gout1_sd_8d;
      gout1_sd_10d <= gout1_sd_9d;
      gout1_sd_11d <= gout1_sd_10d;
    end

    always @(posedge oclk) begin
      gout2_sd_6d <= gout2_sd;
      gout2_sd_7d <= gout2_sd_6d;
      gout2_sd_8d <= gout2_sd_7d;
      gout2_sd_9d <= gout2_sd_8d;
      gout2_sd_10d <= gout2_sd_9d;
      gout2_sd_11d <= gout2_sd_10d;
    end

    always @(posedge oclk) begin
      gout3_sd_6d <= gout3_sd;
      gout3_sd_7d <= gout3_sd_6d;
      gout3_sd_8d <= gout3_sd_7d;
      gout3_sd_9d <= gout3_sd_8d;
      gout3_sd_10d <= gout3_sd_9d;
      gout3_sd_11d <= gout3_sd_10d;
    end

    always @(posedge oclk) begin
      gout4_sd_7d <= gout4_sd;
      gout4_sd_8d <= gout4_sd_7d;
      gout4_sd_9d <= gout4_sd_8d;
      gout4_sd_10d <= gout4_sd_9d;
      gout4_sd_11d <= gout4_sd_10d;
    end

    always @(posedge oclk) begin
      gout5_sd_7d <= gout5_sd;
      gout5_sd_8d <= gout5_sd_7d;
      gout5_sd_9d <= gout5_sd_8d;
      gout5_sd_10d <= gout5_sd_9d;
      gout5_sd_11d <= gout5_sd_10d;
    end

    always @(posedge oclk) begin
      gout6_sd_8d <= gout6_sd;
      gout6_sd_9d <= gout6_sd_8d;
      gout6_sd_10d <= gout6_sd_9d;
      gout6_sd_11d <= gout6_sd_10d;
    end

    always @(posedge oclk) begin
      gout7_sd_8d <= gout7_sd;
      gout7_sd_9d <= gout7_sd_8d;
      gout7_sd_10d <= gout7_sd_9d;
      gout7_sd_11d <= gout7_sd_10d;
    end

    always @(posedge oclk) begin
      gout8_sd_9d <= gout8_sd;
      gout8_sd_10d <= gout8_sd_9d;
      gout8_sd_11d <= gout8_sd_10d;
    end

    always @(posedge oclk) begin
      gout9_sd_9d <= gout9_sd;
      gout9_sd_10d <= gout9_sd_9d;
      gout9_sd_11d <= gout9_sd_10d;
    end

    always @(posedge oclk) begin
      gout10_sd_10d <= gout10_sd;
      gout10_sd_11d <= gout10_sd_10d;
    end

    always @(posedge oclk) begin
      gout11_sd_10d <= gout11_sd;
      gout11_sd_11d <= gout11_sd_10d;
    end

    always @(posedge oclk) begin
      gout12_sd_11d <= gout12_sd;
    end

    always @(posedge oclk) begin
      gout13_sd_11d <= gout13_sd;
    end

    assign gout14_sd_11d = gout14_sd;
    assign gout15_sd_11d = gout15_sd;


    always @(posedge oclk) begin
      bout0_sd_5d <= bout0_sd;
      bout0_sd_6d <= bout0_sd_5d;
      bout0_sd_7d <= bout0_sd_6d;
      bout0_sd_8d <= bout0_sd_7d;
      bout0_sd_9d <= bout0_sd_8d;
      bout0_sd_10d <= bout0_sd_9d;
      bout0_sd_11d <= bout0_sd_10d;
    end

    always @(posedge oclk) begin
      bout1_sd_5d <= bout1_sd;
      bout1_sd_6d <= bout1_sd_5d;
      bout1_sd_7d <= bout1_sd_6d;
      bout1_sd_8d <= bout1_sd_7d;
      bout1_sd_9d <= bout1_sd_8d;
      bout1_sd_10d <= bout1_sd_9d;
      bout1_sd_11d <= bout1_sd_10d;
    end

    always @(posedge oclk) begin
      bout2_sd_6d <= bout2_sd;
      bout2_sd_7d <= bout2_sd_6d;
      bout2_sd_8d <= bout2_sd_7d;
      bout2_sd_9d <= bout2_sd_8d;
      bout2_sd_10d <= bout2_sd_9d;
      bout2_sd_11d <= bout2_sd_10d;
    end

    always @(posedge oclk) begin
      bout3_sd_6d <= bout3_sd;
      bout3_sd_7d <= bout3_sd_6d;
      bout3_sd_8d <= bout3_sd_7d;
      bout3_sd_9d <= bout3_sd_8d;
      bout3_sd_10d <= bout3_sd_9d;
      bout3_sd_11d <= bout3_sd_10d;
    end

    always @(posedge oclk) begin
      bout4_sd_7d <= bout4_sd;
      bout4_sd_8d <= bout4_sd_7d;
      bout4_sd_9d <= bout4_sd_8d;
      bout4_sd_10d <= bout4_sd_9d;
      bout4_sd_11d <= bout4_sd_10d;
    end

    always @(posedge oclk) begin
      bout5_sd_7d <= bout5_sd;
      bout5_sd_8d <= bout5_sd_7d;
      bout5_sd_9d <= bout5_sd_8d;
      bout5_sd_10d <= bout5_sd_9d;
      bout5_sd_11d <= bout5_sd_10d;
    end

    always @(posedge oclk) begin
      bout6_sd_8d <= bout6_sd;
      bout6_sd_9d <= bout6_sd_8d;
      bout6_sd_10d <= bout6_sd_9d;
      bout6_sd_11d <= bout6_sd_10d;
    end

    always @(posedge oclk) begin
      bout7_sd_8d <= bout7_sd;
      bout7_sd_9d <= bout7_sd_8d;
      bout7_sd_10d <= bout7_sd_9d;
      bout7_sd_11d <= bout7_sd_10d;
    end

    always @(posedge oclk) begin
      bout8_sd_9d <= bout8_sd;
      bout8_sd_10d <= bout8_sd_9d;
      bout8_sd_11d <= bout8_sd_10d;
    end

    always @(posedge oclk) begin
      bout9_sd_9d <= bout9_sd;
      bout9_sd_10d <= bout9_sd_9d;
      bout9_sd_11d <= bout9_sd_10d;
    end

    always @(posedge oclk) begin
      bout10_sd_10d <= bout10_sd;
      bout10_sd_11d <= bout10_sd_10d;
    end

    always @(posedge oclk) begin
      bout11_sd_10d <= bout11_sd;
      bout11_sd_11d <= bout11_sd_10d;
    end

    always @(posedge oclk) begin
      bout12_sd_11d <= bout12_sd;
    end

    always @(posedge oclk) begin
      bout13_sd_11d <= bout13_sd;
    end

    assign bout14_sd_11d = bout14_sd;
    assign bout15_sd_11d = bout15_sd;


// データ出力

    // cf_tim_1d -- cf_tim_7d  (出力データ切換えタイミング用レジスタ)  [oclk]
    always @(posedge oclk) begin
      cf_tim_1d <= cf_tim;
      cf_tim_2d <= cf_tim_1d;
      cf_tim_3d <= cf_tim_2d;
    end

    // dout_cf_tim  (config data と gs data の間隔のセンタータイミング)
    assign dout_cf_tim = cf_tim_3d;


    // r_out  16bit (16 area)  [oclk]
    always @(posedge oclk) begin
      r_out[0] <= dout_cf_tim ? r_config_sd_11d : rout0_sd_11d;
      r_out[1] <= dout_cf_tim ? r_config_sd_11d : rout1_sd_11d;
      r_out[2] <= dout_cf_tim ? r_config_sd_11d : rout2_sd_11d;
      r_out[3] <= dout_cf_tim ? r_config_sd_11d : rout3_sd_11d;
      r_out[4] <= dout_cf_tim ? r_config_sd_11d : rout4_sd_11d;
      r_out[5] <= dout_cf_tim ? r_config_sd_11d : rout5_sd_11d;
      r_out[6] <= dout_cf_tim ? r_config_sd_11d : rout6_sd_11d;
      r_out[7] <= dout_cf_tim ? r_config_sd_11d : rout7_sd_11d;
      r_out[8] <= dout_cf_tim ? r_config_sd_11d : rout8_sd_11d;
      r_out[9] <= dout_cf_tim ? r_config_sd_11d : rout9_sd_11d;
      r_out[10] <= dout_cf_tim ? r_config_sd_11d : rout10_sd_11d;
      r_out[11] <= dout_cf_tim ? r_config_sd_11d : rout11_sd_11d;
      r_out[12] <= dout_cf_tim ? r_config_sd_11d : rout12_sd_11d;
      r_out[13] <= dout_cf_tim ? r_config_sd_11d : rout13_sd_11d;
      r_out[14] <= dout_cf_tim ? r_config_sd_11d : rout14_sd_11d;
      r_out[15] <= dout_cf_tim ? r_config_sd_11d : rout15_sd_11d;
    end

    // g_out  16bit (16 8area)  [oclk]
    //always @(posedge oclk) begin
    //  g_out[0] <= dout_cf_tim ? g_config_sd_11d : gout0_sd_11d;
    //  g_out[1] <= dout_cf_tim ? g_config_sd_11d : gout1_sd_11d;
    //  g_out[2] <= dout_cf_tim ? g_config_sd_11d : gout2_sd_11d;
    //  g_out[3] <= dout_cf_tim ? g_config_sd_11d : gout3_sd_11d;
    //  g_out[4] <= dout_cf_tim ? g_config_sd_11d : gout4_sd_11d;
    //  g_out[5] <= dout_cf_tim ? g_config_sd_11d : gout5_sd_11d;
    //  g_out[6] <= dout_cf_tim ? g_config_sd_11d : gout6_sd_11d;
    //  g_out[7] <= dout_cf_tim ? g_config_sd_11d : gout7_sd_11d;
    //  g_out[8] <= dout_cf_tim ? g_config_sd_11d : gout8_sd_11d;
    //  g_out[9] <= dout_cf_tim ? g_config_sd_11d : gout9_sd_11d;
    //  g_out[10] <= dout_cf_tim ? g_config_sd_11d : gout10_sd_11d;
    //  g_out[11] <= dout_cf_tim ? g_config_sd_11d : gout11_sd_11d;
    //  g_out[12] <= dout_cf_tim ? g_config_sd_11d : gout12_sd_11d;
    //  g_out[13] <= dout_cf_tim ? g_config_sd_11d : gout13_sd_11d;
    //  g_out[14] <= dout_cf_tim ? g_config_sd_11d : gout14_sd_11d;
    //  g_out[15] <= dout_cf_tim ? g_config_sd_11d : gout15_sd_11d;
    //end

	always @(posedge oclk) begin
		g_out <= {5'b0,cnt_scano};
	end

    // b_out  8bit (8area)  [oclk]
    always @(posedge oclk) begin
      b_out[0] <= dout_cf_tim ? b_config_sd_11d : bout0_sd_11d;
      b_out[1] <= dout_cf_tim ? b_config_sd_11d : bout1_sd_11d;
      b_out[2] <= dout_cf_tim ? b_config_sd_11d : bout2_sd_11d;
      b_out[3] <= dout_cf_tim ? b_config_sd_11d : bout3_sd_11d;
      b_out[4] <= dout_cf_tim ? b_config_sd_11d : bout4_sd_11d;
      b_out[5] <= dout_cf_tim ? b_config_sd_11d : bout5_sd_11d;
      b_out[6] <= dout_cf_tim ? b_config_sd_11d : bout6_sd_11d;
      b_out[7] <= dout_cf_tim ? b_config_sd_11d : bout7_sd_11d;
      b_out[8] <= dout_cf_tim ? b_config_sd_11d : bout8_sd_11d;
      b_out[9] <= dout_cf_tim ? b_config_sd_11d : bout9_sd_11d;
      b_out[10] <= dout_cf_tim ? b_config_sd_11d : bout10_sd_11d;
      b_out[11] <= dout_cf_tim ? b_config_sd_11d : bout11_sd_11d;
      b_out[12] <= dout_cf_tim ? b_config_sd_11d : bout12_sd_11d;
      b_out[13] <= dout_cf_tim ? b_config_sd_11d : bout13_sd_11d;
      b_out[14] <= dout_cf_tim ? b_config_sd_11d : bout14_sd_11d;
      b_out[15] <= dout_cf_tim ? b_config_sd_11d : bout15_sd_11d;
    end


// LE出力

	reg config4_le;								//Hasco 2021.09
	
    // config1_le -- vsync_le  [oclk]
    always @(posedge oclk) begin
      config1_le <= cf1_le_tim & cf1_tim;
      config2_le <= cf2_le_tim & cf2_tim;
      config3_le <= cf3_le_tim & cf3_tim;
      config4_le <= cf4_le_tim & cf4_tim;		//Hasco 2021.09
      gs_le <= gs_le_tim & gs_tim;
      vsync_le <= vsync_le_a;
    end

    // le_2d -- le_11d, le_out  [oclk]
    always @(posedge oclk) begin
      //le_2d <= config1_le | config2_le | config3_le | gs_le | vsync_le;
      le_2d <= config1_le | config2_le | config3_le | config4_le | gs_le | vsync_le;		//Hasco 2021.09
      le_3d <= le_2d;
      le_4d <= le_3d;
      le_5d <= le_4d;
      le_6d <= le_5d;
      le_7d <= le_6d;
      le_8d <= le_7d;
      le_9d <= le_8d;
      le_10d <= le_9d;
      le_11d <= le_10d;
      le_out <= le_11d;
    end


// DCLK出力

    // sd_dclk
    //assign sd_dclk = cnt_ock_1d[2] & ((cf_dclk_tim & cf_tim) | gs_tim);
    //assign sd_dclk = cnt_ock_1d[4] & ((cf_dclk_tim & cf_tim) | gs_tim);				//Hasco 2021.09
    assign sd_dclk = (cnt_ock_1d >= 12) & ((cf_dclk_tim & cf_tim) | gs_tim);			//Hasco 2021.10

    // vs_dclk
    //assign vs_dclk = cnt_vs_ock[2];
    assign vs_dclk = (cnt_vs_ock >= 12 & cnt_vs_ock <= 23);												//Hasco 2021.10

    // dclk_1d -- dclk_10d, dclk_out  [oclk]
    always @(posedge oclk) begin
      dclk_1d <= (sd_dclk | vs_dclk);
      dclk_2d <= dclk_1d;
      dclk_3d <= dclk_2d;
      dclk_4d <= dclk_3d;
      dclk_5d <= dclk_4d;
      dclk_6d <= dclk_5d;
      dclk_7d <= dclk_6d;
      dclk_8d <= dclk_7d;
      dclk_9d <= dclk_8d;
      dclk_10d <= dclk_9d;
      //dclk_out <= dclk_10d;
      //dclk_out <= dclk_9d;						//Hasco 2021.09 - Hold Time keep 2 clk
      dclk_out <= dclk_6d;							//Hasco 2021.10 - Hold Time more better
    end

endmodule
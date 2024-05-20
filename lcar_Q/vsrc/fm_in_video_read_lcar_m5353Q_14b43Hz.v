`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// Frame memory input video read
//
// 2017.04  作成 (fm_in_video_read_impact2_m5051bを変更)
//                P0,P1をPVII-4,PVII-6用に変更
// 2017.04  変更 (fm_in_video_read_pv2_m5051bをfm_in_video_read_pv2_4_4x4に変更)
//                P0をPVII-4(4x4IM)用に変更, fm_ov_rd_cycle入力を追加,
//                1FM処理cycleでのread pixel数を2から4に変更
// 2017.05  変更 (fm_in_video_read_pv2_4_4x4をfm_in_video_read_pv2_4_4x4_v2に変更)
//                PVII-4のIMの回路変更に伴い p0_had 作成部を変更

module fm_in_video_read_lcar_m5353Q_14b43Hz

      (panel_sel, fm_cycle_stp_adv, ovp, fm_iv_wr_cycle, fm_ov_rd_cycle, frame_alt,
       fm_rd_d, clk,
       fm_in_vid_rd_adrs, fm_iv_rd_cycle,
       red, green, blue,
       fm_m4_cf_rd_adrs,
       cf0d, cf1d, cf2d, cf3d, cf4d, cf5d, cf6d, cf7d, cf8d);

    input [3:0] panel_sel;   //
    input fm_cycle_stp_adv;  // Frame memory 処理 cycle pulse, 72clock周期
    input ovp;               // V start pulse, 1clock幅
    input fm_iv_wr_cycle;    // Frame memory input video write cycle
    input fm_ov_rd_cycle;    // Frame memory output video read cycle
    input frame_alt;         // Frame alternate
    input [29:0] fm_rd_d;    // Frame memory read video data
    input clk;               // 125MHz

    output [16:0] fm_in_vid_rd_adrs;  // Frame memory input video read address
    output reg fm_iv_rd_cycle;        // Frame memory input video read cycle
    output [9:0] red;                 // Red data
    output [9:0] green;               // Green data
    output [9:0] blue;                // Blue data
    output [18:0] fm_m4_cf_rd_adrs;   // Frame memory M4 coefficient read address
    output reg [12:0] cf0d;           // M4 coefficient 0
    output reg [12:0] cf1d;           // M4 coefficient 1
    output reg [12:0] cf2d;           // M4 coefficient 2
    output reg [12:0] cf3d;           // M4 coefficient 3
    output reg [12:0] cf4d;           // M4 coefficient 4
    output reg [12:0] cf5d;           // M4 coefficient 5
    output reg [12:0] cf6d;           // M4 coefficient 6
    output reg [12:0] cf7d;           // M4 coefficient 7
    output reg [12:0] cf8d;           // M4 coefficient 8

    reg [6:0] qa;
    reg cnt_ce2, cnt_ce3, cnt_ce4;
    reg in_vid_lat1, in_vid_lat2, in_vid_lat3, in_vid_lat4;
    reg cf_sel_cnt_rst1, cf_sel_cnt_rst2, cf_sel_cnt_rst3, cf_sel_cnt_rst4;
    reg cf01_tim1, cf23_tim1, cf45_tim1, cf67_tim1, cf8_tim1;
    reg cf01_tim2, cf23_tim2, cf45_tim2, cf67_tim2, cf8_tim2;
    reg cf01_tim3, cf23_tim3, cf45_tim3, cf67_tim3, cf8_tim3;
    reg cf01_tim4, cf23_tim4, cf45_tim4, cf67_tim4, cf8_tim4;
    reg cf01_tim5;
    reg cf_tim1, cf_tim2, cf_tim3, cf_tim4;
    reg ovt;
    reg [3:0] qb;
    reg qb_end;
    reg [3:0] qb_p;
    reg qb_p_end;
    // reg rd_stop_st;
    //reg [2:0] qb_h;
    reg [3:0] qb_h;
    reg qb_h_end;
    reg [2:0] qb_v;
    reg qb_v_end;
    reg [2:0] qb_i;
    reg qb_i_end;
    //reg [3:0] qb_d;
    reg [4:0] qb_d;
    reg qb_stop;
    // reg [2:0] qc;
    // reg qc_stop;
    // reg rd_restart;
    // reg rd_stop_cycle;
    reg [7:0] offset_h;
    //reg [5:0] had_1d;
    reg [7:0] had_1d;
    reg [7:0] fm_had;
    reg [7:0] offset_v;
    reg [4:0] vad_1d;
    reg [7:0] fm_vad;
    reg qb_rst_1d;
    reg fm_rd_bank;
    reg qb_stop_1cycle_d;
    reg fm_iv_rd_cycle_a;
    reg in_vid_latch;
    reg [29:0] fm_rd_data;
    reg [5:0] m4_vad;
    reg [11:0] m4_pix_num;
    reg [2:0] qb_i_1d, m4_h_im_posi;
    reg [2:0] im_vad_1d, m4_v_im_posi;
    reg [2:0] qd;
    reg cf01_latch, cf23_latch, cf45_latch, cf67_latch, cf8_latch;
    reg cf_1st_latch, cf_latch;
    reg [12:0] cf0_da, cf1_da, cf2_da, cf3_da, cf4_da, cf5_da, cf6_da, cf7_da, cf8_da;
    reg [12:0] cf0_db, cf1_db, cf2_db, cf3_db, cf4_db, cf5_db, cf6_db, cf7_db, cf8_db;

    wire [7:0] a0_ofst_v, a1_ofst_v, a2_ofst_v, a3_ofst_v;
    wire [7:0] a4_ofst_v, a5_ofst_v, a6_ofst_v, a7_ofst_v;
    wire [7:0] a8_ofst_v, a9_ofst_v, a10_ofst_v, a11_ofst_v;
    wire [7:0] a12_ofst_v, a13_ofst_v, a14_ofst_v, a15_ofst_v;
    wire [5:0] im_h_pix;
    // wire [5:0] im_v_pix;
    //wire [2:0] h_ic_num_m1;
    wire [3:0] h_ic_num_m1;
    wire [2:0] area_v_ic_num_m1;
    //wire [3:0] duty;
    wire [4:0] duty;
    wire [2:0] im_num_m1;
    wire [1:0] im_v_area_num_m1;
    // wire [2:0] rd_stop_cycle_num, rd_stop_cycle_num_m1;
    wire qa_stop;
    wire cnt_ce;
    wire qb_rst;
    wire qb_ce;
    wire qb_endp;
    wire qb_p_endp;
    wire qb_h_endp;
    wire qb_v_endp;
    wire qb_i_endp;
    wire qb_stop_a;
    // wire rd_stop_stp;
    wire [2:0] qb_p_ex;
    wire [2:0] v_ic_cnt_reverse;
    wire [5:0] p0_had, p1_had;
    wire [4:0] p2_had, p3_had, p4_had, p5_had, p6_had, p7_had;
    wire [4:0] p8_had, p9_had, p10_had;
    wire [4:0] p0_vad, p1_vad, p2_vad, p3_vad, p4_vad, p5_vad, p6_vad, p7_vad;
    wire [4:0] p8_vad, p9_vad, p10_vad;
    wire [5:0] had;
    wire [4:0] vad;
    wire [3:0] area;
    wire [2:0] a1_im_vad, a2_im_vad, a3_im_vad, a4_im_vad;
    wire [5:0] a1_m4_offset_v, a2_m4_offset_v, a3_m4_offset_v, a4_m4_offset_v;
    wire [2:0] im_vad;
    wire [5:0] m4_offset_v;
    wire [2:0] m4_cf_sel;
    wire qd_stop;


// parameter

 //HASCO 202110   (3x3IM)
    parameter  HS_A0_OFST_V = 8'd0;
    parameter  HS_A1_OFST_V = 8'd16;
    parameter  HS_A2_OFST_V = 8'd32;
    parameter  HS_B0_OFST_V = 8'd48;
    parameter  HS_B1_OFST_V = 8'd64;
    parameter  HS_B2_OFST_V = 8'd80;
    parameter  HS_C0_OFST_V = 8'd96;
    parameter  HS_C1_OFST_V = 8'd112;
    parameter  HS_C2_OFST_V = 8'd128;
	
    parameter  HS_IM_H_PIX = 9'd256;
    parameter  HS_H_IC_NUM_M1 = 4'd15;
    parameter  HS_AREA_V_IC_NUM_M1 = 0;
    parameter  HS_DUTY = 5'd16;
    parameter  HS_IM_NUM_M1 = 0;

 //HASCO 202103   (5x1IM)
    //parameter  HS_A0_OFST_V = 8'd0;
    //parameter  HS_A1_OFST_V = 8'd30;
    //parameter  HS_A2_OFST_V = 8'd60;
    //parameter  HS_A3_OFST_V = 8'd30;
    //parameter  HS_A4_OFST_V = 8'd60;
    ////parameter  HS_A5_OFST_V = 8'd75;
    ////parameter  HS_A6_OFST_V = 8'd90;
    ////parameter  HS_A7_OFST_V = 8'd105;
    ////parameter  HS_A8_OFST_V = 8'd120;
    ////parameter  HS_A9_OFST_V = 8'd135;
    ////parameter  HS_A10_OFST_V = 8'd150;
    ////parameter  HS_A11_OFST_V = 8'd165;
    ////parameter  HS_A12_OFST_V = 8'd180;
    ////parameter  HS_A13_OFST_V = 8'd195;
    ////parameter  HS_A14_OFST_V = 8'd210;
    ////parameter  HS_A15_OFST_V = 8'd225;
	//
    //parameter  HS_IM_H_PIX = 9'd256;
    //// parameter  P0_IM_V_PIX = 6'd60;
    //parameter  HS_H_IC_NUM_M1 = 4'd15;
    //parameter  HS_AREA_V_IC_NUM_M1 = 0;
    //parameter  HS_DUTY = 5'd30;
    //// parameter  P0_IM_NUM_M1 = 3'd1;
    //parameter  HS_IM_NUM_M1 = 0;
    ////parameter  HS_IM_V_AREA_NUM_M1 = 2'd3;	

 // P0 : PVII-4 (4x4 IM)
    parameter  P0_A0_OFST_V = 8'd0;
    parameter  P0_A1_OFST_V = 8'd15;
    parameter  P0_A2_OFST_V = 8'd30;
    parameter  P0_A3_OFST_V = 8'd45;
    parameter  P0_A4_OFST_V = 8'd60;
    parameter  P0_A5_OFST_V = 8'd75;
    parameter  P0_A6_OFST_V = 8'd90;
    parameter  P0_A7_OFST_V = 8'd105;
    parameter  P0_A8_OFST_V = 8'd120;
    parameter  P0_A9_OFST_V = 8'd135;
    parameter  P0_A10_OFST_V = 8'd150;
    parameter  P0_A11_OFST_V = 8'd165;
    parameter  P0_A12_OFST_V = 8'd180;
    parameter  P0_A13_OFST_V = 8'd195;
    parameter  P0_A14_OFST_V = 8'd210;
    parameter  P0_A15_OFST_V = 8'd225;

    parameter  P0_IM_H_PIX = 6'd60;
    // parameter  P0_IM_V_PIX = 6'd60;
    parameter  P0_H_IC_NUM_M1 = 3'd3;
    parameter  P0_AREA_V_IC_NUM_M1 = 3'd2;
    parameter  P0_DUTY = 4'd5;
    // parameter  P0_IM_NUM_M1 = 3'd1;
    parameter  P0_IM_NUM_M1 = 3'd3;
    parameter  P0_IM_V_AREA_NUM_M1 = 2'd3;

 // P1 : PVII-6 (4x4 IM)
    parameter  P1_A0_OFST_V = 8'd0;
    parameter  P1_A1_OFST_V = 8'd2;
    parameter  P1_A2_OFST_V = 8'd40;
    parameter  P1_A3_OFST_V = 8'd60;
    parameter  P1_A4_OFST_V = 8'd80;
    parameter  P1_A5_OFST_V = 8'd100;
    parameter  P1_A6_OFST_V = 8'd120;
    parameter  P1_A7_OFST_V = 8'd140;
    parameter  P1_A8_OFST_V = 8'd160;
    parameter  P1_A9_OFST_V = 8'd160;
    parameter  P1_A10_OFST_V = 8'd160;
    parameter  P1_A11_OFST_V = 8'd160;
    parameter  P1_A12_OFST_V = 8'd160;
    parameter  P1_A13_OFST_V = 8'd160;
    parameter  P1_A14_OFST_V = 8'd160;
    parameter  P1_A15_OFST_V = 8'd160;

    parameter  P1_IM_H_PIX = 6'd40;
    // parameter  P1_IM_V_PIX = 6'd40;
    parameter  P1_H_IC_NUM_M1 = 3'd4;
    parameter  P1_AREA_V_IC_NUM_M1 = 3'd1;
    parameter  P1_DUTY = 4'd5;
    parameter  P1_IM_NUM_M1 = 3'd3;
    parameter  P1_IM_V_AREA_NUM_M1 = 2'd1;

 // P2 : ImpactII-10
    parameter  P2_A0_OFST_V = 8'd0;
    parameter  P2_A1_OFST_V = 8'd18;
    parameter  P2_A2_OFST_V = 8'd36;
    parameter  P2_A3_OFST_V = 8'd54;
    parameter  P2_A4_OFST_V = 8'd72;
    parameter  P2_A5_OFST_V = 8'd90;
    parameter  P2_A6_OFST_V = 8'd108;
    parameter  P2_A7_OFST_V = 8'd126;
    parameter  P2_A8_OFST_V = 8'd144;
    parameter  P2_A9_OFST_V = 8'd162;
    parameter  P2_A10_OFST_V = 8'd162;
    parameter  P2_A11_OFST_V = 8'd162;
    parameter  P2_A12_OFST_V = 8'd162;
    parameter  P2_A13_OFST_V = 8'd162;
    parameter  P2_A14_OFST_V = 8'd162;
    parameter  P2_A15_OFST_V = 8'd162;

    parameter  P2_IM_H_PIX = 6'd18;
    // parameter  P2_IM_V_PIX = 6'd18;
    parameter  P2_H_IC_NUM_M1 = 3'd2;
    parameter  P2_AREA_V_IC_NUM_M1 = 3'd4;
    parameter  P2_DUTY = 4'd2;
    parameter  P2_IM_NUM_M1 = 3'd1;
    parameter  P2_IM_V_AREA_NUM_M1 = 2'd0;

 // P3 : ImpactII-12
    parameter  P3_A0_OFST_V = 8'd0;
    parameter  P3_A1_OFST_V = 8'd8;
    parameter  P3_A2_OFST_V = 8'd16;
    parameter  P3_A3_OFST_V = 8'd24;
    parameter  P3_A4_OFST_V = 8'd32;
    parameter  P3_A5_OFST_V = 8'd40;
    parameter  P3_A6_OFST_V = 8'd48;
    parameter  P3_A7_OFST_V = 8'd56;
    parameter  P3_A8_OFST_V = 8'd64;
    parameter  P3_A9_OFST_V = 8'd72;
    parameter  P3_A10_OFST_V = 8'd80;
    parameter  P3_A11_OFST_V = 8'd88;
    parameter  P3_A12_OFST_V = 8'd96;
    parameter  P3_A13_OFST_V = 8'd104;
    parameter  P3_A14_OFST_V = 8'd112;
    parameter  P3_A15_OFST_V = 8'd120;

    parameter  P3_IM_H_PIX = 6'd16;
    // parameter  P3_IM_V_PIX = 6'd16;
    parameter  P3_H_IC_NUM_M1 = 3'd1;
    parameter  P3_AREA_V_IC_NUM_M1 = 3'd3;
    parameter  P3_DUTY = 4'd1;
    parameter  P3_IM_NUM_M1 = 3'd3;
    parameter  P3_IM_V_AREA_NUM_M1 = 2'd1;

 // P4 : ImpactII-16
    parameter  P4_A0_OFST_V = 8'd0;
    parameter  P4_A1_OFST_V = 8'd6;
    parameter  P4_A2_OFST_V = 8'd12;
    parameter  P4_A3_OFST_V = 8'd18;
    parameter  P4_A4_OFST_V = 8'd24;
    parameter  P4_A5_OFST_V = 8'd30;
    parameter  P4_A6_OFST_V = 8'd36;
    parameter  P4_A7_OFST_V = 8'd42;
    parameter  P4_A8_OFST_V = 8'd48;
    parameter  P4_A9_OFST_V = 8'd54;
    parameter  P4_A10_OFST_V = 8'd60;
    parameter  P4_A11_OFST_V = 8'd66;
    parameter  P4_A12_OFST_V = 8'd72;
    parameter  P4_A13_OFST_V = 8'd78;
    parameter  P4_A14_OFST_V = 8'd84;
    parameter  P4_A15_OFST_V = 8'd90;

    parameter  P4_IM_H_PIX = 6'd12;
    // parameter  P4_IM_V_PIX = 6'd12;
    parameter  P4_H_IC_NUM_M1 = 3'd1;
    parameter  P4_AREA_V_IC_NUM_M1 = 3'd2;
    parameter  P4_DUTY = 4'd1;
    parameter  P4_IM_NUM_M1 = 3'd3;
    parameter  P4_IM_V_AREA_NUM_M1 = 2'd1;

 // P5 : Pv16i/o-oval
    parameter  P5_A0_OFST_V = 8'd0;
    parameter  P5_A1_OFST_V = 8'd10;
    parameter  P5_A2_OFST_V = 8'd20;
    parameter  P5_A3_OFST_V = 8'd30;
    parameter  P5_A4_OFST_V = 8'd40;
    parameter  P5_A5_OFST_V = 8'd50;
    parameter  P5_A6_OFST_V = 8'd60;
    parameter  P5_A7_OFST_V = 8'd70;
    parameter  P5_A8_OFST_V = 8'd80;
    parameter  P5_A9_OFST_V = 8'd90;
    parameter  P5_A10_OFST_V = 8'd100;
    parameter  P5_A11_OFST_V = 8'd110;
    parameter  P5_A12_OFST_V = 8'd120;
    parameter  P5_A13_OFST_V = 8'd130;
    parameter  P5_A14_OFST_V = 8'd140;
    parameter  P5_A15_OFST_V = 8'd150;

    parameter  P5_IM_H_PIX = 6'd20;
    // parameter  P5_IM_V_PIX = 6'd20;
    parameter  P5_H_IC_NUM_M1 = 3'd2;
    parameter  P5_AREA_V_IC_NUM_M1 = 3'd4;
    parameter  P5_DUTY = 4'd1;
    parameter  P5_IM_NUM_M1 = 3'd2;
    parameter  P5_IM_V_AREA_NUM_M1 = 2'd1;

 // P6 : Bv16i/o-oval
    parameter  P6_A0_OFST_V = 8'd0;
    parameter  P6_A1_OFST_V = 8'd10;
    parameter  P6_A2_OFST_V = 8'd20;
    parameter  P6_A3_OFST_V = 8'd30;
    parameter  P6_A4_OFST_V = 8'd40;
    parameter  P6_A5_OFST_V = 8'd50;
    parameter  P6_A6_OFST_V = 8'd60;
    parameter  P6_A7_OFST_V = 8'd70;
    parameter  P6_A8_OFST_V = 8'd80;
    parameter  P6_A9_OFST_V = 8'd90;
    parameter  P6_A10_OFST_V = 8'd100;
    parameter  P6_A11_OFST_V = 8'd110;
    parameter  P6_A12_OFST_V = 8'd120;
    parameter  P6_A13_OFST_V = 8'd130;
    parameter  P6_A14_OFST_V = 8'd140;
    parameter  P6_A15_OFST_V = 8'd150;

    parameter  P6_IM_H_PIX = 6'd20;
    // parameter  P6_IM_V_PIX = 6'd20;
    parameter  P6_H_IC_NUM_M1 = 3'd2;
    parameter  P6_AREA_V_IC_NUM_M1 = 3'd4;
    parameter  P6_DUTY = 4'd1;
    parameter  P6_IM_NUM_M1 = 3'd3;
    parameter  P6_IM_V_AREA_NUM_M1 = 2'd1;

 // P7 : Pv20i/o-oval
    parameter  P7_A0_OFST_V = 8'd0;
    parameter  P7_A1_OFST_V = 8'd8;
    parameter  P7_A2_OFST_V = 8'd16;
    parameter  P7_A3_OFST_V = 8'd24;
    parameter  P7_A4_OFST_V = 8'd32;
    parameter  P7_A5_OFST_V = 8'd40;
    parameter  P7_A6_OFST_V = 8'd48;
    parameter  P7_A7_OFST_V = 8'd56;
    parameter  P7_A8_OFST_V = 8'd64;
    parameter  P7_A9_OFST_V = 8'd72;
    parameter  P7_A10_OFST_V = 8'd80;
    parameter  P7_A11_OFST_V = 8'd88;
    parameter  P7_A12_OFST_V = 8'd96;
    parameter  P7_A13_OFST_V = 8'd104;
    parameter  P7_A14_OFST_V = 8'd112;
    parameter  P7_A15_OFST_V = 8'd120;

    parameter  P7_IM_H_PIX = 6'd16;
    // parameter  P7_IM_V_PIX = 6'd16;
    parameter  P7_H_IC_NUM_M1 = 3'd1;
    parameter  P7_AREA_V_IC_NUM_M1 = 3'd3;
    parameter  P7_DUTY = 4'd1;
    parameter  P7_IM_NUM_M1 = 3'd5;
    parameter  P7_IM_V_AREA_NUM_M1 = 2'd1;

 // P8 : Pv26i/o-oval
    parameter  P8_A0_OFST_V = 8'd0;
    parameter  P8_A1_OFST_V = 8'd4;
    parameter  P8_A2_OFST_V = 8'd8;
    parameter  P8_A3_OFST_V = 8'd12;
    parameter  P8_A4_OFST_V = 8'd16;
    parameter  P8_A5_OFST_V = 8'd20;
    parameter  P8_A6_OFST_V = 8'd24;
    parameter  P8_A7_OFST_V = 8'd28;
    parameter  P8_A8_OFST_V = 8'd32;
    parameter  P8_A9_OFST_V = 8'd36;
    parameter  P8_A10_OFST_V = 8'd40;
    parameter  P8_A11_OFST_V = 8'd44;
    parameter  P8_A12_OFST_V = 8'd48;
    parameter  P8_A13_OFST_V = 8'd52;
    parameter  P8_A14_OFST_V = 8'd56;
    parameter  P8_A15_OFST_V = 8'd60;

    parameter  P8_IM_H_PIX = 6'd12;
    // parameter  P8_IM_V_PIX = 6'd12;
    parameter  P8_H_IC_NUM_M1 = 3'd2;
    parameter  P8_AREA_V_IC_NUM_M1 = 3'd0;
    parameter  P8_DUTY = 4'd1;
    parameter  P8_IM_NUM_M1 = 3'd5;
    parameter  P8_IM_V_AREA_NUM_M1 = 2'd2;

 // P9 : Fv20T
    parameter  P9_A0_OFST_V = 8'd0;
    parameter  P9_A1_OFST_V = 8'd16;
    parameter  P9_A2_OFST_V = 8'd32;
    parameter  P9_A3_OFST_V = 8'd48;
    parameter  P9_A4_OFST_V = 8'd64;
    parameter  P9_A5_OFST_V = 8'd80;
    parameter  P9_A6_OFST_V = 8'd96;
    parameter  P9_A7_OFST_V = 8'd112;
    parameter  P9_A8_OFST_V = 8'd128;
    parameter  P9_A9_OFST_V = 8'd144;
    parameter  P9_A10_OFST_V = 8'd160;
    parameter  P9_A11_OFST_V = 8'd176;
    parameter  P9_A12_OFST_V = 8'd176;
    parameter  P9_A13_OFST_V = 8'd176;
    parameter  P9_A14_OFST_V = 8'd176;
    parameter  P9_A15_OFST_V = 8'd176;

    parameter  P9_IM_H_PIX = 6'd16;
    // parameter  P9_IM_V_PIX = 6'd16;
    parameter  P9_H_IC_NUM_M1 = 3'd1;
    parameter  P9_AREA_V_IC_NUM_M1 = 3'd7;
    parameter  P9_DUTY = 4'd1;
    parameter  P9_IM_NUM_M1 = 3'd3;
    parameter  P9_IM_V_AREA_NUM_M1 = 2'd0;

 // P10 : Pv10
    parameter  P10_A0_OFST_V = 8'd0;
    parameter  P10_A1_OFST_V = 8'd8;
    parameter  P10_A2_OFST_V = 8'd16;
    parameter  P10_A3_OFST_V = 8'd24;
    parameter  P10_A4_OFST_V = 8'd32;
    parameter  P10_A5_OFST_V = 8'd40;
    parameter  P10_A6_OFST_V = 8'd48;
    parameter  P10_A7_OFST_V = 8'd56;
    parameter  P10_A8_OFST_V = 8'd64;
    parameter  P10_A9_OFST_V = 8'd72;
    parameter  P10_A10_OFST_V = 8'd80;
    parameter  P10_A11_OFST_V = 8'd88;
    parameter  P10_A12_OFST_V = 8'd96;
    parameter  P10_A13_OFST_V = 8'd104;
    parameter  P10_A14_OFST_V = 8'd112;
    parameter  P10_A15_OFST_V = 8'd120;

    parameter  P10_IM_H_PIX = 6'd24;
    // parameter  P10_IM_V_PIX = 6'd24;
    parameter  P10_H_IC_NUM_M1 = 3'd2;
    parameter  P10_AREA_V_IC_NUM_M1 = 3'd3;
    parameter  P10_DUTY = 4'd1;
    parameter  P10_IM_NUM_M1 = 3'd3;
    parameter  P10_IM_V_AREA_NUM_M1 = 2'd2;


 // parameter select

    // a0_ofst_v  8bit
    function [7:0] a0_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: a0_ofst_v_sel = P0_A0_OFST_V;
        4'h0: a0_ofst_v_sel = HS_A0_OFST_V;
        4'h1: a0_ofst_v_sel = P1_A0_OFST_V;
        4'h2: a0_ofst_v_sel = P2_A0_OFST_V;
        4'h3: a0_ofst_v_sel = P3_A0_OFST_V;
        4'h4: a0_ofst_v_sel = P4_A0_OFST_V;
        4'h5: a0_ofst_v_sel = P5_A0_OFST_V;
        4'h6: a0_ofst_v_sel = P6_A0_OFST_V;
        4'h7: a0_ofst_v_sel = P7_A0_OFST_V;
        4'h8: a0_ofst_v_sel = P8_A0_OFST_V;
        4'h9: a0_ofst_v_sel = P9_A0_OFST_V;
        4'ha: a0_ofst_v_sel = P10_A0_OFST_V;
        default: a0_ofst_v_sel = P0_A0_OFST_V;
      endcase
    endfunction

    assign a0_ofst_v = a0_ofst_v_sel(panel_sel);

    // a1_ofst_v  8bit
    function [7:0] a1_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: a1_ofst_v_sel = P0_A1_OFST_V;
        4'h0: a1_ofst_v_sel = HS_A1_OFST_V;
        4'h1: a1_ofst_v_sel = P1_A1_OFST_V;
        4'h2: a1_ofst_v_sel = P2_A1_OFST_V;
        4'h3: a1_ofst_v_sel = P3_A1_OFST_V;
        4'h4: a1_ofst_v_sel = P4_A1_OFST_V;
        4'h5: a1_ofst_v_sel = P5_A1_OFST_V;
        4'h6: a1_ofst_v_sel = P6_A1_OFST_V;
        4'h7: a1_ofst_v_sel = P7_A1_OFST_V;
        4'h8: a1_ofst_v_sel = P8_A1_OFST_V;
        4'h9: a1_ofst_v_sel = P9_A1_OFST_V;
        4'ha: a1_ofst_v_sel = P10_A1_OFST_V;
        default: a1_ofst_v_sel = P0_A1_OFST_V;
      endcase
    endfunction

    assign a1_ofst_v = a1_ofst_v_sel(panel_sel);

    // a2_ofst_v  8bit
    function [7:0] a2_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: a2_ofst_v_sel = P0_A2_OFST_V;
        4'h0: a2_ofst_v_sel = HS_A2_OFST_V;
        4'h1: a2_ofst_v_sel = P1_A2_OFST_V;
        4'h2: a2_ofst_v_sel = P2_A2_OFST_V;
        4'h3: a2_ofst_v_sel = P3_A2_OFST_V;
        4'h4: a2_ofst_v_sel = P4_A2_OFST_V;
        4'h5: a2_ofst_v_sel = P5_A2_OFST_V;
        4'h6: a2_ofst_v_sel = P6_A2_OFST_V;
        4'h7: a2_ofst_v_sel = P7_A2_OFST_V;
        4'h8: a2_ofst_v_sel = P8_A2_OFST_V;
        4'h9: a2_ofst_v_sel = P9_A2_OFST_V;
        4'ha: a2_ofst_v_sel = P10_A2_OFST_V;
        default: a2_ofst_v_sel = P0_A2_OFST_V;
      endcase
    endfunction

    assign a2_ofst_v = a2_ofst_v_sel(panel_sel);

    // a3_ofst_v  8bit
    function [7:0] a3_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: a3_ofst_v_sel = P0_A3_OFST_V;
        //4'h0: a3_ofst_v_sel = HS_A3_OFST_V;
        4'h0: a3_ofst_v_sel = HS_B0_OFST_V;
        4'h1: a3_ofst_v_sel = P1_A3_OFST_V;
        4'h2: a3_ofst_v_sel = P2_A3_OFST_V;
        4'h3: a3_ofst_v_sel = P3_A3_OFST_V;
        4'h4: a3_ofst_v_sel = P4_A3_OFST_V;
        4'h5: a3_ofst_v_sel = P5_A3_OFST_V;
        4'h6: a3_ofst_v_sel = P6_A3_OFST_V;
        4'h7: a3_ofst_v_sel = P7_A3_OFST_V;
        4'h8: a3_ofst_v_sel = P8_A3_OFST_V;
        4'h9: a3_ofst_v_sel = P9_A3_OFST_V;
        4'ha: a3_ofst_v_sel = P10_A3_OFST_V;
        default: a3_ofst_v_sel = P0_A3_OFST_V;
      endcase
    endfunction

    assign a3_ofst_v = a3_ofst_v_sel(panel_sel);

    // a4_ofst_v  8bit
    function [7:0] a4_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: a4_ofst_v_sel = P0_A4_OFST_V;
        //4'h0: a4_ofst_v_sel = HS_A4_OFST_V;
        4'h0: a4_ofst_v_sel = HS_B1_OFST_V;						//Hasco 20210930
        4'h1: a4_ofst_v_sel = P1_A4_OFST_V;
        4'h2: a4_ofst_v_sel = P2_A4_OFST_V;
        4'h3: a4_ofst_v_sel = P3_A4_OFST_V;
        4'h4: a4_ofst_v_sel = P4_A4_OFST_V;
        4'h5: a4_ofst_v_sel = P5_A4_OFST_V;
        4'h6: a4_ofst_v_sel = P6_A4_OFST_V;
        4'h7: a4_ofst_v_sel = P7_A4_OFST_V;
        4'h8: a4_ofst_v_sel = P8_A4_OFST_V;
        4'h9: a4_ofst_v_sel = P9_A4_OFST_V;
        4'ha: a4_ofst_v_sel = P10_A4_OFST_V;
        default: a4_ofst_v_sel = P0_A4_OFST_V;
      endcase
    endfunction

    assign a4_ofst_v = a4_ofst_v_sel(panel_sel);

    // a5_ofst_v  8bit
    function [7:0] a5_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: a5_ofst_v_sel = P0_A5_OFST_V;
        4'h0: a5_ofst_v_sel = HS_B2_OFST_V;						//Hasco 20210930
        4'h1: a5_ofst_v_sel = P1_A5_OFST_V;
        4'h2: a5_ofst_v_sel = P2_A5_OFST_V;
        4'h3: a5_ofst_v_sel = P3_A5_OFST_V;
        4'h4: a5_ofst_v_sel = P4_A5_OFST_V;
        4'h5: a5_ofst_v_sel = P5_A5_OFST_V;
        4'h6: a5_ofst_v_sel = P6_A5_OFST_V;
        4'h7: a5_ofst_v_sel = P7_A5_OFST_V;
        4'h8: a5_ofst_v_sel = P8_A5_OFST_V;
        4'h9: a5_ofst_v_sel = P9_A5_OFST_V;
        4'ha: a5_ofst_v_sel = P10_A5_OFST_V;
        default: a5_ofst_v_sel = P0_A5_OFST_V;
      endcase
    endfunction

    assign a5_ofst_v = a5_ofst_v_sel(panel_sel);

    // a6_ofst_v  8bit
    function [7:0] a6_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: a6_ofst_v_sel = P0_A6_OFST_V;
        4'h0: a6_ofst_v_sel = HS_C0_OFST_V;						//Hasco 20210930
        4'h1: a6_ofst_v_sel = P1_A6_OFST_V;
        4'h2: a6_ofst_v_sel = P2_A6_OFST_V;
        4'h3: a6_ofst_v_sel = P3_A6_OFST_V;
        4'h4: a6_ofst_v_sel = P4_A6_OFST_V;
        4'h5: a6_ofst_v_sel = P5_A6_OFST_V;
        4'h6: a6_ofst_v_sel = P6_A6_OFST_V;
        4'h7: a6_ofst_v_sel = P7_A6_OFST_V;
        4'h8: a6_ofst_v_sel = P8_A6_OFST_V;
        4'h9: a6_ofst_v_sel = P9_A6_OFST_V;
        4'ha: a6_ofst_v_sel = P10_A6_OFST_V;
        default: a6_ofst_v_sel = P0_A6_OFST_V;
      endcase
    endfunction

    assign a6_ofst_v = a6_ofst_v_sel(panel_sel);

    // a7_ofst_v  8bit
    function [7:0] a7_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: a7_ofst_v_sel = P0_A7_OFST_V;
        4'h0: a7_ofst_v_sel = HS_C1_OFST_V;					//Hasco 20210930
        4'h1: a7_ofst_v_sel = P1_A7_OFST_V;
        4'h2: a7_ofst_v_sel = P2_A7_OFST_V;
        4'h3: a7_ofst_v_sel = P3_A7_OFST_V;
        4'h4: a7_ofst_v_sel = P4_A7_OFST_V;
        4'h5: a7_ofst_v_sel = P5_A7_OFST_V;
        4'h6: a7_ofst_v_sel = P6_A7_OFST_V;
        4'h7: a7_ofst_v_sel = P7_A7_OFST_V;
        4'h8: a7_ofst_v_sel = P8_A7_OFST_V;
        4'h9: a7_ofst_v_sel = P9_A7_OFST_V;
        4'ha: a7_ofst_v_sel = P10_A7_OFST_V;
        default: a7_ofst_v_sel = P0_A7_OFST_V;
      endcase
    endfunction

    assign a7_ofst_v = a7_ofst_v_sel(panel_sel);

    // a8_ofst_v  8bit
    function [7:0] a8_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: a8_ofst_v_sel = P0_A8_OFST_V;
        4'h0: a8_ofst_v_sel = HS_C2_OFST_V;
        4'h1: a8_ofst_v_sel = P1_A8_OFST_V;
        4'h2: a8_ofst_v_sel = P2_A8_OFST_V;
        4'h3: a8_ofst_v_sel = P3_A8_OFST_V;
        4'h4: a8_ofst_v_sel = P4_A8_OFST_V;
        4'h5: a8_ofst_v_sel = P5_A8_OFST_V;
        4'h6: a8_ofst_v_sel = P6_A8_OFST_V;
        4'h7: a8_ofst_v_sel = P7_A8_OFST_V;
        4'h8: a8_ofst_v_sel = P8_A8_OFST_V;
        4'h9: a8_ofst_v_sel = P9_A8_OFST_V;
        4'ha: a8_ofst_v_sel = P10_A8_OFST_V;
        default: a8_ofst_v_sel = P0_A8_OFST_V;
      endcase
    endfunction

    assign a8_ofst_v = a8_ofst_v_sel(panel_sel);

    // a9_ofst_v  8bit
    function [7:0] a9_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a9_ofst_v_sel = P0_A9_OFST_V;
        4'h1: a9_ofst_v_sel = P1_A9_OFST_V;
        4'h2: a9_ofst_v_sel = P2_A9_OFST_V;
        4'h3: a9_ofst_v_sel = P3_A9_OFST_V;
        4'h4: a9_ofst_v_sel = P4_A9_OFST_V;
        4'h5: a9_ofst_v_sel = P5_A9_OFST_V;
        4'h6: a9_ofst_v_sel = P6_A9_OFST_V;
        4'h7: a9_ofst_v_sel = P7_A9_OFST_V;
        4'h8: a9_ofst_v_sel = P8_A9_OFST_V;
        4'h9: a9_ofst_v_sel = P9_A9_OFST_V;
        4'ha: a9_ofst_v_sel = P10_A9_OFST_V;
        default: a9_ofst_v_sel = P0_A9_OFST_V;
      endcase
    endfunction

    assign a9_ofst_v = a9_ofst_v_sel(panel_sel);

    // a10_ofst_v  8bit
    function [7:0] a10_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a10_ofst_v_sel = P0_A10_OFST_V;
        4'h1: a10_ofst_v_sel = P1_A10_OFST_V;
        4'h2: a10_ofst_v_sel = P2_A10_OFST_V;
        4'h3: a10_ofst_v_sel = P3_A10_OFST_V;
        4'h4: a10_ofst_v_sel = P4_A10_OFST_V;
        4'h5: a10_ofst_v_sel = P5_A10_OFST_V;
        4'h6: a10_ofst_v_sel = P6_A10_OFST_V;
        4'h7: a10_ofst_v_sel = P7_A10_OFST_V;
        4'h8: a10_ofst_v_sel = P8_A10_OFST_V;
        4'h9: a10_ofst_v_sel = P9_A10_OFST_V;
        4'ha: a10_ofst_v_sel = P10_A10_OFST_V;
        default: a10_ofst_v_sel = P0_A10_OFST_V;
      endcase
    endfunction

    assign a10_ofst_v = a10_ofst_v_sel(panel_sel);

    // a11_ofst_v  8bit
    function [7:0] a11_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a11_ofst_v_sel = P0_A11_OFST_V;
        4'h1: a11_ofst_v_sel = P1_A11_OFST_V;
        4'h2: a11_ofst_v_sel = P2_A11_OFST_V;
        4'h3: a11_ofst_v_sel = P3_A11_OFST_V;
        4'h4: a11_ofst_v_sel = P4_A11_OFST_V;
        4'h5: a11_ofst_v_sel = P5_A11_OFST_V;
        4'h6: a11_ofst_v_sel = P6_A11_OFST_V;
        4'h7: a11_ofst_v_sel = P7_A11_OFST_V;
        4'h8: a11_ofst_v_sel = P8_A11_OFST_V;
        4'h9: a11_ofst_v_sel = P9_A11_OFST_V;
        4'ha: a11_ofst_v_sel = P10_A11_OFST_V;
        default: a11_ofst_v_sel = P0_A11_OFST_V;
      endcase
    endfunction

    assign a11_ofst_v = a11_ofst_v_sel(panel_sel);

    // a12_ofst_v  8bit
    function [7:0] a12_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a12_ofst_v_sel = P0_A12_OFST_V;
        4'h1: a12_ofst_v_sel = P1_A12_OFST_V;
        4'h2: a12_ofst_v_sel = P2_A12_OFST_V;
        4'h3: a12_ofst_v_sel = P3_A12_OFST_V;
        4'h4: a12_ofst_v_sel = P4_A12_OFST_V;
        4'h5: a12_ofst_v_sel = P5_A12_OFST_V;
        4'h6: a12_ofst_v_sel = P6_A12_OFST_V;
        4'h7: a12_ofst_v_sel = P7_A12_OFST_V;
        4'h8: a12_ofst_v_sel = P8_A12_OFST_V;
        4'h9: a12_ofst_v_sel = P9_A12_OFST_V;
        4'ha: a12_ofst_v_sel = P10_A12_OFST_V;
        default: a12_ofst_v_sel = P0_A12_OFST_V;
      endcase
    endfunction

    assign a12_ofst_v = a12_ofst_v_sel(panel_sel);

    // a13_ofst_v  8bit
    function [7:0] a13_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a13_ofst_v_sel = P0_A13_OFST_V;
        4'h1: a13_ofst_v_sel = P1_A13_OFST_V;
        4'h2: a13_ofst_v_sel = P2_A13_OFST_V;
        4'h3: a13_ofst_v_sel = P3_A13_OFST_V;
        4'h4: a13_ofst_v_sel = P4_A13_OFST_V;
        4'h5: a13_ofst_v_sel = P5_A13_OFST_V;
        4'h6: a13_ofst_v_sel = P6_A13_OFST_V;
        4'h7: a13_ofst_v_sel = P7_A13_OFST_V;
        4'h8: a13_ofst_v_sel = P8_A13_OFST_V;
        4'h9: a13_ofst_v_sel = P9_A13_OFST_V;
        4'ha: a13_ofst_v_sel = P10_A13_OFST_V;
        default: a13_ofst_v_sel = P0_A13_OFST_V;
      endcase
    endfunction

    assign a13_ofst_v = a13_ofst_v_sel(panel_sel);

    // a14_ofst_v  8bit
    function [7:0] a14_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a14_ofst_v_sel = P0_A14_OFST_V;
        4'h1: a14_ofst_v_sel = P1_A14_OFST_V;
        4'h2: a14_ofst_v_sel = P2_A14_OFST_V;
        4'h3: a14_ofst_v_sel = P3_A14_OFST_V;
        4'h4: a14_ofst_v_sel = P4_A14_OFST_V;
        4'h5: a14_ofst_v_sel = P5_A14_OFST_V;
        4'h6: a14_ofst_v_sel = P6_A14_OFST_V;
        4'h7: a14_ofst_v_sel = P7_A14_OFST_V;
        4'h8: a14_ofst_v_sel = P8_A14_OFST_V;
        4'h9: a14_ofst_v_sel = P9_A14_OFST_V;
        4'ha: a14_ofst_v_sel = P10_A14_OFST_V;
        default: a14_ofst_v_sel = P0_A14_OFST_V;
      endcase
    endfunction

    assign a14_ofst_v = a14_ofst_v_sel(panel_sel);

    // a15_ofst_v  8bit
    function [7:0] a15_ofst_v_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a15_ofst_v_sel = P0_A15_OFST_V;
        4'h1: a15_ofst_v_sel = P1_A15_OFST_V;
        4'h2: a15_ofst_v_sel = P2_A15_OFST_V;
        4'h3: a15_ofst_v_sel = P3_A15_OFST_V;
        4'h4: a15_ofst_v_sel = P4_A15_OFST_V;
        4'h5: a15_ofst_v_sel = P5_A15_OFST_V;
        4'h6: a15_ofst_v_sel = P6_A15_OFST_V;
        4'h7: a15_ofst_v_sel = P7_A15_OFST_V;
        4'h8: a15_ofst_v_sel = P8_A15_OFST_V;
        4'h9: a15_ofst_v_sel = P9_A15_OFST_V;
        4'ha: a15_ofst_v_sel = P10_A15_OFST_V;
        default: a15_ofst_v_sel = P0_A15_OFST_V;
      endcase
    endfunction

    assign a15_ofst_v = a15_ofst_v_sel(panel_sel);


    // im_h_pix  6bit
    function [5:0] im_h_pix_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: im_h_pix_sel = P0_IM_H_PIX;
        4'h0: im_h_pix_sel = HS_IM_H_PIX;
        4'h1: im_h_pix_sel = P1_IM_H_PIX;
        4'h2: im_h_pix_sel = P2_IM_H_PIX;
        4'h3: im_h_pix_sel = P3_IM_H_PIX;
        4'h4: im_h_pix_sel = P4_IM_H_PIX;
        4'h5: im_h_pix_sel = P5_IM_H_PIX;
        4'h6: im_h_pix_sel = P6_IM_H_PIX;
        4'h7: im_h_pix_sel = P7_IM_H_PIX;
        4'h8: im_h_pix_sel = P8_IM_H_PIX;
        4'h9: im_h_pix_sel = P9_IM_H_PIX;
        4'ha: im_h_pix_sel = P10_IM_H_PIX;
        default: im_h_pix_sel = P0_IM_H_PIX;
      endcase
    endfunction

    assign im_h_pix = im_h_pix_sel(panel_sel);

    // im_v_pix  6bit
    // function [5:0] im_v_pix_sel;
    // input [3:0] sel;
    //   case(sel)
    //     4'h0: im_v_pix_sel = P0_IM_V_PIX;
    //     4'h1: im_v_pix_sel = P1_IM_V_PIX;
    //     4'h2: im_v_pix_sel = P2_IM_V_PIX;
    //     4'h3: im_v_pix_sel = P3_IM_V_PIX;
    //     4'h4: im_v_pix_sel = P4_IM_V_PIX;
    //     4'h5: im_v_pix_sel = P5_IM_V_PIX;
    //     4'h6: im_v_pix_sel = P6_IM_V_PIX;
    //     4'h7: im_v_pix_sel = P7_IM_V_PIX;
    //     4'h8: im_v_pix_sel = P8_IM_V_PIX;
    //     4'h9: im_v_pix_sel = P9_IM_V_PIX;
    //     4'ha: im_v_pix_sel = P10_IM_V_PIX;
    //     default: im_v_pix_sel = P0_IM_V_PIX;
    //   endcase
    // endfunction

    // assign im_v_pix = im_v_pix_sel(panel_sel);

    // h_ic_num_m1  3bit
    //function [2:0] h_ic_num_m1_sel;
    function [3:0] h_ic_num_m1_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: h_ic_num_m1_sel = P0_H_IC_NUM_M1;
        4'h0: h_ic_num_m1_sel = HS_H_IC_NUM_M1;
        4'h1: h_ic_num_m1_sel = P1_H_IC_NUM_M1;
        4'h2: h_ic_num_m1_sel = P2_H_IC_NUM_M1;
        4'h3: h_ic_num_m1_sel = P3_H_IC_NUM_M1;
        4'h4: h_ic_num_m1_sel = P4_H_IC_NUM_M1;
        4'h5: h_ic_num_m1_sel = P5_H_IC_NUM_M1;
        4'h6: h_ic_num_m1_sel = P6_H_IC_NUM_M1;
        4'h7: h_ic_num_m1_sel = P7_H_IC_NUM_M1;
        4'h8: h_ic_num_m1_sel = P8_H_IC_NUM_M1;
        4'h9: h_ic_num_m1_sel = P9_H_IC_NUM_M1;
        4'ha: h_ic_num_m1_sel = P10_H_IC_NUM_M1;
        default: h_ic_num_m1_sel = P0_H_IC_NUM_M1;
      endcase
    endfunction

    assign h_ic_num_m1 = h_ic_num_m1_sel(panel_sel);

    // area_v_ic_num_m1  3bit
    function [2:0] area_v_ic_num_m1_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: area_v_ic_num_m1_sel = P0_AREA_V_IC_NUM_M1;
        4'h0: area_v_ic_num_m1_sel = HS_AREA_V_IC_NUM_M1;
        4'h1: area_v_ic_num_m1_sel = P1_AREA_V_IC_NUM_M1;
        4'h2: area_v_ic_num_m1_sel = P2_AREA_V_IC_NUM_M1;
        4'h3: area_v_ic_num_m1_sel = P3_AREA_V_IC_NUM_M1;
        4'h4: area_v_ic_num_m1_sel = P4_AREA_V_IC_NUM_M1;
        4'h5: area_v_ic_num_m1_sel = P5_AREA_V_IC_NUM_M1;
        4'h6: area_v_ic_num_m1_sel = P6_AREA_V_IC_NUM_M1;
        4'h7: area_v_ic_num_m1_sel = P7_AREA_V_IC_NUM_M1;
        4'h8: area_v_ic_num_m1_sel = P8_AREA_V_IC_NUM_M1;
        4'h9: area_v_ic_num_m1_sel = P9_AREA_V_IC_NUM_M1;
        4'ha: area_v_ic_num_m1_sel = P10_AREA_V_IC_NUM_M1;
        default: area_v_ic_num_m1_sel = P0_AREA_V_IC_NUM_M1;
      endcase
    endfunction

    assign area_v_ic_num_m1 = area_v_ic_num_m1_sel(panel_sel);

    // duty  4bit
    //function [3:0] duty_sel;
    function [4:0] duty_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: duty_sel = P0_DUTY;
        4'h0: duty_sel = HS_DUTY;
        4'h1: duty_sel = P1_DUTY;
        4'h2: duty_sel = P2_DUTY;
        4'h3: duty_sel = P3_DUTY;
        4'h4: duty_sel = P4_DUTY;
        4'h5: duty_sel = P5_DUTY;
        4'h6: duty_sel = P6_DUTY;
        4'h7: duty_sel = P7_DUTY;
        4'h8: duty_sel = P8_DUTY;
        4'h9: duty_sel = P9_DUTY;
        4'ha: duty_sel = P10_DUTY;
        default: duty_sel = P0_DUTY;
      endcase
    endfunction

    assign duty = duty_sel(panel_sel);

    // im_num_m1  3bit
    function [2:0] im_num_m1_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: im_num_m1_sel = P0_IM_NUM_M1;
        4'h0: im_num_m1_sel = HS_IM_NUM_M1;
        4'h1: im_num_m1_sel = P1_IM_NUM_M1;
        4'h2: im_num_m1_sel = P2_IM_NUM_M1;
        4'h3: im_num_m1_sel = P3_IM_NUM_M1;
        4'h4: im_num_m1_sel = P4_IM_NUM_M1;
        4'h5: im_num_m1_sel = P5_IM_NUM_M1;
        4'h6: im_num_m1_sel = P6_IM_NUM_M1;
        4'h7: im_num_m1_sel = P7_IM_NUM_M1;
        4'h8: im_num_m1_sel = P8_IM_NUM_M1;
        4'h9: im_num_m1_sel = P9_IM_NUM_M1;
        4'ha: im_num_m1_sel = P10_IM_NUM_M1;
        default: im_num_m1_sel = P0_IM_NUM_M1;
      endcase
    endfunction

    assign im_num_m1 = im_num_m1_sel(panel_sel);

    // im_v_area_num_m1  2bit
    function [1:0] im_v_area_num_m1_sel;
    input [3:0] sel;
      case(sel)
        4'h0: im_v_area_num_m1_sel = P0_IM_V_AREA_NUM_M1;
        4'h1: im_v_area_num_m1_sel = P1_IM_V_AREA_NUM_M1;
        4'h2: im_v_area_num_m1_sel = P2_IM_V_AREA_NUM_M1;
        4'h3: im_v_area_num_m1_sel = P3_IM_V_AREA_NUM_M1;
        4'h4: im_v_area_num_m1_sel = P4_IM_V_AREA_NUM_M1;
        4'h5: im_v_area_num_m1_sel = P5_IM_V_AREA_NUM_M1;
        4'h6: im_v_area_num_m1_sel = P6_IM_V_AREA_NUM_M1;
        4'h7: im_v_area_num_m1_sel = P7_IM_V_AREA_NUM_M1;
        4'h8: im_v_area_num_m1_sel = P8_IM_V_AREA_NUM_M1;
        4'h9: im_v_area_num_m1_sel = P9_IM_V_AREA_NUM_M1;
        4'ha: im_v_area_num_m1_sel = P10_IM_V_AREA_NUM_M1;
        default: im_v_area_num_m1_sel = P0_IM_V_AREA_NUM_M1;
      endcase
    endfunction

    assign im_v_area_num_m1 = im_v_area_num_m1_sel(panel_sel);


 // 共通 parameter

    // parameter  LIGHT_ON_BIT_NUM = 5'd21;  // 点灯処理bit数 (17 -- 22)

    // rd_stop_cycle_num, rd_stop_cycle_num_m1  3bit
    // assign rd_stop_cycle_num    = LIGHT_ON_BIT_NUM + 5'h10;  // -16
    // assign rd_stop_cycle_num_m1 = LIGHT_ON_BIT_NUM + 5'h0f;  // -17


// タイミング信号作成

    // qa  7bitカウンタ (cnt_ce 作成用)
    always @(posedge clk) begin
      if(fm_cycle_stp_adv)
        qa <= 0;
      else if(~qa_stop)
        qa <= qa + 1;
    end

    // qa_stop
    assign qa_stop = qa[6] & qa[3];  // 64+8=72

    // cnt_ce2 -- cnt_ce4, in_vid_lat1 -- in_vid_lat4
    // cf_sel_cnt_rst1 -- cf_sel_cnt_rst4, cf01_tim1 -- cf_tim2
    always @(posedge clk) begin
      cnt_ce2 <= (qa == 7'd10);
      cnt_ce3 <= (qa == 7'd22);
      cnt_ce4 <= (qa == 7'd34);

      in_vid_lat1 <= (qa == 7'd18);
      in_vid_lat2 <= (qa == 7'd30);
      in_vid_lat3 <= (qa == 7'd42);
      in_vid_lat4 <= (qa == 7'd54);

      cf_sel_cnt_rst1 <= (qa == 7'd3);
      cf_sel_cnt_rst2 <= (qa == 7'd15);
      cf_sel_cnt_rst3 <= (qa == 7'd27);
      cf_sel_cnt_rst4 <= (qa == 7'd39);

      cf01_tim1 <= (qa == 7'd10);
      cf23_tim1 <= cf01_tim1;
      cf45_tim1 <= cf23_tim1;
      cf67_tim1 <= cf45_tim1;
      cf8_tim1  <= cf67_tim1;

      cf01_tim2 <= (qa == 7'd22);
      cf23_tim2 <= cf01_tim2;
      cf45_tim2 <= cf23_tim2;
      cf67_tim2 <= cf45_tim2;
      cf8_tim2  <= cf67_tim2;

      cf01_tim3 <= (qa == 7'd34);
      cf23_tim3 <= cf01_tim3;
      cf45_tim3 <= cf23_tim3;
      cf67_tim3 <= cf45_tim3;
      cf8_tim3  <= cf67_tim3;

      cf01_tim4 <= (qa == 7'd46);
      cf23_tim4 <= cf01_tim4;
      cf45_tim4 <= cf23_tim4;
      cf67_tim4 <= cf45_tim4;
      cf8_tim4  <= cf67_tim4;

      cf01_tim5 <= (qa == 7'd58);

      cf_tim1 <= (qa == 7'd27);
      cf_tim2 <= (qa == 7'd39);
      cf_tim3 <= (qa == 7'd51);
      cf_tim4 <= (qa == 7'd63);
    end

    // cnt_ce
    assign cnt_ce = fm_cycle_stp_adv | cnt_ce2 | cnt_ce3 | cnt_ce4;

    // ovt
    always @(posedge clk) begin
      if(ovp)
        ovt <= 1;
      else if(fm_cycle_stp_adv)
        ovt <= 0;
    end

    // qb_rst
    assign qb_rst = ovt & fm_cycle_stp_adv;

    // qb_ce
    // assign qb_ce = cnt_ce & ~fm_iv_wr_cycle & ~qb_stop & ~rd_stop_cycle;
    // assign qb_ce = cnt_ce & ~fm_iv_wr_cycle & ~qb_stop;
    assign qb_ce = cnt_ce & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle & ~qb_stop;

    // qb  4bitカウンタ (area カウント)
    always @(posedge clk) begin
      if(qb_rst | qb_endp)
        qb <= 0;
      else if(qb_ce)
        qb <= qb + 1;
    end

    // qb_end
    always @(posedge clk) begin
      qb_end <= (qb == 4'd15);
      //qb_end <= (qb == 4'd7);
      //qb_end <= (qb == 4'd9);						//HASCO 20210930;
      //qb_end <= (qb == 4'd8);						//HASCO 20210930;
    end

    // qb_endp
    assign qb_endp = qb_ce & qb_end;


    // qb_h  3bitカウンタ (H IC 数 / IM カウント)
    always @(posedge clk) begin
      if(qb_rst | qb_h_endp)
        qb_h <= 0;
      else if(qb_endp)
        qb_h <= qb_h + 1;
    end

    // qb_h_end
    always @(posedge clk) begin
      qb_h_end <= (qb_h == h_ic_num_m1);
    end

    // qb_h_endp
    assign qb_h_endp = qb_endp & qb_h_end;


    // qb_v  3bitカウンタ (V IC 数 / area カウント)
	//Hasco  4bit
    always @(posedge clk) begin
      if(qb_rst | qb_v_endp)
        qb_v <= 0;
      else if(qb_h_endp)
        qb_v <= qb_v + 1;
    end

    // qb_v_end
    always @(posedge clk) begin
      qb_v_end <= (qb_v == area_v_ic_num_m1);
    end

    // qb_v_endp
    assign qb_v_endp = qb_h_endp & qb_v_end;


    // qb_i  3bitカウンタ (IM 接続数 カウント)
    always @(posedge clk) begin
      if(qb_rst | qb_i_endp)
        qb_i <= 0;
      else if(qb_v_endp)
        qb_i <= qb_i + 1;
    end

    // qb_i_end
    always @(posedge clk) begin
      qb_i_end <= (qb_i == im_num_m1);
    end

    // qb_i_endp
    assign qb_i_endp = qb_v_endp & qb_i_end;


    // qb_p  4bitカウンタ (pixel / Driver IC カウント)
    always @(posedge clk) begin
      if(qb_rst | qb_p_endp)
        qb_p <= 0;
      else if(qb_i_endp)
        qb_p <= qb_p + 1;
    end

    // qb_p_end
    always @(posedge clk) begin
      qb_p_end <= (qb_p == 4'd15);
    end

    // qb_p_endp
    assign qb_p_endp = qb_i_endp & qb_p_end;


    // qb_d  4bitカウンタ (scan line カウント)
    // HASCO 5bit
    always @(posedge clk) begin
      if(qb_rst)
        qb_d <= 0;
      else if(qb_p_endp)
        qb_d <= qb_d + 1;
    end

    // qb_stop_a
    assign qb_stop_a = (qb_d == duty);

    // qb_stop
    always @(posedge clk) begin
      qb_stop <= qb_stop_a;
    end


    // rd_stop_st
    // always @(posedge clk) begin
    //   rd_stop_st <= (qb == 4'd15) & qb_p[0];
    // end

    // rd_stop_stp
    // assign rd_stop_stp = rd_stop_st & fm_cycle_stp_adv;

    // qc  3bitカウンタ (read stop cycle カウント)
    // always @(posedge clk) begin
    //   if(rd_stop_stp)
    //     qc <= 0;
    //   else if(fm_cycle_stp_adv & ~qc_stop)
    //     qc <= qc + 1;
    // end

    // qc_stop
    // rd_restart
    // always @(posedge clk) begin
    //   qc_stop    <= (qc == rd_stop_cycle_num);
    //   rd_restart <= (qc == rd_stop_cycle_num_m1);
    // end

    // rd_stop_cycle
    // always @(posedge clk) begin
    //   if(qb_rst | (fm_cycle_stp_adv & rd_restart))
    //     rd_stop_cycle <= 0;
    //   else if(rd_stop_stp)
    //     rd_stop_cycle <= 1;
    // end


// had, vad, area 信号作成
//   had : IM 内の H address
//   vad : AREA 内の V address

    // qb_p_ex   3bit
    assign qb_p_ex = qb_p[3] ? qb_p[2:0] : ~qb_p[2:0];


    // v_ic_cnt_reverse   3bit
    assign v_ic_cnt_reverse = area_v_ic_num_m1 + ~qb_v + 1'b1;

	wire[4:0] hs_vad;
    //assign hs_had = {qb_h[1:0], ~qb_p} + {4'b1111, ~qb_h[1:0]} + 1'b1;
    assign hs_vad = qb_d;

    // p0_had  6bit, p0_vad   5bit  (P0 : PVII-4 (4x4 IM))
 // assign p0_had = {qb_h[1:0], ~qb_p};
    assign p0_had = {qb_h[1:0], ~qb_p} + {4'b1111, ~qb_h[1:0]} + 1'b1;
    assign p0_vad = (v_ic_cnt_reverse[1:0] * duty[2:0]) + qb_d[2:0];

    // p1_had  6bit, p1_vad   5bit  (P1 : PVII-6 (4x4 IM))
    assign p1_had = {qb_h[2:0], qb_p_ex};
    assign p1_vad = ({qb_v[0], qb_p[3]} * duty[2:0]) + qb_d[2:0];

    // p2_had, p2_vad   5bit  (P2 : ImpactII-10)
    assign p2_had = {qb_h[1:0], qb_p_ex};
    assign p2_vad = {qb_v[2:0], qb_p[3], qb_d[0]};

    // p3_had, p3_vad   5bit  (P3 : ImpactII-12)
    assign p3_had = {1'b0, qb_h[0], qb_p_ex};
    assign p3_vad = {2'd0, qb_v[1:0], qb_p[3]};

    // p4_had, p4_vad   5bit  (P4 : ImpactII-16)
    assign p4_had = {1'b0, qb_h[0], qb_p_ex};
    assign p4_vad = {2'd0, qb_v[1:0], qb_p[3]};

    // p5_had, p5_vad   5bit  (P5 : Pv16i/o-oval)
    assign p5_had = {qb_h[1:0], qb_p_ex};
    assign p5_vad = {1'd0, qb_v[2:0], qb_p[3]};

    // p6_had, p6_vad   5bit  (P6 : Bv16i/o-oval)
    assign p6_had = {qb_h[1:0], qb_p_ex};
    assign p6_vad = {1'd0, qb_v[2:0], qb_p[3]};

    // p7_had, p7_vad   5bit  (P7 : Pv20i/o-oval)
    assign p7_had = {1'b0, qb_h[0], qb_p_ex};
    assign p7_vad = {2'd0, qb_v[1:0], qb_p[3]};

    // p8_had, p8_vad   5bit  (P8 : Pv26i/o-oval)
    assign p8_had = {1'b0, qb_h[1:0], qb_p[1:0]};
    assign p8_vad = {3'd0, qb_p[3:2]};

    // p9_had, p9_vad   5bit  (P9 : Fv20T)
    assign p9_had = {1'b0, qb_h[0], qb_p_ex};
    assign p9_vad = {1'b0, qb_v[2:0], qb_p[3]};

    // p10_had, p10_vad   5bit  (P10 : Pv10)
    assign p10_had = {qb_h[1:0], qb_p_ex};
    assign p10_vad = {2'd0, qb_v[1:0], qb_p[3]};


    // had  6bit
    function [5:0] had_sel;
    input [3:0] sel;
      case(sel)
        4'h0: had_sel = p0_had;
        4'h1: had_sel = p1_had;
        4'h2: had_sel = {1'b0, p2_had};
        4'h3: had_sel = {1'b0, p3_had};
        4'h4: had_sel = {1'b0, p4_had};
        4'h5: had_sel = {1'b0, p5_had};
        4'h6: had_sel = {1'b0, p6_had};
        4'h7: had_sel = {1'b0, p7_had};
        4'h8: had_sel = {1'b0, p8_had};
        4'h9: had_sel = {1'b0, p9_had};
        4'ha: had_sel = {1'b0, p10_had};
        default: had_sel = p0_had;
      endcase
    endfunction

    assign had = had_sel(panel_sel);

    // vad  5bit
    function [4:0] vad_sel;
    input [3:0] sel;
      case(sel)
        //4'h0: vad_sel = p0_vad;
        4'h0: vad_sel = hs_vad;
        4'h1: vad_sel = p1_vad;
        4'h2: vad_sel = p2_vad;
        4'h3: vad_sel = p3_vad;
        4'h4: vad_sel = p4_vad;
        4'h5: vad_sel = p5_vad;
        4'h6: vad_sel = p6_vad;
        4'h7: vad_sel = p7_vad;
        4'h8: vad_sel = p8_vad;
        4'h9: vad_sel = p9_vad;
        4'ha: vad_sel = p10_vad;
        default: vad_sel = p0_vad;
      endcase
    endfunction

    assign vad = vad_sel(panel_sel);


    // area  4bit
    assign area = qb[3:0];


// Frame memory read address for video 作成

    // offset_h  8bit
    always @(posedge clk) begin
      offset_h <= im_h_pix * qb_i;
    end

    //// had_1d  6bit
    //always @(posedge clk) begin
    //  had_1d <= had;
    //end

    function [4:0] pix_sel;
    input [3:0] sel;
      case(sel)
        4'h0: pix_sel = 9;
        4'h1: pix_sel = 11;
        4'h2: pix_sel = 15;
        4'h3: pix_sel = 14;
        4'h4: pix_sel = 13;
        4'h5: pix_sel = 12;
        4'h6: pix_sel = 10;
        4'h7: pix_sel = 8;
        4'h8: pix_sel = 6;
        4'h9: pix_sel = 4;
        4'ha: pix_sel = 3;
        4'hb: pix_sel = 2;
        4'hc: pix_sel = 1;
        4'hd: pix_sel = 0;
        4'he: pix_sel = 5;
        4'hf: pix_sel = 7;
        default: pix_sel = 9;
      endcase
    endfunction

    wire[3:0] pix_rearr = pix_sel(qb_p);
	
    // had_1d  8bit
	// Hasco
    always @(posedge clk) begin
      //case(area)
		//4'h0: 	had_1d <= {qb_h,~qb_p};
		//4'h1:	had_1d <= {qb_h,~qb_p};
		//4'h2:	had_1d <= {qb_h,~qb_p};
		//4'h3:	had_1d <= (qb_h>=4'd6) ? {qb_h-4'd6,~qb_p} : {qb_h,~qb_p};
		//4'h4:	begin
		//	//if(vad==5'd28&qb_h<4'd10)
		//	//	had_1d <= 8'd0;
		//	//else if(vad==5'd28&qb_h>=4'd10&qb_h<4'd12)
		//	if(vad==5'd28&qb_h>=4'd10&qb_h<4'd12)
		//		had_1d <= {qb_h-4'd6,~qb_p};
		//	else if(vad==5'd28&qb_h>=4'd12)
		//		had_1d <= {qb_h,~qb_p};
		//	//else if(qb_h<4'd1)
		//	//	had_1d <= 8'd0;
		//	else
		//		had_1d <= {qb_h,~qb_p};
		//end
		//default: had_1d <= {qb_h,~qb_p};
		//had_1d <= {qb_h,qb_p};									//HASCO 20210930
		//had_1d <= {qb_h,pix_rearr};									//HASCO 20210930
		had_1d <= {~qb_h,pix_rearr};									//HASCO 20210930
	  //endcase
	  //had_1d <= had;
    end
	
    // fm_had  8bit
    always @(posedge clk) begin
      //fm_had <= {2'd0, had_1d} + offset_h;
      fm_had <= had_1d + offset_h;
    end


    // offset_v  8bit
    always @(posedge clk) begin
        case (area)
          4'h0: offset_v <= a0_ofst_v;
          4'h1: offset_v <= a1_ofst_v;
          4'h2: offset_v <= a2_ofst_v;
          4'h3: offset_v <= a3_ofst_v;
          4'h4: offset_v <= a4_ofst_v;
          4'h5: offset_v <= a5_ofst_v;
          4'h6: offset_v <= a6_ofst_v;
          4'h7: offset_v <= a7_ofst_v;
          4'h8: offset_v <= a8_ofst_v;
          4'h9: offset_v <= a9_ofst_v;
          4'ha: offset_v <= a10_ofst_v;
          4'hb: offset_v <= a11_ofst_v;
          4'hc: offset_v <= a12_ofst_v;
          4'hd: offset_v <= a13_ofst_v;
          4'he: offset_v <= a14_ofst_v;
          4'hf: offset_v <= a15_ofst_v;
        endcase
    end

    // vad_1d  5bit
    always @(posedge clk) begin
      vad_1d <= vad;
    end

    // fm_vad  8bit
    always @(posedge clk) begin
      fm_vad <= {3'h0, vad_1d} + offset_v;
    end

    // qb_rst_1d
    always @(posedge clk) begin
      qb_rst_1d <= qb_rst;
    end

    // fm_rd_bank
    always @(posedge clk) begin
      if(qb_rst_1d)
        fm_rd_bank <= ~frame_alt;
    end

    // fm_in_vid_rd_adrs  17bit
    assign fm_in_vid_rd_adrs = {fm_rd_bank, fm_vad, fm_had};


    // qb_stop_1cycle_d
    always @(posedge clk) begin
      if(fm_cycle_stp_adv)
        qb_stop_1cycle_d <= qb_stop_a;
    end

    // fm_iv_rd_cycle_a, fm_iv_rd_cycle
    always @(posedge clk) begin
      // fm_iv_rd_cycle_a <= ~qb_stop_a & ~rd_stop_cycle;
      fm_iv_rd_cycle_a <= ~qb_stop_a | ~qb_stop_1cycle_d;
      fm_iv_rd_cycle   <= fm_iv_rd_cycle_a;
    end


// Frame memory read video data 入力ラッチ

    // in_vid_latch
    always @(posedge clk) begin
      in_vid_latch <= (in_vid_lat1 | in_vid_lat2 | in_vid_lat3 | in_vid_lat4) &
                       fm_iv_rd_cycle & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle;
    end

    // fm_rd_data  30bit
    always @(posedge clk) begin
      if(in_vid_latch)
        fm_rd_data <= fm_rd_d;
    end

    // red, green, blue  10bit
    assign red   = fm_rd_data[29:20];
    assign green = fm_rd_data[19:10];
    assign blue  = fm_rd_data[9:0];


// Frame memory read address for M4 coeff. 作成

  // M coeff. data read 用 im_vad, m4_offset_v 信号作成

    // IM 内 AREA 数 = 1 の場合
    // a1_im_vad  3bit
    // a1_m4_offset_v  6bit
    function [8:0] a1_im_vad_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a1_im_vad_sel = {3'd0, a0_ofst_v[5:0]};
        4'h1: a1_im_vad_sel = {3'd1, a0_ofst_v[5:0]};
        4'h2: a1_im_vad_sel = {3'd2, a0_ofst_v[5:0]};
        4'h3: a1_im_vad_sel = {3'd3, a0_ofst_v[5:0]};
        4'h4: a1_im_vad_sel = {3'd4, a0_ofst_v[5:0]};
        4'h5: a1_im_vad_sel = {3'd5, a0_ofst_v[5:0]};
        4'h6: a1_im_vad_sel = {3'd6, a0_ofst_v[5:0]};
        4'h7: a1_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
        4'h8: a1_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
        4'h9: a1_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
        4'ha: a1_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
        4'hb: a1_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
        4'hc: a1_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
        4'hd: a1_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
        4'he: a1_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
        4'hf: a1_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
      endcase
    endfunction

    assign {a1_im_vad, a1_m4_offset_v} = a1_im_vad_sel(area);

    // IM 内 AREA 数 = 2 の場合
    // a2_im_vad  3bit
    // a2_m4_offset_v  6bit
    function [8:0] a2_im_vad_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a2_im_vad_sel = {3'd0, a0_ofst_v[5:0]};
        4'h1: a2_im_vad_sel = {3'd0, a1_ofst_v[5:0]};
        4'h2: a2_im_vad_sel = {3'd1, a0_ofst_v[5:0]};
        4'h3: a2_im_vad_sel = {3'd1, a1_ofst_v[5:0]};
        4'h4: a2_im_vad_sel = {3'd2, a0_ofst_v[5:0]};
        4'h5: a2_im_vad_sel = {3'd2, a1_ofst_v[5:0]};
        4'h6: a2_im_vad_sel = {3'd3, a0_ofst_v[5:0]};
        4'h7: a2_im_vad_sel = {3'd3, a1_ofst_v[5:0]};
        4'h8: a2_im_vad_sel = {3'd4, a0_ofst_v[5:0]};
        4'h9: a2_im_vad_sel = {3'd4, a1_ofst_v[5:0]};
        4'ha: a2_im_vad_sel = {3'd5, a0_ofst_v[5:0]};
        4'hb: a2_im_vad_sel = {3'd5, a1_ofst_v[5:0]};
        4'hc: a2_im_vad_sel = {3'd6, a0_ofst_v[5:0]};
        4'hd: a2_im_vad_sel = {3'd6, a1_ofst_v[5:0]};
        4'he: a2_im_vad_sel = {3'd7, a0_ofst_v[5:0]};
        4'hf: a2_im_vad_sel = {3'd7, a1_ofst_v[5:0]};
      endcase
    endfunction

    assign {a2_im_vad, a2_m4_offset_v} = a2_im_vad_sel(area);

    // IM 内 AREA 数 = 3 の場合
    // a3_im_vad  3bit
    // a3_m4_offset_v  6bit
    function [8:0] a3_im_vad_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a3_im_vad_sel = {3'd0, a0_ofst_v[5:0]};
        4'h1: a3_im_vad_sel = {3'd0, a1_ofst_v[5:0]};
        4'h2: a3_im_vad_sel = {3'd0, a2_ofst_v[5:0]};
        4'h3: a3_im_vad_sel = {3'd1, a0_ofst_v[5:0]};
        4'h4: a3_im_vad_sel = {3'd1, a1_ofst_v[5:0]};
        4'h5: a3_im_vad_sel = {3'd1, a2_ofst_v[5:0]};
        4'h6: a3_im_vad_sel = {3'd2, a0_ofst_v[5:0]};
        4'h7: a3_im_vad_sel = {3'd2, a1_ofst_v[5:0]};
        4'h8: a3_im_vad_sel = {3'd2, a2_ofst_v[5:0]};
        4'h9: a3_im_vad_sel = {3'd3, a0_ofst_v[5:0]};
        4'ha: a3_im_vad_sel = {3'd3, a1_ofst_v[5:0]};
        4'hb: a3_im_vad_sel = {3'd3, a2_ofst_v[5:0]};
        4'hc: a3_im_vad_sel = {3'd4, a0_ofst_v[5:0]};
        4'hd: a3_im_vad_sel = {3'd4, a1_ofst_v[5:0]};
        4'he: a3_im_vad_sel = {3'd4, a2_ofst_v[5:0]};
        4'hf: a3_im_vad_sel = {3'd4, a2_ofst_v[5:0]};
      endcase
    endfunction

    assign {a3_im_vad, a3_m4_offset_v} = a3_im_vad_sel(area);

    // IM 内 AREA 数 = 4 の場合
    // a4_im_vad  3bit
    // a4_m4_offset_v  6bit
    function [8:0] a4_im_vad_sel;
    input [3:0] sel;
      case(sel)
        4'h0: a4_im_vad_sel = {3'd0, a0_ofst_v[5:0]};
        4'h1: a4_im_vad_sel = {3'd0, a1_ofst_v[5:0]};
        4'h2: a4_im_vad_sel = {3'd0, a2_ofst_v[5:0]};
        4'h3: a4_im_vad_sel = {3'd0, a3_ofst_v[5:0]};
        4'h4: a4_im_vad_sel = {3'd1, a0_ofst_v[5:0]};
        4'h5: a4_im_vad_sel = {3'd1, a1_ofst_v[5:0]};
        4'h6: a4_im_vad_sel = {3'd1, a2_ofst_v[5:0]};
        4'h7: a4_im_vad_sel = {3'd1, a3_ofst_v[5:0]};
        4'h8: a4_im_vad_sel = {3'd2, a0_ofst_v[5:0]};
        4'h9: a4_im_vad_sel = {3'd2, a1_ofst_v[5:0]};
        4'ha: a4_im_vad_sel = {3'd2, a2_ofst_v[5:0]};
        4'hb: a4_im_vad_sel = {3'd2, a3_ofst_v[5:0]};
        4'hc: a4_im_vad_sel = {3'd3, a0_ofst_v[5:0]};
        4'hd: a4_im_vad_sel = {3'd3, a1_ofst_v[5:0]};
        4'he: a4_im_vad_sel = {3'd3, a2_ofst_v[5:0]};
        4'hf: a4_im_vad_sel = {3'd3, a3_ofst_v[5:0]};
      endcase
    endfunction

    assign {a4_im_vad, a4_m4_offset_v} = a4_im_vad_sel(area);


    // im_vad  3bit
    // m4_offset_v  6bit
    function [8:0] m4_offset_v_sel;
    input [1:0] sel;
      case(sel)
        2'h0: m4_offset_v_sel = {a1_im_vad, a1_m4_offset_v};
        2'h1: m4_offset_v_sel = {a2_im_vad, a2_m4_offset_v};
        2'h2: m4_offset_v_sel = {a3_im_vad, a3_m4_offset_v};
        2'h3: m4_offset_v_sel = {a4_im_vad, a4_m4_offset_v};
      endcase
    endfunction

    assign {im_vad, m4_offset_v} = m4_offset_v_sel(im_v_area_num_m1);


  // Frame memory read address for M4 coeff.

    // m4_vad  6bit
    always @(posedge clk) begin
      m4_vad <= {1'd0, vad} + m4_offset_v;
    end

    // m4_pix_num  12bit
    always @(posedge clk) begin
      m4_pix_num <= (im_h_pix * m4_vad) + {6'd0, had_1d};
    end


    // qb_i_1d, m4_h_im_posi  3bit
    always @(posedge clk) begin
      qb_i_1d <= qb_i;
      m4_h_im_posi <= qb_i_1d;
    end

    // im_vad_1d, m4_v_im_posi  3bit
    always @(posedge clk) begin
      im_vad_1d <= im_vad;
      m4_v_im_posi <= im_vad_1d;
    end


    // qd  3bitカウンタ (M4 coeff. select timing カウンタ)
    always @(posedge clk) begin
      if(cf_sel_cnt_rst1 | cf_sel_cnt_rst2 | cf_sel_cnt_rst3 | cf_sel_cnt_rst4)
        qd <= 0;
      else if(~qd_stop)
        qd <= qd + 1;
    end

    // m4_cf_sel  3bit
    assign m4_cf_sel = qd;

    // qd_stop
    assign qd_stop = qd[2];  // 4


    // fm_m4_cf_rd_adrs  19bit
    assign fm_m4_cf_rd_adrs = {m4_v_im_posi[1:0], m4_h_im_posi[1:0], m4_pix_num, m4_cf_sel};


// Frame memory read M4 coeff. data 入力ラッチ

    // cf01_latch, cf23_latch, cf45_latch, cf67_latch, cf8_latch, cf_da_latch, cf_latch
    always @(posedge clk) begin
      cf01_latch <= (cf01_tim1 | cf01_tim2 | cf01_tim3 | cf01_tim4) &
                     fm_iv_rd_cycle & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle;
      cf23_latch <= (cf23_tim1 | cf23_tim2 | cf23_tim3 | cf23_tim4) &
                     fm_iv_rd_cycle & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle;
      cf45_latch <= (cf45_tim1 | cf45_tim2 | cf45_tim3 | cf45_tim4) &
                     fm_iv_rd_cycle & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle;
      cf67_latch <= (cf67_tim1 | cf67_tim2 | cf67_tim3 | cf67_tim4) &
                     fm_iv_rd_cycle & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle;
      cf8_latch  <= (cf8_tim1 | cf8_tim2 | cf8_tim3 | cf8_tim4) &
                     fm_iv_rd_cycle & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle;
      cf_1st_latch <= (cf01_tim2 | cf01_tim3 | cf01_tim4 | cf01_tim5) &
                       fm_iv_rd_cycle & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle;
      cf_latch   <= (cf_tim1 | cf_tim2 | cf_tim3 | cf_tim4) &
                     fm_iv_rd_cycle & ~fm_iv_wr_cycle & ~fm_ov_rd_cycle;
    end

    // cf0_da, cf1_da  13bit
    always @(posedge clk) begin
      if(cf01_latch) begin
        cf0_da <= fm_rd_d[12:0];
        cf1_da <= fm_rd_d[28:16];
      end
    end

    // cf2_da, cf3_da  13bit
    always @(posedge clk) begin
      if(cf23_latch) begin
        cf2_da <= fm_rd_d[12:0];
        cf3_da <= fm_rd_d[28:16];
      end
    end

    // cf4_da, cf5_da  13bit
    always @(posedge clk) begin
      if(cf45_latch) begin
        cf4_da <= fm_rd_d[12:0];
        cf5_da <= fm_rd_d[28:16];
      end
    end

    // cf6_da, cf7_da  13bit
    always @(posedge clk) begin
      if(cf67_latch) begin
        cf6_da <= fm_rd_d[12:0];
        cf7_da <= fm_rd_d[28:16];
      end
    end

    // cf8  13bit
    always @(posedge clk) begin
      if(cf8_latch)
        cf8_da <= fm_rd_d[12:0];
    end

    // cf0_db -- cf8_db  13bit
    always @(posedge clk) begin
      if(cf_1st_latch) begin
        cf0_db <= cf0_da;
        cf1_db <= cf1_da;
        cf2_db <= cf2_da;
        cf3_db <= cf3_da;
        cf4_db <= cf4_da;
        cf5_db <= cf5_da;
        cf6_db <= cf6_da;
        cf7_db <= cf7_da;
        cf8_db <= cf8_da;
      end
    end

    // cf0d -- cf8d  13bit
    always @(posedge clk) begin
      if(cf_latch) begin
        cf0d <= cf0_db;
        cf1d <= cf1_db;
        cf2d <= cf2_db;
        cf3d <= cf3_db;
        cf4d <= cf4_db;
        cf5d <= cf5_db;
        cf6d <= cf6_db;
        cf7d <= cf7_db;
        cf8d <= cf8_db;
      end
    end

endmodule
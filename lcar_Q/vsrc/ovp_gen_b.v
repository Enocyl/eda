`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// ovp generator
//
// 2015.07 作成
// 2017.10 修正 50Hz入力で入力が切れた時の残画像表示問題対策
//              カウンタqbの入力 qb_stop を削除
// 2017.12 変更 名称ovp_gen_aをovp_gen_bに変更
//              over_vp出力追加
//

module ovp_gen_b (f50hz, rx_ok, rx_vp, clk,
                  ovp, frame_alt, adv_int_vp, rx_vp_sel, over_vp);

    input f50hz;
    input rx_ok;
    input rx_vp;
    input clk;             // 125MHz

    output reg ovp;        // 入力有 : rx_vp, 無入力 : 内部発生 vp
    //output ovp;        		// Hasco 2021.09
    output reg frame_alt;
    output adv_int_vp;
    output rx_vp_sel;
    output reg over_vp;

    reg [10:0] qa;
    reg qa_last_1d;
    reg qa_f59_vtp, qa_f50_vtp, qa_vtp;
    reg [11:0] qb;
    reg qb_f59_vt, qb_f50_vt, qb_vt;
    // reg qb_f59_1p2vt;
    reg qb_f50_1p2vt, qb_1p2vt;
    reg qb_f59_ovr_vt, qb_f50_ovr_vt, qb_ovr_vt;
    reg int_vp, int_1p2vp, intval_over_vp;
    reg int_1p2vtim;

    wire qa_last;
    wire qb_stop;
    wire sel_vp, ovp_a, ovp_b;


// 内部 vp (int_vp) 作成

    // qa  11bitカウンタ (1024分周)
    always @(posedge clk) begin
      if(ovp_a | qa_last)
        qa <= 11'd1;
      else
        qa <= qa + 1;
    end

    // qa_last
    assign qa_last = qa[10];  // 1024

    // qa_last_1d
    always @(posedge clk) begin
      qa_last_1d <= qa_last;
    end

    // qa_f59_vtp, qa_f50_vtp, qa_vtp
    always @(posedge clk) begin
      qa_f59_vtp <= (qa == 11'd550);
      qa_f50_vtp <= (qa == 11'd414);
      qa_vtp <= f50hz ? qa_f50_vtp : qa_f59_vtp;
    end


    // qb  12bitカウンタ (0 -- 2036 or 2441)
    always @(posedge clk) begin
      if(ovp_a)
        qb <= 0;
 //   else if(qa_last & ~qb_stop)
      else if(qa_last)              // 2017.10
        qb <= qb + 1;
    end

    // qb_stop
 // assign qb_stop = qb[11] & qb[10];  // 3072,  2017.10

    // qb_f59_vt, qb_f50_vt, qb_vt
    always @(posedge clk) begin
      qb_f59_vt <= (qb == 12'd2036);
      qb_f50_vt <= (qb == 12'd2441);
      qb_vt <= f50hz ? qb_f50_vt : qb_f59_vt;
    end

    // qb_f59_1p2vt, qb_f50_1p2vt, qb_1p2vt
    always @(posedge clk) begin
      // qb_f59_1p2vt <= (qb == 12'd1017);
      qb_f50_1p2vt <= (qb == 12'd1220);
      // qb_1p2vt <= f50hz ? qb_f50_1p2vt : qb_f59_1p2vt;
      qb_1p2vt <= qb_f50_1p2vt;
    end

    // qb_f59_ovr_vt, qb_f50_ovr_vt, qb_ovr_vt
    always @(posedge clk) begin
      qb_f59_ovr_vt <= (qb == 12'd2092);
      qb_f50_ovr_vt <= (qb == 12'd2516);
      qb_ovr_vt <= f50hz ? qb_f50_ovr_vt : qb_f59_ovr_vt;
    end


    // int_vp, int_1p2vp, intval_over_vp, over_vp
    always @(posedge clk) begin
      int_vp <= qa_vtp & qb_vt;
      int_1p2vp <= qa_last_1d & qb_1p2vt;
      intval_over_vp <= qa_last_1d & qb_ovr_vt;
      over_vp <= intval_over_vp;                 // 2017.12
    end

    // adv_int_vp
    assign adv_int_vp = int_vp;


    // int_1p2vtim
    always @(posedge clk) begin
      if(ovp_a)
        int_1p2vtim <= 1'b1;
      else if(int_1p2vp)
        int_1p2vtim <= 1'b0;
    end


// ovp, frame_alt 出力

    // rx_vp_sel
    assign rx_vp_sel = rx_ok;

    // sel_vp, ovp_a, ovp_b
    assign sel_vp = rx_vp_sel ? rx_vp : int_vp;
    assign ovp_a = sel_vp | intval_over_vp;
    //assign ovp_b = ovp_a & ~int_1p2vtim;
    assign ovp_b = sel_vp;

	reg[1:0] qc;									//Hasco 2021.09
	always @(posedge clk) begin
		if(~rx_ok | qc_endp)
			qc <= 0;
		else if(ovp_b)
			qc <= qc + 1;						
			//qc <= ~qc;						//frame rate 60/2=30HZ
	end

	wire qc_endp = (qc == 2) & ovp_b;			//frame rate 60/4=21HZ

	reg ovp_c;								
    // ovp_c
    always @(posedge clk) begin				//Hasco 2021.09
      ovp <= ovp_b;
      //ovp_c <= ovp_b;
    end
											//Hasco 2021.09
	//wire ovp = ovp_c & ~(|qc);				//enable per 3th ovp  

    // frame_alt
    always @(posedge clk) begin
      if(ovp)
        frame_alt <= ~frame_alt;
    end

endmodule
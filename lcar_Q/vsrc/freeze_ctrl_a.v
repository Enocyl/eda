`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// freeze control

module freeze_ctrl_a (c_done, sel_port_chngp, ovp, clk,
                      pac_stp, rxd, rx_ok,
                      freeze, frame_alt_frz);

    input c_done;
    input sel_port_chngp;
    input ovp;
    input clk;             // 125MHz
    input pac_stp;
    input [7:0] rxd;
    input rx_ok;

    output freeze;
    output reg frame_alt_frz;

    reg [2:0] qa;
    reg [10:0] pac_cnt;
    reg [11:0] pac_intval_cnt;
    reg pac_intval_cnt_stop_1d, pac_intval_cnt_stop_2d;
    reg pac_loss_a_p;
    reg [2:0] vst_cnt;
    reg pac0_hd1_tp, pac0_hd2_tp, pac0_hd3_tp;
    reg [7:0] rx_pac_num0_low;
    reg [10:0] rx_pac_num0;
    reg pac_num0_err_p;
    reg pac_err;
    reg pac_err_1d;
    reg pac_err_p;

    wire pac_cnt_stop;
    wire pac_intval_cnt_stop;
    wire vst_cnt_stop;


// packet loss 検出

    // pac_cnt  11bitカウンタ
    always @(posedge clk) begin
      if(ovp)
        pac_cnt <= 0;
      else if(pac_stp & ~pac_cnt_stop)
        pac_cnt <= pac_cnt + 1;
    end

    // pac_cnt_stop
    assign pac_cnt_stop = (pac_cnt >= 11'd1040);


    // pac_intval_cnt  11bitカウンタ
    always @(posedge clk) begin
      if(pac_stp)
        pac_intval_cnt <= 0;
      else if(~pac_intval_cnt_stop)
        pac_intval_cnt <= pac_intval_cnt + 1;
    end

    // pac_intval_cnt_stop
    assign pac_intval_cnt_stop = pac_intval_cnt[10] & pac_intval_cnt[11];  // 3072


    // pac_intval_cnt_stop_1d, pac_intval_cnt_stop_2d
    always @(posedge clk) begin
      pac_intval_cnt_stop_1d <= pac_intval_cnt_stop;
      pac_intval_cnt_stop_2d <= pac_intval_cnt_stop_1d;
    end

    // pac_loss_a_p
    always @(posedge clk) begin
      pac_loss_a_p <= pac_intval_cnt_stop_1d & ~pac_intval_cnt_stop_2d & ~pac_cnt_stop;
    end


    // vst_cnt  3bitカウンタ
    always @(posedge clk) begin
      if(ovp)
        vst_cnt <= 0;
      else if(~vst_cnt_stop)
        vst_cnt <= vst_cnt + 1;
    end

    // vst_cnt_stop
    assign vst_cnt_stop = vst_cnt[2];  // 4


    // pac0_hd1_tp, pac0_hd2_tp, pac0_hd3_tp
    always @(posedge clk) begin
      pac0_hd1_tp <= (vst_cnt == 3'd3);
      pac0_hd2_tp <= pac0_hd1_tp;
      pac0_hd3_tp <= pac0_hd2_tp;
    end


    // rx_pac_num0_low  8bit
    always @(posedge clk) begin
      if(pac0_hd1_tp)
        rx_pac_num0_low <= rxd;
    end

    // rx_pac_num0  11bit
    always @(posedge clk) begin
      if(pac0_hd2_tp)
        rx_pac_num0 <= {rxd[2:0], rx_pac_num0_low};
    end

    // pac_num0_err_p
    always @(posedge clk) begin
      pac_num0_err_p <= pac0_hd3_tp & (rx_pac_num0 != 11'd0);
    end


    // pac_err
    always @(posedge clk) begin
      if(ovp)
        pac_err <= 1'b0;
      else if(pac_loss_a_p | pac_num0_err_p)
        pac_err <= 1'b1;
    end

    // pac_err_1d
    always @(posedge clk) begin
      pac_err_1d <= pac_err;
    end

    // pac_err_p
    always @(posedge clk) begin
      pac_err_p <= pac_err & ~pac_err_1d & rx_ok;
      //pac_err_p <= 0;	//Hasco 2021.10
    end


 
// frame_alt_frz 作成

    // qa  3bitカウンタ (freeze期間設定)
    always @(posedge clk) begin
      if(~c_done)
        qa <= 3'd0;
      else if(sel_port_chngp | pac_err_p)
        qa <= 3'd6;           // MSB=1
      else if(ovp & freeze)
        qa <= qa + 1;
    end

    // freeze
    //assign freeze = qa[2];
    assign freeze = 0;


    // frame_alt_frz
    always @(posedge clk) begin
      if(ovp & ~freeze)
        frame_alt_frz <= ~frame_alt_frz;
    end

endmodule
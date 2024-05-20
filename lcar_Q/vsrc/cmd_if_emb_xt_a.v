`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// Serial communication command for EMB
//
// サブモジュール
//   sens_temp_convert  (温度データのスケール変換)
//   sens_power_convert (電源電圧データのスケール変換) 
//

module cmd_if_emb_xt_a (sensor_port_sel, clk, rst, frame_alt,
                   cmd_rx_req, rcv_ok, rx_cmd_data,
                   // cmd_tx_done,
                   ext_cmd_tx_req, ext_cmd_data,
                   rx_timeout_set,
                   pwr_ena, temp_ena, humid_ena,
                   sdi_fan_on, sdi_fan_cmd_ena,
                   fan_set_ena,

                   cmd_tx_req, tx_timeout, tx_cmd_data,
                   power1, power2, power3, power4, power5,
                   power6, power7, power8, power9,
                   temperature1, temperature2,
                   humidity1, humidity2,
                   rsp_rx_req, rsp_data,
                   emb_baud_rate,
                   tp_out, sens_num);

    input [ 1:0] sensor_port_sel;
    input clk, rst, frame_alt;
    input cmd_rx_req, rcv_ok;
    input [79:0] rx_cmd_data;
    // input cmd_tx_done;
    input ext_cmd_tx_req;
    input [79:0] ext_cmd_data;
    input [ 6:0] rx_timeout_set;
    input [ 9:1] pwr_ena;
    input [ 2:1] temp_ena;
    input [ 2:1] humid_ena;
    input sdi_fan_on, sdi_fan_cmd_ena;
    input fan_set_ena;

    output reg cmd_tx_req;
    output tx_timeout;
    output reg [79:0] tx_cmd_data;
    output [15:0] power1, power2, power3, power4, power5;
    output [15:0] power6, power7, power8, power9;
    output [15:0] temperature1, temperature2;
    output [15:0] humidity1, humidity2;
    output reg rsp_rx_req;
    output reg [79:0] rsp_data;
    output reg [ 1:0] emb_baud_rate;
    output [ 7:0] tp_out;
    output reg [ 3:0] sens_num;

    reg [ 7:0] power1_port, power2_port, power3_port, power4_port, power5_port;
    reg [ 7:0] power6_port, power7_port, power8_port, power9_port;
    reg [ 7:0] temp1_channel, temp2_channel, temp1_sensor, temp2_sensor;
    reg [ 7:0] humid1_channel, humid2_channel, humid1_sensor, humid2_sensor;
    reg [17:0] sens_cycle_qa;
    reg [10:0] sens_cycle_qb;
    reg [ 4:0] sens_cycle_qc;
    reg sens_cycle_start_ena_1d;
    reg sens_power_up;
    reg [ 3:0] tp_qa;
    reg sdi_fan_cmd_tp, ext_cmd_tp, sens_tp;
    reg sdi_fan_cmd_wait, ext_cmd_wait, sens_wait;
    reg sdi_fan_cmd_comm_busy, ext_cmd_comm_busy, sens_comm_busy;
    // reg rx_wait_time;
    reg [17:0] rx_to_qa;
    reg [ 7:0] rx_to_qb;
    reg [ 6:0] rx_to_qc;
    reg rx_timeout_1d;
    reg rx_timeout_tp;
    reg [14:0] rx_req_dly_q;
    reg rx_req_dly_q_b14_1d;
    reg com_rx_req_dlyp;
    reg [17:0] tx_to_qa;
    reg [10:0] tx_to_qb;
    reg [ 4:0] tx_to_qc;
    reg [15:0] dec_prmtr;
    reg sens_rx_req_ok;
    reg [ 3:0] sens_num_d;
    reg [11:0] temp1_doa, temp2_doa;
    reg [ 9:0] pwr1_doa, pwr2_doa, pwr3_doa, pwr4_doa, pwr5_doa;
    reg [ 9:0] pwr6_doa, pwr7_doa, pwr8_doa, pwr9_doa;
    // reg [ 5:0] sens_rx_last_qa;
    // reg sens_rx_last_qa5b_1d;
    // reg [11:0] temp1_dob, temp2_dob;
    // reg [ 9:0] pwr1_dob, pwr2_dob, pwr3_dob, pwr4_dob, pwr5_dob;
    // reg [ 9:0] pwr6_dob, pwr7_dob, pwr8_dob, pwr9_dob;
    reg frame_alt_1d, frame_alt_2d;
    reg pwr1_sens_on, pwr2_sens_on, pwr3_sens_on, pwr4_sens_on, pwr5_sens_on;
    reg pwr6_sens_on, pwr7_sens_on, pwr8_sens_on, pwr9_sens_on;
    reg temp1_sens_on, temp2_sens_on;
    reg pwr1_sens_on_vt, pwr2_sens_on_vt, pwr3_sens_on_vt, pwr4_sens_on_vt, pwr5_sens_on_vt;
    reg pwr6_sens_on_vt, pwr7_sens_on_vt, pwr8_sens_on_vt, pwr9_sens_on_vt;
    reg temp1_sens_on_vt, temp2_sens_on_vt;
    reg [11:0] temp1_do, temp2_do;
    reg [ 9:0] pwr1_do, pwr2_do, pwr3_do, pwr4_do, pwr5_do;
    reg [ 9:0] pwr6_do, pwr7_do, pwr8_do, pwr9_do;
    // reg emb_det_a, emb_det_b, emb_det;
    // reg pwr_sens_on_a;
    // reg pwr_sens_on;
    reg ext_cmd_rx_det;
    reg rsp_rx_req_a;
    reg sdi_fan_on_1d, sdi_fan_on_2d;
    reg ext_cmd_fan_set, ext_cmd_fan_mode;
    reg baud_rate_set_ena;

    wire rst;
    wire sens_cycle_startp;
    wire sens_cycle_start_ena;
    wire sens_cycle_start_tp;
    // wire sens_cycle_start_tp_a;
    wire sens_rx_req;
    wire sens_num_eq0, sens_num_lt13, sens_num_eq13, sens_num_eq14;
    // wire sens_rx_req_last;
    wire sens_tx_req;
    wire sdi_fan_cmd_tx_startp, ext_cmd_tx_startp, sens_tx_startp;
    wire comm_busy;
    wire rx_to_cnt_ena;
    wire rx_timeout;
    wire comm_endp;
    wire comm_end_dlyp;
    wire tx_to_cnt_rst;
    wire tx_to_1ms_p;
    wire tx_to_qb_end;
    wire tx_to_1s_p;
    wire [55:0] tx_sens_cmd_prmtr;
    wire [ 3:0] dec_p3, dec_p2, dec_p1, dec_p0;
    wire [11:0] temp_cnvt_do;
    wire temp_cnvt_done;
    wire [ 9:0] pwr_cnvt_do;
    wire pwr_cnvt_done;
    wire pwr1_rx_ena, pwr2_rx_ena, pwr3_rx_ena, pwr4_rx_ena, pwr5_rx_ena;
    wire pwr6_rx_ena, pwr7_rx_ena, pwr8_rx_ena, pwr9_rx_ena;
    wire temp1_rx_ena, temp2_rx_ena;
    wire pwr1_cnvt_done, pwr2_cnvt_done, pwr3_cnvt_done, pwr4_cnvt_done, pwr5_cnvt_done;
    wire pwr6_cnvt_done, pwr7_cnvt_done, pwr8_cnvt_done, pwr9_cnvt_done;
    wire temp1_cnvt_done, temp2_cnvt_done;
    // wire sens_rx_last_tp;
    wire vp;
    wire pwr1_comm_time, pwr2_comm_time, pwr3_comm_time, pwr4_comm_time, pwr5_comm_time;
    wire pwr6_comm_time, pwr7_comm_time, pwr8_comm_time, pwr9_comm_time;
    wire temp1_comm_time, temp2_comm_time;
    wire sdi_fan_cmd_tx_req;
    wire [ 7:0] fan_mode;
    wire [55:0] fan_ctrl_cmd;


 // パラメータ設定部

    // power1_port -- power9_port  8bit  (Power Sensor port)
    always @(posedge clk) begin
      case (sensor_port_sel)
        2'h0: begin     // NPC mode
                power1_port <= 8'h30;  // Sensor port 0
                power2_port <= 8'h31;  // Sensor port 1
                power3_port <= 8'h32;  // Sensor port 2
                power4_port <= 8'h33;  // Sensor port 3
                power5_port <= 8'h34;  // Sensor port 4
                power6_port <= 8'h35;  // Sensor port 5
                power7_port <= 8'h36;  // Sensor port 6
                power8_port <= 8'h37;  // Sensor port 7
                power9_port <= 8'h38;  // Sensor port 8
                temp1_channel <= 8'h31;  // I2C channel 1
                temp1_sensor  <= 8'h30;  // I2C address 0
                temp2_channel <= 8'h30;  // On Board
                temp2_sensor  <= 8'h46;  // Sensor port F
                humid1_channel <= 8'h30;  // On Board (Dummy)
                humid1_sensor  <= 8'h36;  // Sensor port 6 (Dummy)
                humid2_channel <= 8'h30;  // On Board (Dummy)
                humid2_sensor  <= 8'h36;  // Sensor port 6 (Dummy)
              end
        2'h1: begin     //  Nasdaq mode
                power1_port <= 8'h30;  // Sensor port 0
                power2_port <= 8'h31;  // Sensor port 1
                power3_port <= 8'h32;  // Sensor port 2
                power4_port <= 8'h33;  // Sensor port 3
                power5_port <= 8'h34;  // Sensor port 4
                power6_port <= 8'h35;  // Sensor port 5
                power7_port <= 8'h36;  // Sensor port 6
                power8_port <= 8'h37;  // Sensor port 7
                power9_port <= 8'h38;  // Sensor port 8
                temp1_channel <= 8'h30;  // On Board
                temp1_sensor  <= 8'h46;  // Sensor port F
                temp2_channel <= 8'h31;  // I2C channel 1
                temp2_sensor  <= 8'h30;  // I2C address 0
                humid1_channel <= 8'h30;  // On Board (Dummy)
                humid1_sensor  <= 8'h36;  // Sensor port 6 (Dummy)
                humid2_channel <= 8'h30;  // On Board (Dummy)
                humid2_sensor  <= 8'h36;  // Sensor port 6 (Dummy)
              end
       default: begin     // NPC mode
                power1_port <= 8'h30;  // Sensor port 0
                power2_port <= 8'h31;  // Sensor port 1
                power3_port <= 8'h32;  // Sensor port 2
                power4_port <= 8'h33;  // Sensor port 3
                power5_port <= 8'h34;  // Sensor port 4
                power6_port <= 8'h35;  // Sensor port 5
                power7_port <= 8'h36;  // Sensor port 6
                power8_port <= 8'h37;  // Sensor port 7
                power9_port <= 8'h38;  // Sensor port 8
                temp1_channel <= 8'h31;  // I2C channel 1
                temp1_sensor  <= 8'h30;  // I2C address 0
                temp2_channel <= 8'h30;  // On Board
                temp2_sensor  <= 8'h46;  // Sensor port F
                humid1_channel <= 8'h30;  // On Board (Dummy)
                humid1_sensor  <= 8'h36;  // Sensor port 6 (Dummy)
                humid2_channel <= 8'h30;  // On Board (Dummy)
                humid2_sensor  <= 8'h36;  // Sensor port 6 (Dummy)
              end
      endcase
    end


 // センサー読み出し周期設定カウンタ

    // sens_cycle_startp
    assign sens_cycle_startp = sens_tx_startp & sens_num_eq0;

    // sens_cycle_qa  18bitカウンタ  1ms周期作成
    always @(posedge clk) begin
      if((rst | sens_cycle_startp) | sens_cycle_qa[17])
        sens_cycle_qa <= 18'd59073;
      else if(~sens_cycle_start_ena)
        sens_cycle_qa <= sens_cycle_qa + 1;
    end

    // sens_cycle_qb  11bitカウンタ  1s周期作成
    always @(posedge clk) begin
      if((rst | sens_cycle_startp) | (sens_cycle_qa[17] & sens_cycle_qb[10]))
        sens_cycle_qb <= 11'd25;
      else if(sens_cycle_qa[17])
        sens_cycle_qb <= sens_cycle_qb + 1;
    end

    // sens_cycle_qc  5bitカウンタ  5s周期作成
    always @(posedge clk) begin
      if(rst | sens_cycle_startp)
        sens_cycle_qc <= rst ? 5'd15 : 5'd11;
      else if(sens_cycle_qa[17] & sens_cycle_qb[10])
        sens_cycle_qc <= sens_cycle_qc + 1;
    end

    // sens_cycle_start_ena
    assign sens_cycle_start_ena = sens_cycle_qc[4];


 // センサー読み出し要求パルス作成

    // sens_cycle_start_ena_1d
    always @(posedge clk) begin
      sens_cycle_start_ena_1d <= sens_cycle_start_ena;
    end

    // sens_cycle_start_tp
    assign sens_cycle_start_tp = sens_cycle_start_ena & ~sens_cycle_start_ena_1d;

    // sens_power_up
    always @(posedge clk) begin
      if(rst)
        sens_power_up <= 1'b0;
      else if(sens_cycle_start_tp)
        sens_power_up <= 1'b1;
    end

    // sens_cycle_start_tp_a
     // assign sens_cycle_start_tp_a = sens_cycle_start_tp & sens_power_up;

    // sens_rx_req
    assign sens_rx_req = sens_comm_busy & cmd_rx_req;


    // sens_num  4bitカウンタ  センサー順次選択用カウント値

    // always @(posedge clk) begin
    //   if(rst | (sens_cycle_start_tp & sens_num_eq14)
    //          | (sens_rx_req & sens_cycle_start_ena & sens_num_eq13 & rcv_ok)
    //          | (sens_comm_busy & rx_timeout_tp & ~sens_num_lt13))
    //     sens_num <= 4'd0;
    //   else if((sens_rx_req & rcv_ok & ~sens_num_eq14) | (sens_comm_busy & rx_timeout_tp))
    //     sens_num <= sens_num + 1;
    // end

    always @(posedge clk) begin
      if(rst | (sens_cycle_start_tp & sens_num_eq14)
             | (sens_rx_req & sens_cycle_start_ena & sens_num_eq13)
             | (sens_comm_busy & rx_timeout_tp & ~sens_num_lt13))
        sens_num <= 4'd0;
      else if((sens_rx_req & ~sens_num_eq14) | (sens_comm_busy & rx_timeout_tp))
        sens_num <= sens_num + 1;
    end


    // sens_num_eq0, sens_num_lt13, sens_num_eq13, sens_num_eq14
    assign sens_num_eq0  = (sens_num == 4'd0 );
    assign sens_num_lt13 = (sens_num <  4'd13);
    // assign sens_num_eq13 = (sens_num == 4'd13);
    assign sens_num_eq13 = (sens_num >= 4'd13);
    // assign sens_num_eq14 = (sens_num == 4'd14);
    assign sens_num_eq14 = (sens_num >= 4'd14);

    // sens_rx_req_last
     // assign sens_rx_req_last = sens_num_eq13 & sens_rx_req & rcv_ok;

    // sens_tx_req
    assign sens_tx_req =   (sens_cycle_start_tp & ~sens_power_up)
                         | (sens_cycle_start_tp & sens_num_eq14)
                         | (sens_rx_req & sens_num_lt13)
                         | (sens_rx_req & sens_cycle_start_ena & sens_num_eq13)
                         | (sens_comm_busy & rx_timeout_tp);


 // コマンド送信トリガー作成

    // tp_qa  4bitカウンタ  タイミングパルス作成用
    always @(posedge clk) begin
      if(rst)
        tp_qa <= 0;
      else
        tp_qa <= tp_qa + 1;
    end

    // sdi_fan_cmd_tp, ext_cmd_tp, sens_tp
    always @(posedge clk) begin
      sdi_fan_cmd_tp <= (tp_qa == 4'd1);
      ext_cmd_tp    <= (tp_qa == 4'd2);
      sens_tp       <= (tp_qa == 4'd3);
    end

    // sdi_fan_cmd_wait
    always @(posedge clk) begin
      if(rst | sdi_fan_cmd_tx_startp)
        sdi_fan_cmd_wait <= 1'b0;
      else if(sdi_fan_cmd_tx_req)
        sdi_fan_cmd_wait <= 1'b1;
    end

    // sdi_fan_cmd_tx_startp
    assign sdi_fan_cmd_tx_startp = sdi_fan_cmd_wait & sdi_fan_cmd_tp & ~comm_busy;

    // ext_cmd_wait
    always @(posedge clk) begin
      if(rst | ext_cmd_tx_startp)
        ext_cmd_wait <= 1'b0;
      else if(ext_cmd_tx_req)
        ext_cmd_wait <= 1'b1;
    end

    // ext_cmd_tx_startp
    assign ext_cmd_tx_startp = ext_cmd_wait & ext_cmd_tp & ~comm_busy & ~sdi_fan_cmd_wait;

    // sens_wait
    always @(posedge clk) begin
      if(rst | sens_tx_startp)
        sens_wait <= 1'b0;
      else if(sens_tx_req)
        sens_wait <= 1'b1;
    end

    // sens_tx_startp
    assign sens_tx_startp = sens_wait & sens_tp & ~comm_busy & ~sdi_fan_cmd_wait & ~ext_cmd_wait;

    // cmd_tx_req
    always @(posedge clk) begin
      cmd_tx_req <= sdi_fan_cmd_tx_startp | ext_cmd_tx_startp | sens_tx_startp;
    end

    // sdi_fan_cmd_comm_busy
    always @(posedge clk) begin
      if(rst | comm_end_dlyp)
        sdi_fan_cmd_comm_busy <= 1'b0;
      else if(sdi_fan_cmd_tx_startp)
        sdi_fan_cmd_comm_busy <= 1'b1;
    end

    // ext_cmd_comm_busy
    always @(posedge clk) begin
      if(rst | comm_end_dlyp)
        ext_cmd_comm_busy <= 1'b0;
      else if(ext_cmd_tx_startp)
        ext_cmd_comm_busy <= 1'b1;
    end

    // sens_comm_busy
    always @(posedge clk) begin
      if(rst | comm_end_dlyp)
        sens_comm_busy <= 1'b0;
      else if(sens_tx_startp)
        sens_comm_busy <= 1'b1;
    end

    // comm_busy
    assign comm_busy = sdi_fan_cmd_comm_busy | ext_cmd_comm_busy | sens_comm_busy;


 // コマンド受信タイムアウト検出

    // rx_wait_time
      // always @(posedge clk) begin
      //   if(rst | comm_endp)
      //     rx_wait_time <= 1'b0;
      //   else if(cmd_tx_done)
      //     rx_wait_time <= 1'b1;
      // end

    // rx_to_cnt_ena
    assign rx_to_cnt_ena = ~rst & comm_busy;

    // rx_to_qa  18bitカウンタ  1ms周期作成
    always @(posedge clk) begin
      if(~rx_to_cnt_ena | rx_to_qa[17])
        rx_to_qa <= 18'd59073;
      else if(~rx_timeout)
        rx_to_qa <= rx_to_qa + 1;
    end

    // rx_to_qb  8bitカウンタ  100ms周期作成
    always @(posedge clk) begin
      if(~rx_to_cnt_ena | (rx_to_qa[17] & rx_to_qb[7]))
        rx_to_qb <= 8'd29;
      else if(rx_to_qa[17])
        rx_to_qb <= rx_to_qb + 1;
    end

    // rx_to_qc  7bitカウンタ  タイムアウト設定値まで100msパルスをカウント
    always @(posedge clk) begin
      if(~rx_to_cnt_ena)
        rx_to_qc <= 0;
      else if(rx_to_qa[17] & rx_to_qb[7])
        rx_to_qc <= rx_to_qc + 1;
    end

    // rx_timeout
    assign rx_timeout = (rx_to_qc == rx_timeout_set);

    // rx_timeout_1d, rx_timeout_tp
    always @(posedge clk) begin
      rx_timeout_1d <= rx_timeout;
      rx_timeout_tp <= rx_timeout & ~rx_timeout_1d;
    end

    // comm_endp
    assign comm_endp = cmd_rx_req | rx_timeout_tp;

    // rx_req_dly_q  15bitカウンタ  cmd_rx_req遅延用(9600bpsの1.5周期分)
    always @(posedge clk) begin
      if(rst)
        rx_req_dly_q <= 0;
      else if(cmd_rx_req)
        rx_req_dly_q <= 15'h540e;  // 32768-11250=21518
      else if(rx_req_dly_q[14])
        rx_req_dly_q <= rx_req_dly_q + 1;
    end

    // rx_req_dly_q_b14_1d, com_rx_req_dlyp
    always @(posedge clk) begin
      rx_req_dly_q_b14_1d <= rx_req_dly_q[14];
      com_rx_req_dlyp <= ~rx_req_dly_q[14] & rx_req_dly_q_b14_1d;
    end

    // comm_end_dlyp
    assign comm_end_dlyp = com_rx_req_dlyp | rx_timeout_tp;


 // コマンド送信タイムアウト検出

    // tx_to_cnt_rst
    assign tx_to_cnt_rst = rst | cmd_tx_req;

    // tx_to_qa  18bitカウンタ  1ms周期作成
    always @(posedge clk) begin
      if(tx_to_cnt_rst | tx_to_1ms_p)
        tx_to_qa <= 18'd59073;
      else if(~tx_timeout)
        tx_to_qa <= tx_to_qa + 1;
    end

    // tx_to_1ms_p
    assign tx_to_1ms_p = tx_to_qa[17];  // 131072

    // tx_to_qb  11bitカウンタ  1s周期作成
    always @(posedge clk) begin
      if(tx_to_cnt_rst | tx_to_1s_p)
        tx_to_qb <= 11'd25;
      else if(tx_to_1ms_p)
        tx_to_qb <= tx_to_qb + 1;
    end

    // tx_to_qb_end
    assign tx_to_qb_end = tx_to_qb[10];  // 1024

    // tx_to_1s_p
    assign tx_to_1s_p = tx_to_qb_end & tx_to_1ms_p;

    // tx_to_qc  5bitカウンタ  タイムアウト作成(10s)
    always @(posedge clk) begin
      if(tx_to_cnt_rst)
        tx_to_qc <= 5'd6;
      else if(tx_to_1s_p)
        tx_to_qc <= tx_to_qc + 1;
    end

    // tx_timeout
    assign tx_timeout = tx_to_qc[4];  // 16


 // センサー読み出しコマンド 選択出力

    // tx_sens_cmd_prmtr  56bit 
    function [55:0] tx_sens_cmd_prmtr_sel;
    input [3:0] sel;
      case(sel)
                                      // {Command, P5, P4, P3, P2, P1, P0};  8'h30 : ASCII Code '0'
        4'h0   : tx_sens_cmd_prmtr_sel = fan_ctrl_cmd;                       // Fan Control command
        4'h1   : tx_sens_cmd_prmtr_sel = {8'h73, {5{8'h30}}, power1_port};   // Power 1 Read command
        4'h2   : tx_sens_cmd_prmtr_sel = {8'h73, {5{8'h30}}, power2_port};   // Power 2 Read command
        4'h3   : tx_sens_cmd_prmtr_sel = {8'h73, {5{8'h30}}, power3_port};   // Power 3 Read command
        4'h4   : tx_sens_cmd_prmtr_sel = {8'h73, {5{8'h30}}, power4_port};   // Power 4 Read command
        4'h5   : tx_sens_cmd_prmtr_sel = {8'h73, {5{8'h30}}, power5_port};   // Power 5 Read command
        4'h6   : tx_sens_cmd_prmtr_sel = {8'h73, {5{8'h30}}, power6_port};   // Power 6 Read command
        4'h7   : tx_sens_cmd_prmtr_sel = {8'h73, {5{8'h30}}, power7_port};   // Power 7 Read command
        4'h8   : tx_sens_cmd_prmtr_sel = {8'h73, {5{8'h30}}, power8_port};   // Power 8 Read command
        4'h9   : tx_sens_cmd_prmtr_sel = {8'h73, {5{8'h30}}, power9_port};   // Power 9 Read command
        4'ha   : tx_sens_cmd_prmtr_sel = {8'h74, temp1_channel, {4{8'h30}}, temp1_sensor};  // Temp. 1 Read
        4'hb   : tx_sens_cmd_prmtr_sel = {8'h74, temp2_channel, {4{8'h30}}, temp2_sensor};  // Temp. 2 Read
        4'hc   : tx_sens_cmd_prmtr_sel = {8'h74, humid1_channel, {4{8'h30}}, humid1_sensor};  // Humid. 1 Read (dummy)
        4'hd   : tx_sens_cmd_prmtr_sel = {8'h74, humid2_channel, {4{8'h30}}, humid2_sensor};  // Humid. 2 Read (dummy)
        default: tx_sens_cmd_prmtr_sel = 56'd0;
      endcase
    endfunction

    assign tx_sens_cmd_prmtr = tx_sens_cmd_prmtr_sel(sens_num);

    // tx_cmd_data  80bit
    always @(posedge clk) begin
      case ({sdi_fan_cmd_comm_busy, ext_cmd_comm_busy})
        2'h0: tx_cmd_data <= {8'h45, 8'h30, 8'h30, tx_sens_cmd_prmtr};  // TYP ("E"),  ADH ("0"),  ADV ("0")
        2'h1: tx_cmd_data <= ext_cmd_data;
        2'h2: tx_cmd_data <= {8'h45, 8'h30, 8'h30, fan_ctrl_cmd};
        2'h3: tx_cmd_data <= {8'h45, 8'h30, 8'h30, fan_ctrl_cmd};
      endcase
    end


 // センサー読み出しデータ ASCIIデコード

    // dec_p3, dec_p2, dec_p1, dec_p0  4bit
    function [3:0] ascii_dec;     // Convert from ASCII code to Binary value
    input [7:0] ascii;
      case(ascii)
        8'h30  : ascii_dec = 4'h0;
        8'h31  : ascii_dec = 4'h1;
        8'h32  : ascii_dec = 4'h2;
        8'h33  : ascii_dec = 4'h3;
        8'h34  : ascii_dec = 4'h4;
        8'h35  : ascii_dec = 4'h5;
        8'h36  : ascii_dec = 4'h6;
        8'h37  : ascii_dec = 4'h7;
        8'h38  : ascii_dec = 4'h8;
        8'h39  : ascii_dec = 4'h9;
        8'h41  : ascii_dec = 4'ha;
        8'h61  : ascii_dec = 4'ha;
        8'h42  : ascii_dec = 4'hb;
        8'h62  : ascii_dec = 4'hb;
        8'h43  : ascii_dec = 4'hc;
        8'h63  : ascii_dec = 4'hc;
        8'h44  : ascii_dec = 4'hd;
        8'h64  : ascii_dec = 4'hd;
        8'h45  : ascii_dec = 4'he;
        8'h65  : ascii_dec = 4'he;
        8'h46  : ascii_dec = 4'hf;
        8'h66  : ascii_dec = 4'hf;
        default: ascii_dec = 4'h0;
      endcase
    endfunction

    assign dec_p0 = ascii_dec(rx_cmd_data[ 7: 0]);
    assign dec_p1 = ascii_dec(rx_cmd_data[15: 8]);
    assign dec_p2 = ascii_dec(rx_cmd_data[23:16]);
    assign dec_p3 = ascii_dec(rx_cmd_data[31:24]);

    // dec_prmtr  16bit
    always @(posedge clk) begin
      dec_prmtr <= {dec_p3, dec_p2, dec_p1, dec_p0};
    end


 // センサー読み出しデータ スケール変換 選択出力

    // sens_rx_req_ok
    always @(posedge clk) begin
      sens_rx_req_ok <= cmd_rx_req & sens_comm_busy & rcv_ok;
    end

    // sens_num_d  4bit
    always @(posedge clk) begin
      if(cmd_rx_req & sens_comm_busy & rcv_ok)
        sens_num_d <= sens_num;
    end

    // サブモジュール sens_power_convert (電源電圧データのスケール変換)
    sens_power_convert  sens_power_convert_0(
      .pwr_din        (dec_prmtr),        // 16bit データ入力
      .data_startp    (sens_rx_req_ok),   // データ取込みパルス
      .rst            (rst),
      .clk            (clk),

      .pwr_dout       (pwr_cnvt_do),      // 10bit データ出力
      .calc_done      (pwr_cnvt_done)     // 出力データラッチ用パルス
    );

    // サブモジュール sens_temp_convert  (温度データのスケール変換)
    sens_temp_convert  sens_temp_convert_0(
      .temp_din       (dec_prmtr),        // 16bit データ入力
      .data_startp    (sens_rx_req_ok),   // データ取込みパルス
      .rst            (rst),
      .clk            (clk),

      .temp_dout      (temp_cnvt_do),     // 12bit データ出力
      .calc_done      (temp_cnvt_done)    // 出力データラッチ用パルス
    );

    // pwr1_rx_ena -- temp2_rx_ena  センサー出力選択用信号
    assign pwr1_rx_ena  = (sens_num_d == 4'd1);
    assign pwr2_rx_ena  = (sens_num_d == 4'd2);
    assign pwr3_rx_ena  = (sens_num_d == 4'd3);
    assign pwr4_rx_ena  = (sens_num_d == 4'd4);
    assign pwr5_rx_ena  = (sens_num_d == 4'd5);
    assign pwr6_rx_ena  = (sens_num_d == 4'd6);
    assign pwr7_rx_ena  = (sens_num_d == 4'd7);
    assign pwr8_rx_ena  = (sens_num_d == 4'd8);
    assign pwr9_rx_ena  = (sens_num_d == 4'd9);
    assign temp1_rx_ena = (sens_num_d == 4'd10);
    assign temp2_rx_ena = (sens_num_d == 4'd11);

    // pwr1_cnvt_done -- temp2_cnvt_done  センサーごとの出力データラッチ信号
    assign pwr1_cnvt_done  = pwr_cnvt_done & pwr1_rx_ena;
    assign pwr2_cnvt_done  = pwr_cnvt_done & pwr2_rx_ena;
    assign pwr3_cnvt_done  = pwr_cnvt_done & pwr3_rx_ena;
    assign pwr4_cnvt_done  = pwr_cnvt_done & pwr4_rx_ena;
    assign pwr5_cnvt_done  = pwr_cnvt_done & pwr5_rx_ena;
    assign pwr6_cnvt_done  = pwr_cnvt_done & pwr6_rx_ena;
    assign pwr7_cnvt_done  = pwr_cnvt_done & pwr7_rx_ena;
    assign pwr8_cnvt_done  = pwr_cnvt_done & pwr8_rx_ena;
    assign pwr9_cnvt_done  = pwr_cnvt_done & pwr9_rx_ena;
    assign temp1_cnvt_done = temp_cnvt_done & temp1_rx_ena;
    assign temp2_cnvt_done = temp_cnvt_done & temp2_rx_ena;

    // pwr1_doa  10bit  スケール変換出力
    always @(posedge clk) begin
      if(pwr1_cnvt_done)
        pwr1_doa <= pwr_cnvt_do;
    end

    // pwr2_doa  10bit  スケール変換出力
    always @(posedge clk) begin
      if(pwr2_cnvt_done)
        pwr2_doa <= pwr_cnvt_do;
    end

    // pwr3_doa  10bit  スケール変換出力
    always @(posedge clk) begin
      if(pwr3_cnvt_done)
        pwr3_doa <= pwr_cnvt_do;
    end

    // pwr4_doa  10bit  スケール変換出力
    always @(posedge clk) begin
      if(pwr4_cnvt_done)
        pwr4_doa <= pwr_cnvt_do;
    end

    // pwr5_doa  10bit  スケール変換出力
    always @(posedge clk) begin
      if(pwr5_cnvt_done)
        pwr5_doa <= pwr_cnvt_do;
    end

    // pwr6_doa  10bit  スケール変換出力
    always @(posedge clk) begin
      if(pwr6_cnvt_done)
        pwr6_doa <= pwr_cnvt_do;
    end

    // pwr7_doa  10bit  スケール変換出力
    always @(posedge clk) begin
      if(pwr7_cnvt_done)
        pwr7_doa <= pwr_cnvt_do;
    end

    // pwr8_doa  10bit  スケール変換出力
    always @(posedge clk) begin
      if(pwr8_cnvt_done)
        pwr8_doa <= pwr_cnvt_do;
    end

    // pwr9_doa  10bit  スケール変換出力
    always @(posedge clk) begin
      if(pwr9_cnvt_done)
        pwr9_doa <= pwr_cnvt_do;
    end

    // temp1_doa  12bit  スケール変換出力
    always @(posedge clk) begin
      if(temp1_cnvt_done)
        temp1_doa <= temp_cnvt_do;
    end

    // temp2_doa  12bit  スケール変換出力
    always @(posedge clk) begin
      if(temp2_cnvt_done)
        temp2_doa <= temp_cnvt_do;
    end

    // sens_rx_last_qa  6bitカウンタ  センサー出力更新タイミング作成用
     // always @(posedge clk) begin
     //   if(rst | sens_rx_req_last)
     //     sens_rx_last_qa <= {sens_rx_req_last, 5'h00};
     //   else if(sens_rx_last_qa[5])
     //     sens_rx_last_qa <= sens_rx_last_qa + 1;
     // end

    // sens_rx_last_qa5b_1d
     // always @(posedge clk) begin
     //   sens_rx_last_qa5b_1d <= sens_rx_last_qa[5];
     // end

    // sens_rx_last_tp  センサー出力更新タイミングパルス
     // assign sens_rx_last_tp = ~sens_rx_last_qa[5] & sens_rx_last_qa5b_1d;

    // pwr1_dob -- pwr9_dob  10bit,  temp1_dob, temp2_dob  12bit  更新タイミング統一化出力
     // always @(posedge clk) begin
     //   if(sens_rx_last_tp) begin
     //     pwr1_dob  <= pwr1_doa;
     //     pwr2_dob  <= pwr2_doa;
     //     pwr3_dob  <= pwr3_doa;
     //     pwr4_dob  <= pwr4_doa;
     //     pwr5_dob  <= pwr5_doa;
     //     pwr6_dob  <= pwr6_doa;
     //     pwr7_dob  <= pwr7_doa;
     //     pwr8_dob  <= pwr8_doa;
     //     pwr9_dob  <= pwr9_doa;
     //     temp1_dob <= temp1_doa;
     //     temp2_dob <= temp2_doa;
     //   end
     // end

    // frame_alt_1d, frame_alt_2d
    always @(posedge clk) begin
      frame_alt_1d <= frame_alt;
      frame_alt_2d <= frame_alt_1d;
    end

    // vp  V同期パルス
    assign vp = frame_alt_1d ^ frame_alt_2d;

    // pwr1_comm_time -- temp2_comm_time  センサー選択
    assign pwr1_comm_time  = (sens_num == 4'd1);
    assign pwr2_comm_time  = (sens_num == 4'd2);
    assign pwr3_comm_time  = (sens_num == 4'd3);
    assign pwr4_comm_time  = (sens_num == 4'd4);
    assign pwr5_comm_time  = (sens_num == 4'd5);
    assign pwr6_comm_time  = (sens_num == 4'd6);
    assign pwr7_comm_time  = (sens_num == 4'd7);
    assign pwr8_comm_time  = (sens_num == 4'd8);
    assign pwr9_comm_time  = (sens_num == 4'd9);
    assign temp1_comm_time = (sens_num == 4'd10);
    assign temp2_comm_time = (sens_num == 4'd11);

    // pwr1_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & pwr1_comm_time))
        pwr1_sens_on <= 1'b0;
      else if(pwr1_cnvt_done)
        pwr1_sens_on <= 1'b1;
    end

    // pwr2_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & pwr2_comm_time))
        pwr2_sens_on <= 1'b0;
      else if(pwr2_cnvt_done)
        pwr2_sens_on <= 1'b1;
    end

    // pwr3_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & pwr3_comm_time))
        pwr3_sens_on <= 1'b0;
      else if(pwr3_cnvt_done)
        pwr3_sens_on <= 1'b1;
    end

    // pwr4_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & pwr4_comm_time))
        pwr4_sens_on <= 1'b0;
      else if(pwr4_cnvt_done)
        pwr4_sens_on <= 1'b1;
    end

    // pwr5_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & pwr5_comm_time))
        pwr5_sens_on <= 1'b0;
      else if(pwr5_cnvt_done)
        pwr5_sens_on <= 1'b1;
    end

    // pwr6_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & pwr6_comm_time))
        pwr6_sens_on <= 1'b0;
      else if(pwr6_cnvt_done)
        pwr6_sens_on <= 1'b1;
    end

    // pwr7_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & pwr7_comm_time))
        pwr7_sens_on <= 1'b0;
      else if(pwr7_cnvt_done)
        pwr7_sens_on <= 1'b1;
    end

    // pwr8_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & pwr8_comm_time))
        pwr8_sens_on <= 1'b0;
      else if(pwr8_cnvt_done)
        pwr8_sens_on <= 1'b1;
    end

    // pwr9_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & pwr9_comm_time))
        pwr9_sens_on <= 1'b0;
      else if(pwr9_cnvt_done)
        pwr9_sens_on <= 1'b1;
    end

    // temp1_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & temp1_comm_time))
        temp1_sens_on <= 1'b0;
      else if(temp1_cnvt_done)
        temp1_sens_on <= 1'b1;
    end

    // temp2_sens_on
    always @(posedge clk) begin
      if(rst | (sens_comm_busy & rx_timeout_tp & temp2_comm_time))
        temp2_sens_on <= 1'b0;
      else if(temp2_cnvt_done)
        temp2_sens_on <= 1'b1;
    end

    // pwr1_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        pwr1_sens_on_vt <= pwr1_sens_on;
    end

    // pwr2_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        pwr2_sens_on_vt <= pwr2_sens_on;
    end

    // pwr3_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        pwr3_sens_on_vt <= pwr3_sens_on;
    end

    // pwr4_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        pwr4_sens_on_vt <= pwr4_sens_on;
    end

    // pwr5_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        pwr5_sens_on_vt <= pwr5_sens_on;
    end

    // pwr6_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        pwr6_sens_on_vt <= pwr6_sens_on;
    end

    // pwr7_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        pwr7_sens_on_vt <= pwr7_sens_on;
    end

    // pwr8_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        pwr8_sens_on_vt <= pwr8_sens_on;
    end

    // pwr9_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        pwr9_sens_on_vt <= pwr9_sens_on;
    end

    // temp1_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        temp1_sens_on_vt <= temp1_sens_on;
    end

    // temp2_sens_on_vt
    always @(posedge clk) begin
      if(vp)
        temp2_sens_on_vt <= temp2_sens_on;
    end

    // pwr1_do -- pwr9_do  10bit,  temp1_do, temp2_do  12bit  更新タイミングV同期化出力
    always @(posedge clk) begin
      if(vp) begin
        pwr1_do  <= pwr1_sens_on ? pwr1_doa : 10'd0;
        pwr2_do  <= pwr2_sens_on ? pwr2_doa : 10'd0;
        pwr3_do  <= pwr3_sens_on ? pwr3_doa : 10'd0;
        pwr4_do  <= pwr4_sens_on ? pwr4_doa : 10'd0;
        pwr5_do  <= pwr5_sens_on ? pwr5_doa : 10'd0;
        pwr6_do  <= pwr6_sens_on ? pwr6_doa : 10'd0;
        pwr7_do  <= pwr7_sens_on ? pwr7_doa : 10'd0;
        pwr8_do  <= pwr8_sens_on ? pwr8_doa : 10'd0;
        pwr9_do  <= pwr9_sens_on ? pwr9_doa : 10'd0;
        temp1_do <= temp1_sens_on ? temp1_doa : 12'd0;
        temp2_do <= temp2_sens_on ? temp2_doa : 12'd0;
      end
    end


 // EMB接続有無検出, データ出力

    // pwr_sens_on_a
     // always @(posedge clk) begin
     //   if(rst)
     //     pwr_sens_on_a <= 1'b0;
     //   else if(sens_rx_last_tp | sens_cycle_start_tp_a)
     //     pwr_sens_on_a <= 1'b1;
     // end

    // pwr_sens_on     Power出力データ用センサー有無ビット
    //                 電源ONから一定時間後,常に 1 にする
    //                 LCM processor で Panel からのレスポンスの有無検出に使用するため 
     // always @(posedge clk) begin
     //   if(rst)
     //     pwr_sens_on <= 1'b0;
     //   else if(vp)
     //     pwr_sens_on <= 1'b1;
     // end

    // emb_det_a
     // always @(posedge clk) begin
     //   if(rst | (sens_comm_busy & rx_timeout_tp))
     //     emb_det_a <= 1'b0;
     //   else if(sens_comm_busy & cmd_rx_req & rcv_ok)
     //     emb_det_a <= 1'b1;
     // end

    // emb_det_b
     // always @(posedge clk) begin
     //   if(rst)
     //     emb_det_b <= 1'b0;
     //   else if(sens_rx_last_tp)
     //     emb_det_b <= emb_det_a;
     // end

    // emb_det     Temperature出力データ用センサー有無ビット
    //             EMB の接続有無(応答有無)を検出
     // always @(posedge clk) begin
     //   if(rst)
     //     emb_det <= 1'b0;
     //   else if(vp)
     //     emb_det <= emb_det_b;
     // end

    // power1 -- power9, temperature1, temperature2, humidity1, humidity2  16bit  SDIリターン信号用データ出力
    assign power1 = pwr_ena[1] ? {pwr1_sens_on_vt, 5'h00, pwr1_do} : 16'd0;
    assign power2 = pwr_ena[2] ? {pwr2_sens_on_vt, 5'h00, pwr2_do} : 16'd0;
    assign power3 = pwr_ena[3] ? {pwr3_sens_on_vt, 5'h00, pwr3_do} : 16'd0;
    assign power4 = pwr_ena[4] ? {pwr4_sens_on_vt, 5'h00, pwr4_do} : 16'd0;
    assign power5 = pwr_ena[5] ? {pwr5_sens_on_vt, 5'h00, pwr5_do} : 16'd0;
    assign power6 = pwr_ena[6] ? {pwr6_sens_on_vt, 5'h00, pwr6_do} : 16'd0;
    assign power7 = pwr_ena[7] ? {pwr7_sens_on_vt, 5'h00, pwr7_do} : 16'd0;
    assign power8 = pwr_ena[8] ? {pwr8_sens_on_vt, 5'h00, pwr8_do} : 16'd0;
    assign power9 = pwr_ena[9] ? {pwr9_sens_on_vt, 5'h00, pwr9_do} : 16'd0;
    assign temperature1 = temp_ena[1] ? {temp1_sens_on_vt, 3'h0, temp1_do} : 16'd0;
    assign temperature2 = temp_ena[2] ? {temp2_sens_on_vt, 3'h0, temp2_do} : 16'd0;
    assign humidity1 = humid_ena[1] ? {temp1_sens_on_vt, 15'd0} : 16'd0;
    assign humidity2 = humid_ena[2] ? {temp2_sens_on_vt, 15'd0} : 16'd0;


 // 外部コマンドへのレスポンスデータ出力

    // ext_cmd_rx_det     0の場合はNAKを返す
    always @(posedge clk) begin
      if(rst | (ext_cmd_comm_busy & rx_timeout_tp))
        ext_cmd_rx_det <= 1'b0;
      else if(ext_cmd_comm_busy & cmd_rx_req)
        ext_cmd_rx_det <= 1'b1;
    end

    // rsp_rx_req_a, rsp_rx_req
    always @(posedge clk) begin
      rsp_rx_req_a <= (ext_cmd_comm_busy & rx_timeout_tp) | (ext_cmd_comm_busy & cmd_rx_req);
      rsp_rx_req   <= rsp_rx_req_a;
    end

    // rsp_data  80bit  レスポンスデータ出力
    always @(posedge clk) begin
      if(rsp_rx_req_a)
        rsp_data <= ext_cmd_rx_det ? rx_cmd_data
                                   : {ext_cmd_data[79:48], 8'h15, {5{8'h30}}};  // NAK
    end


 // SDI信号からの fan on/off コマンド入力

    // sdi_fan_on_1d, sdi_fan_on_2d
    always @(posedge clk) begin
      sdi_fan_on_1d <= sdi_fan_on;
      sdi_fan_on_2d <= sdi_fan_on_1d;
    end

    // sdi_fan_cmd_tx_req
    assign sdi_fan_cmd_tx_req = (sdi_fan_on_1d ^ sdi_fan_on_2d) & sdi_fan_cmd_ena;

    // fan_mode  8bit
    assign fan_mode = (sdi_fan_on_1d | ~sdi_fan_cmd_ena) ? 8'h30   // '0' Normal Speed mode
                                                       : 8'h45;  // 'E' Fan stop mode

 // RS-232C からの Fan Speed Set コマンド受信検出

    // ext_cmd_fan_set  Fan Speed Set コマンド受信検出パルス
    always @(posedge clk) begin
      ext_cmd_fan_set <= (ext_cmd_data[79:72] == 8'h45)  // 'E' Header Type
                       & (ext_cmd_data[55:48] == 8'h46)  // 'F' Command
                       & ( rx_cmd_data[47:40] == 8'h06)  // 'ACK'
                       & ext_cmd_comm_busy
                       & cmd_rx_req
                       & rcv_ok;
    end

    // ext_cmd_fan_mode     Fan Speed Set コマンド受信検出後, 常に'1'
    always @(posedge clk) begin
      if(rst)
        ext_cmd_fan_mode <= 1'b0;
      else if(ext_cmd_fan_set)
        ext_cmd_fan_mode <= 1'b1;
    end

 // fan_ctrl_cmd 選択

    // fan_ctrl_cmd  56bit
    assign fan_ctrl_cmd = (ext_cmd_fan_mode | ~fan_set_ena) ? {8'h66, {6{8'h30}}} // 'f' Fan Speed Read command
                                                : {8'h46, {5{8'h30}}, fan_mode};  // 'F' Fan Speed Set command


 // Baud Rate 設定

    // baud_rate_set_ena  Baud Rate 設定イネーブル
    always @(posedge clk) begin
      baud_rate_set_ena <= (ext_cmd_data[79:72] == 8'h45)  // 'E' Header Type
                         & (ext_cmd_data[55:48] == 8'h55)  // 'U' Command
                         & (ext_cmd_data[47:40] == 8'h30)  // '0' P5
                         & (ext_cmd_data[ 7: 4] == 4'h3 )  // '3' P0 MSB side
                         & (ext_cmd_data[ 3: 0] <  4'h3 )  // '0-2' P0 LSB side
                         & ( rx_cmd_data[47:40] == 8'h06)  // 'ACK'
                         & ext_cmd_comm_busy
                         & cmd_rx_req
                         & rcv_ok;
    end

    // emb_baud_rate  2bit  Baud Rate 設定出力
    always @(posedge clk) begin
      if(rst)
        emb_baud_rate <= 2'h0;
      else if(baud_rate_set_ena)
        emb_baud_rate <= ext_cmd_data[1:0];
    end


 // 動作チェック用出力

    // tp_out  8bit
    assign tp_out = {sens_cycle_start_ena,   // tp_out[7]
                     rx_timeout,             // tp_out[6]
                     sens_wait,              // tp_out[5]
                     sens_num_eq0,           // tp_out[4]
                     sens_num_eq14,          // tp_out[3]
                     sens_comm_busy,         // tp_out[2]
                     comm_busy,              // tp_out[1]
                     comm_endp};             // tp_out[0]

endmodule
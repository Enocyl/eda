`timescale 1ns / 1ns
// `default_nettype none

// MPC-II for Nasdaq
// EMB����̓d���d���f�[�^��
// LCM processor �ւ̃��^�[���f�[�^�t�H�[�}�b�g�֕ϊ�
//
// �T�u���W���[��
//   div_22b_12b_int
//   (���Z�� 22bit / 12bit ���̐���) 

module sens_power_convert(pwr_din, data_startp, rst, clk,
                          pwr_dout, calc_done);

    input  [15:0] pwr_din;
    input  data_startp, rst, clk;

    output [ 9:0] pwr_dout;
    output        calc_done;

    reg [11:0] pwr_limit;
    reg [21:0] pwr_x;
    reg data_startp_1d, data_startp_2d;
    reg calc_busy_1d;

    wire [21:0] doa;
    wire calc_busy;


    // pwr_limit  12bit  16bit���̓f�[�^��12'hf00(12'd3840)�ȉ��ɐ���
    always @(posedge clk) begin
      pwr_limit <= (pwr_din > 16'h0f00) ? 12'hf00 : pwr_din[11:0];
    end

    // pwr_x  22bit  (pwr_limit * 1023) = (pwr_limit * 1024 - pwr_limit)
    always @(posedge clk) begin
      pwr_x <= {pwr_limit, 10'h000} + {10'h3ff, ~pwr_limit} + 22'd1;
    end

    // data_startp_1d, data_startp_2d
    always @(posedge clk) begin
      data_startp_1d <= data_startp;
      data_startp_2d <= data_startp_1d;
    end


// �T�u���W���[�� div_22b_12b_int  (���Z�� 22bit / 12bit ���̐���)

    div_22b_12b_int  div_22b_12b_int_0(
      .z                 (pwr_x),          // 22bit �폜��
      .d                 (12'hf00),        // 12bit ���� (12'd3840)
      .startp            (data_startp_2d), // �X�^�[�g�p���X
      .rst               (rst),            // ���Z�b�g
      .clk               (clk),            // �N���b�N

      .q                 (doa),            // 22bit ��
      .r                 (),               // 12bit �]
      .busy              (calc_busy)       // �v�Z��
    );


    // pwr_dout  10bit  �o�̓f�[�^
    assign pwr_dout = doa[9:0];


    // calc_busy_1d
    always @(posedge clk) begin
      calc_busy_1d <= calc_busy;
    end

    // calc_done
    assign calc_done = ~calc_busy & calc_busy_1d;

endmodule
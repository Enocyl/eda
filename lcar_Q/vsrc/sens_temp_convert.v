`timescale 1ns / 1ns
// `default_nettype none

// MPC-II for Nasdaq
// EMB����̉��x�f�[�^��
// LCM processor �ւ̃��^�[���f�[�^�t�H�[�}�b�g�֕ϊ�
//
// �T�u���W���[��
//   div_28b_16b_int
//   (���Z�� 28bit / 16bit ���̐���) 

module sens_temp_convert(temp_din, data_startp, rst, clk,
                         temp_dout, calc_done);

    input  [15:0] temp_din;
    input  data_startp, rst, clk;

    output [11:0] temp_dout;
    output        calc_done;

    reg [15:0] dinb;
    reg [27:0] dinc;
    reg data_startp_1d, data_startp_2d;
    reg calc_busy_1d;

    wire [16:0] dina;
    wire over_temp;
    wire [27:0] doa;
    wire calc_busy;


    // dina  17bit  ���̓f�[�^ 2'c �� STB �ɕϊ��� 18688 ������(16'hb700 ����)
    assign dina = {~temp_din[15], temp_din[14:0]} + 16'hb700;

    // over_temp  +125degC ���I�[�o�[
    assign over_temp = (dina[15:0] > 16'd46080);

    // dinb  16bit  OF/UF (-55degC -- +125degC)
    always @(posedge clk) begin
      case ({dina[16], over_temp})
        2'h0: dinb <= 16'd0;
        2'h1: dinb <= 16'd0;
        2'h2: dinb <= dina[15:0];
        2'h3: dinb <= 16'd46080;
      endcase
    end

    // dinc  28bit  (dinb * 4095) = (dinb * 4096 - dinb)
    always @(posedge clk) begin
      dinc <= {dinb, 12'h000} + {12'hfff, ~dinb} + 28'd1;
    end

    // data_startp_1d, data_startp_2d
    always @(posedge clk) begin
      data_startp_1d <= data_startp;
      data_startp_2d <= data_startp_1d;
    end


// �T�u���W���[�� div_28b_16b_int  (���Z�� 28bit / 16bit ���̐���)

    div_28b_16b_int  div_28b_16b_int_0(
      .z                 (dinc),           // 28bit �폜��
      .d                 (16'hb400),       // 16bit ���� (16'd46080)
      .startp            (data_startp_2d), // �X�^�[�g�p���X
      .rst               (rst),            // ���Z�b�g
      .clk               (clk),            // �N���b�N

      .q                 (doa),            // 28bit ��
      .r                 (),               // 16bit �]
      .busy              (calc_busy)       // �v�Z��
    );


    // temp_dout  12bit  �o�̓f�[�^
    assign temp_dout = doa[11:0];


    // calc_busy_1d
    always @(posedge clk) begin
      calc_busy_1d <= calc_busy;
    end

    // calc_done
    assign calc_done = ~calc_busy & calc_busy_1d;

endmodule
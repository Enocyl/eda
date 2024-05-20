`timescale 1ns / 1ns
// `default_nettype none

// MPC-II
// ���Z 28bit/16bit ���̐���
//
//  z / d = q .. r
//

module div_28b_16b_int(
    z      ,  // �폜��
    d      ,  // ����
    startp ,  // �X�^�[�g�p���X
    clk    ,  // �N���b�N
    rst    ,  // ���Z�b�g

    q      ,  // ��
    r      ,  // �]
    busy   ); // �v�Z��

    input  [27:0]  z      ;
    input  [15:0]  d      ;
    input          startp ;
    input          clk    ;
    input          rst    ;

    output [27:0]  q      ;
    output [15:0]  r      ;
    output         busy   ;

    reg    [ 4:0]  i      ;
    reg    [43:0]  zr     ;
    reg    [15:0]  dr     ;

    wire           en_seq ;
    wire   [16:0]  pr     ;
    wire   [16:0]  sb     ;
    wire           pq     ;
    wire   [15:0]  mx     ;
    wire   [43:0]  zw     ;


 // sequence (�V�[�P���T)

    // en_seq
    assign en_seq = (i > 0);

    // i  5bit
    always @(posedge clk) begin
      if(rst)
        i <= 5'h00;
      else if(startp)
        i <= 5'h1c;
      else if(en_seq)
        i <= i - 1'b1;
    end


 // function (���Z������)

    // pr  17bit  �O�T�C�N���̃V�t�g�A�b�v�ςݕ����]
    assign pr = zr[43:27];

    // sb  17bit  �����] - ����
    assign sb = pr - {1'b0, dr};

    // pq         ���Z���ʂ̕����𔽓]���������Ƃ���
    assign pq = ~sb[16];

    // mx  16bit  ���Z�O�ƌ�����Z���ʂɂ��I��
    assign mx = (sb[16]) ? pr[15:0] : sb[15:0];

    // zw  44bit  ���T�C�N���pzr���W�X�^���e
    assign zw = {mx, zr[26:0], pq};

    // zr  44bit  �폜��,��,�] �i�[���W�X�^
    always @(posedge clk) begin
      if(startp)
        zr <= {16'h0000, z};
      else if(en_seq)
        zr <= zw;
    end

    // dr  16bit  ���� �i�[���W�X�^
    always @(posedge clk) begin
      if(startp)
        dr <= d;
    end

    // q  ��  28bit
    assign q = zr[27:0];

    // r  �]  16bit
    assign r = zr[43:28];

    // busy  �v�Z��
    assign busy = en_seq;

endmodule
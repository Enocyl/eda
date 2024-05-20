`timescale 1ns / 1ns
// `default_nettype none

// MPC-II
// ���Z 22bit/12bit ���̐���
//
//  z / d = q .. r
//

module div_22b_12b_int(
    z      ,  // �폜��
    d      ,  // ����
    startp ,  // �X�^�[�g�p���X
    clk    ,  // �N���b�N
    rst    ,  // ���Z�b�g

    q      ,  // ��
    r      ,  // �]
    busy   ); // �v�Z��

    input  [21:0]  z      ;
    input  [11:0]  d      ;
    input          startp ;
    input          clk    ;
    input          rst    ;

    output [21:0]  q      ;
    output [11:0]  r      ;
    output         busy   ;

    reg    [ 4:0]  i      ;
    reg    [33:0]  zr     ;
    reg    [11:0]  dr     ;

    wire           en_seq ;
    wire   [12:0]  pr     ;
    wire   [12:0]  sb     ;
    wire           pq     ;
    wire   [11:0]  mx     ;
    wire   [33:0]  zw     ;


 // sequence (�V�[�P���T)

    // en_seq
    assign en_seq = (i > 0);

    // i  5bit
    always @(posedge clk) begin
      if(rst)
        i <= 5'h00;
      else if(startp)
        i <= 5'h16;
      else if(en_seq)
        i <= i - 1'b1;
    end


 // function (���Z������)

    // pr  13bit  �O�T�C�N���̃V�t�g�A�b�v�ςݕ����]
    assign pr = zr[33:21];

    // sb  13bit  �����] - ����
    assign sb = pr - {1'b0, dr};

    // pq         ���Z���ʂ̕����𔽓]���������Ƃ���
    assign pq = ~sb[12];

    // mx  12bit  ���Z�O�ƌ�����Z���ʂɂ��I��
    assign mx = (sb[12]) ? pr[11:0] : sb[11:0];

    // zw  34bit  ���T�C�N���pzr���W�X�^���e
    assign zw = {mx, zr[20:0], pq};

    // zr  34bit  �폜��,��,�] �i�[���W�X�^
    always @(posedge clk) begin
      if(startp)
        zr <= {12'h000, z};
      else if(en_seq)
        zr <= zw;
    end

    // dr  12bit  ���� �i�[���W�X�^
    always @(posedge clk) begin
      if(startp)
        dr <= d;
    end

    // q  ��
    assign q = zr[21:0];

    // r  �]
    assign r = zr[33:22];

    // busy  �v�Z��
    assign busy = en_seq;

endmodule
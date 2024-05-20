`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board for XT
//
// Version表示 LED 制御 (電源立ち上げ時にLD1,2でVersionを表示)
//   LD1 : 8bitタイミング表示(8回点滅)
//   LD2 : Version No. (小数点以上,以下ともに1桁で各4bitで表示
//         LD1 の点灯に合わせて、小数点以上のMSB側から"1"は点灯,"0"は消灯する) 
//
// DIPSW2操作(OFF=>ON)による IM Download 時の表示
//   LD1 & LD2 : IM Download 中は消灯
//               終了時ERRORがなかった場合はLD1とLD2が同時に2回点滅する
//               ERRORがあった場合は5秒間,LD1とLD2が交互に点滅する
//               (ただしDIPSW2がONの場合はOFFに戻されるまで点滅を続ける)
//

module version_disp_xt(ver, frame_alt, c_done, clk,
                       dsw_im_download_on, im_download_exe_tim,
                       im_err_det, dipsw2_on,
                       ver_disp, ex_disp, ld1_on, ld2_on);

    input [7:0] ver;
    input frame_alt, c_done, clk;
    input dsw_im_download_on, im_download_exe_tim;
    input im_err_det, dipsw2_on;

    output ver_disp, ex_disp, ld1_on, ld2_on;

    reg frame_alt1, frame_alt2, vp;
    reg [4:0] qa, qb, qc;
    reg im_dl_on1d, im_dl_on2d;
    reg im_dl_exe1d, im_dl_exe2d;
    reg im_dl_tim;
    reg blink_tim;
    reg [4:0] qd, qe;
    reg blink_5sec;
    reg dipsw2_on_a;

    wire start_n;
    wire cntp;
    wire s_ver;
    wire ld1on_n_a, ld2on_n_a;
    wire im_dl_endp, im_dl_tim_set, im_dl_tim_rst;
    wire im_download_tim;
    wire blink_tp;
    wire tim_5sec;
    wire blink_stop;


// Version表示

    // frame_alt1, frame_alt2, vp
    always @(posedge clk) begin
      frame_alt1 <= frame_alt;
      frame_alt2 <= frame_alt1;
      vp <= frame_alt1 ^ frame_alt2;
    end

    // qa  5bitカウンタ
    always @(posedge clk) begin
      if(~c_done)
        qa <= 0;
      else if(vp & ~qa[4])
        qa <= qa + 1;
    end

    // start_n
    assign start_n = ~(qa[4] & c_done);

    // qb  5bitカウンタ
    always @(posedge clk) begin
      if(start_n | cntp)
        qb <= 5'h05;
      else if(vp & ~qc[4])
        qb <= qb + 1;
    end

    // cntp
    assign cntp = vp & qb[4];

    // qc  5bitカウンタ
    always @(posedge clk) begin
      if(start_n)
        qc <= 0;
      else if(cntp)
        qc <= qc + 1;
    end

    // ver_disp
    assign ver_disp = ~qc[4];

    // s_ver
    function s_ver_sel;
    input [2:0] sel;
      case(sel)
        3'h0: s_ver_sel = ver[7];
        3'h1: s_ver_sel = ver[6];
        3'h2: s_ver_sel = ver[5];
        3'h3: s_ver_sel = ver[4];
        3'h4: s_ver_sel = ver[3];
        3'h5: s_ver_sel = ver[2];
        3'h6: s_ver_sel = ver[1];
        3'h7: s_ver_sel = ver[0];
      endcase
    endfunction

    assign s_ver = s_ver_sel(qc[3:1]);

    // ld1on_n_a, ld2on_n_a
    assign ld1on_n_a = ~(~start_n & ~qc[0] & ~qc[4]);
    assign ld2on_n_a = ~(~ld1on_n_a & s_ver);


// DIPSW操作による IM Download 時の表示

    // im_dl_exe1d, im_dl_exe2d
    always @(posedge clk) begin
      im_dl_exe1d <= im_download_exe_tim;
      im_dl_exe2d <= im_dl_exe1d;
    end

    // im_dl_endp
    assign im_dl_endp = ~im_dl_exe1d & im_dl_exe2d;

    // im_dl_tim_rst
    assign im_dl_tim_rst = im_dl_endp | ver_disp;

    // im_dl_on1d, im_dl_on2d
    always @(posedge clk) begin
      im_dl_on1d <= dsw_im_download_on;
      im_dl_on2d <= im_dl_on1d;
    end

    // im_dl_tim_set
    assign im_dl_tim_set = im_dl_on1d & ~im_dl_on2d & ~im_dl_tim_rst;

    // im_dl_tim
    always @(posedge clk) begin
      if(im_dl_tim_rst)
        im_dl_tim <= 1'b0;
      else if(im_dl_tim_set)
        im_dl_tim <= 1'b1;
    end

    // im_download_tim
    assign im_download_tim = im_dl_tim | dsw_im_download_on;

    // blink_tim
    always @(posedge clk) begin
      if(im_dl_tim_set | ver_disp | blink_stop)
        blink_tim <= 1'b0;
      else if(im_dl_endp & im_dl_tim)
        blink_tim <= 1'b1;
    end

    // ex_disp
    assign ex_disp = im_download_tim | blink_tim | ver_disp;

    // qd  5bitカウンタ
    always @(posedge clk) begin
      if(~blink_tim | blink_tp)
        qd <= 5'h04;
      else if(vp)
        qd <= qd + 1;
    end

    // blink_tp
    assign blink_tp = vp & qd[4];

    // qe  5bitカウンタ
    always @(posedge clk) begin
      if(~blink_tim)
        qe <= 0;
      else if(blink_tp)
        qe <= qe + 1;
    end

    // tim_5sec
    assign tim_5sec = im_err_det ? (qe == 5'h17) : (qe == 5'h07);

    // blink_5sec
    always @(posedge clk) begin
      if(~blink_tim)
        blink_5sec <= 1'b0;
      else if(tim_5sec & blink_tp & blink_tim)
        blink_5sec <= 1'b1;
    end

    // dipsw2_on_a
    always @(posedge clk) begin
      if(vp)
        dipsw2_on_a <= dipsw2_on;
    end

    // blink_stop
    assign blink_stop = blink_5sec & ~(dipsw2_on_a & im_err_det);

    // ld1_on
    assign ld1_on = ~(ver_disp ? ld1on_n_a : (im_download_tim | qe[0] | qe[2]));

    // ld2_on
    assign ld2_on = ~(ver_disp ? ld2on_n_a : (im_download_tim | qe[0] | (qe[2] ^ im_err_det)));

endmodule
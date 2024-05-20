`timescale 1ns / 1ns
`default_nettype none

// MPC
// DCM用リセット信号作成

module dcm_rst_mpc(locked, clkin_stop, f59hz, c_done, ovp, clk,
                   dcm_rst);

    input locked, clkin_stop, f59hz, c_done, ovp, clk;

    output dcm_rst;

    reg locked1, locked2, locked3, locked4;
    reg f59hz1, f59hz2;
    reg [3:0] qa, qb;

    wire unlk_startp, f59_change, unlk_16vp;

    // locked1, locked2, locked3, locked4
    always @(posedge clk) begin
      locked1 <= locked;
      locked2 <= locked1;
      locked3 <= locked1 | locked2;
      locked4 <= locked3;
    end

    // unlk_startp
    assign unlk_startp = ~locked3 & locked4;

    // f59hz1, f59hz2
    always @(posedge clk) begin
      f59hz1 <= f59hz;
      f59hz2 <= f59hz1;
    end

    // f59_change
    assign f59_change = f59hz1 ^ f59hz2;

    // qa  4bitカウンタ
    always @(posedge clk) begin
      if(~c_done | locked)
        qa <= 0;
      else if(ovp)
        qa <= qa + 1;
    end

    // unlk_16vp
    assign unlk_16vp = (qa == 4'hf) & ovp;

    // qb  4bitカウンタ
    always @(posedge clk) begin
      if(unlk_startp | clkin_stop | f59_change | unlk_16vp)
        qb <= 0;
      else if(~qb[3])
        qb <= qb + 1;
    end

    // dcm_rst
    assign dcm_rst = ~qb[3] |  clkin_stop;

endmodule
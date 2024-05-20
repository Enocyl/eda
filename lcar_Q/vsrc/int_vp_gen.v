`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// Internal VP gen.

module int_ovp_gen (f50hz, clk,
                    vp);

    input f50hz;  // VP freq. select (1 : 50Hz, 0 : 59.94Hz)
    input clk;   // 25MHz

    output reg vp;  // 1clk width pulse

    reg [18:0] qa;

    wire cnt_rstp;


    // qa  19bitƒJƒEƒ“ƒ^
    always @(posedge clk) begin
      if(cnt_rstp)
        qa <= 0;
      else
        qa <= qa + 1;
    end

    // cnt_rstp
    assign cnt_rstp = f50hz ? (qa == 19'd499999) : (qa == 19'd417083);

    // vp
    always @(posedge clk) begin
      vp <= cnt_rstp;
    end

endmodule
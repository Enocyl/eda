`timescale 1ns / 1ns
// `default_nettype none

// MPC
// brightness
//
// 2017.04 brightness_mpc_b (3clk delay => 2clk delay)

module brightness_mpc_b(din, brightness, ovp, clk,
                        dout);

    input [15:0] din;
    input [6:0] brightness;
    input ovp, clk;

    output reg [15:0] dout;

    reg [15:0] din1;
    reg brt100pct;
    reg [16:0] brt;
    reg [17:0] dbrta;

    wire [32:0] dbrt;
    wire [16:0] dbrtb;
    wire [15:0] dbrtc;

    // din1  16bit
    always @(posedge clk) begin
      din1 <= din;
    end

    // brt100pct
    always @(posedge clk) begin
      if(ovp)
        brt100pct <= (brightness == 7'h64);
    end

    // brt  17bit
    always @(posedge clk) begin
      if(ovp)
        brt <= brightness * 10'h28f;  // d655
    end

    // dbrt  33bit
    assign dbrt = din * brt;

    // dbrta  18bit
    always @(posedge clk) begin
      dbrta <= dbrt[32:15];
    end

    // dbrtb  17bit
    assign dbrtb = dbrta[17:1] + {16'h0000, dbrta[0]};

    // dbrtc  16bit
    assign dbrtc = dbrtb[16] ? 16'hffff : dbrtb[15:0];

    // dout  16bit
    always @(posedge clk) begin
      dout <= brt100pct ? din1 : dbrtc;
    end

endmodule
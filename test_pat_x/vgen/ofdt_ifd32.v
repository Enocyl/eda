`timescale 1ns / 1ns
// `default_nettype none

// VCM Receiver
// 32bit ‘o•ûŒü“üo—Í “üo—Í‹¤‚ÉDFF—L‚è 

module ofdt_ifd32(dio,
                  dout_in, dout_tri, clk,
                  din_out);

    inout [31:0] dio;

    input [31:0] dout_in;
    input dout_tri;
    input clk;

    output reg [31:0] din_out;

    reg [31:0] dout_in1d;


  (* IOB = "TRUE" *)


    // dout_in1d  32bit
    always @(posedge clk) begin
      dout_in1d <= dout_in;
    end

    // dio  32bit
    assign dio = dout_tri ? 32'hzzzzzzzz : dout_in1d;

    // din_out  32bit
    always @(posedge clk) begin
      din_out <= dio;
    end

endmodule
`timescale 1ns / 1ns
// `default_nettype none

// Input Video セレクタ 30bit bus
// Panel Address 表示出力機能付き 

module in_video_mux (in_video, test_pat, test_on, pad_white, pad_black, backup, o);

    input [29:0] in_video, test_pat;  // [29:20]:red, [19:10]:green, [9:0]:blue
    input test_on;
    input pad_white;
    input pad_black;
    input backup;

    output [29:0] o;

    wire pad_wht, pad_red;


    assign pad_wht = pad_white & ~backup;

    assign pad_red = pad_white & backup;

    assign o = pad_black ? 30'h00000000 :
               pad_wht ? 30'h3fffffff :
               pad_red ? 30'h3ff00000 :
               test_on ? test_pat : in_video;

endmodule
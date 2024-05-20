`timescale 1ns / 1ns
// `default_nettype none

// 2:1ƒZƒŒƒNƒ^ 17bit bus 

module sel17(ia, ib, s, o);

    input [16:0] ia, ib;
    input s;

    output [16:0] o;


    assign o = s ? ib : ia;

endmodule
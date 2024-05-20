`timescale 1ns / 1ns
// //`default_nettype none

// 2:1ƒZƒŒƒNƒ^ 16bit bus 

module sel16(ia, ib, s, o);

    input [15:0] ia, ib;
    input s;

    output [15:0] o;


    assign o = s ? ib : ia;

endmodule
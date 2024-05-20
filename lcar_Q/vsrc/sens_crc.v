`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// Sensor (Si7020) —p CRC ‰‰ŽZ‰ñ˜H
//
/*
This module was made by modifying the module "hdsdi_crc".

This module does a 8-bit CRC calculation.

x^8 + x^5 + x^4 + 1

The clr input must be asserted coincident with the first input data word of
a new CRC calculation. The clr input forces the old CRC value stored in the
module's crc_reg to be discarded and a new calculation begins as if the old CRC
value had been cleared to zero.
*/


module  sens_crc (
    clk,    // clock input
    ce,     // clock enable
    rst,    // reset input
    clr,    // forces the old CRC value to zero to start new calculation
    d,      // input data word
    crc_out // new calculated CRC value
);


//-----------------------------------------------------------------------------
// Port definitions
//
input                   clk;
input                   ce;
input                   rst;
input                   clr;
input   [7:0]           d;
output  [7:0]           crc_out;


//-----------------------------------------------------------------------------
// Signal definitions
//
wire                    x8;
wire                    x7;
wire                    x6;
wire                    x5;
wire                    x4;
wire                    x3;
wire                    x2;
wire                    x1;
wire    [7:0]          newcrc;     // input to CRC register            
wire    [7:0]          crc;        // output of crc_reg, unless clr is asserted
reg     [7:0]          crc_reg;    // internal CRC register


//
// The previous CRC value is represented by the variable crc. This value is
// combined with the new data word to form the new CRC value. Normally, crc is
// equal to the contents of the crc_reg. However, if the clr input is asserted,
// the crc value is set to all zeros.
//
assign crc = clr ? 0 : crc_reg;

//
// The x variables are intermediate terms used in the new CRC calculation.
//                             
assign x8  = d[7] ^ crc[7];
assign x7  = d[6] ^ crc[6];
assign x6  = d[5] ^ crc[5];
assign x5  = d[4] ^ crc[4];
assign x4  = d[3] ^ crc[3];
assign x3  = d[2] ^ crc[2];
assign x2  = d[1] ^ crc[1];
assign x1  = d[0] ^ crc[0];

//
// These assignments generate the new CRC value.
//

assign newcrc[0] = x1 ^ x4 ^ x5 ^ x7;
assign newcrc[1] = x2 ^ x5 ^ x6 ^ x8;
assign newcrc[2] = x3 ^ x6 ^ x7;
assign newcrc[3] = x4 ^ x7 ^ x8;
assign newcrc[4] = x1 ^ x4 ^ x7 ^ x8;
assign newcrc[5] = x1 ^ x2 ^ x4 ^ x7 ^ x8;
assign newcrc[6] = x2 ^ x3 ^ x5 ^ x8;
assign newcrc[7] = x3 ^ x4 ^ x6;

//
// This is the crc_reg. On each clock cycle when ce is asserted, it loads the
// newcrc value. The module's crc_out vector is always assigned to the contents
// of the crc_reg.
//
always @ (posedge clk) begin
    if (rst)
        crc_reg <= 0;
    else if (ce)
        crc_reg <= newcrc;
end

assign crc_out = crc_reg;

endmodule

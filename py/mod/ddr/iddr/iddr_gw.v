//
//Written by GowinSynthesis
//Product Version "GowinSynthesis V1.9.8.05"
//Tue Aug 09 16:07:02 2022

//Source file index table:
//file0 "\D:/Gowin/Gowin_V1.9.8.05/IDE/ipcore/DDR/data/ddr.v"
`timescale 100 ps/100 ps
module IDDR_GW (
  din,
  clk,
  q
)
;
input [3:0] din;
input clk;
output [7:0] q;
wire VCC;
wire GND;
  IDDR \iddr_gen[0].iddr_inst  (
    .Q0(q[0]),
    .Q1(q[4]),
    .D(din[0]),
    .CLK(clk) 
);
  IDDR \iddr_gen[1].iddr_inst  (
    .Q0(q[1]),
    .Q1(q[5]),
    .D(din[1]),
    .CLK(clk) 
);
  IDDR \iddr_gen[2].iddr_inst  (
    .Q0(q[2]),
    .Q1(q[6]),
    .D(din[2]),
    .CLK(clk) 
);
  IDDR \iddr_gen[3].iddr_inst  (
    .Q0(q[3]),
    .Q1(q[7]),
    .D(din[3]),
    .CLK(clk) 
);
  VCC VCC_cZ (
    .V(VCC)
);
  GND GND_cZ (
    .G(GND)
);
  GSR GSR (
    .GSRI(VCC) 
);
endmodule /* IDDR_GW */

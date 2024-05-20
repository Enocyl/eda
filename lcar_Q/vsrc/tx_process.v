module tx_process(CLK25M, 
                  DST_IP, 
                  DST_MAC, 
                  DST_PORT, 
                  frame_alt, 
                  HUMID1, 
                  HUMID2, 
                  LINK_ON, 
                  POWER1, 
                  POWER2, 
                  RX_OK, 
                  SRC_IP, 
                  SRC_MAC, 
                  SRC_PORT, 
                  SS_NE, 
                  tcm_e, 
                  tcm_v, 
                  tcm_wd, 
                  TEMP1, 
                  TEMP2, 
                  TX_CLK, 
                  TXD, 
                  TX_EN);

    input CLK25M;
    input [31:0] DST_IP;
    input [47:0] DST_MAC;
    input [15:0] DST_PORT;
    input frame_alt;
    input [15:0] HUMID1;
    input [15:0] HUMID2;
    input LINK_ON;
    input [15:0] POWER1;
    input [15:0] POWER2;
    input RX_OK;
    input [31:0] SRC_IP;
    input [47:0] SRC_MAC;
    input [15:0] SRC_PORT;
    input SS_NE;
    input tcm_e;
    input tcm_v;
    input [7:0] tcm_wd;
    input [15:0] TEMP1;
    input [15:0] TEMP2;
    input TX_CLK;
   output [3:0] TXD;
   output TX_EN;
   
   wire L;
   wire [8:0] tcm_ra;
   wire [7:0] txd_in;
   wire txen_in;
   wire tx_done;
   
   rtn_mux_lcar_ru  rtn_mux_0 (.clk25M(CLK25M), 
                              .frame_alt(frame_alt), 
                              .humid1(HUMID1[15:0]), 
                              .humid2(HUMID2[15:0]), 
                              .link_on(LINK_ON), 
                              .power1(POWER1[15:0]), 
                              .power2(POWER2[15:0]), 
                              .rx_ok(RX_OK), 
                              .ss_ne(SS_NE), 
                              .tcm_e(tcm_e), 
                              .tcm_ra(tcm_ra[8:0]), 
                              .tcm_v(tcm_v), 
                              .tcm_wd(tcm_wd[7:0]), 
                              .temp1(TEMP1[15:0]), 
                              .temp2(TEMP2[15:0]), 
                              .tx_clk(TX_CLK), 
                              .tx_done(tx_done), 
                              .dout(txd_in[7:0]), 
                              .tx_en(txen_in), 
                              .tx_on());
   tx_mii_udp  tx_mii_udp_0 (.clk(TX_CLK), 
                            .c_done(LINK_ON), 
                            .dst_ip(DST_IP[31:0]), 
                            .dst_mac(DST_MAC[47:0]), 
                            .dst_port(DST_PORT[15:0]), 
                            .src_ip(SRC_IP[31:0]), 
                            .src_mac(SRC_MAC[47:0]), 
                            .src_port(SRC_PORT[15:0]), 
                            .txd_in(txd_in[7:0]), 
                            .txen_in(txen_in), 
                            .mii_txd(TXD[3:0]), 
                            .mii_txen(TX_EN), 
                            .tcm_ra(tcm_ra[8:0]), 
                            .tx_done(tx_done));
   GND  XLXI_80 (.G(L));
endmodule

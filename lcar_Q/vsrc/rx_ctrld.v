module rx_ctrld(CLK, 
                CMD_BRIGHTNESS, 
                CMD_CT_BLUE, 
                CMD_CT_GREEN, 
                CMD_CT_RED, 
                CMD_GAMMA, 
                CMD_M4_BANK1, 
                CMD_M4_ON, 
                CMD_TEST_PAD, 
                C_DONE, 
                DSW_PAD_UPDATE, 
                MEM_PAD, 
                MEM_PAD_ENA, 
                M4_SET_DONE, 
                PA_PAC_STP, 
                PA_RXD, 
                PA_RX_DV, 
                PA_RX_ER, 
                PA_RX_OK, 
                PA_RX50HZ, 
                PA_VP, 
                BRIGHTNESS, 
                COLOR_LOSS, 
                COLOR_LOSS_ON_N, 
                CTRLD_CSUM_OK, 
                CT_BLUE, 
                CT_GREEN, 
                CT_RED, 
                ER_UPDATE, 
                FRAME_ALT, 
                FRAME_ALT_FRZ, 
                FREEZE, 
                FR_RATE, 
                GAMMA, 
                HSTP, 
                H_SIZE, 
                M4_BANK1, 
                M4_BRT, 
                M4_ON, 
                OUT_CH, 
                OVP, 
                PAC_STP, 
                PAC1_OK, 
                PANEL_NUM, 
                PNL_ADRS_UPDATE, 
                REBOOT_N, 
                RXD, 
                RX_FAN_ON, 
                RX_IM_DOWNLOAD, 
                RX_OK, 
                RX50HZ, 
                TOTAL_PANEL, 
                UPDATE_ER_ON, 
                UPDATE_PNL_NUM, 
                VSTP, 
                V_SIZE);

    input CLK;
    input [6:0] CMD_BRIGHTNESS;
    input [3:0] CMD_CT_BLUE;
    input [3:0] CMD_CT_GREEN;
    input [3:0] CMD_CT_RED;
    input [2:0] CMD_GAMMA;
    input CMD_M4_BANK1;
    input CMD_M4_ON;
    input [7:0] CMD_TEST_PAD;
    input C_DONE;
    input DSW_PAD_UPDATE;
    input [9:0] MEM_PAD;
    input MEM_PAD_ENA;
    input M4_SET_DONE;
    input PA_PAC_STP;
    input [7:0] PA_RXD;
    input PA_RX_DV;
    input PA_RX_ER;
    input PA_RX_OK;
    input PA_RX50HZ;
    input PA_VP;
   output [6:0] BRIGHTNESS;
   output [2:0] COLOR_LOSS;
   output COLOR_LOSS_ON_N;
   output CTRLD_CSUM_OK;
   output [3:0] CT_BLUE;
   output [3:0] CT_GREEN;
   output [3:0] CT_RED;
   output ER_UPDATE;
   output FRAME_ALT;
   output FRAME_ALT_FRZ;
   output FREEZE;
   output [15:0] FR_RATE;
   output [2:0] GAMMA;
   output [10:0] HSTP;
   output [10:0] H_SIZE;
   output M4_BANK1;
   output [6:0] M4_BRT;
   output M4_ON;
   output [2:0] OUT_CH;
   output OVP;
   output PAC_STP;
   output PAC1_OK;
   output [9:0] PANEL_NUM;
   output PNL_ADRS_UPDATE;
   output REBOOT_N;
   output [7:0] RXD;
   output RX_FAN_ON;
   output RX_IM_DOWNLOAD;
   output RX_OK;
   output RX50HZ;
   output [9:0] TOTAL_PANEL;
   output UPDATE_ER_ON;
   output [9:0] UPDATE_PNL_NUM;
   output [10:0] VSTP;
   output [10:0] V_SIZE;
   
   wire XLXN_216;
   wire XLXN_218;
   wire XLXN_274;
   wire XLXN_275;
   wire RX50HZ_DUMMY;
   wire PAC_STP_DUMMY;
   wire OVP_DUMMY;
   wire [7:0] RXD_DUMMY;
   wire RX_OK_DUMMY;
   
   assign OVP = OVP_DUMMY;
   assign PAC_STP = PAC_STP_DUMMY;
   assign RXD[7:0] = RXD_DUMMY[7:0];
   assign RX_OK = RX_OK_DUMMY;
   assign RX50HZ = RX50HZ_DUMMY;
   ctrld_reg  ctrld_reg0 (.clk(CLK), 
                         .cmd_brightness(CMD_BRIGHTNESS[6:0]), 
                         .cmd_ct_blue(CMD_CT_BLUE[3:0]), 
                         .cmd_ct_green(CMD_CT_GREEN[3:0]), 
                         .cmd_ct_red(CMD_CT_RED[3:0]), 
                         .cmd_gamma(CMD_GAMMA[2:0]), 
                         .cmd_m4_bank1(CMD_M4_BANK1), 
                         .cmd_m4_on(CMD_M4_ON), 
                         .cmd_test_pat(CMD_TEST_PAD[7:0]), 
                         .c_done(C_DONE), 
                         .d(RXD_DUMMY[7:0]), 
                         .dsw_pad_update(DSW_PAD_UPDATE), 
                         .mem_pad(MEM_PAD[9:0]), 
                         .mem_pad_ena(MEM_PAD_ENA), 
                         .m4_set_done(M4_SET_DONE), 
                         .ovp(OVP_DUMMY), 
                         .pac_stp(PAC_STP_DUMMY), 
                         .pixel_disp_on(), 
                         .rx_dv(XLXN_218), 
                         .rx_er(XLXN_216), 
                         .rx_ok(RX_OK_DUMMY), 
                         .sel_port_b(), 
                         .test_dsw(), 
                         .backup(), 
                         .brightness(BRIGHTNESS[6:0]), 
                         .color_loss(COLOR_LOSS[2:0]), 
                         .color_loss_on_n(COLOR_LOSS_ON_N), 
                         .ctrld_csum_ok(CTRLD_CSUM_OK), 
                         .ct_blue(CT_BLUE[3:0]), 
                         .ct_green(CT_GREEN[3:0]), 
                         .ct_red(CT_RED[3:0]), 
                         .er_update(ER_UPDATE), 
                         .fr_rate(FR_RATE[15:0]), 
                         .gamma(GAMMA[2:0]), 
                         .hstp(HSTP[10:0]), 
                         .h_size(H_SIZE[10:0]), 
                         .m4_bank1(M4_BANK1), 
                         .m4_brt(M4_BRT[6:0]), 
                         .m4_on(M4_ON), 
                         .out_ch(OUT_CH[2:0]), 
                         .pac1_ok(PAC1_OK), 
                         .panel_num(PANEL_NUM[9:0]), 
                         .pnl_adrs_update(PNL_ADRS_UPDATE), 
                         .reboot_n(REBOOT_N), 
                         .rx_fan_on(RX_FAN_ON), 
                         .rx_im_download(RX_IM_DOWNLOAD), 
                         .test_pat(), 
                         .total_panel(TOTAL_PANEL[9:0]), 
                         .update_er_on(UPDATE_ER_ON), 
                         .update_pnl_num(UPDATE_PNL_NUM[9:0]), 
                         .vstp(VSTP[10:0]), 
                         .v_size(V_SIZE[10:0]));
   freeze_ctrl_a  freeze_ctrl_a0 (.clk(CLK), 
                                 .c_done(C_DONE), 
                                 .ovp(OVP_DUMMY), 
                                 .pac_stp(PAC_STP_DUMMY), 
                                 .rxd(RXD_DUMMY[7:0]), 
                                 .rx_ok(RX_OK_DUMMY), 
                                 .sel_port_chngp(), 
                                 .frame_alt_frz(FRAME_ALT_FRZ), 
                                 .freeze(FREEZE));
   ovp_gen_b  ovp_gen_b0 (.clk(CLK), 
                         .f50hz(RX50HZ_DUMMY), 
                         .rx_ok(RX_OK_DUMMY), 
                         .rx_vp(PA_VP), 
                         .adv_int_vp(XLXN_274), 
                         .frame_alt(FRAME_ALT), 
                         .over_vp(), 
                         .ovp(OVP_DUMMY), 
                         .rx_vp_sel(XLXN_275));
   pac_stp_gen  pac_stp_gen0 (.clk(CLK), 
                             .int_vp(XLXN_274), 
                             .rx_pac_stp(PA_PAC_STP), 
                             .rx_vp_sel(XLXN_275), 
                             .pac_stp(PAC_STP_DUMMY));
   fd8_MUSER_rx_ctrld  XLXI_26 (.CK(CLK), 
                               .I(PA_RXD[7:0]), 
                               .O(RXD_DUMMY[7:0]));
   fd1_MUSER_rx_ctrld  XLXI_27 (.CK(CLK), 
                               .D(PA_RX_DV), 
                               .Q(XLXN_218));
   fd1_MUSER_rx_ctrld  XLXI_28 (.CK(CLK), 
                               .D(PA_RX_ER), 
                               .Q(XLXN_216));
   fd1_MUSER_rx_ctrld  XLXI_36 (.CK(CLK), 
                               .D(PA_RX50HZ), 
                               .Q(RX50HZ_DUMMY));
   fd1_MUSER_rx_ctrld  XLXI_38 (.CK(CLK), 
                               .D(PA_RX_OK), 
                               .Q(RX_OK_DUMMY));
endmodule

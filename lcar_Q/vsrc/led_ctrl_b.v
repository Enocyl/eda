module led_ctrl_b(CLK, 
                  CSUM_ERR_SEL, 
                  C_DONE, 
                  DSW_IM_DOWNLOAD_ON, 
                  FRAME_ALT, 
                  IM_DOWNLOAD_EXE_TIM, 
                  IM_ERR_DET, 
                  PA_CSUM_ERR, 
                  PA_LED1, 
                  PA_LED2, 
                  PA_RX_OK, 
                  SEL_PORT_B, 
                  VER, 
                  LED_A, 
                  PA_LINK_ON);

    input CLK;
    input CSUM_ERR_SEL;
    input C_DONE;
    input DSW_IM_DOWNLOAD_ON;
    input FRAME_ALT;
    input IM_DOWNLOAD_EXE_TIM;
    input IM_ERR_DET;
    input PA_CSUM_ERR;
    input PA_LED1;
    input PA_LED2;
    input PA_RX_OK;
    input SEL_PORT_B;
    input [7:0] VER;
   output LED_A;
   output PA_LINK_ON;
   
   wire BLINK_ON_TIME;
   wire XLXN_561;
   wire XLXN_595;
   wire XLXN_657;
   wire XLXN_658;
   wire XLXN_664;
   wire XLXN_685;
   wire XLXN_795;
   wire XLXN_796;
   wire XLXN_800;
   wire XLXN_802;
   wire XLXN_848;
   wire PA_LINK_ON_DUMMY;
   
   assign PA_LINK_ON = PA_LINK_ON_DUMMY;
   (* IOSTANDARD = "DEFAULT" *) (* IBUF_DELAY_VALUE = "0" *) (* 
         IFD_DELAY_VALUE = "AUTO" *) 
   IBUF  XLXI_1 (.I(PA_LED1), 
                .O(XLXN_800));
   (* IOSTANDARD = "DEFAULT" *) (* IBUF_DELAY_VALUE = "0" *) (* 
         IFD_DELAY_VALUE = "AUTO" *) 
   IBUF  XLXI_2 (.I(PA_LED2), 
                .O(XLXN_595));
   (* IOSTANDARD = "DEFAULT" *) (* SLEW = "SLOW" *) (* DRIVE = "12" *) 
   OBUF  XLXI_5 (.I(XLXN_664), 
                .O(LED_A));
   (* HU_SET = "XLXI_245_0" *) 
   M2_1_HXILINX_led_ctrl_b  XLXI_245 (.D0(XLXN_561), 
                                     .D1(PA_CSUM_ERR), 
                                     .S0(CSUM_ERR_SEL), 
                                     .O(XLXN_658));
   INV  XLXI_255 (.I(XLXN_595), 
                 .O(XLXN_848));
   AND2  XLXI_263 (.I0(PA_LINK_ON_DUMMY), 
                  .I1(XLXN_685), 
                  .O(XLXN_561));
   version_disp_xt  XLXI_265 (.clk(CLK), 
                             .c_done(C_DONE), 
                             .dipsw2_on(), 
                             .dsw_im_download_on(), 
                             .frame_alt(FRAME_ALT), 
                             .im_download_exe_tim(), 
                             .im_err_det(IM_ERR_DET), 
                             .ver(VER[7:0]), 
                             .ex_disp(XLXN_657), 
                             .ld1_on(XLXN_802), 
                             .ld2_on(), 
                             .ver_disp());
   (* HU_SET = "XLXI_268_1" *) 
   M2_1_HXILINX_led_ctrl_b  XLXI_268 (.D0(XLXN_658), 
                                     .D1(XLXN_802), 
                                     .S0(XLXN_657), 
                                     .O(XLXN_664));
   OR2B1  XLXI_278 (.I0(PA_CSUM_ERR), 
                   .I1(XLXN_795), 
                   .O(XLXN_685));
   led_blink_brt  XLXI_283 (.clk(CLK), 
                           .c_done(C_DONE), 
                           .pa_rx_ok(PA_RX_OK), 
                           .pb_rx_ok(), 
                           .blink_on_time(BLINK_ON_TIME));
   AND2  XLXI_320 (.I0(XLXN_796), 
                  .I1(XLXN_800), 
                  .O(XLXN_795));
   OR2B1  XLXI_321 (.I0(SEL_PORT_B), 
                   .I1(BLINK_ON_TIME), 
                   .O(XLXN_796));
   link_on_in_filter  XLXI_345 (.clk(CLK), 
                               .din(XLXN_848), 
                               .dout(PA_LINK_ON_DUMMY));
endmodule

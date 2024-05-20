<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="aspartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="GAMMA(2:0)" />
        <signal name="CT_RED(3:0)" />
        <signal name="CT_GREEN(3:0)" />
        <signal name="CT_BLUE(3:0)" />
        <signal name="OVP" />
        <signal name="CLK" />
        <signal name="M4_BRT(6:0)" />
        <signal name="XLXN_1513(15:0)" />
        <signal name="XLXN_1514(15:0)" />
        <signal name="XLXN_1515(15:0)" />
        <signal name="XLXN_1670(15:0)" />
        <signal name="XLXN_1671(15:0)" />
        <signal name="XLXN_1672(15:0)" />
        <signal name="M4_ON" />
        <signal name="G_M4IN(15:0)" />
        <signal name="B_M4IN(15:0)" />
        <signal name="XLXN_1675(15:0)" />
        <signal name="XLXN_1676(15:0)" />
        <signal name="XLXN_1678(15:0)" />
        <signal name="R_M4IN(15:0)" />
        <signal name="CF0D(12:0)" />
        <signal name="XLXN_1817(15:0)" />
        <signal name="XLXN_1818(15:0)" />
        <signal name="XLXN_1819(15:0)" />
        <signal name="FM_IN_RD_RED(9:0)" />
        <signal name="FM_IN_RD_GREEN(9:0)" />
        <signal name="FM_IN_RD_BLUE(9:0)" />
        <signal name="FM_OV_WR_D(31:0)" />
        <signal name="FM_OV_WR_ADRS(18:0)" />
        <signal name="FM_OV_WR_CYCLE" />
        <signal name="FM_CYCLE_STP_ADV" />
        <signal name="FM_IV_RD_CYCLE" />
        <signal name="FM_IV_WR_CYCLE" />
        <signal name="FRAME_ALT" />
        <signal name="XLXN_2105(15:0)" />
        <signal name="XLXN_2106(15:0)" />
        <signal name="XLXN_2108(15:0)" />
        <signal name="CHECK" />
        <signal name="BRIGHTNESS(6:0)" />
        <signal name="M4_ON,GAMMA(2:0),CT_BLUE(3:0),CT_GREEN(3:0),CT_RED(3:0)" />
        <signal name="FM_RD_D(29:0)" />
        <signal name="FM_IN_VID_RD_ADRS(16:0)" />
        <signal name="FM_M4_CF_RD_ADRS(18:0)" />
        <signal name="CF1D(12:0)" />
        <signal name="CF2D(12:0)" />
        <signal name="CF3D(12:0)" />
        <signal name="CF4D(12:0)" />
        <signal name="CF5D(12:0)" />
        <signal name="CF6D(12:0)" />
        <signal name="CF7D(12:0)" />
        <signal name="CF8D(12:0)" />
        <signal name="PANEL_SEL(3:0)" />
        <signal name="XLXN_2127(15:0)" />
        <signal name="FM_OV_RD_CYCLE" />
        <signal name="FRAME_ALT_FRZ" />
        <port polarity="Input" name="GAMMA(2:0)" />
        <port polarity="Input" name="CT_RED(3:0)" />
        <port polarity="Input" name="CT_GREEN(3:0)" />
        <port polarity="Input" name="CT_BLUE(3:0)" />
        <port polarity="Input" name="OVP" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="M4_BRT(6:0)" />
        <port polarity="Input" name="M4_ON" />
        <port polarity="Output" name="FM_IN_RD_RED(9:0)" />
        <port polarity="Output" name="FM_IN_RD_GREEN(9:0)" />
        <port polarity="Output" name="FM_IN_RD_BLUE(9:0)" />
        <port polarity="Output" name="FM_OV_WR_D(31:0)" />
        <port polarity="Output" name="FM_OV_WR_ADRS(18:0)" />
        <port polarity="Output" name="FM_OV_WR_CYCLE" />
        <port polarity="Input" name="FM_CYCLE_STP_ADV" />
        <port polarity="Output" name="FM_IV_RD_CYCLE" />
        <port polarity="Input" name="FM_IV_WR_CYCLE" />
        <port polarity="Input" name="FRAME_ALT" />
        <port polarity="Input" name="CHECK" />
        <port polarity="Input" name="BRIGHTNESS(6:0)" />
        <port polarity="Input" name="FM_RD_D(29:0)" />
        <port polarity="Output" name="FM_IN_VID_RD_ADRS(16:0)" />
        <port polarity="Output" name="FM_M4_CF_RD_ADRS(18:0)" />
        <port polarity="Input" name="PANEL_SEL(3:0)" />
        <port polarity="Input" name="FM_OV_RD_CYCLE" />
        <port polarity="Input" name="FRAME_ALT_FRZ" />
        <blockdef name="gamma_ctemp_mpc">
            <timestamp>2010-5-17T1:54:22</timestamp>
            <rect width="64" x="352" y="-236" height="24" />
            <line x2="416" y1="-224" y2="-224" x1="352" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-188" height="24" />
            <line x2="0" y1="-176" y2="-176" x1="64" />
            <rect width="64" x="0" y="-140" height="24" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <rect width="288" x="64" y="-256" height="256" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
        </blockdef>
        <blockdef name="sel16">
            <timestamp>2013-1-10T1:37:55</timestamp>
            <rect width="192" x="64" y="-192" height="160" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-124" height="24" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
            <rect width="64" x="256" y="-172" height="24" />
            <line x2="320" y1="-160" y2="-160" x1="256" />
        </blockdef>
        <blockdef name="f1d16">
            <timestamp>2004-2-13T23:6:26</timestamp>
            <rect width="160" x="64" y="-112" height="112" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
            <rect width="64" x="0" y="-92" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="288" y1="-80" y2="-80" x1="224" />
            <rect width="64" x="224" y="-92" height="24" />
        </blockdef>
        <blockdef name="m4_mult_xt2p5_a">
            <timestamp>2015-5-20T7:4:54</timestamp>
            <rect width="64" x="320" y="-876" height="24" />
            <line x2="384" y1="-864" y2="-864" x1="320" />
            <rect width="64" x="0" y="-876" height="24" />
            <line x2="0" y1="-864" y2="-864" x1="64" />
            <rect width="64" x="0" y="-828" height="24" />
            <line x2="0" y1="-816" y2="-816" x1="64" />
            <rect width="64" x="0" y="-780" height="24" />
            <line x2="0" y1="-768" y2="-768" x1="64" />
            <rect width="64" x="320" y="-828" height="24" />
            <line x2="384" y1="-816" y2="-816" x1="320" />
            <rect width="64" x="320" y="-780" height="24" />
            <line x2="384" y1="-768" y2="-768" x1="320" />
            <rect width="64" x="0" y="-684" height="24" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <rect width="64" x="0" y="-636" height="24" />
            <line x2="0" y1="-624" y2="-624" x1="64" />
            <rect width="64" x="0" y="-588" height="24" />
            <line x2="0" y1="-576" y2="-576" x1="64" />
            <rect width="64" x="0" y="-540" height="24" />
            <line x2="0" y1="-528" y2="-528" x1="64" />
            <rect width="64" x="0" y="-492" height="24" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <rect width="64" x="0" y="-444" height="24" />
            <line x2="0" y1="-432" y2="-432" x1="64" />
            <rect width="64" x="0" y="-396" height="24" />
            <line x2="0" y1="-384" y2="-384" x1="64" />
            <rect width="64" x="0" y="-348" height="24" />
            <line x2="0" y1="-336" y2="-336" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-240" y2="-240" x1="64" />
            <rect width="256" x="64" y="-896" height="784" />
            <line x2="0" y1="-144" y2="-144" x1="64" />
            <line x2="0" y1="-192" y2="-192" x1="64" />
            <rect width="64" x="320" y="-156" height="24" />
            <line x2="384" y1="-144" y2="-144" x1="320" />
        </blockdef>
        <blockdef name="fm_out_video_write_pv2_4_4x4">
            <timestamp>2017-4-13T1:54:16</timestamp>
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="0" y1="-304" y2="-304" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="512" y1="-448" y2="-448" x1="448" />
            <rect width="64" x="448" y="-508" height="24" />
            <line x2="512" y1="-496" y2="-496" x1="448" />
            <rect width="64" x="448" y="-556" height="24" />
            <line x2="512" y1="-544" y2="-544" x1="448" />
            <rect width="64" x="0" y="-556" height="24" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <rect width="64" x="0" y="-508" height="24" />
            <line x2="0" y1="-496" y2="-496" x1="64" />
            <rect width="64" x="0" y="-460" height="24" />
            <line x2="0" y1="-448" y2="-448" x1="64" />
            <rect width="384" x="64" y="-576" height="544" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-208" y2="-208" x1="64" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
        </blockdef>
        <blockdef name="brightness_mpc_b">
            <timestamp>2017-4-19T2:59:40</timestamp>
            <rect width="256" x="64" y="-256" height="208" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-188" height="24" />
            <line x2="0" y1="-176" y2="-176" x1="64" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
        </blockdef>
        <blockdef name="fm_in_video_read_lcar_m5353Q_14b43Hz">
            <timestamp>2021-11-1T9:22:40</timestamp>
            <line x2="0" y1="-704" y2="-704" x1="64" />
            <line x2="0" y1="-800" y2="-800" x1="64" />
            <line x2="0" y1="-752" y2="-752" x1="64" />
            <line x2="0" y1="-656" y2="-656" x1="64" />
            <rect width="64" x="0" y="-620" height="24" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-560" y2="-560" x1="64" />
            <rect width="64" x="544" y="-812" height="24" />
            <line x2="608" y1="-800" y2="-800" x1="544" />
            <line x2="608" y1="-752" y2="-752" x1="544" />
            <rect width="64" x="544" y="-716" height="24" />
            <line x2="608" y1="-704" y2="-704" x1="544" />
            <rect width="64" x="544" y="-620" height="24" />
            <line x2="608" y1="-608" y2="-608" x1="544" />
            <rect width="64" x="544" y="-572" height="24" />
            <line x2="608" y1="-560" y2="-560" x1="544" />
            <rect width="64" x="544" y="-524" height="24" />
            <line x2="608" y1="-512" y2="-512" x1="544" />
            <rect width="64" x="544" y="-476" height="24" />
            <line x2="608" y1="-464" y2="-464" x1="544" />
            <rect width="64" x="544" y="-428" height="24" />
            <line x2="608" y1="-416" y2="-416" x1="544" />
            <rect width="64" x="544" y="-380" height="24" />
            <line x2="608" y1="-368" y2="-368" x1="544" />
            <rect width="64" x="544" y="-332" height="24" />
            <line x2="608" y1="-320" y2="-320" x1="544" />
            <rect width="64" x="544" y="-284" height="24" />
            <line x2="608" y1="-272" y2="-272" x1="544" />
            <rect width="64" x="544" y="-236" height="24" />
            <line x2="608" y1="-224" y2="-224" x1="544" />
            <rect width="64" x="544" y="-44" height="24" />
            <line x2="608" y1="-32" y2="-32" x1="544" />
            <rect width="64" x="544" y="-92" height="24" />
            <line x2="608" y1="-80" y2="-80" x1="544" />
            <rect width="64" x="544" y="-140" height="24" />
            <line x2="608" y1="-128" y2="-128" x1="544" />
            <rect width="64" x="0" y="-476" height="24" />
            <line x2="0" y1="-464" y2="-464" x1="64" />
            <rect width="480" x="64" y="-832" height="832" />
            <line x2="0" y1="-368" y2="-368" x1="64" />
        </blockdef>
        <block symbolname="gamma_ctemp_mpc" name="XLXI_81">
            <blockpin signalname="FM_IN_RD_RED(9:0)" name="DIN(9:0)" />
            <blockpin signalname="CT_RED(3:0)" name="CT_GAIN(3:0)" />
            <blockpin signalname="GAMMA(2:0)" name="GAMMA(2:0)" />
            <blockpin signalname="XLXN_1513(15:0)" name="DOUT(15:0)" />
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="OVP" name="OVP" />
        </block>
        <block symbolname="gamma_ctemp_mpc" name="XLXI_90">
            <blockpin signalname="FM_IN_RD_GREEN(9:0)" name="DIN(9:0)" />
            <blockpin signalname="CT_GREEN(3:0)" name="CT_GAIN(3:0)" />
            <blockpin signalname="GAMMA(2:0)" name="GAMMA(2:0)" />
            <blockpin signalname="XLXN_1514(15:0)" name="DOUT(15:0)" />
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="OVP" name="OVP" />
        </block>
        <block symbolname="gamma_ctemp_mpc" name="XLXI_91">
            <blockpin signalname="FM_IN_RD_BLUE(9:0)" name="DIN(9:0)" />
            <blockpin signalname="CT_BLUE(3:0)" name="CT_GAIN(3:0)" />
            <blockpin signalname="GAMMA(2:0)" name="GAMMA(2:0)" />
            <blockpin signalname="XLXN_1515(15:0)" name="DOUT(15:0)" />
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="OVP" name="OVP" />
        </block>
        <block symbolname="sel16" name="XLXI_383">
            <blockpin signalname="CHECK" name="s" />
            <blockpin signalname="XLXN_1675(15:0)" name="ia(15:0)" />
            <blockpin signalname="XLXN_2127(15:0)" name="ib(15:0)" />
            <blockpin signalname="XLXN_1817(15:0)" name="o(15:0)" />
        </block>
        <block symbolname="sel16" name="XLXI_384">
            <blockpin signalname="CHECK" name="s" />
            <blockpin signalname="XLXN_1678(15:0)" name="ia(15:0)" />
            <blockpin signalname="XLXN_2127(15:0)" name="ib(15:0)" />
            <blockpin signalname="XLXN_1818(15:0)" name="o(15:0)" />
        </block>
        <block symbolname="sel16" name="XLXI_385">
            <blockpin signalname="CHECK" name="s" />
            <blockpin signalname="XLXN_1676(15:0)" name="ia(15:0)" />
            <blockpin signalname="XLXN_2127(15:0)" name="ib(15:0)" />
            <blockpin signalname="XLXN_1819(15:0)" name="o(15:0)" />
        </block>
        <block symbolname="f1d16" name="XLXI_425">
            <blockpin signalname="XLXN_1817(15:0)" name="D(15:0)" />
            <blockpin signalname="CLK" name="CK" />
            <blockpin signalname="XLXN_2105(15:0)" name="Q(15:0)" />
        </block>
        <block symbolname="f1d16" name="XLXI_427">
            <blockpin signalname="XLXN_1819(15:0)" name="D(15:0)" />
            <blockpin signalname="CLK" name="CK" />
            <blockpin signalname="XLXN_2108(15:0)" name="Q(15:0)" />
        </block>
        <block symbolname="f1d16" name="XLXI_426">
            <blockpin signalname="XLXN_1818(15:0)" name="D(15:0)" />
            <blockpin signalname="CLK" name="CK" />
            <blockpin signalname="XLXN_2106(15:0)" name="Q(15:0)" />
        </block>
        <block symbolname="m4_mult_xt2p5_a" name="XLXI_456">
            <blockpin signalname="CF0D(12:0)" name="CF0D(12:0)" />
            <blockpin signalname="CF4D(12:0)" name="CF4D(12:0)" />
            <blockpin signalname="R_M4IN(15:0)" name="RIN(15:0)" />
            <blockpin signalname="G_M4IN(15:0)" name="GIN(15:0)" />
            <blockpin signalname="CF8D(12:0)" name="CF8D(12:0)" />
            <blockpin signalname="B_M4IN(15:0)" name="BIN(15:0)" />
            <blockpin signalname="M4_ON" name="M4_ON" />
            <blockpin signalname="CF1D(12:0)" name="CF1D(12:0)" />
            <blockpin signalname="CF2D(12:0)" name="CF2D(12:0)" />
            <blockpin signalname="CF3D(12:0)" name="CF3D(12:0)" />
            <blockpin signalname="CF5D(12:0)" name="CF5D(12:0)" />
            <blockpin signalname="CF6D(12:0)" name="CF6D(12:0)" />
            <blockpin signalname="CF7D(12:0)" name="CF7D(12:0)" />
            <blockpin signalname="XLXN_1675(15:0)" name="ROUT(15:0)" />
            <blockpin signalname="XLXN_1678(15:0)" name="GOUT(15:0)" />
            <blockpin signalname="XLXN_1676(15:0)" name="BOUT(15:0)" />
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="OVP" name="OVP" />
            <blockpin name="BR(35:0)" />
        </block>
        <block symbolname="f1d16" name="XLXI_459">
            <blockpin signalname="M4_ON,GAMMA(2:0),CT_BLUE(3:0),CT_GREEN(3:0),CT_RED(3:0)" name="D(15:0)" />
            <blockpin signalname="CLK" name="CK" />
            <blockpin signalname="XLXN_2127(15:0)" name="Q(15:0)" />
        </block>
        <block symbolname="fm_out_video_write_pv2_4_4x4" name="fm_out0">
            <blockpin signalname="FM_CYCLE_STP_ADV" name="fm_cycle_stp_adv" />
            <blockpin signalname="FM_IV_RD_CYCLE" name="fm_iv_rd_cycle" />
            <blockpin signalname="FM_IV_WR_CYCLE" name="fm_iv_wr_cycle" />
            <blockpin signalname="XLXN_2105(15:0)" name="r_din(15:0)" />
            <blockpin signalname="XLXN_2106(15:0)" name="g_din(15:0)" />
            <blockpin signalname="XLXN_2108(15:0)" name="b_din(15:0)" />
            <blockpin signalname="FM_OV_WR_CYCLE" name="fm_ov_wr_cycle" />
            <blockpin signalname="FM_OV_WR_ADRS(18:0)" name="fm_ov_wr_adrs(18:0)" />
            <blockpin signalname="FM_OV_WR_D(31:0)" name="fm_ov_wr_d(31:0)" />
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="FM_OV_RD_CYCLE" name="fm_ov_rd_cycle" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="FRAME_ALT_FRZ" name="frame_alt" />
        </block>
        <block symbolname="brightness_mpc_b" name="XLXI_473">
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_1670(15:0)" name="din(15:0)" />
            <blockpin signalname="BRIGHTNESS(6:0)" name="brightness(6:0)" />
            <blockpin signalname="R_M4IN(15:0)" name="dout(15:0)" />
        </block>
        <block symbolname="brightness_mpc_b" name="XLXI_474">
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_1671(15:0)" name="din(15:0)" />
            <blockpin signalname="BRIGHTNESS(6:0)" name="brightness(6:0)" />
            <blockpin signalname="G_M4IN(15:0)" name="dout(15:0)" />
        </block>
        <block symbolname="brightness_mpc_b" name="XLXI_475">
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_1672(15:0)" name="din(15:0)" />
            <blockpin signalname="BRIGHTNESS(6:0)" name="brightness(6:0)" />
            <blockpin signalname="B_M4IN(15:0)" name="dout(15:0)" />
        </block>
        <block symbolname="brightness_mpc_b" name="XLXI_476">
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_1513(15:0)" name="din(15:0)" />
            <blockpin signalname="M4_BRT(6:0)" name="brightness(6:0)" />
            <blockpin signalname="XLXN_1670(15:0)" name="dout(15:0)" />
        </block>
        <block symbolname="brightness_mpc_b" name="XLXI_477">
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_1514(15:0)" name="din(15:0)" />
            <blockpin signalname="M4_BRT(6:0)" name="brightness(6:0)" />
            <blockpin signalname="XLXN_1671(15:0)" name="dout(15:0)" />
        </block>
        <block symbolname="brightness_mpc_b" name="XLXI_478">
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_1515(15:0)" name="din(15:0)" />
            <blockpin signalname="M4_BRT(6:0)" name="brightness(6:0)" />
            <blockpin signalname="XLXN_1672(15:0)" name="dout(15:0)" />
        </block>
        <block symbolname="fm_in_video_read_lcar_m5353Q_14b43Hz" name="fm_in0">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="FM_CYCLE_STP_ADV" name="fm_cycle_stp_adv" />
            <blockpin signalname="FM_IV_WR_CYCLE" name="fm_iv_wr_cycle" />
            <blockpin signalname="FM_OV_RD_CYCLE" name="fm_ov_rd_cycle" />
            <blockpin signalname="FM_RD_D(29:0)" name="fm_rd_d(29:0)" />
            <blockpin signalname="FRAME_ALT" name="frame_alt" />
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="PANEL_SEL(3:0)" name="panel_sel(3:0)" />
            <blockpin signalname="FM_IN_RD_BLUE(9:0)" name="blue(9:0)" />
            <blockpin signalname="CF0D(12:0)" name="cf0d(12:0)" />
            <blockpin signalname="CF1D(12:0)" name="cf1d(12:0)" />
            <blockpin signalname="CF2D(12:0)" name="cf2d(12:0)" />
            <blockpin signalname="CF3D(12:0)" name="cf3d(12:0)" />
            <blockpin signalname="CF4D(12:0)" name="cf4d(12:0)" />
            <blockpin signalname="CF5D(12:0)" name="cf5d(12:0)" />
            <blockpin signalname="CF6D(12:0)" name="cf6d(12:0)" />
            <blockpin signalname="CF7D(12:0)" name="cf7d(12:0)" />
            <blockpin signalname="CF8D(12:0)" name="cf8d(12:0)" />
            <blockpin signalname="FM_IN_VID_RD_ADRS(16:0)" name="fm_in_vid_rd_adrs(16:0)" />
            <blockpin signalname="FM_IV_RD_CYCLE" name="fm_iv_rd_cycle" />
            <blockpin signalname="FM_M4_CF_RD_ADRS(18:0)" name="fm_m4_cf_rd_adrs(18:0)" />
            <blockpin signalname="FM_IN_RD_GREEN(9:0)" name="green(9:0)" />
            <blockpin signalname="FM_IN_RD_RED(9:0)" name="red(9:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="6916" y="5152">video_proc</text>
        <branch name="GAMMA(2:0)">
            <wire x2="2032" y1="2208" y2="2208" x1="1984" />
            <wire x2="2160" y1="2208" y2="2208" x1="2032" />
            <wire x2="2032" y1="2208" y2="2608" x1="2032" />
            <wire x2="2160" y1="2608" y2="2608" x1="2032" />
            <wire x2="2032" y1="2608" y2="3008" x1="2032" />
            <wire x2="2160" y1="3008" y2="3008" x1="2032" />
        </branch>
        <branch name="CT_RED(3:0)">
            <wire x2="2160" y1="2256" y2="2256" x1="1984" />
        </branch>
        <branch name="CT_GREEN(3:0)">
            <wire x2="2160" y1="2656" y2="2656" x1="1984" />
        </branch>
        <branch name="CT_BLUE(3:0)">
            <wire x2="2160" y1="3056" y2="3056" x1="1984" />
        </branch>
        <instance x="2160" y="2384" name="XLXI_81" orien="R0">
        </instance>
        <instance x="2160" y="2784" name="XLXI_90" orien="R0">
        </instance>
        <instance x="2160" y="3184" name="XLXI_91" orien="R0">
        </instance>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="2304" type="branch" />
            <wire x2="2160" y1="2304" y2="2304" x1="2112" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="2352" type="branch" />
            <wire x2="2160" y1="2352" y2="2352" x1="2112" />
        </branch>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="2704" type="branch" />
            <wire x2="2160" y1="2704" y2="2704" x1="2112" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="2752" type="branch" />
            <wire x2="2160" y1="2752" y2="2752" x1="2112" />
        </branch>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="3104" type="branch" />
            <wire x2="2160" y1="3104" y2="3104" x1="2112" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="3152" type="branch" />
            <wire x2="2160" y1="3152" y2="3152" x1="2112" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2276" y="2004">5clk delay</text>
        <text style="fontsize:40;fontname:Arial" x="1744" y="3008">CT_BLUE(3:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1696" y="2604">CT_GREEN(3:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1772" y="2112">GAMMA(2:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1752" y="2320">CT_RED(3:0)</text>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2752" y="2256" type="branch" />
            <wire x2="2800" y1="2256" y2="2256" x1="2752" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2752" y="2304" type="branch" />
            <wire x2="2800" y1="2304" y2="2304" x1="2752" />
        </branch>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2752" y="2656" type="branch" />
            <wire x2="2800" y1="2656" y2="2656" x1="2752" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2752" y="2704" type="branch" />
            <wire x2="2800" y1="2704" y2="2704" x1="2752" />
        </branch>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2752" y="3056" type="branch" />
            <wire x2="2800" y1="3056" y2="3056" x1="2752" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2752" y="3104" type="branch" />
            <wire x2="2800" y1="3104" y2="3104" x1="2752" />
        </branch>
        <branch name="M4_BRT(6:0)">
            <wire x2="2672" y1="3280" y2="3280" x1="2560" />
            <wire x2="2800" y1="2208" y2="2208" x1="2672" />
            <wire x2="2672" y1="2208" y2="2608" x1="2672" />
            <wire x2="2800" y1="2608" y2="2608" x1="2672" />
            <wire x2="2672" y1="2608" y2="3008" x1="2672" />
            <wire x2="2800" y1="3008" y2="3008" x1="2672" />
            <wire x2="2672" y1="3008" y2="3280" x1="2672" />
        </branch>
        <branch name="XLXN_1513(15:0)">
            <wire x2="2800" y1="2160" y2="2160" x1="2576" />
        </branch>
        <branch name="XLXN_1514(15:0)">
            <wire x2="2800" y1="2560" y2="2560" x1="2576" />
        </branch>
        <branch name="XLXN_1515(15:0)">
            <wire x2="2800" y1="2960" y2="2960" x1="2576" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2904" y="2004">2clk delay</text>
        <text style="fontsize:40;fontname:Arial" x="2056" y="3280">M4_BRT(6:0)</text>
        <text style="fontsize:40;fontname:Arial" x="3480" y="2004">2clk delay</text>
        <branch name="XLXN_1670(15:0)">
            <wire x2="3376" y1="2160" y2="2160" x1="3184" />
        </branch>
        <branch name="XLXN_1671(15:0)">
            <wire x2="3376" y1="2560" y2="2560" x1="3184" />
        </branch>
        <branch name="XLXN_1672(15:0)">
            <wire x2="3376" y1="2960" y2="2960" x1="3184" />
        </branch>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3328" y="2256" type="branch" />
            <wire x2="3376" y1="2256" y2="2256" x1="3328" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3328" y="2304" type="branch" />
            <wire x2="3376" y1="2304" y2="2304" x1="3328" />
        </branch>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3328" y="2656" type="branch" />
            <wire x2="3376" y1="2656" y2="2656" x1="3328" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3328" y="2704" type="branch" />
            <wire x2="3376" y1="2704" y2="2704" x1="3328" />
        </branch>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3328" y="3056" type="branch" />
            <wire x2="3376" y1="3056" y2="3056" x1="3328" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3328" y="3104" type="branch" />
            <wire x2="3376" y1="3104" y2="3104" x1="3328" />
        </branch>
        <branch name="M4_ON">
            <wire x2="4352" y1="2784" y2="2784" x1="4272" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4452" y="2004">4clk delay</text>
        <branch name="G_M4IN(15:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4112" y="2208" type="branch" />
            <wire x2="3840" y1="2560" y2="2560" x1="3760" />
            <wire x2="4112" y1="2208" y2="2208" x1="3840" />
            <wire x2="4352" y1="2208" y2="2208" x1="4112" />
            <wire x2="3840" y1="2208" y2="2560" x1="3840" />
        </branch>
        <branch name="B_M4IN(15:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4112" y="2256" type="branch" />
            <wire x2="3904" y1="2960" y2="2960" x1="3760" />
            <wire x2="4112" y1="2256" y2="2256" x1="3904" />
            <wire x2="4352" y1="2256" y2="2256" x1="4112" />
            <wire x2="3904" y1="2256" y2="2960" x1="3904" />
        </branch>
        <instance x="5024" y="2320" name="XLXI_383" orien="R0">
        </instance>
        <instance x="5024" y="2560" name="XLXI_384" orien="R0">
        </instance>
        <instance x="5024" y="2800" name="XLXI_385" orien="R0">
        </instance>
        <branch name="XLXN_1675(15:0)">
            <wire x2="5024" y1="2160" y2="2160" x1="4736" />
        </branch>
        <branch name="XLXN_1676(15:0)">
            <wire x2="4784" y1="2256" y2="2256" x1="4736" />
            <wire x2="4784" y1="2256" y2="2640" x1="4784" />
            <wire x2="5024" y1="2640" y2="2640" x1="4784" />
        </branch>
        <branch name="XLXN_1678(15:0)">
            <wire x2="4832" y1="2208" y2="2208" x1="4736" />
            <wire x2="4832" y1="2208" y2="2400" x1="4832" />
            <wire x2="5024" y1="2400" y2="2400" x1="4832" />
        </branch>
        <branch name="R_M4IN(15:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4112" y="2160" type="branch" />
            <wire x2="4112" y1="2160" y2="2160" x1="3760" />
            <wire x2="4352" y1="2160" y2="2160" x1="4112" />
        </branch>
        <branch name="CF0D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4288" y="2352" type="branch" />
            <wire x2="4352" y1="2352" y2="2352" x1="4288" />
        </branch>
        <instance x="5472" y="2240" name="XLXI_425" orien="R0">
        </instance>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="5424" y="2208" type="branch" />
            <wire x2="5472" y1="2208" y2="2208" x1="5424" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="5424" y="2688" type="branch" />
            <wire x2="5472" y1="2688" y2="2688" x1="5424" />
        </branch>
        <instance x="5472" y="2720" name="XLXI_427" orien="R0">
        </instance>
        <instance x="5472" y="2480" name="XLXI_426" orien="R0">
        </instance>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="5424" y="2448" type="branch" />
            <wire x2="5472" y1="2448" y2="2448" x1="5424" />
        </branch>
        <branch name="XLXN_1817(15:0)">
            <wire x2="5472" y1="2160" y2="2160" x1="5344" />
        </branch>
        <branch name="XLXN_1818(15:0)">
            <wire x2="5472" y1="2400" y2="2400" x1="5344" />
        </branch>
        <branch name="XLXN_1819(15:0)">
            <wire x2="5472" y1="2640" y2="2640" x1="5344" />
        </branch>
        <branch name="FM_IN_RD_RED(9:0)">
            <wire x2="1680" y1="1664" y2="1664" x1="1488" />
            <wire x2="1680" y1="1664" y2="2160" x1="1680" />
            <wire x2="2160" y1="2160" y2="2160" x1="1680" />
            <wire x2="1920" y1="1664" y2="1664" x1="1680" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2304" y="1668">FM_IN_RD_RED(9:0)</text>
        <branch name="FM_IN_RD_GREEN(9:0)">
            <wire x2="1616" y1="1712" y2="1712" x1="1488" />
            <wire x2="1920" y1="1712" y2="1712" x1="1616" />
            <wire x2="1616" y1="1712" y2="2560" x1="1616" />
            <wire x2="2160" y1="2560" y2="2560" x1="1616" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2304" y="1716">FM_IN_RD_GREEN(9:0)</text>
        <branch name="FM_IN_RD_BLUE(9:0)">
            <wire x2="1552" y1="1760" y2="1760" x1="1488" />
            <wire x2="1920" y1="1760" y2="1760" x1="1552" />
            <wire x2="1552" y1="1760" y2="2960" x1="1552" />
            <wire x2="2160" y1="2960" y2="2960" x1="1552" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2304" y="1764">FM_IN_RD_BLUE(9:0)</text>
        <branch name="FM_OV_WR_D(31:0)">
            <wire x2="7200" y1="2160" y2="2160" x1="7152" />
        </branch>
        <branch name="FM_OV_WR_ADRS(18:0)">
            <wire x2="7200" y1="2208" y2="2208" x1="7152" />
        </branch>
        <branch name="FM_OV_WR_CYCLE">
            <wire x2="7200" y1="2256" y2="2256" x1="7152" />
        </branch>
        <branch name="FM_CYCLE_STP_ADV">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="6576" y="2352" type="branch" />
            <wire x2="6640" y1="2352" y2="2352" x1="6576" />
        </branch>
        <branch name="FM_IV_RD_CYCLE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="6576" y="2400" type="branch" />
            <wire x2="6640" y1="2400" y2="2400" x1="6576" />
        </branch>
        <branch name="FM_IV_WR_CYCLE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="6576" y="2448" type="branch" />
            <wire x2="6640" y1="2448" y2="2448" x1="6576" />
        </branch>
        <text style="fontsize:32;fontname:Arial" x="5924" y="2352">FM_CYCLE_STP_ADV</text>
        <text style="fontsize:32;fontname:Arial" x="5924" y="2400">FM_IV_RD_CYCLE</text>
        <text style="fontsize:32;fontname:Arial" x="5924" y="2448">FM_IV_WR_CYCLE</text>
        <branch name="XLXN_2105(15:0)">
            <wire x2="6640" y1="2160" y2="2160" x1="5760" />
        </branch>
        <branch name="XLXN_2106(15:0)">
            <wire x2="5824" y1="2400" y2="2400" x1="5760" />
            <wire x2="6640" y1="2208" y2="2208" x1="5824" />
            <wire x2="5824" y1="2208" y2="2400" x1="5824" />
        </branch>
        <branch name="XLXN_2108(15:0)">
            <wire x2="5872" y1="2640" y2="2640" x1="5760" />
            <wire x2="5872" y1="2256" y2="2640" x1="5872" />
            <wire x2="6640" y1="2256" y2="2256" x1="5872" />
        </branch>
        <text style="fontsize:32;fontname:Arial" x="7208" y="2376">FM_OV_WR_ADRS(18:0)</text>
        <text style="fontsize:32;fontname:Arial" x="7208" y="2328">FM_OV_WR_D(31:0)</text>
        <text style="fontsize:32;fontname:Arial" x="7208" y="2424">FM_OV_WR_CYCLE</text>
        <text style="fontsize:40;fontname:Arial" x="4540" y="3768">CHECK</text>
        <branch name="CHECK">
            <wire x2="4976" y1="3760" y2="3760" x1="4880" />
            <wire x2="5024" y1="2256" y2="2256" x1="4976" />
            <wire x2="4976" y1="2256" y2="2496" x1="4976" />
            <wire x2="5024" y1="2496" y2="2496" x1="4976" />
            <wire x2="4976" y1="2496" y2="2736" x1="4976" />
            <wire x2="5024" y1="2736" y2="2736" x1="4976" />
            <wire x2="4976" y1="2736" y2="3760" x1="4976" />
        </branch>
        <branch name="BRIGHTNESS(6:0)">
            <wire x2="3248" y1="3280" y2="3280" x1="3184" />
            <wire x2="3376" y1="2208" y2="2208" x1="3248" />
            <wire x2="3248" y1="2208" y2="2608" x1="3248" />
            <wire x2="3376" y1="2608" y2="2608" x1="3248" />
            <wire x2="3248" y1="2608" y2="3008" x1="3248" />
            <wire x2="3376" y1="3008" y2="3008" x1="3248" />
            <wire x2="3248" y1="3008" y2="3280" x1="3248" />
        </branch>
        <branch name="M4_ON,GAMMA(2:0),CT_BLUE(3:0),CT_GREEN(3:0),CT_RED(3:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4480" y="3600" type="branch" />
            <wire x2="4560" y1="3600" y2="3600" x1="4480" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3276" y="3528">M4_ON,GAMMA(2:0),CT_BLUE(3:0),CT_GREEN(3:0),CT_RED(3:0)</text>
        <text style="fontsize:40;fontname:Arial" x="36" y="1232">CLK</text>
        <text style="fontsize:40;fontname:Arial" x="36" y="1184">FM_RD_D(29:0)</text>
        <text style="fontsize:40;fontname:Arial" x="36" y="1136">FM_IV_WR_CYCLE</text>
        <text style="fontsize:40;fontname:Arial" x="36" y="992">OVP</text>
        <text style="fontsize:40;fontname:Arial" x="36" y="1040">FRAME_ALT</text>
        <text style="fontsize:40;fontname:Arial" x="36" y="1088">FM_CYCLE_STP_ADV</text>
        <branch name="CLK">
            <wire x2="880" y1="1232" y2="1232" x1="800" />
        </branch>
        <branch name="FM_RD_D(29:0)">
            <wire x2="880" y1="1184" y2="1184" x1="800" />
        </branch>
        <branch name="FM_IV_WR_CYCLE">
            <wire x2="880" y1="1136" y2="1136" x1="800" />
        </branch>
        <branch name="OVP">
            <wire x2="880" y1="992" y2="992" x1="800" />
        </branch>
        <branch name="FRAME_ALT">
            <wire x2="880" y1="1040" y2="1040" x1="800" />
        </branch>
        <branch name="FM_CYCLE_STP_ADV">
            <wire x2="880" y1="1088" y2="1088" x1="800" />
        </branch>
        <branch name="FM_IN_VID_RD_ADRS(16:0)">
            <wire x2="1552" y1="992" y2="992" x1="1488" />
        </branch>
        <branch name="FM_IV_RD_CYCLE">
            <wire x2="1552" y1="1040" y2="1040" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2000" y="1044">FM_IV_RD_CYCLE</text>
        <text style="fontsize:40;fontname:Arial" x="2000" y="996">FM_IN_VID_RD_ADRS(16:0)</text>
        <branch name="FM_M4_CF_RD_ADRS(18:0)">
            <wire x2="1552" y1="1088" y2="1088" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2000" y="1092">FM_M4_CF_RD_ADRS(18:0)</text>
        <branch name="CF0D(12:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1552" y="1184" type="branch" />
            <wire x2="1552" y1="1184" y2="1184" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1744" y="1184">CF0D(12:0)</text>
        <branch name="CF1D(12:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1552" y="1232" type="branch" />
            <wire x2="1552" y1="1232" y2="1232" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1744" y="1232">CF1D(12:0)</text>
        <branch name="CF2D(12:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1552" y="1280" type="branch" />
            <wire x2="1552" y1="1280" y2="1280" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1744" y="1280">CF2D(12:0)</text>
        <branch name="CF3D(12:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1552" y="1328" type="branch" />
            <wire x2="1552" y1="1328" y2="1328" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1744" y="1328">CF3D(12:0)</text>
        <branch name="CF4D(12:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1552" y="1376" type="branch" />
            <wire x2="1552" y1="1376" y2="1376" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1744" y="1376">CF4D(12:0)</text>
        <branch name="CF5D(12:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1552" y="1424" type="branch" />
            <wire x2="1552" y1="1424" y2="1424" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1744" y="1424">CF5D(12:0)</text>
        <branch name="CF6D(12:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1552" y="1472" type="branch" />
            <wire x2="1552" y1="1472" y2="1472" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1744" y="1472">CF6D(12:0)</text>
        <branch name="CF7D(12:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1552" y="1520" type="branch" />
            <wire x2="1552" y1="1520" y2="1520" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1744" y="1520">CF7D(12:0)</text>
        <branch name="CF8D(12:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1552" y="1568" type="branch" />
            <wire x2="1552" y1="1568" y2="1568" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1744" y="1568">CF8D(12:0)</text>
        <branch name="PANEL_SEL(3:0)">
            <wire x2="880" y1="1328" y2="1328" x1="800" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="36" y="1328">PANEL_SEL(3:0)</text>
        <text style="fontsize:40;fontname:Arial" x="3920" y="2352">CF0D(12:0)</text>
        <branch name="CF1D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4288" y="2400" type="branch" />
            <wire x2="4352" y1="2400" y2="2400" x1="4288" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3920" y="2400">CF1D(12:0)</text>
        <branch name="CF2D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4288" y="2448" type="branch" />
            <wire x2="4352" y1="2448" y2="2448" x1="4288" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3920" y="2448">CF2D(12:0)</text>
        <branch name="CF3D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4288" y="2496" type="branch" />
            <wire x2="4352" y1="2496" y2="2496" x1="4288" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3920" y="2496">CF3D(12:0)</text>
        <branch name="CF4D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4288" y="2544" type="branch" />
            <wire x2="4352" y1="2544" y2="2544" x1="4288" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3920" y="2544">CF4D(12:0)</text>
        <branch name="CF5D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4288" y="2592" type="branch" />
            <wire x2="4352" y1="2592" y2="2592" x1="4288" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3920" y="2592">CF5D(12:0)</text>
        <branch name="CF6D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4288" y="2640" type="branch" />
            <wire x2="4352" y1="2640" y2="2640" x1="4288" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3920" y="2640">CF6D(12:0)</text>
        <branch name="CF7D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4288" y="2688" type="branch" />
            <wire x2="4352" y1="2688" y2="2688" x1="4288" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3920" y="2688">CF7D(12:0)</text>
        <branch name="CF8D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4288" y="2736" type="branch" />
            <wire x2="4352" y1="2736" y2="2736" x1="4288" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3920" y="2736">CF8D(12:0)</text>
        <iomarker fontsize="28" x="1984" y="2656" name="CT_GREEN(3:0)" orien="R180" />
        <iomarker fontsize="28" x="1984" y="3056" name="CT_BLUE(3:0)" orien="R180" />
        <iomarker fontsize="28" x="1984" y="2256" name="CT_RED(3:0)" orien="R180" />
        <iomarker fontsize="28" x="1984" y="2208" name="GAMMA(2:0)" orien="R180" />
        <iomarker fontsize="28" x="2560" y="3280" name="M4_BRT(6:0)" orien="R180" />
        <iomarker fontsize="28" x="4272" y="2784" name="M4_ON" orien="R180" />
        <iomarker fontsize="28" x="1920" y="1664" name="FM_IN_RD_RED(9:0)" orien="R0" />
        <iomarker fontsize="28" x="1920" y="1712" name="FM_IN_RD_GREEN(9:0)" orien="R0" />
        <iomarker fontsize="28" x="1920" y="1760" name="FM_IN_RD_BLUE(9:0)" orien="R0" />
        <iomarker fontsize="28" x="7200" y="2160" name="FM_OV_WR_D(31:0)" orien="R0" />
        <iomarker fontsize="28" x="7200" y="2208" name="FM_OV_WR_ADRS(18:0)" orien="R0" />
        <iomarker fontsize="28" x="7200" y="2256" name="FM_OV_WR_CYCLE" orien="R0" />
        <iomarker fontsize="28" x="4880" y="3760" name="CHECK" orien="R180" />
        <iomarker fontsize="28" x="800" y="1232" name="CLK" orien="R180" />
        <iomarker fontsize="28" x="800" y="1184" name="FM_RD_D(29:0)" orien="R180" />
        <iomarker fontsize="28" x="800" y="1136" name="FM_IV_WR_CYCLE" orien="R180" />
        <iomarker fontsize="28" x="800" y="1088" name="FM_CYCLE_STP_ADV" orien="R180" />
        <iomarker fontsize="28" x="800" y="1040" name="FRAME_ALT" orien="R180" />
        <iomarker fontsize="28" x="800" y="992" name="OVP" orien="R180" />
        <iomarker fontsize="28" x="1552" y="992" name="FM_IN_VID_RD_ADRS(16:0)" orien="R0" />
        <iomarker fontsize="28" x="1552" y="1040" name="FM_IV_RD_CYCLE" orien="R0" />
        <iomarker fontsize="28" x="1552" y="1088" name="FM_M4_CF_RD_ADRS(18:0)" orien="R0" />
        <iomarker fontsize="28" x="800" y="1328" name="PANEL_SEL(3:0)" orien="R180" />
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4304" y="2880" type="branch" />
            <wire x2="4352" y1="2880" y2="2880" x1="4304" />
        </branch>
        <instance x="4352" y="3024" name="XLXI_456" orien="R0">
        </instance>
        <text style="fontsize:40;fontname:Arial" x="4048" y="2884">CLK</text>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4304" y="2832" type="branch" />
            <wire x2="4352" y1="2832" y2="2832" x1="4304" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4048" y="2836">OVP</text>
        <instance x="4560" y="3680" name="XLXI_459" orien="R0">
        </instance>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4480" y="3648" type="branch" />
            <wire x2="4560" y1="3648" y2="3648" x1="4480" />
        </branch>
        <iomarker fontsize="28" x="3184" y="3280" name="BRIGHTNESS(6:0)" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="2812" y="3340">BRIGHTNESS(6:0)</text>
        <branch name="XLXN_2127(15:0)">
            <wire x2="4912" y1="3600" y2="3600" x1="4848" />
            <wire x2="5024" y1="2208" y2="2208" x1="4912" />
            <wire x2="4912" y1="2208" y2="2448" x1="4912" />
            <wire x2="5024" y1="2448" y2="2448" x1="4912" />
            <wire x2="4912" y1="2448" y2="2688" x1="4912" />
            <wire x2="4912" y1="2688" y2="3600" x1="4912" />
            <wire x2="5024" y1="2688" y2="2688" x1="4912" />
        </branch>
        <branch name="FM_OV_RD_CYCLE">
            <wire x2="880" y1="1424" y2="1424" x1="800" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="36" y="1424">FM_OV_RD_CYCLE</text>
        <iomarker fontsize="28" x="800" y="1424" name="FM_OV_RD_CYCLE" orien="R180" />
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="6576" y="2544" type="branch" />
            <wire x2="6640" y1="2544" y2="2544" x1="6576" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="6576" y="2640" type="branch" />
            <wire x2="6640" y1="2640" y2="2640" x1="6576" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="6008" y="2548">OVP</text>
        <text style="fontsize:40;fontname:Arial" x="6008" y="2636">CLK</text>
        <branch name="FRAME_ALT_FRZ">
            <wire x2="6640" y1="2592" y2="2592" x1="6560" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5920" y="2596">FRAME_ALT_FRZ</text>
        <iomarker fontsize="28" x="6560" y="2592" name="FRAME_ALT_FRZ" orien="R180" />
        <branch name="FM_OV_RD_CYCLE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="6576" y="2496" type="branch" />
            <wire x2="6640" y1="2496" y2="2496" x1="6576" />
        </branch>
        <text style="fontsize:32;fontname:Arial" x="5924" y="2496">FM_OV_RD_CYCLE</text>
        <instance x="6640" y="2704" name="fm_out0" orien="R0">
        </instance>
        <instance x="3376" y="2384" name="XLXI_473" orien="R0">
        </instance>
        <instance x="3376" y="2784" name="XLXI_474" orien="R0">
        </instance>
        <instance x="3376" y="3184" name="XLXI_475" orien="R0">
        </instance>
        <instance x="2800" y="2384" name="XLXI_476" orien="R0">
        </instance>
        <instance x="2800" y="2784" name="XLXI_477" orien="R0">
        </instance>
        <instance x="2800" y="3184" name="XLXI_478" orien="R0">
        </instance>
        <instance x="880" y="1792" name="fm_in0" orien="R0">
        </instance>
    </sheet>
</drawing>
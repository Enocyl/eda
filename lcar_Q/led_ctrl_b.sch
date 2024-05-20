<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="aspartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="DSW_IM_DOWNLOAD_ON" />
        <signal name="IM_DOWNLOAD_EXE_TIM" />
        <signal name="IM_ERR_DET" />
        <signal name="CLK" />
        <signal name="C_DONE" />
        <signal name="FRAME_ALT" />
        <signal name="VER(7:0)" />
        <signal name="CSUM_ERR_SEL" />
        <signal name="PA_RX_OK" />
        <signal name="BLINK_ON_TIME" />
        <signal name="XLXN_802" />
        <signal name="XLXN_561" />
        <signal name="PA_LINK_ON" />
        <signal name="PA_CSUM_ERR" />
        <signal name="XLXN_658" />
        <signal name="LED_A" />
        <signal name="XLXN_664" />
        <signal name="XLXN_685" />
        <signal name="XLXN_795" />
        <signal name="XLXN_796" />
        <signal name="SEL_PORT_B" />
        <signal name="PA_LED1" />
        <signal name="XLXN_800" />
        <signal name="XLXN_657" />
        <signal name="PA_LED2" />
        <signal name="XLXN_595" />
        <signal name="XLXN_848" />
        <port polarity="Input" name="DSW_IM_DOWNLOAD_ON" />
        <port polarity="Input" name="IM_DOWNLOAD_EXE_TIM" />
        <port polarity="Input" name="IM_ERR_DET" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="C_DONE" />
        <port polarity="Input" name="FRAME_ALT" />
        <port polarity="Input" name="VER(7:0)" />
        <port polarity="Input" name="CSUM_ERR_SEL" />
        <port polarity="Input" name="PA_RX_OK" />
        <port polarity="Output" name="PA_LINK_ON" />
        <port polarity="Input" name="PA_CSUM_ERR" />
        <port polarity="Output" name="LED_A" />
        <port polarity="Input" name="SEL_PORT_B" />
        <port polarity="Input" name="PA_LED1" />
        <port polarity="Input" name="PA_LED2" />
        <blockdef name="ibuf">
            <timestamp>2009-3-20T10:10:10</timestamp>
            <line x2="64" y1="0" y2="-64" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <blockdef name="m2_1">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="96" y1="-64" y2="-192" x1="96" />
            <line x2="96" y1="-96" y2="-64" x1="256" />
            <line x2="256" y1="-160" y2="-96" x1="256" />
            <line x2="256" y1="-192" y2="-160" x1="96" />
            <line x2="96" y1="-32" y2="-32" x1="176" />
            <line x2="176" y1="-80" y2="-32" x1="176" />
            <line x2="96" y1="-32" y2="-32" x1="0" />
            <line x2="256" y1="-128" y2="-128" x1="320" />
            <line x2="96" y1="-96" y2="-96" x1="0" />
            <line x2="96" y1="-160" y2="-160" x1="0" />
        </blockdef>
        <blockdef name="obuf">
            <timestamp>2009-3-20T10:10:10</timestamp>
            <line x2="64" y1="0" y2="-64" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
        </blockdef>
        <blockdef name="and2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <blockdef name="version_disp_xt">
            <timestamp>2015-2-11T2:17:13</timestamp>
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="16" y2="16" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-176" y2="-176" x1="64" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
            <line x2="384" y1="-128" y2="-128" x1="320" />
            <line x2="384" y1="-80" y2="-80" x1="320" />
            <rect width="256" x="64" y="-256" height="400" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-176" y2="-176" x1="320" />
            <line x2="0" y1="64" y2="64" x1="64" />
            <line x2="0" y1="112" y2="112" x1="64" />
        </blockdef>
        <blockdef name="or2b1">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="32" y1="-64" y2="-64" x1="0" />
            <circle r="12" cx="44" cy="-64" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
        </blockdef>
        <blockdef name="led_blink_brt">
            <timestamp>2015-7-18T9:17:38</timestamp>
            <rect width="256" x="64" y="-256" height="208" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="0" y1="-176" y2="-176" x1="64" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
        </blockdef>
        <blockdef name="link_on_in_filter">
            <timestamp>2017-3-23T6:16:25</timestamp>
            <rect width="128" x="64" y="-128" height="112" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-48" y2="-48" x1="64" />
            <line x2="256" y1="-96" y2="-96" x1="192" />
        </blockdef>
        <block symbolname="version_disp_xt" name="XLXI_265">
            <blockpin signalname="FRAME_ALT" name="frame_alt" />
            <blockpin signalname="C_DONE" name="c_done" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin name="dsw_im_download_on" />
            <blockpin name="im_download_exe_tim" />
            <blockpin signalname="VER(7:0)" name="ver(7:0)" />
            <blockpin name="ver_disp" />
            <blockpin signalname="XLXN_657" name="ex_disp" />
            <blockpin signalname="XLXN_802" name="ld1_on" />
            <blockpin name="ld2_on" />
            <blockpin signalname="IM_ERR_DET" name="im_err_det" />
            <blockpin name="dipsw2_on" />
        </block>
        <block symbolname="led_blink_brt" name="XLXI_283">
            <blockpin signalname="C_DONE" name="c_done" />
            <blockpin signalname="BLINK_ON_TIME" name="blink_on_time" />
            <blockpin signalname="PA_RX_OK" name="pa_rx_ok" />
            <blockpin name="pb_rx_ok" />
            <blockpin signalname="CLK" name="clk" />
        </block>
        <block symbolname="m2_1" name="XLXI_245">
            <blockpin signalname="XLXN_561" name="D0" />
            <blockpin signalname="PA_CSUM_ERR" name="D1" />
            <blockpin signalname="CSUM_ERR_SEL" name="S0" />
            <blockpin signalname="XLXN_658" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_263">
            <blockpin signalname="PA_LINK_ON" name="I0" />
            <blockpin signalname="XLXN_685" name="I1" />
            <blockpin signalname="XLXN_561" name="O" />
        </block>
        <block symbolname="m2_1" name="XLXI_268">
            <blockpin signalname="XLXN_658" name="D0" />
            <blockpin signalname="XLXN_802" name="D1" />
            <blockpin signalname="XLXN_657" name="S0" />
            <blockpin signalname="XLXN_664" name="O" />
        </block>
        <block symbolname="obuf" name="XLXI_5">
            <blockpin signalname="XLXN_664" name="I" />
            <blockpin signalname="LED_A" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_320">
            <blockpin signalname="XLXN_796" name="I0" />
            <blockpin signalname="XLXN_800" name="I1" />
            <blockpin signalname="XLXN_795" name="O" />
        </block>
        <block symbolname="or2b1" name="XLXI_321">
            <blockpin signalname="SEL_PORT_B" name="I0" />
            <blockpin signalname="BLINK_ON_TIME" name="I1" />
            <blockpin signalname="XLXN_796" name="O" />
        </block>
        <block symbolname="or2b1" name="XLXI_278">
            <blockpin signalname="PA_CSUM_ERR" name="I0" />
            <blockpin signalname="XLXN_795" name="I1" />
            <blockpin signalname="XLXN_685" name="O" />
        </block>
        <block symbolname="ibuf" name="XLXI_1">
            <blockpin signalname="PA_LED1" name="I" />
            <blockpin signalname="XLXN_800" name="O" />
        </block>
        <block symbolname="link_on_in_filter" name="XLXI_345">
            <blockpin signalname="XLXN_848" name="din" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="PA_LINK_ON" name="dout" />
        </block>
        <block symbolname="ibuf" name="XLXI_2">
            <blockpin signalname="PA_LED2" name="I" />
            <blockpin signalname="XLXN_595" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_255">
            <blockpin signalname="XLXN_595" name="I" />
            <blockpin signalname="XLXN_848" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="5382" height="3801">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="4864" y="3584">led_ctrl_b</text>
        <text style="fontsize:40;fontname:Arial" x="960" y="1920">CSUM_ERR_SEL</text>
        <branch name="DSW_IM_DOWNLOAD_ON">
            <wire x2="1632" y1="2432" y2="2432" x1="1600" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="664" y="2432">DSW_IM_DOWNLOAD_ON</text>
        <branch name="IM_DOWNLOAD_EXE_TIM">
            <wire x2="1632" y1="2480" y2="2480" x1="1600" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="664" y="2480">IM_DOWNLOAD_EXE_TIM</text>
        <branch name="IM_ERR_DET">
            <wire x2="1680" y1="2528" y2="2528" x1="1600" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="664" y="2528">IM_ERR_DET</text>
        <text style="fontsize:40;fontname:Arial" x="664" y="2576">DIPSW2_ON</text>
        <branch name="CLK">
            <wire x2="1680" y1="2384" y2="2384" x1="1600" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="664" y="2384">CLK</text>
        <branch name="C_DONE">
            <wire x2="1680" y1="2336" y2="2336" x1="1600" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="664" y="2336">C_DONE</text>
        <branch name="FRAME_ALT">
            <wire x2="1680" y1="2288" y2="2288" x1="1600" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="664" y="2288">FRAME_ALT</text>
        <branch name="VER(7:0)">
            <wire x2="1680" y1="2240" y2="2240" x1="1600" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="664" y="2240">VER(7:0)</text>
        <instance x="1680" y="3104" name="XLXI_283" orien="R0">
        </instance>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1600" y="2880" type="branch" />
            <wire x2="1680" y1="2880" y2="2880" x1="1600" />
        </branch>
        <branch name="PA_RX_OK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1600" y="2928" type="branch" />
            <wire x2="1680" y1="2928" y2="2928" x1="1600" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1600" y="3024" type="branch" />
            <wire x2="1680" y1="3024" y2="3024" x1="1600" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1188" y="2880">C_DONE</text>
        <text style="fontsize:40;fontname:Arial" x="1188" y="2928">PA_RX_OK</text>
        <text style="fontsize:40;fontname:Arial" x="1188" y="2976">PB_RX_OK</text>
        <text style="fontsize:40;fontname:Arial" x="1188" y="3024">CLK</text>
        <branch name="BLINK_ON_TIME">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="2144" y="2880" type="branch" />
            <wire x2="2144" y1="2880" y2="2880" x1="2064" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2420" y="2880">BLINK_ON_TIME</text>
        <iomarker fontsize="28" x="1600" y="1920" name="CSUM_ERR_SEL" orien="R180" />
        <iomarker fontsize="28" x="1600" y="2240" name="VER(7:0)" orien="R180" />
        <iomarker fontsize="28" x="1600" y="2288" name="FRAME_ALT" orien="R180" />
        <iomarker fontsize="28" x="1600" y="2336" name="C_DONE" orien="R180" />
        <iomarker fontsize="28" x="1600" y="2384" name="CLK" orien="R180" />
        <iomarker fontsize="28" x="1600" y="2432" name="DSW_IM_DOWNLOAD_ON" orien="R180" />
        <iomarker fontsize="28" x="1600" y="2480" name="IM_DOWNLOAD_EXE_TIM" orien="R180" />
        <iomarker fontsize="28" x="1600" y="2528" name="IM_ERR_DET" orien="R180" />
        <branch name="XLXN_802">
            <wire x2="2928" y1="2240" y2="2240" x1="2064" />
            <wire x2="3120" y1="848" y2="848" x1="2928" />
            <wire x2="2928" y1="848" y2="2240" x1="2928" />
        </branch>
        <branch name="XLXN_561">
            <wire x2="2528" y1="752" y2="752" x1="2336" />
        </branch>
        <branch name="PA_CSUM_ERR">
            <wire x2="2400" y1="992" y2="992" x1="1600" />
            <wire x2="2528" y1="816" y2="816" x1="2400" />
            <wire x2="2400" y1="816" y2="992" x1="2400" />
        </branch>
        <branch name="XLXN_658">
            <wire x2="3120" y1="784" y2="784" x1="2848" />
        </branch>
        <branch name="LED_A">
            <wire x2="3840" y1="816" y2="816" x1="3760" />
        </branch>
        <branch name="XLXN_664">
            <wire x2="3536" y1="816" y2="816" x1="3440" />
        </branch>
        <instance x="2528" y="912" name="XLXI_245" orien="R0" />
        <instance x="2080" y="848" name="XLXI_263" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="960" y="992">PA_CSUM_ERR</text>
        <instance x="3120" y="944" name="XLXI_268" orien="R0" />
        <instance x="3536" y="848" name="XLXI_5" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="3860" y="740">LED_A</text>
        <instance x="1360" y="528" name="XLXI_320" orien="R0" />
        <instance x="976" y="624" name="XLXI_321" orien="R0" />
        <branch name="XLXN_685">
            <wire x2="2032" y1="464" y2="464" x1="1984" />
            <wire x2="2032" y1="464" y2="720" x1="2032" />
            <wire x2="2080" y1="720" y2="720" x1="2032" />
        </branch>
        <instance x="1728" y="560" name="XLXI_278" orien="R0" />
        <branch name="XLXN_795">
            <wire x2="1728" y1="432" y2="432" x1="1616" />
        </branch>
        <branch name="XLXN_796">
            <wire x2="1296" y1="528" y2="528" x1="1232" />
            <wire x2="1360" y1="464" y2="464" x1="1296" />
            <wire x2="1296" y1="464" y2="528" x1="1296" />
        </branch>
        <branch name="BLINK_ON_TIME">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="896" y="496" type="branch" />
            <wire x2="976" y1="496" y2="496" x1="896" />
        </branch>
        <branch name="SEL_PORT_B">
            <wire x2="976" y1="560" y2="560" x1="880" />
        </branch>
        <branch name="PA_LED1">
            <wire x2="960" y1="400" y2="400" x1="880" />
        </branch>
        <instance x="960" y="432" name="XLXI_1" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="412" y="400">PA_LED1</text>
        <text style="fontsize:40;fontname:Arial" x="308" y="496">BLINK_ON_TIME</text>
        <text style="fontsize:40;fontname:Arial" x="336" y="564">SEL_PORT_B</text>
        <branch name="XLXN_800">
            <wire x2="1360" y1="400" y2="400" x1="1184" />
        </branch>
        <branch name="XLXN_657">
            <wire x2="3056" y1="2336" y2="2336" x1="2064" />
            <wire x2="3120" y1="912" y2="912" x1="3056" />
            <wire x2="3056" y1="912" y2="1712" x1="3056" />
            <wire x2="3056" y1="1712" y2="2336" x1="3056" />
        </branch>
        <iomarker fontsize="28" x="1600" y="992" name="PA_CSUM_ERR" orien="R180" />
        <iomarker fontsize="28" x="3840" y="816" name="LED_A" orien="R0" />
        <iomarker fontsize="28" x="880" y="400" name="PA_LED1" orien="R180" />
        <iomarker fontsize="28" x="880" y="560" name="SEL_PORT_B" orien="R180" />
        <branch name="CSUM_ERR_SEL">
            <wire x2="2464" y1="1920" y2="1920" x1="1600" />
            <wire x2="2528" y1="880" y2="880" x1="2464" />
            <wire x2="2464" y1="880" y2="1680" x1="2464" />
            <wire x2="2464" y1="1680" y2="1920" x1="2464" />
        </branch>
        <branch name="PA_LINK_ON">
            <wire x2="2032" y1="784" y2="784" x1="1936" />
            <wire x2="2032" y1="784" y2="880" x1="2032" />
            <wire x2="2080" y1="880" y2="880" x1="2032" />
            <wire x2="2080" y1="784" y2="784" x1="2032" />
        </branch>
        <branch name="PA_LED2">
            <wire x2="960" y1="784" y2="784" x1="880" />
        </branch>
        <branch name="XLXN_595">
            <wire x2="1248" y1="784" y2="784" x1="1184" />
        </branch>
        <instance x="960" y="816" name="XLXI_2" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="412" y="784">PA_LED2</text>
        <instance x="1248" y="816" name="XLXI_255" orien="R0" />
        <iomarker fontsize="28" x="880" y="784" name="PA_LED2" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="2076" y="928">PA_LINK_ON</text>
        <iomarker fontsize="28" x="2080" y="880" name="PA_LINK_ON" orien="R0" />
        <instance x="1680" y="880" name="XLXI_345" orien="R0">
        </instance>
        <branch name="XLXN_848">
            <wire x2="1680" y1="784" y2="784" x1="1472" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1632" y="832" type="branch" />
            <wire x2="1680" y1="832" y2="832" x1="1632" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="444" y="660">PA_RX_OK</text>
        <iomarker fontsize="28" x="864" y="672" name="PA_RX_OK" orien="R180" />
        <branch name="PA_RX_OK">
            <wire x2="912" y1="672" y2="672" x1="864" />
        </branch>
        <branch name="PA_CSUM_ERR">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1504" y="656" type="branch" />
            <wire x2="1680" y1="656" y2="656" x1="1504" />
            <wire x2="1728" y1="496" y2="496" x1="1680" />
            <wire x2="1680" y1="496" y2="656" x1="1680" />
        </branch>
        <instance x="1680" y="2464" name="XLXI_265" orien="R0">
        </instance>
    </sheet>
</drawing>
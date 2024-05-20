<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="aspartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="LINK_ON" />
        <signal name="L" />
        <signal name="txd_in(7:0)" />
        <signal name="txen_in" />
        <signal name="TX_CLK" />
        <signal name="DST_MAC(47:0)" />
        <signal name="DST_PORT(15:0)" />
        <signal name="DST_IP(31:0)" />
        <signal name="SRC_MAC(47:0)" />
        <signal name="SRC_IP(31:0)" />
        <signal name="SRC_PORT(15:0)" />
        <signal name="TX_EN" />
        <signal name="TXD(3:0)" />
        <signal name="tx_done" />
        <signal name="tcm_ra(8:0)" />
        <signal name="POWER1(15:0)" />
        <signal name="RX_OK" />
        <signal name="CLK25M" />
        <signal name="TEMP1(15:0)" />
        <signal name="TEMP2(15:0)" />
        <signal name="HUMID1(15:0)" />
        <signal name="HUMID2(15:0)" />
        <signal name="tcm_e" />
        <signal name="tcm_v" />
        <signal name="frame_alt" />
        <signal name="POWER2(15:0)" />
        <signal name="tcm_wd(7:0)" />
        <signal name="SS_NE" />
        <port polarity="Input" name="LINK_ON" />
        <port polarity="Input" name="TX_CLK" />
        <port polarity="Input" name="DST_MAC(47:0)" />
        <port polarity="Input" name="DST_PORT(15:0)" />
        <port polarity="Input" name="DST_IP(31:0)" />
        <port polarity="Input" name="SRC_MAC(47:0)" />
        <port polarity="Input" name="SRC_IP(31:0)" />
        <port polarity="Input" name="SRC_PORT(15:0)" />
        <port polarity="Output" name="TX_EN" />
        <port polarity="Output" name="TXD(3:0)" />
        <port polarity="Input" name="POWER1(15:0)" />
        <port polarity="Input" name="RX_OK" />
        <port polarity="Input" name="CLK25M" />
        <port polarity="Input" name="TEMP1(15:0)" />
        <port polarity="Input" name="TEMP2(15:0)" />
        <port polarity="Input" name="HUMID1(15:0)" />
        <port polarity="Input" name="HUMID2(15:0)" />
        <port polarity="Input" name="tcm_e" />
        <port polarity="Input" name="tcm_v" />
        <port polarity="Input" name="frame_alt" />
        <port polarity="Input" name="POWER2(15:0)" />
        <port polarity="Input" name="tcm_wd(7:0)" />
        <port polarity="Input" name="SS_NE" />
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="tx_mii_udp">
            <timestamp>2021-11-18T9:20:57</timestamp>
            <line x2="416" y1="96" y2="96" x1="352" />
            <rect width="64" x="352" y="148" height="24" />
            <line x2="416" y1="160" y2="160" x1="352" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="0" y="-364" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="416" y1="-544" y2="-544" x1="352" />
            <rect width="64" x="352" y="-556" height="24" />
            <line x2="416" y1="-608" y2="-608" x1="352" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <rect width="288" x="64" y="-640" height="832" />
        </blockdef>
        <blockdef name="rtn_mux_lcar_ru">
            <timestamp>2021-11-25T8:46:16</timestamp>
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="-1056" y2="-1056" x1="64" />
            <line x2="0" y1="-992" y2="-992" x1="64" />
            <line x2="0" y1="-864" y2="-864" x1="64" />
            <line x2="0" y1="-800" y2="-800" x1="64" />
            <line x2="0" y1="-736" y2="-736" x1="64" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <rect width="64" x="0" y="-492" height="24" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <rect width="64" x="0" y="-364" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-1056" y2="-1056" x1="320" />
            <line x2="384" y1="-544" y2="-544" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-1088" height="1152" />
        </blockdef>
        <block symbolname="gnd" name="XLXI_80">
            <blockpin signalname="L" name="G" />
        </block>
        <block symbolname="tx_mii_udp" name="tx_mii_udp_0">
            <blockpin signalname="TX_CLK" name="clk" />
            <blockpin signalname="LINK_ON" name="c_done" />
            <blockpin signalname="txen_in" name="txen_in" />
            <blockpin signalname="txd_in(7:0)" name="txd_in(7:0)" />
            <blockpin signalname="DST_MAC(47:0)" name="dst_mac(47:0)" />
            <blockpin signalname="DST_PORT(15:0)" name="dst_port(15:0)" />
            <blockpin signalname="DST_IP(31:0)" name="dst_ip(31:0)" />
            <blockpin signalname="SRC_MAC(47:0)" name="src_mac(47:0)" />
            <blockpin signalname="SRC_IP(31:0)" name="src_ip(31:0)" />
            <blockpin signalname="SRC_PORT(15:0)" name="src_port(15:0)" />
            <blockpin signalname="TX_EN" name="mii_txen" />
            <blockpin signalname="TXD(3:0)" name="mii_txd(3:0)" />
            <blockpin signalname="tx_done" name="tx_done" />
            <blockpin signalname="tcm_ra(8:0)" name="tcm_ra(8:0)" />
        </block>
        <block symbolname="rtn_mux_lcar_ru" name="rtn_mux_0">
            <blockpin signalname="RX_OK" name="rx_ok" />
            <blockpin signalname="LINK_ON" name="link_on" />
            <blockpin signalname="TX_CLK" name="tx_clk" />
            <blockpin signalname="CLK25M" name="clk25M" />
            <blockpin signalname="tcm_e" name="tcm_e" />
            <blockpin signalname="tcm_v" name="tcm_v" />
            <blockpin signalname="tx_done" name="tx_done" />
            <blockpin signalname="frame_alt" name="frame_alt" />
            <blockpin signalname="POWER1(15:0)" name="power1(15:0)" />
            <blockpin signalname="POWER2(15:0)" name="power2(15:0)" />
            <blockpin signalname="TEMP1(15:0)" name="temp1(15:0)" />
            <blockpin signalname="TEMP2(15:0)" name="temp2(15:0)" />
            <blockpin signalname="HUMID1(15:0)" name="humid1(15:0)" />
            <blockpin signalname="HUMID2(15:0)" name="humid2(15:0)" />
            <blockpin signalname="tcm_ra(8:0)" name="tcm_ra(8:0)" />
            <blockpin signalname="tcm_wd(7:0)" name="tcm_wd(7:0)" />
            <blockpin signalname="txen_in" name="tx_en" />
            <blockpin name="tx_on" />
            <blockpin signalname="txd_in(7:0)" name="dout(7:0)" />
            <blockpin signalname="SS_NE" name="ss_ne" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="7036" y="5224">tx_process</text>
        <instance x="2256" y="2928" name="XLXI_80" orien="R0" />
        <branch name="L">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="2368" y="2752" type="branch" />
            <wire x2="2320" y1="2752" y2="2800" x1="2320" />
            <wire x2="2368" y1="2752" y2="2752" x1="2320" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2440" y="2752">L</text>
        <branch name="TX_CLK">
            <wire x2="3712" y1="1296" y2="1296" x1="3696" />
            <wire x2="3744" y1="1296" y2="1296" x1="3712" />
        </branch>
        <branch name="LINK_ON">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3696" y="1360" type="branch" />
            <wire x2="3712" y1="1360" y2="1360" x1="3696" />
            <wire x2="3744" y1="1360" y2="1360" x1="3712" />
        </branch>
        <branch name="txen_in">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3696" y="1424" type="branch" />
            <wire x2="3712" y1="1424" y2="1424" x1="3696" />
            <wire x2="3744" y1="1424" y2="1424" x1="3712" />
        </branch>
        <branch name="txd_in(7:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3696" y="1488" type="branch" />
            <wire x2="3712" y1="1488" y2="1488" x1="3696" />
            <wire x2="3744" y1="1488" y2="1488" x1="3712" />
        </branch>
        <branch name="DST_MAC(47:0)">
            <wire x2="3712" y1="1552" y2="1552" x1="3696" />
            <wire x2="3744" y1="1552" y2="1552" x1="3712" />
        </branch>
        <branch name="DST_PORT(15:0)">
            <wire x2="3712" y1="1616" y2="1616" x1="3696" />
            <wire x2="3744" y1="1616" y2="1616" x1="3712" />
        </branch>
        <branch name="DST_IP(31:0)">
            <wire x2="3712" y1="1680" y2="1680" x1="3696" />
            <wire x2="3744" y1="1680" y2="1680" x1="3712" />
        </branch>
        <branch name="SRC_MAC(47:0)">
            <wire x2="3712" y1="1744" y2="1744" x1="3696" />
            <wire x2="3744" y1="1744" y2="1744" x1="3712" />
        </branch>
        <branch name="SRC_IP(31:0)">
            <wire x2="3712" y1="1808" y2="1808" x1="3696" />
            <wire x2="3744" y1="1808" y2="1808" x1="3712" />
        </branch>
        <branch name="SRC_PORT(15:0)">
            <wire x2="3712" y1="1872" y2="1872" x1="3696" />
            <wire x2="3744" y1="1872" y2="1872" x1="3712" />
        </branch>
        <instance x="3744" y="1904" name="tx_mii_udp_0" orien="R0">
        </instance>
        <branch name="TX_EN">
            <wire x2="4176" y1="1296" y2="1296" x1="4160" />
            <wire x2="4208" y1="1296" y2="1296" x1="4176" />
            <wire x2="4224" y1="1296" y2="1296" x1="4208" />
        </branch>
        <branch name="TXD(3:0)">
            <wire x2="4176" y1="1360" y2="1360" x1="4160" />
            <wire x2="4208" y1="1360" y2="1360" x1="4176" />
            <wire x2="4224" y1="1360" y2="1360" x1="4208" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4420" y="1308">TXD(3:0)</text>
        <text style="fontsize:40;fontname:Arial" x="4420" y="1356">TX_EN</text>
        <iomarker fontsize="28" x="3696" y="1296" name="TX_CLK" orien="R180" />
        <iomarker fontsize="28" x="3696" y="1552" name="DST_MAC(47:0)" orien="R180" />
        <iomarker fontsize="28" x="3696" y="1616" name="DST_PORT(15:0)" orien="R180" />
        <iomarker fontsize="28" x="3696" y="1680" name="DST_IP(31:0)" orien="R180" />
        <iomarker fontsize="28" x="3696" y="1744" name="SRC_MAC(47:0)" orien="R180" />
        <iomarker fontsize="28" x="3696" y="1808" name="SRC_IP(31:0)" orien="R180" />
        <iomarker fontsize="28" x="3696" y="1872" name="SRC_PORT(15:0)" orien="R180" />
        <iomarker fontsize="28" x="4224" y="1296" name="TX_EN" orien="R0" />
        <iomarker fontsize="28" x="4224" y="1360" name="TXD(3:0)" orien="R0" />
        <branch name="tx_done">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="4192" y="2000" type="branch" />
            <wire x2="4192" y1="2000" y2="2000" x1="4160" />
        </branch>
        <branch name="tcm_ra(8:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="4192" y="2064" type="branch" />
            <wire x2="4192" y1="2064" y2="2064" x1="4160" />
        </branch>
        <branch name="POWER1(15:0)">
            <wire x2="2480" y1="1744" y2="1744" x1="2400" />
            <wire x2="2496" y1="1744" y2="1744" x1="2480" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1772" y="1744">POWER1(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1772" y="1792">POWER2(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1772" y="1840">POWER3(15:0)</text>
        <instance x="2496" y="2224" name="rtn_mux_0" orien="R0">
        </instance>
        <branch name="RX_OK">
            <wire x2="2480" y1="1168" y2="1168" x1="2400" />
            <wire x2="2496" y1="1168" y2="1168" x1="2480" />
        </branch>
        <branch name="LINK_ON">
            <wire x2="2480" y1="1232" y2="1232" x1="2400" />
            <wire x2="2496" y1="1232" y2="1232" x1="2480" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2032" y="1168">RX_OK</text>
        <text style="fontsize:40;fontname:Arial" x="2012" y="1236">LINK_ON</text>
        <branch name="CLK25M">
            <wire x2="2496" y1="1424" y2="1424" x1="2416" />
        </branch>
        <branch name="TX_CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2416" y="1360" type="branch" />
            <wire x2="2496" y1="1360" y2="1360" x1="2416" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1756" y="1888">TEMP1(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1756" y="1936">TEMP2(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1756" y="1984">HUMID1(15:0)</text>
        <branch name="TEMP1(15:0)">
            <wire x2="2480" y1="1872" y2="1872" x1="2384" />
            <wire x2="2496" y1="1872" y2="1872" x1="2480" />
        </branch>
        <branch name="TEMP2(15:0)">
            <wire x2="2480" y1="1936" y2="1936" x1="2384" />
            <wire x2="2496" y1="1936" y2="1936" x1="2480" />
        </branch>
        <branch name="HUMID1(15:0)">
            <wire x2="2480" y1="2000" y2="2000" x1="2384" />
            <wire x2="2496" y1="2000" y2="2000" x1="2480" />
        </branch>
        <branch name="HUMID2(15:0)">
            <wire x2="2480" y1="2064" y2="2064" x1="2384" />
            <wire x2="2496" y1="2064" y2="2064" x1="2480" />
        </branch>
        <branch name="tcm_e">
            <wire x2="2496" y1="1488" y2="1488" x1="2416" />
        </branch>
        <branch name="tcm_v">
            <wire x2="2496" y1="1552" y2="1552" x1="2416" />
        </branch>
        <branch name="tx_done">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2416" y="1616" type="branch" />
            <wire x2="2496" y1="1616" y2="1616" x1="2416" />
        </branch>
        <branch name="frame_alt">
            <wire x2="2496" y1="1680" y2="1680" x1="2416" />
        </branch>
        <branch name="POWER2(15:0)">
            <wire x2="2480" y1="1808" y2="1808" x1="2400" />
            <wire x2="2496" y1="1808" y2="1808" x1="2480" />
        </branch>
        <branch name="tcm_ra(8:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2384" y="2128" type="branch" />
            <wire x2="2496" y1="2128" y2="2128" x1="2384" />
        </branch>
        <branch name="tcm_wd(7:0)">
            <wire x2="2400" y1="2192" y2="2192" x1="2384" />
            <wire x2="2496" y1="2192" y2="2192" x1="2400" />
        </branch>
        <branch name="txd_in(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2992" y="2192" type="branch" />
            <wire x2="2928" y1="2192" y2="2192" x1="2880" />
            <wire x2="2960" y1="2192" y2="2192" x1="2928" />
            <wire x2="2992" y1="2192" y2="2192" x1="2960" />
        </branch>
        <branch name="txen_in">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2992" y="1168" type="branch" />
            <wire x2="2912" y1="1168" y2="1168" x1="2880" />
            <wire x2="2960" y1="1168" y2="1168" x1="2912" />
            <wire x2="2992" y1="1168" y2="1168" x1="2960" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1756" y="2060">HUMID2(15:0)</text>
        <iomarker fontsize="28" x="2400" y="1168" name="RX_OK" orien="R180" />
        <iomarker fontsize="28" x="2400" y="1232" name="LINK_ON" orien="R180" />
        <iomarker fontsize="28" x="2416" y="1424" name="CLK25M" orien="R180" />
        <iomarker fontsize="28" x="2400" y="1744" name="POWER1(15:0)" orien="R180" />
        <iomarker fontsize="28" x="2384" y="1872" name="TEMP1(15:0)" orien="R180" />
        <iomarker fontsize="28" x="2400" y="1808" name="POWER2(15:0)" orien="R180" />
        <iomarker fontsize="28" x="2384" y="2064" name="HUMID2(15:0)" orien="R180" />
        <iomarker fontsize="28" x="2384" y="2000" name="HUMID1(15:0)" orien="R180" />
        <iomarker fontsize="28" x="2384" y="1936" name="TEMP2(15:0)" orien="R180" />
        <iomarker fontsize="28" x="2416" y="1680" name="frame_alt" orien="R180" />
        <iomarker fontsize="28" x="2416" y="1488" name="tcm_e" orien="R180" />
        <iomarker fontsize="28" x="2416" y="1552" name="tcm_v" orien="R180" />
        <iomarker fontsize="28" x="2384" y="2192" name="tcm_wd(7:0)" orien="R180" />
        <branch name="SS_NE">
            <wire x2="2496" y1="2256" y2="2256" x1="2384" />
        </branch>
        <iomarker fontsize="28" x="2384" y="2256" name="SS_NE" orien="R180" />
    </sheet>
</drawing>
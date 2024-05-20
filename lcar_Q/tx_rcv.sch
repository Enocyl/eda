<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="aspartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="PA_TXD(3:0)" />
        <signal name="PA_TX_EN" />
        <signal name="PA_LINK_ON" />
        <signal name="SENS_SCL_TP" />
        <signal name="XLXN_86" />
        <signal name="XLXN_89" />
        <signal name="SENS_SDA" />
        <signal name="SENS_SCL" />
        <signal name="SENS_SDA_TP" />
        <signal name="FRAME_ALT" />
        <signal name="C_DONE" />
        <signal name="SENS_POWER(15:0)" />
        <signal name="SENS_HUMID(15:0)" />
        <signal name="SENS_TEMP(15:0)" />
        <signal name="CLK25M" />
        <signal name="EMB_TX_DATA(79:0)" />
        <signal name="EMB_RXD" />
        <signal name="EMB_TX_REQ" />
        <signal name="RX_FAN_ON" />
        <signal name="STARTN_DLY" />
        <signal name="STARTN" />
        <signal name="CLK72M" />
        <signal name="EMB_RSP_DATA(79:0)" />
        <signal name="EMB_RSP_REQ" />
        <signal name="EMB_TXD" />
        <signal name="EMB_POWER1(15:0)" />
        <signal name="EMB_POWER2(15:0)" />
        <signal name="EMB_POWER3(15:0)" />
        <signal name="EMB_POWER4(15:0)" />
        <signal name="EMB_POWER5(15:0)" />
        <signal name="EMB_POWER6(15:0)" />
        <signal name="EMB_POWER7(15:0)" />
        <signal name="EMB_POWER8(15:0)" />
        <signal name="EMB_TEMP(15:0)" />
        <signal name="EMB_HUMID(15:0)" />
        <signal name="RH_CSUM_OK_P" />
        <signal name="TMP_CSUM_OK_P" />
        <signal name="PA_DST_MAC(47:0)" />
        <signal name="PA_DST_PORT(15:0)" />
        <signal name="PA_DST_IP(31:0)" />
        <signal name="PA_SRC_MAC(47:0)" />
        <signal name="PA_SRC_PORT(15:0)" />
        <signal name="PA_SRC_IP(31:0)" />
        <signal name="PA_RX_OK" />
        <signal name="H" />
        <signal name="TX_CLK" />
        <signal name="tcm_e" />
        <signal name="tcm_v" />
        <signal name="tcm_wd(7:0)" />
        <signal name="SS_NE" />
        <port polarity="Output" name="PA_TXD(3:0)" />
        <port polarity="Output" name="PA_TX_EN" />
        <port polarity="Input" name="PA_LINK_ON" />
        <port polarity="Output" name="SENS_SCL_TP" />
        <port polarity="BiDirectional" name="SENS_SDA" />
        <port polarity="Output" name="SENS_SCL" />
        <port polarity="Output" name="SENS_SDA_TP" />
        <port polarity="Input" name="FRAME_ALT" />
        <port polarity="Input" name="C_DONE" />
        <port polarity="Input" name="CLK25M" />
        <port polarity="Input" name="EMB_TX_DATA(79:0)" />
        <port polarity="Input" name="EMB_RXD" />
        <port polarity="Input" name="EMB_TX_REQ" />
        <port polarity="Input" name="RX_FAN_ON" />
        <port polarity="Input" name="STARTN_DLY" />
        <port polarity="Input" name="CLK72M" />
        <port polarity="Output" name="EMB_RSP_DATA(79:0)" />
        <port polarity="Output" name="EMB_RSP_REQ" />
        <port polarity="Output" name="EMB_TXD" />
        <port polarity="Output" name="RH_CSUM_OK_P" />
        <port polarity="Output" name="TMP_CSUM_OK_P" />
        <port polarity="Input" name="PA_DST_MAC(47:0)" />
        <port polarity="Input" name="PA_DST_PORT(15:0)" />
        <port polarity="Input" name="PA_DST_IP(31:0)" />
        <port polarity="Input" name="PA_SRC_MAC(47:0)" />
        <port polarity="Input" name="PA_SRC_PORT(15:0)" />
        <port polarity="Input" name="PA_SRC_IP(31:0)" />
        <port polarity="Input" name="PA_RX_OK" />
        <port polarity="Input" name="TX_CLK" />
        <port polarity="Input" name="tcm_e" />
        <port polarity="Input" name="tcm_v" />
        <port polarity="Input" name="tcm_wd(7:0)" />
        <port polarity="Input" name="SS_NE" />
        <blockdef name="tx_process">
            <timestamp>2021-11-25T8:47:23</timestamp>
            <line x2="0" y1="496" y2="496" x1="64" />
            <line x2="0" y1="208" y2="208" x1="64" />
            <line x2="0" y1="304" y2="304" x1="64" />
            <line x2="0" y1="352" y2="352" x1="64" />
            <line x2="0" y1="400" y2="400" x1="64" />
            <rect width="64" x="0" y="436" height="24" />
            <line x2="0" y1="448" y2="448" x1="64" />
            <line x2="0" y1="160" y2="160" x1="64" />
            <rect width="64" x="0" y="4" height="24" />
            <line x2="0" y1="16" y2="16" x1="64" />
            <rect width="64" x="0" y="52" height="24" />
            <line x2="0" y1="64" y2="64" x1="64" />
            <rect width="64" x="0" y="100" height="24" />
            <line x2="0" y1="112" y2="112" x1="64" />
            <rect width="64" x="0" y="-140" height="24" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <rect width="64" x="0" y="-92" height="24" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="368" y="-1532" height="24" />
            <line x2="432" y1="-1520" y2="-1520" x1="368" />
            <line x2="432" y1="-1472" y2="-1472" x1="368" />
            <rect width="64" x="0" y="-1052" height="24" />
            <line x2="0" y1="-1040" y2="-1040" x1="64" />
            <rect width="64" x="0" y="-1004" height="24" />
            <line x2="0" y1="-992" y2="-992" x1="64" />
            <rect width="64" x="0" y="-620" height="24" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <rect width="64" x="0" y="-572" height="24" />
            <line x2="0" y1="-560" y2="-560" x1="64" />
            <rect width="64" x="0" y="-524" height="24" />
            <line x2="0" y1="-512" y2="-512" x1="64" />
            <rect width="64" x="0" y="-476" height="24" />
            <line x2="0" y1="-464" y2="-464" x1="64" />
            <line x2="0" y1="-1328" y2="-1328" x1="64" />
            <line x2="0" y1="-1280" y2="-1280" x1="64" />
            <rect width="304" x="64" y="-1600" height="2128" />
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
        <blockdef name="iobuf">
            <timestamp>2009-3-20T10:10:10</timestamp>
            <line x2="128" y1="-128" y2="-128" x1="224" />
            <line x2="128" y1="-64" y2="-64" x1="160" />
            <line x2="160" y1="-128" y2="-64" x1="160" />
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="96" y1="-140" y2="-192" x1="96" />
            <line x2="96" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-96" y2="-160" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="128" />
            <line x2="128" y1="-160" y2="-128" x1="64" />
            <line x2="128" y1="-96" y2="-32" x1="128" />
            <line x2="128" y1="-64" y2="-96" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
        </blockdef>
        <blockdef name="obuf">
            <timestamp>2009-3-20T10:10:10</timestamp>
            <line x2="64" y1="0" y2="-64" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
        </blockdef>
        <blockdef name="rs232c_emb">
            <timestamp>2013-4-23T1:44:38</timestamp>
            <rect width="64" x="512" y="20" height="24" />
            <line x2="576" y1="32" y2="32" x1="512" />
            <line x2="0" y1="-928" y2="-928" x1="64" />
            <line x2="0" y1="-832" y2="-832" x1="64" />
            <rect width="64" x="0" y="-796" height="24" />
            <line x2="0" y1="-784" y2="-784" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-208" y2="-208" x1="64" />
            <line x2="576" y1="-928" y2="-928" x1="512" />
            <rect width="64" x="512" y="-892" height="24" />
            <line x2="576" y1="-880" y2="-880" x1="512" />
            <rect width="64" x="512" y="-844" height="24" />
            <line x2="576" y1="-832" y2="-832" x1="512" />
            <rect width="64" x="512" y="-796" height="24" />
            <line x2="576" y1="-784" y2="-784" x1="512" />
            <rect width="64" x="512" y="-748" height="24" />
            <line x2="576" y1="-736" y2="-736" x1="512" />
            <rect width="64" x="512" y="-700" height="24" />
            <line x2="576" y1="-688" y2="-688" x1="512" />
            <rect width="64" x="512" y="-652" height="24" />
            <line x2="576" y1="-640" y2="-640" x1="512" />
            <rect width="64" x="512" y="-604" height="24" />
            <line x2="576" y1="-592" y2="-592" x1="512" />
            <rect width="64" x="512" y="-556" height="24" />
            <line x2="576" y1="-544" y2="-544" x1="512" />
            <rect width="64" x="512" y="-508" height="24" />
            <line x2="576" y1="-496" y2="-496" x1="512" />
            <rect width="64" x="512" y="-460" height="24" />
            <line x2="576" y1="-448" y2="-448" x1="512" />
            <rect width="64" x="512" y="-412" height="24" />
            <line x2="576" y1="-400" y2="-400" x1="512" />
            <rect width="64" x="512" y="-268" height="24" />
            <line x2="576" y1="-256" y2="-256" x1="512" />
            <line x2="576" y1="-208" y2="-208" x1="512" />
            <rect width="64" x="512" y="-172" height="24" />
            <line x2="576" y1="-160" y2="-160" x1="512" />
            <rect width="64" x="512" y="-364" height="24" />
            <line x2="576" y1="-352" y2="-352" x1="512" />
            <rect width="64" x="512" y="-316" height="24" />
            <line x2="576" y1="-304" y2="-304" x1="512" />
            <line x2="0" y1="-304" y2="-304" x1="64" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="576" y1="-112" y2="-112" x1="512" />
            <line x2="576" y1="-16" y2="-16" x1="512" />
            <line x2="576" y1="-64" y2="-64" x1="512" />
            <rect width="448" x="64" y="-960" height="1024" />
            <line x2="0" y1="-688" y2="-688" x1="64" />
        </blockdef>
        <blockdef name="adc_sensor_ctrl_b">
            <timestamp>2016-12-6T6:28:33</timestamp>
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="384" y1="-544" y2="-544" x1="320" />
            <line x2="384" y1="-496" y2="-496" x1="320" />
            <line x2="384" y1="-448" y2="-448" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-112" y2="-112" x1="320" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="320" y="-220" height="24" />
            <line x2="384" y1="-208" y2="-208" x1="320" />
            <rect width="64" x="320" y="-268" height="24" />
            <line x2="384" y1="-256" y2="-256" x1="320" />
            <rect width="64" x="320" y="-316" height="24" />
            <line x2="384" y1="-304" y2="-304" x1="320" />
            <line x2="384" y1="-64" y2="-64" x1="320" />
            <rect width="256" x="64" y="-576" height="736" />
            <line x2="384" y1="128" y2="128" x1="320" />
            <line x2="384" y1="80" y2="80" x1="320" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <line x2="384" y1="-16" y2="-16" x1="320" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <block symbolname="tx_process" name="tx_process_a">
            <blockpin signalname="PA_LINK_ON" name="LINK_ON" />
            <blockpin signalname="TX_CLK" name="TX_CLK" />
            <blockpin signalname="PA_DST_MAC(47:0)" name="DST_MAC(47:0)" />
            <blockpin signalname="PA_DST_PORT(15:0)" name="DST_PORT(15:0)" />
            <blockpin signalname="PA_DST_IP(31:0)" name="DST_IP(31:0)" />
            <blockpin signalname="PA_SRC_MAC(47:0)" name="SRC_MAC(47:0)" />
            <blockpin signalname="PA_SRC_IP(31:0)" name="SRC_IP(31:0)" />
            <blockpin signalname="PA_SRC_PORT(15:0)" name="SRC_PORT(15:0)" />
            <blockpin signalname="SENS_POWER(15:0)" name="POWER1(15:0)" />
            <blockpin signalname="PA_RX_OK" name="RX_OK" />
            <blockpin signalname="CLK25M" name="CLK25M" />
            <blockpin signalname="SENS_TEMP(15:0)" name="TEMP1(15:0)" />
            <blockpin signalname="EMB_TEMP(15:0)" name="TEMP2(15:0)" />
            <blockpin signalname="SENS_HUMID(15:0)" name="HUMID1(15:0)" />
            <blockpin signalname="EMB_HUMID(15:0)" name="HUMID2(15:0)" />
            <blockpin signalname="tcm_e" name="tcm_e" />
            <blockpin signalname="tcm_v" name="tcm_v" />
            <blockpin signalname="FRAME_ALT" name="frame_alt" />
            <blockpin signalname="EMB_POWER1(15:0)" name="POWER2(15:0)" />
            <blockpin signalname="tcm_wd(7:0)" name="tcm_wd(7:0)" />
            <blockpin signalname="PA_TX_EN" name="TX_EN" />
            <blockpin signalname="PA_TXD(3:0)" name="TXD(3:0)" />
            <blockpin signalname="SS_NE" name="SS_NE" />
        </block>
        <block symbolname="obuf" name="XLXI_26">
            <blockpin signalname="SENS_SCL_TP" name="I" />
            <blockpin signalname="SENS_SCL" name="O" />
        </block>
        <block symbolname="iobuf" name="XLXI_25">
            <blockpin signalname="XLXN_86" name="I" />
            <blockpin signalname="SENS_SDA" name="IO" />
            <blockpin signalname="SENS_SDA_TP" name="O" />
            <blockpin signalname="XLXN_89" name="T" />
        </block>
        <block symbolname="inv" name="XLXI_32">
            <blockpin signalname="C_DONE" name="I" />
            <blockpin signalname="STARTN" name="O" />
        </block>
        <block symbolname="rs232c_emb" name="rs232c_emb0">
            <blockpin signalname="CLK72M" name="CLK" />
            <blockpin signalname="STARTN" name="STARTN" />
            <blockpin signalname="EMB_TX_REQ" name="EMB_TX_REQ" />
            <blockpin signalname="EMB_TX_DATA(79:0)" name="EMB_TX_DATA(79:0)" />
            <blockpin signalname="FRAME_ALT" name="FRAME_ALT" />
            <blockpin signalname="EMB_RXD" name="RXD" />
            <blockpin signalname="STARTN_DLY" name="STARTN_DLY" />
            <blockpin name="EMB_BAUD_RATE(1:0)" />
            <blockpin name="CMD_RX_REQ" />
            <blockpin name="CMD_TX_REQ" />
            <blockpin signalname="EMB_POWER1(15:0)" name="POWER1(15:0)" />
            <blockpin signalname="EMB_POWER2(15:0)" name="POWER2(15:0)" />
            <blockpin signalname="EMB_POWER3(15:0)" name="POWER3(15:0)" />
            <blockpin signalname="EMB_POWER4(15:0)" name="POWER4(15:0)" />
            <blockpin signalname="EMB_POWER5(15:0)" name="POWER5(15:0)" />
            <blockpin signalname="EMB_POWER6(15:0)" name="POWER6(15:0)" />
            <blockpin signalname="EMB_POWER7(15:0)" name="POWER7(15:0)" />
            <blockpin signalname="EMB_POWER8(15:0)" name="POWER8(15:0)" />
            <blockpin name="POWER9(15:0)" />
            <blockpin signalname="EMB_TEMP(15:0)" name="TEMPERATURE1(15:0)" />
            <blockpin name="TEMPERATURE2(15:0)" />
            <blockpin signalname="EMB_RSP_REQ" name="EMB_RSP_REQ" />
            <blockpin signalname="EMB_RSP_DATA(79:0)" name="EMB_RSP_DATA(79:0)" />
            <blockpin signalname="EMB_HUMID(15:0)" name="HUMIDITY1(15:0)" />
            <blockpin name="HUMIDITY2(15:0)" />
            <blockpin name="RXD_O" />
            <blockpin signalname="EMB_TXD" name="TXD" />
            <blockpin name="EMB_TP_OUT(7:0)" />
            <blockpin signalname="RX_FAN_ON" name="SDI_FAN_ON" />
        </block>
        <block symbolname="adc_sensor_ctrl_b" name="adc_sensor0">
            <blockpin signalname="STARTN" name="startn_in" />
            <blockpin signalname="SENS_SDA_TP" name="sda_in" />
            <blockpin signalname="FRAME_ALT" name="frame_alt" />
            <blockpin signalname="CLK25M" name="clk" />
            <blockpin name="cnt_rst" />
            <blockpin name="busy" />
            <blockpin name="adc_err_det" />
            <blockpin name="adc2_err_det" />
            <blockpin name="sens_err_det" />
            <blockpin signalname="SENS_SCL_TP" name="scl" />
            <blockpin signalname="XLXN_89" name="sda_ot" />
            <blockpin signalname="XLXN_86" name="sdao" />
            <blockpin signalname="RH_CSUM_OK_P" name="rh_csum_ok_p" />
            <blockpin signalname="TMP_CSUM_OK_P" name="tmp_csum_ok_p" />
            <blockpin signalname="SENS_POWER(15:0)" name="volt_dout(15:0)" />
            <blockpin signalname="SENS_HUMID(15:0)" name="rh_dout(15:0)" />
            <blockpin signalname="SENS_TEMP(15:0)" name="tmp_dout(15:0)" />
        </block>
        <block symbolname="vcc" name="XLXI_33">
            <blockpin signalname="H" name="P" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="6988" y="5160">tx_rcv</text>
        <instance x="3520" y="2128" name="tx_process_a" orien="R0">
        </instance>
        <branch name="PA_TXD(3:0)">
            <wire x2="4080" y1="608" y2="608" x1="3952" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4352" y="608">PA_TXD(3:0)</text>
        <branch name="PA_TX_EN">
            <wire x2="4080" y1="656" y2="656" x1="3952" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4352" y="656">PA_TX_EN</text>
        <text style="fontsize:40;fontname:Arial" x="2824" y="944">PANEL_NUM(9:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2824" y="992">CLK</text>
        <branch name="PA_RX_OK">
            <wire x2="3520" y1="848" y2="848" x1="3440" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2824" y="848">RX_OK</text>
        <branch name="PA_LINK_ON">
            <wire x2="3520" y1="800" y2="800" x1="3440" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2824" y="800">PA_LINK_ON</text>
        <iomarker fontsize="28" x="3440" y="800" name="PA_LINK_ON" orien="R180" />
        <iomarker fontsize="28" x="4080" y="608" name="PA_TXD(3:0)" orien="R0" />
        <iomarker fontsize="28" x="4080" y="656" name="PA_TX_EN" orien="R0" />
        <instance x="2480" y="4448" name="XLXI_26" orien="R0" />
        <instance x="2480" y="4128" name="XLXI_25" orien="M180" />
        <branch name="SENS_SCL_TP">
            <wire x2="2432" y1="4416" y2="4416" x1="2304" />
            <wire x2="2480" y1="4416" y2="4416" x1="2432" />
            <wire x2="2432" y1="4416" y2="4496" x1="2432" />
            <wire x2="2800" y1="4496" y2="4496" x1="2432" />
        </branch>
        <branch name="XLXN_86">
            <wire x2="2368" y1="4320" y2="4320" x1="2304" />
            <wire x2="2480" y1="4256" y2="4256" x1="2368" />
            <wire x2="2368" y1="4256" y2="4320" x1="2368" />
        </branch>
        <branch name="XLXN_89">
            <wire x2="2432" y1="4368" y2="4368" x1="2304" />
            <wire x2="2432" y1="4320" y2="4368" x1="2432" />
            <wire x2="2480" y1="4320" y2="4320" x1="2432" />
        </branch>
        <branch name="SENS_SDA">
            <wire x2="2800" y1="4256" y2="4256" x1="2704" />
        </branch>
        <branch name="SENS_SCL">
            <wire x2="2800" y1="4416" y2="4416" x1="2704" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3040" y="4256">SENS_SDA</text>
        <text style="fontsize:40;fontname:Arial" x="3040" y="4416">SENS_SCL</text>
        <text style="fontsize:40;fontname:Arial" x="3088" y="4496">SENS_SCL_TP</text>
        <text style="fontsize:40;fontname:Arial" x="3088" y="4112">SENS_SDA_TP</text>
        <branch name="SENS_SDA_TP">
            <wire x2="1856" y1="4192" y2="4320" x1="1856" />
            <wire x2="1920" y1="4320" y2="4320" x1="1856" />
            <wire x2="2432" y1="4192" y2="4192" x1="1856" />
            <wire x2="2480" y1="4192" y2="4192" x1="2432" />
            <wire x2="2800" y1="4112" y2="4112" x1="2432" />
            <wire x2="2432" y1="4112" y2="4192" x1="2432" />
        </branch>
        <iomarker fontsize="28" x="2800" y="4256" name="SENS_SDA" orien="R0" />
        <iomarker fontsize="28" x="2800" y="4416" name="SENS_SCL" orien="R0" />
        <iomarker fontsize="28" x="2800" y="4496" name="SENS_SCL_TP" orien="R0" />
        <iomarker fontsize="28" x="2800" y="4112" name="SENS_SDA_TP" orien="R0" />
        <branch name="FRAME_ALT">
            <wire x2="1920" y1="4752" y2="4752" x1="1440" />
        </branch>
        <instance x="1552" y="4672" name="XLXI_32" orien="R0" />
        <branch name="C_DONE">
            <wire x2="1552" y1="4640" y2="4640" x1="1440" />
        </branch>
        <iomarker fontsize="28" x="1440" y="4640" name="C_DONE" orien="R180" />
        <branch name="SENS_POWER(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="2368" y="4560" type="branch" />
            <wire x2="2368" y1="4560" y2="4560" x1="2304" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2704" y="4560">SENS_POWER(15:0)</text>
        <branch name="SENS_HUMID(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="2368" y="4608" type="branch" />
            <wire x2="2368" y1="4608" y2="4608" x1="2304" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2704" y="4608">SENS_HUMID(15:0)</text>
        <branch name="SENS_TEMP(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="2368" y="4656" type="branch" />
            <wire x2="2368" y1="4656" y2="4656" x1="2304" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2704" y="4656">SENS_TEMP(15:0)</text>
        <branch name="SENS_POWER(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3360" y="1088" type="branch" />
            <wire x2="3520" y1="1088" y2="1088" x1="3360" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1088">SENS_POWER(15:0)</text>
        <branch name="SENS_TEMP(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3360" y="1520" type="branch" />
            <wire x2="3520" y1="1520" y2="1520" x1="3360" />
        </branch>
        <branch name="SENS_HUMID(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3360" y="1616" type="branch" />
            <wire x2="3520" y1="1616" y2="1616" x1="3360" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1520">SENS_TEMP(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1616">SENS_HUMID(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="968" y="4752">FRAME_ALT</text>
        <text style="fontsize:40;fontname:Arial" x="968" y="4800">CLK25M</text>
        <iomarker fontsize="28" x="1440" y="4752" name="FRAME_ALT" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="968" y="4644">C_DONE</text>
        <branch name="CLK25M">
            <wire x2="1920" y1="4800" y2="4800" x1="1440" />
        </branch>
        <iomarker fontsize="28" x="1440" y="4800" name="CLK25M" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="2824" y="1712">OVP</text>
        <instance x="4640" y="5008" name="rs232c_emb0" orien="R0">
        </instance>
        <branch name="EMB_TX_DATA(79:0)">
            <wire x2="4640" y1="4224" y2="4224" x1="4560" />
        </branch>
        <iomarker fontsize="28" x="4560" y="4224" name="EMB_TX_DATA(79:0)" orien="R180" />
        <branch name="EMB_RXD">
            <wire x2="4640" y1="4080" y2="4080" x1="4560" />
        </branch>
        <branch name="EMB_TX_REQ">
            <wire x2="4640" y1="4176" y2="4176" x1="4560" />
        </branch>
        <branch name="RX_FAN_ON">
            <wire x2="4640" y1="4320" y2="4320" x1="4560" />
        </branch>
        <branch name="FRAME_ALT">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4560" y="4704" type="branch" />
            <wire x2="4640" y1="4704" y2="4704" x1="4560" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3828" y="4704">FRAME_ALT</text>
        <branch name="STARTN_DLY">
            <wire x2="4640" y1="4752" y2="4752" x1="4560" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3828" y="4752">STARTN_DLY</text>
        <branch name="STARTN">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4560" y="4800" type="branch" />
            <wire x2="4640" y1="4800" y2="4800" x1="4560" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3828" y="4800">STARTN</text>
        <branch name="CLK72M">
            <wire x2="4640" y1="4848" y2="4848" x1="4560" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3828" y="4848">CLK72M</text>
        <iomarker fontsize="28" x="4560" y="4080" name="EMB_RXD" orien="R180" />
        <iomarker fontsize="28" x="4560" y="4176" name="EMB_TX_REQ" orien="R180" />
        <iomarker fontsize="28" x="4560" y="4320" name="RX_FAN_ON" orien="R180" />
        <iomarker fontsize="28" x="4560" y="4752" name="STARTN_DLY" orien="R180" />
        <iomarker fontsize="28" x="4560" y="4848" name="CLK72M" orien="R180" />
        <branch name="EMB_RSP_DATA(79:0)">
            <wire x2="5280" y1="4848" y2="4848" x1="5216" />
        </branch>
        <iomarker fontsize="28" x="5280" y="4848" name="EMB_RSP_DATA(79:0)" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="5668" y="4848">EMB_RSP_DATA(79:0)</text>
        <branch name="EMB_RSP_REQ">
            <wire x2="5280" y1="4800" y2="4800" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4800">EMB_RSP_REQ</text>
        <branch name="EMB_TXD">
            <wire x2="5280" y1="4080" y2="4080" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4080">EMB_TXD</text>
        <branch name="EMB_POWER1(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4128" type="branch" />
            <wire x2="5280" y1="4128" y2="4128" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4128">EMB_POWER1(15:0)</text>
        <branch name="EMB_POWER2(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4176" type="branch" />
            <wire x2="5280" y1="4176" y2="4176" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4176">EMB_POWER2(15:0)</text>
        <branch name="EMB_POWER3(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4224" type="branch" />
            <wire x2="5280" y1="4224" y2="4224" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4224">EMB_POWER3(15:0)</text>
        <branch name="EMB_POWER4(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4272" type="branch" />
            <wire x2="5280" y1="4272" y2="4272" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4272">EMB_POWER4(15:0)</text>
        <branch name="EMB_POWER5(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4320" type="branch" />
            <wire x2="5280" y1="4320" y2="4320" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4320">EMB_POWER5(15:0)</text>
        <branch name="EMB_POWER6(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4368" type="branch" />
            <wire x2="5280" y1="4368" y2="4368" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4368">EMB_POWER6(15:0)</text>
        <branch name="EMB_POWER7(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4416" type="branch" />
            <wire x2="5280" y1="4416" y2="4416" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4416">EMB_POWER7(15:0)</text>
        <branch name="EMB_POWER8(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4464" type="branch" />
            <wire x2="5280" y1="4464" y2="4464" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4464">EMB_POWER8(15:0)</text>
        <branch name="EMB_TEMP(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4560" type="branch" />
            <wire x2="5280" y1="4560" y2="4560" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4560">EMB_TEMP(15:0)</text>
        <branch name="EMB_HUMID(15:0)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5280" y="4656" type="branch" />
            <wire x2="5280" y1="4656" y2="4656" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5668" y="4656">EMB_HUMID(15:0)</text>
        <iomarker fontsize="28" x="5280" y="4080" name="EMB_TXD" orien="R0" />
        <iomarker fontsize="28" x="5280" y="4800" name="EMB_RSP_REQ" orien="R0" />
        <branch name="EMB_POWER1(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3360" y="1136" type="branch" />
            <wire x2="3520" y1="1136" y2="1136" x1="3360" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1136">EMB_POWER1(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1184">EMB_POWER2(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1232">EMB_POWER3(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1280">EMB_POWER4(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1328">EMB_POWER5(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1376">EMB_POWER6(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1424">EMB_POWER7(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1472">EMB_POWER8(15:0)</text>
        <branch name="EMB_TEMP(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3360" y="1568" type="branch" />
            <wire x2="3520" y1="1568" y2="1568" x1="3360" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1568">EMB_TEMP(15:0)</text>
        <branch name="EMB_HUMID(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3360" y="1664" type="branch" />
            <wire x2="3520" y1="1664" y2="1664" x1="3360" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2656" y="1664">EMB_HUMID(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2076" y="5120">STARTN</text>
        <branch name="STARTN">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1920" y="5120" type="branch" />
            <wire x2="1840" y1="4640" y2="4640" x1="1776" />
            <wire x2="1840" y1="4640" y2="4704" x1="1840" />
            <wire x2="1920" y1="4704" y2="4704" x1="1840" />
            <wire x2="1840" y1="4704" y2="5120" x1="1840" />
            <wire x2="1920" y1="5120" y2="5120" x1="1840" />
        </branch>
        <branch name="RH_CSUM_OK_P">
            <wire x2="2400" y1="4944" y2="4944" x1="2304" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2752" y="4944">RH_CSUM_OK_P</text>
        <branch name="TMP_CSUM_OK_P">
            <wire x2="2400" y1="4992" y2="4992" x1="2304" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2752" y="4992">TMP_CSUM_OK_P</text>
        <iomarker fontsize="28" x="2400" y="4944" name="RH_CSUM_OK_P" orien="R0" />
        <iomarker fontsize="28" x="2400" y="4992" name="TMP_CSUM_OK_P" orien="R0" />
        <instance x="1920" y="4864" name="adc_sensor0" orien="R0">
        </instance>
        <branch name="PA_DST_MAC(47:0)">
            <wire x2="3520" y1="2000" y2="2000" x1="3136" />
        </branch>
        <branch name="PA_DST_PORT(15:0)">
            <wire x2="3520" y1="2048" y2="2048" x1="3152" />
        </branch>
        <branch name="PA_DST_IP(31:0)">
            <wire x2="3520" y1="2096" y2="2096" x1="3152" />
        </branch>
        <iomarker fontsize="28" x="3136" y="2000" name="PA_DST_MAC(47:0)" orien="R180" />
        <iomarker fontsize="28" x="3152" y="2048" name="PA_DST_PORT(15:0)" orien="R180" />
        <iomarker fontsize="28" x="3152" y="2096" name="PA_DST_IP(31:0)" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="4060" y="4084">EMB_RXD</text>
        <text style="fontsize:40;fontname:Arial" x="4004" y="4168">EMB_TX_REQ</text>
        <text style="fontsize:40;fontname:Arial" x="3840" y="4232">EMB_TX_DATA(79:0)</text>
        <text style="fontsize:40;fontname:Arial" x="4036" y="4324">RX_FAN_ON</text>
        <branch name="PA_SRC_MAC(47:0)">
            <wire x2="3520" y1="2144" y2="2144" x1="3104" />
        </branch>
        <branch name="PA_SRC_PORT(15:0)">
            <wire x2="3520" y1="2192" y2="2192" x1="3120" />
        </branch>
        <branch name="PA_SRC_IP(31:0)">
            <wire x2="3520" y1="2240" y2="2240" x1="3120" />
        </branch>
        <iomarker fontsize="28" x="3104" y="2144" name="PA_SRC_MAC(47:0)" orien="R180" />
        <iomarker fontsize="28" x="3120" y="2192" name="PA_SRC_PORT(15:0)" orien="R180" />
        <iomarker fontsize="28" x="3120" y="2240" name="PA_SRC_IP(31:0)" orien="R180" />
        <instance x="960" y="1600" name="XLXI_33" orien="R0" />
        <branch name="H">
            <attrtext style="alignment:SOFT-BCENTER;fontsize:28;fontname:Arial" attrname="Name" x="1056" y="1616" type="branch" />
            <wire x2="1024" y1="1600" y2="1616" x1="1024" />
            <wire x2="1056" y1="1616" y2="1616" x1="1024" />
            <wire x2="1072" y1="1616" y2="1616" x1="1056" />
        </branch>
        <iomarker fontsize="28" x="3440" y="848" name="PA_RX_OK" orien="R180" />
        <branch name="TX_CLK">
            <wire x2="3504" y1="2288" y2="2288" x1="3072" />
            <wire x2="3520" y1="2288" y2="2288" x1="3504" />
        </branch>
        <iomarker fontsize="28" x="3072" y="2288" name="TX_CLK" orien="R180" />
        <branch name="CLK25M">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3456" y="2336" type="branch" />
            <wire x2="3520" y1="2336" y2="2336" x1="3456" />
        </branch>
        <branch name="tcm_e">
            <wire x2="3520" y1="2432" y2="2432" x1="3456" />
        </branch>
        <branch name="tcm_v">
            <wire x2="3520" y1="2480" y2="2480" x1="3456" />
        </branch>
        <branch name="FRAME_ALT">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3456" y="2528" type="branch" />
            <wire x2="3520" y1="2528" y2="2528" x1="3456" />
        </branch>
        <branch name="tcm_wd(7:0)">
            <wire x2="3520" y1="2576" y2="2576" x1="3456" />
        </branch>
        <iomarker fontsize="28" x="3456" y="2432" name="tcm_e" orien="R180" />
        <iomarker fontsize="28" x="3456" y="2480" name="tcm_v" orien="R180" />
        <iomarker fontsize="28" x="3456" y="2576" name="tcm_wd(7:0)" orien="R180" />
        <branch name="SS_NE">
            <wire x2="3520" y1="2624" y2="2624" x1="3456" />
        </branch>
        <iomarker fontsize="28" x="3456" y="2624" name="SS_NE" orien="R180" />
    </sheet>
</drawing>
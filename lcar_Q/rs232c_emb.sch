<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="L,L" />
        <signal name="L" />
        <signal name="EMB_BAUD_RATE(1:0)" />
        <signal name="RST" />
        <signal name="CLK" />
        <signal name="H" />
        <signal name="XLXN_12(7:0)" />
        <signal name="XLXN_80" />
        <signal name="XLXN_81(7:0)" />
        <signal name="XLXN_82" />
        <signal name="XLXN_83" />
        <signal name="CMD_RX_REQ" />
        <signal name="XLXN_85" />
        <signal name="XLXN_98" />
        <signal name="XLXN_99" />
        <signal name="XLXN_100" />
        <signal name="STARTN" />
        <signal name="CMD_TX_REQ" />
        <signal name="XLXN_142(79:0)" />
        <signal name="XLXN_144(79:0)" />
        <signal name="EMB_TX_REQ" />
        <signal name="EMB_TX_DATA(79:0)" />
        <signal name="L,L,L,L,H,H,H" />
        <signal name="FRAME_ALT" />
        <signal name="POWER1(15:0)" />
        <signal name="POWER2(15:0)" />
        <signal name="POWER3(15:0)" />
        <signal name="POWER4(15:0)" />
        <signal name="POWER5(15:0)" />
        <signal name="POWER6(15:0)" />
        <signal name="POWER7(15:0)" />
        <signal name="POWER8(15:0)" />
        <signal name="POWER9(15:0)" />
        <signal name="TEMPERATURE1(15:0)" />
        <signal name="TEMPERATURE2(15:0)" />
        <signal name="EMB_RSP_REQ" />
        <signal name="EMB_RSP_DATA(79:0)" />
        <signal name="HUMIDITY1(15:0)" />
        <signal name="HUMIDITY2(15:0)" />
        <signal name="H,H,H,H,H,H,H,H,H" />
        <signal name="L,H" />
        <signal name="RXD" />
        <signal name="RXD_O" />
        <signal name="XLXN_154" />
        <signal name="TXD" />
        <signal name="XLXN_159" />
        <signal name="STARTN_DLY" />
        <signal name="EMB_TP_OUT(7:0)" />
        <signal name="SDI_FAN_ON" />
        <signal name="XLXN_138" />
        <signal name="TX_TIMEOUT" />
        <port polarity="Output" name="EMB_BAUD_RATE(1:0)" />
        <port polarity="Input" name="CLK" />
        <port polarity="Output" name="CMD_RX_REQ" />
        <port polarity="Input" name="STARTN" />
        <port polarity="Output" name="CMD_TX_REQ" />
        <port polarity="Input" name="EMB_TX_REQ" />
        <port polarity="Input" name="EMB_TX_DATA(79:0)" />
        <port polarity="Input" name="FRAME_ALT" />
        <port polarity="Output" name="POWER1(15:0)" />
        <port polarity="Output" name="POWER2(15:0)" />
        <port polarity="Output" name="POWER3(15:0)" />
        <port polarity="Output" name="POWER4(15:0)" />
        <port polarity="Output" name="POWER5(15:0)" />
        <port polarity="Output" name="POWER6(15:0)" />
        <port polarity="Output" name="POWER7(15:0)" />
        <port polarity="Output" name="POWER8(15:0)" />
        <port polarity="Output" name="POWER9(15:0)" />
        <port polarity="Output" name="TEMPERATURE1(15:0)" />
        <port polarity="Output" name="TEMPERATURE2(15:0)" />
        <port polarity="Output" name="EMB_RSP_REQ" />
        <port polarity="Output" name="EMB_RSP_DATA(79:0)" />
        <port polarity="Output" name="HUMIDITY1(15:0)" />
        <port polarity="Output" name="HUMIDITY2(15:0)" />
        <port polarity="Input" name="RXD" />
        <port polarity="Output" name="RXD_O" />
        <port polarity="Output" name="TXD" />
        <port polarity="Input" name="STARTN_DLY" />
        <port polarity="Output" name="EMB_TP_OUT(7:0)" />
        <port polarity="Input" name="SDI_FAN_ON" />
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="fd1">
            <timestamp>2010-5-11T8:39:30</timestamp>
            <rect width="80" x="64" y="-112" height="112" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="208" y1="-80" y2="-80" x1="144" />
        </blockdef>
        <blockdef name="or2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
        </blockdef>
        <blockdef name="uart_if_emb">
            <timestamp>2013-3-18T5:55:4</timestamp>
            <line x2="0" y1="-1248" y2="-1248" x1="64" />
            <rect width="64" x="0" y="-1212" height="24" />
            <line x2="0" y1="-1200" y2="-1200" x1="64" />
            <line x2="0" y1="-1152" y2="-1152" x1="64" />
            <line x2="0" y1="-1104" y2="-1104" x1="64" />
            <line x2="0" y1="-1056" y2="-1056" x1="64" />
            <line x2="512" y1="-1200" y2="-1200" x1="448" />
            <rect width="384" x="64" y="-1280" height="640" />
            <line x2="512" y1="-1248" y2="-1248" x1="448" />
            <rect width="64" x="448" y="-1164" height="24" />
            <line x2="512" y1="-1152" y2="-1152" x1="448" />
            <line x2="512" y1="-1056" y2="-1056" x1="448" />
            <line x2="512" y1="-960" y2="-960" x1="448" />
            <line x2="0" y1="-960" y2="-960" x1="64" />
            <rect width="64" x="0" y="-924" height="24" />
            <line x2="0" y1="-912" y2="-912" x1="64" />
            <line x2="0" y1="-864" y2="-864" x1="64" />
            <line x2="0" y1="-816" y2="-816" x1="64" />
            <line x2="0" y1="-720" y2="-720" x1="64" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <line x2="512" y1="-768" y2="-768" x1="448" />
            <rect width="64" x="448" y="-732" height="24" />
            <line x2="512" y1="-720" y2="-720" x1="448" />
            <line x2="512" y1="-672" y2="-672" x1="448" />
        </blockdef>
        <blockdef name="ibuf">
            <timestamp>2009-3-20T10:10:10</timestamp>
            <line x2="64" y1="0" y2="-64" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
        </blockdef>
        <blockdef name="obuf">
            <timestamp>2009-3-20T10:10:10</timestamp>
            <line x2="64" y1="0" y2="-64" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
        </blockdef>
        <blockdef name="uart_core_mpc_a">
            <timestamp>2013-3-28T9:22:58</timestamp>
            <rect width="256" x="64" y="-576" height="544" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="384" y1="-544" y2="-544" x1="320" />
            <rect width="64" x="320" y="-508" height="24" />
            <line x2="384" y1="-496" y2="-496" x1="320" />
            <line x2="384" y1="-448" y2="-448" x1="320" />
            <line x2="384" y1="-400" y2="-400" x1="320" />
            <rect width="64" x="0" y="-460" height="24" />
            <line x2="0" y1="-448" y2="-448" x1="64" />
            <line x2="0" y1="-400" y2="-400" x1="64" />
            <rect width="64" x="0" y="-364" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-220" height="24" />
            <line x2="0" y1="-208" y2="-208" x1="64" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="384" y1="-256" y2="-256" x1="320" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-112" y2="-112" x1="320" />
        </blockdef>
        <blockdef name="or3">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="48" y1="-64" y2="-64" x1="0" />
            <line x2="72" y1="-128" y2="-128" x1="0" />
            <line x2="48" y1="-192" y2="-192" x1="0" />
            <line x2="192" y1="-128" y2="-128" x1="256" />
            <arc ex="192" ey="-128" sx="112" sy="-80" r="88" cx="116" cy="-168" />
            <arc ex="48" ey="-176" sx="48" sy="-80" r="56" cx="16" cy="-128" />
            <line x2="48" y1="-64" y2="-80" x1="48" />
            <line x2="48" y1="-192" y2="-176" x1="48" />
            <line x2="48" y1="-80" y2="-80" x1="112" />
            <arc ex="112" ey="-176" sx="192" sy="-128" r="88" cx="116" cy="-88" />
            <line x2="48" y1="-176" y2="-176" x1="112" />
        </blockdef>
        <blockdef name="cmd_if_emb_xt_a">
            <timestamp>2015-12-3T1:59:18</timestamp>
            <line x2="544" y1="64" y2="64" x1="480" />
            <line x2="0" y1="16" y2="16" x1="64" />
            <line x2="544" y1="-992" y2="-992" x1="480" />
            <line x2="0" y1="-992" y2="-992" x1="64" />
            <line x2="0" y1="-944" y2="-944" x1="64" />
            <rect width="64" x="0" y="-908" height="24" />
            <line x2="0" y1="-896" y2="-896" x1="64" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <rect width="64" x="0" y="-572" height="24" />
            <line x2="0" y1="-560" y2="-560" x1="64" />
            <rect width="64" x="0" y="-476" height="24" />
            <line x2="0" y1="-464" y2="-464" x1="64" />
            <rect width="64" x="480" y="-956" height="24" />
            <line x2="544" y1="-944" y2="-944" x1="480" />
            <rect width="64" x="480" y="-860" height="24" />
            <line x2="544" y1="-848" y2="-848" x1="480" />
            <rect width="64" x="480" y="-812" height="24" />
            <line x2="544" y1="-800" y2="-800" x1="480" />
            <rect width="64" x="480" y="-764" height="24" />
            <line x2="544" y1="-752" y2="-752" x1="480" />
            <rect width="64" x="480" y="-716" height="24" />
            <line x2="544" y1="-704" y2="-704" x1="480" />
            <rect width="64" x="480" y="-668" height="24" />
            <line x2="544" y1="-656" y2="-656" x1="480" />
            <rect width="64" x="480" y="-620" height="24" />
            <line x2="544" y1="-608" y2="-608" x1="480" />
            <rect width="64" x="480" y="-572" height="24" />
            <line x2="544" y1="-560" y2="-560" x1="480" />
            <rect width="64" x="480" y="-524" height="24" />
            <line x2="544" y1="-512" y2="-512" x1="480" />
            <rect width="64" x="480" y="-476" height="24" />
            <line x2="544" y1="-464" y2="-464" x1="480" />
            <rect width="64" x="480" y="-428" height="24" />
            <line x2="544" y1="-416" y2="-416" x1="480" />
            <rect width="64" x="480" y="-380" height="24" />
            <line x2="544" y1="-368" y2="-368" x1="480" />
            <line x2="0" y1="-272" y2="-272" x1="64" />
            <rect width="64" x="0" y="-860" height="24" />
            <line x2="0" y1="-848" y2="-848" x1="64" />
            <rect width="64" x="0" y="-812" height="24" />
            <line x2="0" y1="-800" y2="-800" x1="64" />
            <rect width="64" x="0" y="-764" height="24" />
            <line x2="0" y1="-752" y2="-752" x1="64" />
            <rect width="64" x="480" y="-332" height="24" />
            <line x2="544" y1="-320" y2="-320" x1="480" />
            <rect width="64" x="480" y="-44" height="24" />
            <line x2="544" y1="-32" y2="-32" x1="480" />
            <rect width="64" x="480" y="-140" height="24" />
            <line x2="544" y1="-128" y2="-128" x1="480" />
            <line x2="544" y1="-176" y2="-176" x1="480" />
            <rect width="64" x="480" y="-284" height="24" />
            <line x2="544" y1="-272" y2="-272" x1="480" />
            <rect width="64" x="480" y="-92" height="24" />
            <line x2="544" y1="-80" y2="-80" x1="480" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-176" y2="-176" x1="64" />
            <rect width="64" x="0" y="-140" height="24" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <rect width="64" x="480" y="4" height="24" />
            <line x2="544" y1="16" y2="16" x1="480" />
            <rect width="416" x="64" y="-1024" height="1120" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
        </blockdef>
        <block symbolname="vcc" name="XLXI_5">
            <blockpin signalname="H" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_6">
            <blockpin signalname="L" name="G" />
        </block>
        <block symbolname="fd1" name="XLXI_7">
            <blockpin signalname="STARTN" name="D" />
            <blockpin signalname="CLK" name="CK" />
            <blockpin signalname="XLXN_138" name="Q" />
        </block>
        <block symbolname="uart_if_emb" name="XLXI_14">
            <blockpin signalname="XLXN_80" name="rx_vld" />
            <blockpin signalname="XLXN_82" name="rx_frm_err" />
            <blockpin signalname="XLXN_83" name="rx_prty_err" />
            <blockpin signalname="H" name="rx_time_out_on" />
            <blockpin signalname="XLXN_81(7:0)" name="rx_data(7:0)" />
            <blockpin signalname="XLXN_85" name="rcv_ok" />
            <blockpin signalname="CMD_RX_REQ" name="cmd_rx_req" />
            <blockpin signalname="XLXN_144(79:0)" name="rx_cmd_data(79:0)" />
            <blockpin name="rx_time_out" />
            <blockpin name="cmd_tx_done" />
            <blockpin signalname="CMD_TX_REQ" name="cmd_tx_req" />
            <blockpin signalname="XLXN_142(79:0)" name="tx_cmd_data(79:0)" />
            <blockpin signalname="XLXN_99" name="tx_busy" />
            <blockpin signalname="XLXN_100" name="tx_done" />
            <blockpin signalname="RST" name="rst" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_98" name="tx_vld" />
            <blockpin signalname="XLXN_12(7:0)" name="tx_data(7:0)" />
            <blockpin name="tx_brk" />
        </block>
        <block symbolname="ibuf" name="XLXI_15">
            <blockpin signalname="RXD" name="I" />
            <blockpin signalname="RXD_O" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_16">
            <blockpin signalname="XLXN_154" name="I0" />
            <blockpin signalname="STARTN_DLY" name="I1" />
            <blockpin signalname="XLXN_159" name="O" />
        </block>
        <block symbolname="obuf" name="XLXI_18">
            <blockpin signalname="XLXN_159" name="I" />
            <blockpin signalname="TXD" name="O" />
        </block>
        <block symbolname="uart_core_mpc_a" name="XLXI_19">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="RST" name="rst" />
            <blockpin signalname="RXD_O" name="rxd" />
            <blockpin signalname="XLXN_98" name="tx_vld" />
            <blockpin signalname="L" name="tx_brk" />
            <blockpin signalname="L" name="stpsel" />
            <blockpin signalname="XLXN_12(7:0)" name="tx_data(7:0)" />
            <blockpin signalname="L,L" name="prtysel(1:0)" />
            <blockpin signalname="EMB_BAUD_RATE(1:0)" name="brdsel(1:0)" />
            <blockpin signalname="XLXN_154" name="txd" />
            <blockpin signalname="XLXN_99" name="tx_busy" />
            <blockpin signalname="XLXN_100" name="tx_done" />
            <blockpin signalname="XLXN_80" name="rx_vld" />
            <blockpin signalname="XLXN_82" name="rx_frm_err" />
            <blockpin signalname="XLXN_83" name="rx_prty_err" />
            <blockpin name="rx_brk" />
            <blockpin signalname="XLXN_81(7:0)" name="rx_data(7:0)" />
        </block>
        <block symbolname="or3" name="XLXI_21">
            <blockpin signalname="TX_TIMEOUT" name="I0" />
            <blockpin signalname="XLXN_138" name="I1" />
            <blockpin signalname="STARTN" name="I2" />
            <blockpin signalname="RST" name="O" />
        </block>
        <block symbolname="cmd_if_emb_xt_a" name="XLXI_22">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="RST" name="rst" />
            <blockpin signalname="FRAME_ALT" name="frame_alt" />
            <blockpin signalname="CMD_RX_REQ" name="cmd_rx_req" />
            <blockpin signalname="XLXN_85" name="rcv_ok" />
            <blockpin signalname="EMB_TX_REQ" name="ext_cmd_tx_req" />
            <blockpin signalname="SDI_FAN_ON" name="sdi_fan_on" />
            <blockpin signalname="L" name="sdi_fan_cmd_ena" />
            <blockpin signalname="L" name="fan_set_ena" />
            <blockpin signalname="L,L" name="sensor_port_sel(1:0)" />
            <blockpin signalname="XLXN_144(79:0)" name="rx_cmd_data(79:0)" />
            <blockpin signalname="EMB_TX_DATA(79:0)" name="ext_cmd_data(79:0)" />
            <blockpin signalname="L,L,L,L,H,H,H" name="rx_timeout_set(6:0)" />
            <blockpin signalname="H,H,H,H,H,H,H,H,H" name="pwr_ena(9:1)" />
            <blockpin signalname="L,H" name="temp_ena(2:1)" />
            <blockpin signalname="L,L" name="humid_ena(2:1)" />
            <blockpin signalname="CMD_TX_REQ" name="cmd_tx_req" />
            <blockpin signalname="TX_TIMEOUT" name="tx_timeout" />
            <blockpin signalname="EMB_RSP_REQ" name="rsp_rx_req" />
            <blockpin signalname="XLXN_142(79:0)" name="tx_cmd_data(79:0)" />
            <blockpin signalname="POWER1(15:0)" name="power1(15:0)" />
            <blockpin signalname="POWER2(15:0)" name="power2(15:0)" />
            <blockpin signalname="POWER3(15:0)" name="power3(15:0)" />
            <blockpin signalname="POWER4(15:0)" name="power4(15:0)" />
            <blockpin signalname="POWER5(15:0)" name="power5(15:0)" />
            <blockpin signalname="POWER6(15:0)" name="power6(15:0)" />
            <blockpin signalname="POWER7(15:0)" name="power7(15:0)" />
            <blockpin signalname="POWER8(15:0)" name="power8(15:0)" />
            <blockpin signalname="POWER9(15:0)" name="power9(15:0)" />
            <blockpin signalname="TEMPERATURE1(15:0)" name="temperature1(15:0)" />
            <blockpin signalname="TEMPERATURE2(15:0)" name="temperature2(15:0)" />
            <blockpin signalname="HUMIDITY1(15:0)" name="humidity1(15:0)" />
            <blockpin signalname="HUMIDITY2(15:0)" name="humidity2(15:0)" />
            <blockpin signalname="EMB_RSP_DATA(79:0)" name="rsp_data(79:0)" />
            <blockpin signalname="EMB_BAUD_RATE(1:0)" name="emb_baud_rate(1:0)" />
            <blockpin signalname="EMB_TP_OUT(7:0)" name="tp_out(7:0)" />
            <blockpin name="sens_num(3:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="7048" y="5224">rs232c_emb</text>
        <branch name="L,L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1456" y="1696" type="branch" />
            <wire x2="1520" y1="1696" y2="1696" x1="1456" />
        </branch>
        <branch name="L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1456" y="1744" type="branch" />
            <wire x2="1520" y1="1744" y2="1744" x1="1456" />
        </branch>
        <branch name="RST">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1456" y="2032" type="branch" />
            <wire x2="1520" y1="2032" y2="2032" x1="1456" />
        </branch>
        <branch name="CLK">
            <wire x2="1520" y1="2080" y2="2080" x1="1440" />
        </branch>
        <iomarker fontsize="28" x="1440" y="2080" name="CLK" orien="R180" />
        <branch name="H">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2816" y="1792" type="branch" />
            <wire x2="2880" y1="1792" y2="1792" x1="2816" />
        </branch>
        <instance x="576" y="1760" name="XLXI_5" orien="R0" />
        <instance x="576" y="2048" name="XLXI_6" orien="R0" />
        <branch name="H">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="720" y="1808" type="branch" />
            <wire x2="640" y1="1760" y2="1808" x1="640" />
            <wire x2="720" y1="1808" y2="1808" x1="640" />
        </branch>
        <branch name="L">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="720" y="1872" type="branch" />
            <wire x2="640" y1="1872" y2="1920" x1="640" />
            <wire x2="720" y1="1872" y2="1872" x1="640" />
        </branch>
        <branch name="XLXN_80">
            <wire x2="2880" y1="1600" y2="1600" x1="1904" />
        </branch>
        <branch name="XLXN_82">
            <wire x2="2880" y1="1696" y2="1696" x1="1904" />
        </branch>
        <branch name="XLXN_83">
            <wire x2="2880" y1="1744" y2="1744" x1="1904" />
        </branch>
        <branch name="CMD_RX_REQ">
            <wire x2="4400" y1="1600" y2="1600" x1="3392" />
            <wire x2="4480" y1="1600" y2="1600" x1="4400" />
            <wire x2="4400" y1="1280" y2="1600" x1="4400" />
            <wire x2="5200" y1="1280" y2="1280" x1="4400" />
        </branch>
        <branch name="XLXN_85">
            <wire x2="4480" y1="1648" y2="1648" x1="3392" />
        </branch>
        <instance x="1600" y="3840" name="XLXI_7" orien="R0">
        </instance>
        <branch name="STARTN">
            <wire x2="1536" y1="3600" y2="3600" x1="1440" />
            <wire x2="1536" y1="3600" y2="3760" x1="1536" />
            <wire x2="1600" y1="3760" y2="3760" x1="1536" />
            <wire x2="1968" y1="3600" y2="3600" x1="1536" />
            <wire x2="2048" y1="3600" y2="3600" x1="1968" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1536" y="3808" type="branch" />
            <wire x2="1600" y1="3808" y2="3808" x1="1536" />
        </branch>
        <iomarker fontsize="28" x="1440" y="3600" name="STARTN" orien="R180" />
        <branch name="CMD_TX_REQ">
            <wire x2="2720" y1="1440" y2="1888" x1="2720" />
            <wire x2="2880" y1="1888" y2="1888" x1="2720" />
            <wire x2="5088" y1="1440" y2="1440" x1="2720" />
            <wire x2="5088" y1="1440" y2="1600" x1="5088" />
            <wire x2="5200" y1="1600" y2="1600" x1="5088" />
            <wire x2="5088" y1="1600" y2="1600" x1="5024" />
        </branch>
        <branch name="XLXN_142(79:0)">
            <wire x2="5152" y1="1376" y2="1376" x1="2656" />
            <wire x2="5152" y1="1376" y2="1648" x1="5152" />
            <wire x2="2656" y1="1376" y2="1936" x1="2656" />
            <wire x2="2880" y1="1936" y2="1936" x1="2656" />
            <wire x2="5152" y1="1648" y2="1648" x1="5024" />
        </branch>
        <branch name="XLXN_12(7:0)">
            <wire x2="1520" y1="1936" y2="1936" x1="1216" />
            <wire x2="1216" y1="1936" y2="2464" x1="1216" />
            <wire x2="3520" y1="2464" y2="2464" x1="1216" />
            <wire x2="3520" y1="2128" y2="2128" x1="3392" />
            <wire x2="3520" y1="2128" y2="2464" x1="3520" />
        </branch>
        <branch name="XLXN_98">
            <wire x2="1520" y1="1888" y2="1888" x1="1152" />
            <wire x2="1152" y1="1888" y2="2528" x1="1152" />
            <wire x2="3584" y1="2528" y2="2528" x1="1152" />
            <wire x2="3584" y1="2080" y2="2080" x1="3392" />
            <wire x2="3584" y1="2080" y2="2528" x1="3584" />
        </branch>
        <branch name="XLXN_144(79:0)">
            <wire x2="4480" y1="1696" y2="1696" x1="3392" />
        </branch>
        <branch name="XLXN_99">
            <wire x2="2880" y1="1984" y2="1984" x1="1904" />
        </branch>
        <branch name="XLXN_100">
            <wire x2="2880" y1="2032" y2="2032" x1="1904" />
        </branch>
        <branch name="XLXN_81(7:0)">
            <wire x2="2880" y1="1648" y2="1648" x1="1904" />
        </branch>
        <branch name="EMB_TX_REQ">
            <wire x2="4480" y1="1984" y2="1984" x1="4400" />
        </branch>
        <branch name="EMB_TX_DATA(79:0)">
            <wire x2="4480" y1="2032" y2="2032" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="1984" name="EMB_TX_REQ" orien="R180" />
        <iomarker fontsize="28" x="4400" y="2032" name="EMB_TX_DATA(79:0)" orien="R180" />
        <branch name="L,L,L,L,H,H,H">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="2128" type="branch" />
            <wire x2="4480" y1="2128" y2="2128" x1="4416" />
        </branch>
        <branch name="FRAME_ALT">
            <wire x2="4480" y1="2320" y2="2320" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="2320" name="FRAME_ALT" orien="R180" />
        <branch name="POWER1(15:0)">
            <wire x2="5200" y1="1744" y2="1744" x1="5024" />
        </branch>
        <branch name="POWER2(15:0)">
            <wire x2="5200" y1="1792" y2="1792" x1="5024" />
        </branch>
        <branch name="POWER3(15:0)">
            <wire x2="5200" y1="1840" y2="1840" x1="5024" />
        </branch>
        <branch name="POWER4(15:0)">
            <wire x2="5200" y1="1888" y2="1888" x1="5024" />
        </branch>
        <branch name="POWER5(15:0)">
            <wire x2="5200" y1="1936" y2="1936" x1="5024" />
        </branch>
        <branch name="POWER6(15:0)">
            <wire x2="5200" y1="1984" y2="1984" x1="5024" />
        </branch>
        <branch name="POWER7(15:0)">
            <wire x2="5200" y1="2032" y2="2032" x1="5024" />
        </branch>
        <branch name="POWER8(15:0)">
            <wire x2="5200" y1="2080" y2="2080" x1="5024" />
        </branch>
        <branch name="POWER9(15:0)">
            <wire x2="5200" y1="2128" y2="2128" x1="5024" />
        </branch>
        <branch name="TEMPERATURE1(15:0)">
            <wire x2="5200" y1="2176" y2="2176" x1="5024" />
        </branch>
        <branch name="TEMPERATURE2(15:0)">
            <wire x2="5200" y1="2224" y2="2224" x1="5024" />
        </branch>
        <iomarker fontsize="28" x="5200" y="1744" name="POWER1(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="1792" name="POWER2(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="1840" name="POWER3(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="1888" name="POWER4(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="1936" name="POWER5(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="1984" name="POWER6(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="2032" name="POWER7(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="2080" name="POWER8(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="2128" name="POWER9(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="2176" name="TEMPERATURE1(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="2224" name="TEMPERATURE2(15:0)" orien="R0" />
        <branch name="RST">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2816" y="2128" type="branch" />
            <wire x2="2880" y1="2128" y2="2128" x1="2816" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2816" y="2176" type="branch" />
            <wire x2="2880" y1="2176" y2="2176" x1="2816" />
        </branch>
        <instance x="2880" y="2848" name="XLXI_14" orien="R0">
        </instance>
        <branch name="EMB_RSP_REQ">
            <wire x2="5200" y1="2416" y2="2416" x1="5024" />
        </branch>
        <branch name="EMB_RSP_DATA(79:0)">
            <wire x2="5200" y1="2464" y2="2464" x1="5024" />
        </branch>
        <iomarker fontsize="28" x="5200" y="2560" name="EMB_BAUD_RATE(1:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="2416" name="EMB_RSP_REQ" orien="R0" />
        <iomarker fontsize="28" x="5200" y="2464" name="EMB_RSP_DATA(79:0)" orien="R0" />
        <branch name="EMB_BAUD_RATE(1:0)">
            <wire x2="1520" y1="1792" y2="1792" x1="1088" />
            <wire x2="1088" y1="1792" y2="2800" x1="1088" />
            <wire x2="5120" y1="2800" y2="2800" x1="1088" />
            <wire x2="5120" y1="2560" y2="2560" x1="5024" />
            <wire x2="5200" y1="2560" y2="2560" x1="5120" />
            <wire x2="5120" y1="2560" y2="2800" x1="5120" />
        </branch>
        <branch name="HUMIDITY1(15:0)">
            <wire x2="5200" y1="2272" y2="2272" x1="5024" />
        </branch>
        <branch name="HUMIDITY2(15:0)">
            <wire x2="5200" y1="2320" y2="2320" x1="5024" />
        </branch>
        <iomarker fontsize="28" x="5200" y="2272" name="HUMIDITY1(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5200" y="2320" name="HUMIDITY2(15:0)" orien="R0" />
        <branch name="H,H,H,H,H,H,H,H,H">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="1744" type="branch" />
            <wire x2="4480" y1="1744" y2="1744" x1="4416" />
        </branch>
        <branch name="L,H">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="1792" type="branch" />
            <wire x2="4480" y1="1792" y2="1792" x1="4416" />
        </branch>
        <branch name="L,L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="1840" type="branch" />
            <wire x2="4480" y1="1840" y2="1840" x1="4416" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3748" y="1744">power1 - 9 : enable</text>
        <text style="fontsize:40;fontname:Arial" x="3748" y="1796">temperature1 : enable</text>
        <branch name="RXD">
            <wire x2="1120" y1="1600" y2="1600" x1="1040" />
        </branch>
        <iomarker fontsize="28" x="1040" y="1600" name="RXD" orien="R180" />
        <branch name="RXD_O">
            <wire x2="1440" y1="1600" y2="1600" x1="1344" />
            <wire x2="1520" y1="1600" y2="1600" x1="1440" />
            <wire x2="1440" y1="1392" y2="1600" x1="1440" />
            <wire x2="1520" y1="1392" y2="1392" x1="1440" />
        </branch>
        <branch name="XLXN_154">
            <wire x2="1968" y1="1888" y2="1888" x1="1904" />
            <wire x2="2032" y1="1312" y2="1312" x1="1968" />
            <wire x2="1968" y1="1312" y2="1888" x1="1968" />
        </branch>
        <instance x="2032" y="1376" name="XLXI_16" orien="R0" />
        <branch name="TXD">
            <wire x2="2672" y1="1280" y2="1280" x1="2592" />
            <wire x2="2720" y1="1280" y2="1280" x1="2672" />
        </branch>
        <iomarker fontsize="28" x="2720" y="1280" name="TXD" orien="R0" />
        <instance x="2368" y="1312" name="XLXI_18" orien="R0" />
        <branch name="XLXN_159">
            <wire x2="2368" y1="1280" y2="1280" x1="2288" />
        </branch>
        <branch name="STARTN_DLY">
            <wire x2="2032" y1="1248" y2="1248" x1="1840" />
        </branch>
        <iomarker fontsize="28" x="1840" y="1248" name="STARTN_DLY" orien="R180" />
        <instance x="1120" y="1632" name="XLXI_15" orien="R0" />
        <iomarker fontsize="28" x="1520" y="1392" name="RXD_O" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="1508" y="1348">for Check</text>
        <iomarker fontsize="28" x="5200" y="1600" name="CMD_TX_REQ" orien="R0" />
        <iomarker fontsize="28" x="5200" y="1280" name="CMD_RX_REQ" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="5252" y="1540">for Check</text>
        <text style="fontsize:40;fontname:Arial" x="5252" y="1220">for Check</text>
        <branch name="EMB_TP_OUT(7:0)">
            <wire x2="5200" y1="2512" y2="2512" x1="5024" />
        </branch>
        <iomarker fontsize="28" x="5200" y="2512" name="EMB_TP_OUT(7:0)" orien="R0" />
        <instance x="1520" y="2144" name="XLXI_19" orien="R0">
        </instance>
        <branch name="RST">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="2512" type="branch" />
            <wire x2="4480" y1="2512" y2="2512" x1="4416" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="2560" type="branch" />
            <wire x2="4480" y1="2560" y2="2560" x1="4416" />
        </branch>
        <branch name="SDI_FAN_ON">
            <wire x2="4480" y1="2368" y2="2368" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="2368" name="SDI_FAN_ON" orien="R180" />
        <branch name="L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="2416" type="branch" />
            <wire x2="4480" y1="2416" y2="2416" x1="4416" />
        </branch>
        <branch name="L,L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="2464" type="branch" />
            <wire x2="4480" y1="2464" y2="2464" x1="4416" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3868" y="2420">SDI FAN command Disable</text>
        <text style="fontsize:40;fontname:Arial" x="3868" y="2520">NPC mode (L,L)</text>
        <text style="fontsize:40;fontname:Arial" x="3868" y="2472">Sensor port sel</text>
        <text style="fontsize:40;fontname:Arial" x="3840" y="2128">RX_timeout_settimg</text>
        <text style="fontsize:40;fontname:Arial" x="3840" y="2176">700msec (L,L,L,L,H,H,H)</text>
        <branch name="L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="2608" type="branch" />
            <wire x2="4480" y1="2608" y2="2608" x1="4416" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3732" y="2608">Fan Speed Set Command Disable</text>
        <text style="fontsize:40;fontname:Arial" x="3732" y="2656">(without Command from RS-232C)</text>
        <branch name="L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1456" y="1984" type="branch" />
            <wire x2="1520" y1="1984" y2="1984" x1="1456" />
        </branch>
        <branch name="TX_TIMEOUT">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="5200" y="2656" type="branch" />
            <wire x2="5200" y1="2656" y2="2656" x1="5024" />
        </branch>
        <branch name="XLXN_138">
            <wire x2="1824" y1="3760" y2="3760" x1="1808" />
            <wire x2="1888" y1="3760" y2="3760" x1="1824" />
            <wire x2="1888" y1="3664" y2="3760" x1="1888" />
            <wire x2="1968" y1="3664" y2="3664" x1="1888" />
            <wire x2="2048" y1="3664" y2="3664" x1="1968" />
        </branch>
        <instance x="2048" y="3792" name="XLXI_21" orien="R0" />
        <branch name="TX_TIMEOUT">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1888" y="3920" type="branch" />
            <wire x2="1968" y1="3920" y2="3920" x1="1888" />
            <wire x2="2048" y1="3728" y2="3728" x1="1968" />
            <wire x2="1968" y1="3728" y2="3920" x1="1968" />
        </branch>
        <branch name="RST">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="2384" y="3664" type="branch" />
            <wire x2="2384" y1="3664" y2="3664" x1="2304" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2508" y="3664">RST</text>
        <text style="fontsize:40;fontname:Arial" x="5440" y="2656">TX_TIMEOUT</text>
        <text style="fontsize:40;fontname:Arial" x="1424" y="3920">TX_TIMEOUT</text>
        <instance x="4480" y="2592" name="XLXI_22" orien="R0">
        </instance>
    </sheet>
</drawing>
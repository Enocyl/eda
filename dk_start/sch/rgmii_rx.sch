<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <signal name="RX_CLK" />
        <signal name="XLXN_10" />
        <signal name="XLXN_11" />
        <signal name="XLXN_12" />
        <signal name="XLXN_17" />
        <signal name="XLXN_18" />
        <signal name="XLXN_19" />
        <signal name="XLXN_24" />
        <signal name="XLXN_25" />
        <signal name="XLXN_26" />
        <signal name="XLXN_31" />
        <signal name="XLXN_32" />
        <signal name="XLXN_33" />
        <signal name="XLXN_151" />
        <signal name="XLXN_152" />
        <signal name="XLXN_153" />
        <signal name="XLXN_154" />
        <signal name="XLXN_155" />
        <signal name="XLXN_163" />
        <signal name="XLXN_164" />
        <signal name="XLXN_165" />
        <signal name="XLXN_166" />
        <signal name="XLXN_167" />
        <signal name="XLXN_168" />
        <signal name="XLXN_169" />
        <signal name="XLXN_170" />
        <signal name="XLXN_171" />
        <signal name="XLXN_172" />
        <signal name="RXD(0)" />
        <signal name="RXD(3:0)" />
        <signal name="RXD(1)" />
        <signal name="RXD(2)" />
        <signal name="RXD(3)" />
        <signal name="RX_DV" />
        <signal name="RX_DVQ" />
        <signal name="XLXN_42" />
        <signal name="RX_ER" />
        <signal name="RXDQ(7:0)" />
        <signal name="RXDQ(0)" />
        <signal name="RXDQ(4)" />
        <signal name="RXDQ(1)" />
        <signal name="RXDQ(5)" />
        <signal name="RXDQ(2)" />
        <signal name="RXDQ(6)" />
        <signal name="RXDQ(3)" />
        <signal name="RXDQ(7)" />
        <signal name="XLXN_177" />
        <signal name="XLXN_178" />
        <signal name="XLXN_179" />
        <signal name="XLXN_180" />
        <signal name="XLXN_181" />
        <port polarity="Input" name="RX_CLK" />
        <port polarity="Input" name="RXD(3:0)" />
        <port polarity="Input" name="RX_DV" />
        <port polarity="Output" name="RX_DVQ" />
        <port polarity="Output" name="RX_ER" />
        <port polarity="Output" name="RXDQ(7:0)" />
        <blockdef name="iddr2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="192" x="64" y="-304" height="392" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="64" y2="64" x1="64" />
            <line x2="0" y1="0" y2="0" x1="64" />
            <line x2="0" y1="-192" y2="-192" x1="64" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="320" y1="-192" y2="-192" x1="256" />
            <line x2="320" y1="-32" y2="-32" x1="256" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
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
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
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
        <blockdef name="xor2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="60" y1="-128" y2="-128" x1="0" />
            <line x2="208" y1="-96" y2="-96" x1="256" />
            <arc ex="44" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <arc ex="64" ey="-144" sx="64" sy="-48" r="56" cx="32" cy="-96" />
            <line x2="64" y1="-144" y2="-144" x1="128" />
            <line x2="64" y1="-48" y2="-48" x1="128" />
            <arc ex="128" ey="-144" sx="208" sy="-96" r="88" cx="132" cy="-56" />
            <arc ex="208" ey="-96" sx="128" sy="-48" r="88" cx="132" cy="-136" />
        </blockdef>
        <blockdef name="iodelay2">
            <timestamp>2009-3-13T20:26:47</timestamp>
            <rect width="256" x="64" y="-640" height="640" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-608" y2="-608" x1="320" />
            <line x2="384" y1="-464" y2="-464" x1="320" />
            <line x2="384" y1="-320" y2="-320" x1="320" />
            <line x2="384" y1="-176" y2="-176" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="fd1">
            <timestamp>2010-5-11T8:39:30</timestamp>
            <rect width="80" x="64" y="-112" height="112" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="208" y1="-80" y2="-80" x1="144" />
        </blockdef>
        <block symbolname="iddr2" name="XLXI_1">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <blockpin signalname="XLXN_151" name="D" />
            <blockpin signalname="RX_CLK" name="C0" />
            <blockpin signalname="XLXN_4" name="C1" />
            <blockpin signalname="XLXN_3" name="CE" />
            <blockpin signalname="XLXN_2" name="R" />
            <blockpin signalname="XLXN_2" name="S" />
            <blockpin signalname="XLXN_177" name="Q0" />
            <blockpin signalname="RXDQ(4)" name="Q1" />
        </block>
        <block symbolname="gnd" name="XLXI_2">
            <blockpin signalname="XLXN_2" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_3">
            <blockpin signalname="XLXN_3" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_4">
            <blockpin signalname="RX_CLK" name="I" />
            <blockpin signalname="XLXN_4" name="O" />
        </block>
        <block symbolname="iddr2" name="XLXI_5">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <blockpin signalname="XLXN_152" name="D" />
            <blockpin signalname="RX_CLK" name="C0" />
            <blockpin signalname="XLXN_12" name="C1" />
            <blockpin signalname="XLXN_11" name="CE" />
            <blockpin signalname="XLXN_10" name="R" />
            <blockpin signalname="XLXN_10" name="S" />
            <blockpin signalname="XLXN_178" name="Q0" />
            <blockpin signalname="RXDQ(5)" name="Q1" />
        </block>
        <block symbolname="gnd" name="XLXI_6">
            <blockpin signalname="XLXN_10" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_7">
            <blockpin signalname="XLXN_11" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_8">
            <blockpin signalname="RX_CLK" name="I" />
            <blockpin signalname="XLXN_12" name="O" />
        </block>
        <block symbolname="iddr2" name="XLXI_9">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <blockpin signalname="XLXN_153" name="D" />
            <blockpin signalname="RX_CLK" name="C0" />
            <blockpin signalname="XLXN_19" name="C1" />
            <blockpin signalname="XLXN_18" name="CE" />
            <blockpin signalname="XLXN_17" name="R" />
            <blockpin signalname="XLXN_17" name="S" />
            <blockpin signalname="XLXN_179" name="Q0" />
            <blockpin signalname="RXDQ(6)" name="Q1" />
        </block>
        <block symbolname="gnd" name="XLXI_10">
            <blockpin signalname="XLXN_17" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_11">
            <blockpin signalname="XLXN_18" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_12">
            <blockpin signalname="RX_CLK" name="I" />
            <blockpin signalname="XLXN_19" name="O" />
        </block>
        <block symbolname="iddr2" name="XLXI_13">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <blockpin signalname="XLXN_154" name="D" />
            <blockpin signalname="RX_CLK" name="C0" />
            <blockpin signalname="XLXN_26" name="C1" />
            <blockpin signalname="XLXN_25" name="CE" />
            <blockpin signalname="XLXN_24" name="R" />
            <blockpin signalname="XLXN_24" name="S" />
            <blockpin signalname="XLXN_180" name="Q0" />
            <blockpin signalname="RXDQ(7)" name="Q1" />
        </block>
        <block symbolname="gnd" name="XLXI_14">
            <blockpin signalname="XLXN_24" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_15">
            <blockpin signalname="XLXN_25" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_16">
            <blockpin signalname="RX_CLK" name="I" />
            <blockpin signalname="XLXN_26" name="O" />
        </block>
        <block symbolname="iddr2" name="XLXI_17">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <blockpin signalname="XLXN_155" name="D" />
            <blockpin signalname="RX_CLK" name="C0" />
            <blockpin signalname="XLXN_33" name="C1" />
            <blockpin signalname="XLXN_32" name="CE" />
            <blockpin signalname="XLXN_31" name="R" />
            <blockpin signalname="XLXN_31" name="S" />
            <blockpin signalname="XLXN_181" name="Q0" />
            <blockpin signalname="XLXN_42" name="Q1" />
        </block>
        <block symbolname="gnd" name="XLXI_18">
            <blockpin signalname="XLXN_31" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_19">
            <blockpin signalname="XLXN_32" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_20">
            <blockpin signalname="RX_CLK" name="I" />
            <blockpin signalname="XLXN_33" name="O" />
        </block>
        <block symbolname="iodelay2" name="delay_rgmii_rxd0">
            <attr value="IDATAIN" name="DELAY_SRC">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList IO IDATAIN ODATAIN" />
            </attr>
            <attr value="DDR" name="DATA_RATE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SDR DDR" />
            </attr>
            <attr value="STAY_AT_LIMIT" name="COUNTER_WRAPAROUND">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList WRAPAROUND STAY_AT_LIMIT" />
            </attr>
            <attr value="FIXED" name="IDELAY_TYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList DEFAULT DIFF_PHASE_DETECTOR FIXED VARIABLE_FROM_HALF_MAX VARIABLE_FROM_ZERO" />
            </attr>
            <blockpin signalname="XLXN_171" name="CAL" />
            <blockpin signalname="XLXN_171" name="CE" />
            <blockpin signalname="XLXN_171" name="CLK" />
            <blockpin signalname="RXD(0)" name="IDATAIN" />
            <blockpin signalname="XLXN_171" name="INC" />
            <blockpin signalname="XLXN_171" name="IOCLK0" />
            <blockpin signalname="XLXN_171" name="IOCLK1" />
            <blockpin signalname="XLXN_171" name="ODATAIN" />
            <blockpin signalname="XLXN_171" name="RST" />
            <blockpin signalname="XLXN_172" name="T" />
            <blockpin name="BUSY" />
            <blockpin signalname="XLXN_151" name="DATAOUT" />
            <blockpin name="DATAOUT2" />
            <blockpin name="DOUT" />
            <blockpin name="TOUT" />
        </block>
        <block symbolname="iodelay2" name="delay_rgmii_rxd1">
            <attr value="IDATAIN" name="DELAY_SRC">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList IO IDATAIN ODATAIN" />
            </attr>
            <attr value="DDR" name="DATA_RATE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SDR DDR" />
            </attr>
            <attr value="STAY_AT_LIMIT" name="COUNTER_WRAPAROUND">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList WRAPAROUND STAY_AT_LIMIT" />
            </attr>
            <attr value="FIXED" name="IDELAY_TYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList DEFAULT DIFF_PHASE_DETECTOR FIXED VARIABLE_FROM_HALF_MAX VARIABLE_FROM_ZERO" />
            </attr>
            <blockpin signalname="XLXN_169" name="CAL" />
            <blockpin signalname="XLXN_169" name="CE" />
            <blockpin signalname="XLXN_169" name="CLK" />
            <blockpin signalname="RXD(1)" name="IDATAIN" />
            <blockpin signalname="XLXN_169" name="INC" />
            <blockpin signalname="XLXN_169" name="IOCLK0" />
            <blockpin signalname="XLXN_169" name="IOCLK1" />
            <blockpin signalname="XLXN_169" name="ODATAIN" />
            <blockpin signalname="XLXN_169" name="RST" />
            <blockpin signalname="XLXN_170" name="T" />
            <blockpin name="BUSY" />
            <blockpin signalname="XLXN_152" name="DATAOUT" />
            <blockpin name="DATAOUT2" />
            <blockpin name="DOUT" />
            <blockpin name="TOUT" />
        </block>
        <block symbolname="iodelay2" name="delay_rgmii_rxd2">
            <attr value="IDATAIN" name="DELAY_SRC">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList IO IDATAIN ODATAIN" />
            </attr>
            <attr value="DDR" name="DATA_RATE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SDR DDR" />
            </attr>
            <attr value="STAY_AT_LIMIT" name="COUNTER_WRAPAROUND">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList WRAPAROUND STAY_AT_LIMIT" />
            </attr>
            <attr value="FIXED" name="IDELAY_TYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList DEFAULT DIFF_PHASE_DETECTOR FIXED VARIABLE_FROM_HALF_MAX VARIABLE_FROM_ZERO" />
            </attr>
            <blockpin signalname="XLXN_167" name="CAL" />
            <blockpin signalname="XLXN_167" name="CE" />
            <blockpin signalname="XLXN_167" name="CLK" />
            <blockpin signalname="RXD(2)" name="IDATAIN" />
            <blockpin signalname="XLXN_167" name="INC" />
            <blockpin signalname="XLXN_167" name="IOCLK0" />
            <blockpin signalname="XLXN_167" name="IOCLK1" />
            <blockpin signalname="XLXN_167" name="ODATAIN" />
            <blockpin signalname="XLXN_167" name="RST" />
            <blockpin signalname="XLXN_168" name="T" />
            <blockpin name="BUSY" />
            <blockpin signalname="XLXN_153" name="DATAOUT" />
            <blockpin name="DATAOUT2" />
            <blockpin name="DOUT" />
            <blockpin name="TOUT" />
        </block>
        <block symbolname="iodelay2" name="delay_rgmii_rxd3">
            <attr value="IDATAIN" name="DELAY_SRC">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList IO IDATAIN ODATAIN" />
            </attr>
            <attr value="DDR" name="DATA_RATE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SDR DDR" />
            </attr>
            <attr value="STAY_AT_LIMIT" name="COUNTER_WRAPAROUND">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList WRAPAROUND STAY_AT_LIMIT" />
            </attr>
            <attr value="FIXED" name="IDELAY_TYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList DEFAULT DIFF_PHASE_DETECTOR FIXED VARIABLE_FROM_HALF_MAX VARIABLE_FROM_ZERO" />
            </attr>
            <blockpin signalname="XLXN_165" name="CAL" />
            <blockpin signalname="XLXN_165" name="CE" />
            <blockpin signalname="XLXN_165" name="CLK" />
            <blockpin signalname="RXD(3)" name="IDATAIN" />
            <blockpin signalname="XLXN_165" name="INC" />
            <blockpin signalname="XLXN_165" name="IOCLK0" />
            <blockpin signalname="XLXN_165" name="IOCLK1" />
            <blockpin signalname="XLXN_165" name="ODATAIN" />
            <blockpin signalname="XLXN_165" name="RST" />
            <blockpin signalname="XLXN_166" name="T" />
            <blockpin name="BUSY" />
            <blockpin signalname="XLXN_154" name="DATAOUT" />
            <blockpin name="DATAOUT2" />
            <blockpin name="DOUT" />
            <blockpin name="TOUT" />
        </block>
        <block symbolname="iodelay2" name="delay_rgmii_rx_dv">
            <attr value="IDATAIN" name="DELAY_SRC">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList IO IDATAIN ODATAIN" />
            </attr>
            <attr value="DDR" name="DATA_RATE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SDR DDR" />
            </attr>
            <attr value="STAY_AT_LIMIT" name="COUNTER_WRAPAROUND">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList WRAPAROUND STAY_AT_LIMIT" />
            </attr>
            <attr value="FIXED" name="IDELAY_TYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList DEFAULT DIFF_PHASE_DETECTOR FIXED VARIABLE_FROM_HALF_MAX VARIABLE_FROM_ZERO" />
            </attr>
            <blockpin signalname="XLXN_163" name="CAL" />
            <blockpin signalname="XLXN_163" name="CE" />
            <blockpin signalname="XLXN_163" name="CLK" />
            <blockpin signalname="RX_DV" name="IDATAIN" />
            <blockpin signalname="XLXN_163" name="INC" />
            <blockpin signalname="XLXN_163" name="IOCLK0" />
            <blockpin signalname="XLXN_163" name="IOCLK1" />
            <blockpin signalname="XLXN_163" name="ODATAIN" />
            <blockpin signalname="XLXN_163" name="RST" />
            <blockpin signalname="XLXN_164" name="T" />
            <blockpin name="BUSY" />
            <blockpin signalname="XLXN_155" name="DATAOUT" />
            <blockpin name="DATAOUT2" />
            <blockpin name="DOUT" />
            <blockpin name="TOUT" />
        </block>
        <block symbolname="gnd" name="XLXI_105">
            <blockpin signalname="XLXN_163" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_107">
            <blockpin signalname="XLXN_164" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_108">
            <blockpin signalname="XLXN_165" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_109">
            <blockpin signalname="XLXN_166" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_110">
            <blockpin signalname="XLXN_167" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_111">
            <blockpin signalname="XLXN_168" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_112">
            <blockpin signalname="XLXN_169" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_113">
            <blockpin signalname="XLXN_170" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_114">
            <blockpin signalname="XLXN_171" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_115">
            <blockpin signalname="XLXN_172" name="P" />
        </block>
        <block symbolname="xor2" name="XLXI_21">
            <blockpin signalname="XLXN_42" name="I0" />
            <blockpin signalname="RX_DVQ" name="I1" />
            <blockpin signalname="RX_ER" name="O" />
        </block>
        <block symbolname="fd1" name="XLXI_117">
            <blockpin signalname="XLXN_181" name="D" />
            <blockpin signalname="RX_CLK" name="CK" />
            <blockpin signalname="RX_DVQ" name="Q" />
        </block>
        <block symbolname="fd1" name="XLXI_118">
            <blockpin signalname="XLXN_180" name="D" />
            <blockpin signalname="RX_CLK" name="CK" />
            <blockpin signalname="RXDQ(3)" name="Q" />
        </block>
        <block symbolname="fd1" name="XLXI_119">
            <blockpin signalname="XLXN_179" name="D" />
            <blockpin signalname="RX_CLK" name="CK" />
            <blockpin signalname="RXDQ(2)" name="Q" />
        </block>
        <block symbolname="fd1" name="XLXI_120">
            <blockpin signalname="XLXN_178" name="D" />
            <blockpin signalname="RX_CLK" name="CK" />
            <blockpin signalname="RXDQ(1)" name="Q" />
        </block>
        <block symbolname="fd1" name="XLXI_121">
            <blockpin signalname="XLXN_177" name="D" />
            <blockpin signalname="RX_CLK" name="CK" />
            <blockpin signalname="RXDQ(0)" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="7120" y="5180">rgmii_rx</text>
        <instance x="3040" y="1056" name="XLXI_1" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="120" type="instance" />
        </instance>
        <instance x="2912" y="1296" name="XLXI_2" orien="R0" />
        <instance x="2912" y="752" name="XLXI_3" orien="R0" />
        <branch name="XLXN_2">
            <wire x2="3040" y1="1056" y2="1056" x1="2976" />
            <wire x2="2976" y1="1056" y2="1120" x1="2976" />
            <wire x2="3040" y1="1120" y2="1120" x1="2976" />
            <wire x2="2976" y1="1120" y2="1168" x1="2976" />
        </branch>
        <branch name="XLXN_3">
            <wire x2="2976" y1="752" y2="992" x1="2976" />
            <wire x2="3040" y1="992" y2="992" x1="2976" />
        </branch>
        <instance x="2688" y="960" name="XLXI_4" orien="R0" />
        <branch name="XLXN_4">
            <wire x2="3040" y1="928" y2="928" x1="2912" />
        </branch>
        <instance x="3040" y="1856" name="XLXI_5" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="120" type="instance" />
        </instance>
        <instance x="2912" y="2096" name="XLXI_6" orien="R0" />
        <instance x="2912" y="1552" name="XLXI_7" orien="R0" />
        <branch name="XLXN_10">
            <wire x2="3040" y1="1856" y2="1856" x1="2976" />
            <wire x2="2976" y1="1856" y2="1920" x1="2976" />
            <wire x2="3040" y1="1920" y2="1920" x1="2976" />
            <wire x2="2976" y1="1920" y2="1968" x1="2976" />
        </branch>
        <branch name="XLXN_11">
            <wire x2="2976" y1="1552" y2="1792" x1="2976" />
            <wire x2="3040" y1="1792" y2="1792" x1="2976" />
        </branch>
        <instance x="2688" y="1760" name="XLXI_8" orien="R0" />
        <branch name="XLXN_12">
            <wire x2="3040" y1="1728" y2="1728" x1="2912" />
        </branch>
        <instance x="3040" y="2656" name="XLXI_9" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="120" type="instance" />
        </instance>
        <instance x="2912" y="2896" name="XLXI_10" orien="R0" />
        <instance x="2912" y="2352" name="XLXI_11" orien="R0" />
        <branch name="XLXN_17">
            <wire x2="3040" y1="2656" y2="2656" x1="2976" />
            <wire x2="2976" y1="2656" y2="2720" x1="2976" />
            <wire x2="3040" y1="2720" y2="2720" x1="2976" />
            <wire x2="2976" y1="2720" y2="2768" x1="2976" />
        </branch>
        <branch name="XLXN_18">
            <wire x2="2976" y1="2352" y2="2592" x1="2976" />
            <wire x2="3040" y1="2592" y2="2592" x1="2976" />
        </branch>
        <instance x="2688" y="2560" name="XLXI_12" orien="R0" />
        <branch name="XLXN_19">
            <wire x2="3040" y1="2528" y2="2528" x1="2912" />
        </branch>
        <instance x="3040" y="3456" name="XLXI_13" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="120" type="instance" />
        </instance>
        <instance x="2912" y="3696" name="XLXI_14" orien="R0" />
        <instance x="2912" y="3152" name="XLXI_15" orien="R0" />
        <branch name="XLXN_24">
            <wire x2="3040" y1="3456" y2="3456" x1="2976" />
            <wire x2="2976" y1="3456" y2="3520" x1="2976" />
            <wire x2="3040" y1="3520" y2="3520" x1="2976" />
            <wire x2="2976" y1="3520" y2="3568" x1="2976" />
        </branch>
        <branch name="XLXN_25">
            <wire x2="2976" y1="3152" y2="3392" x1="2976" />
            <wire x2="3040" y1="3392" y2="3392" x1="2976" />
        </branch>
        <instance x="2688" y="3360" name="XLXI_16" orien="R0" />
        <branch name="XLXN_26">
            <wire x2="3040" y1="3328" y2="3328" x1="2912" />
        </branch>
        <instance x="3040" y="4256" name="XLXI_17" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="120" type="instance" />
        </instance>
        <instance x="2912" y="4496" name="XLXI_18" orien="R0" />
        <instance x="2912" y="3952" name="XLXI_19" orien="R0" />
        <branch name="XLXN_31">
            <wire x2="3040" y1="4256" y2="4256" x1="2976" />
            <wire x2="2976" y1="4256" y2="4320" x1="2976" />
            <wire x2="3040" y1="4320" y2="4320" x1="2976" />
            <wire x2="2976" y1="4320" y2="4368" x1="2976" />
        </branch>
        <branch name="XLXN_32">
            <wire x2="2976" y1="3952" y2="4192" x1="2976" />
            <wire x2="3040" y1="4192" y2="4192" x1="2976" />
        </branch>
        <instance x="2688" y="4160" name="XLXI_20" orien="R0" />
        <branch name="XLXN_33">
            <wire x2="3040" y1="4128" y2="4128" x1="2912" />
        </branch>
        <instance x="1920" y="1264" name="delay_rgmii_rxd0" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DATA_RATE" x="80" y="32" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="IDELAY_TYPE" x="80" y="60" type="instance" />
        </instance>
        <instance x="1920" y="2064" name="delay_rgmii_rxd1" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DATA_RATE" x="80" y="32" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="IDELAY_TYPE" x="80" y="60" type="instance" />
        </instance>
        <instance x="1920" y="2864" name="delay_rgmii_rxd2" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DATA_RATE" x="80" y="32" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="IDELAY_TYPE" x="80" y="60" type="instance" />
        </instance>
        <instance x="1920" y="3664" name="delay_rgmii_rxd3" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DATA_RATE" x="80" y="32" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="IDELAY_TYPE" x="80" y="60" type="instance" />
        </instance>
        <instance x="1920" y="4464" name="delay_rgmii_rx_dv" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DATA_RATE" x="80" y="32" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="IDELAY_TYPE" x="80" y="60" type="instance" />
        </instance>
        <branch name="XLXN_151">
            <wire x2="3040" y1="800" y2="800" x1="2304" />
        </branch>
        <branch name="XLXN_152">
            <wire x2="3040" y1="1600" y2="1600" x1="2304" />
        </branch>
        <branch name="XLXN_153">
            <wire x2="3040" y1="2400" y2="2400" x1="2304" />
        </branch>
        <branch name="XLXN_154">
            <wire x2="3040" y1="3200" y2="3200" x1="2304" />
        </branch>
        <branch name="XLXN_155">
            <wire x2="3040" y1="4000" y2="4000" x1="2304" />
        </branch>
        <instance x="1792" y="4608" name="XLXI_105" orien="R0" />
        <branch name="XLXN_163">
            <wire x2="1920" y1="3856" y2="3856" x1="1856" />
            <wire x2="1856" y1="3856" y2="3920" x1="1856" />
            <wire x2="1920" y1="3920" y2="3920" x1="1856" />
            <wire x2="1856" y1="3920" y2="3984" x1="1856" />
            <wire x2="1920" y1="3984" y2="3984" x1="1856" />
            <wire x2="1856" y1="3984" y2="4112" x1="1856" />
            <wire x2="1920" y1="4112" y2="4112" x1="1856" />
            <wire x2="1856" y1="4112" y2="4176" x1="1856" />
            <wire x2="1920" y1="4176" y2="4176" x1="1856" />
            <wire x2="1856" y1="4176" y2="4240" x1="1856" />
            <wire x2="1920" y1="4240" y2="4240" x1="1856" />
            <wire x2="1856" y1="4240" y2="4304" x1="1856" />
            <wire x2="1920" y1="4304" y2="4304" x1="1856" />
            <wire x2="1856" y1="4304" y2="4368" x1="1856" />
            <wire x2="1920" y1="4368" y2="4368" x1="1856" />
            <wire x2="1856" y1="4368" y2="4480" x1="1856" />
        </branch>
        <instance x="1712" y="4384" name="XLXI_107" orien="R0" />
        <branch name="XLXN_164">
            <wire x2="1776" y1="4384" y2="4432" x1="1776" />
            <wire x2="1920" y1="4432" y2="4432" x1="1776" />
        </branch>
        <instance x="1792" y="3808" name="XLXI_108" orien="R0" />
        <branch name="XLXN_165">
            <wire x2="1920" y1="3056" y2="3056" x1="1856" />
            <wire x2="1856" y1="3056" y2="3120" x1="1856" />
            <wire x2="1920" y1="3120" y2="3120" x1="1856" />
            <wire x2="1856" y1="3120" y2="3184" x1="1856" />
            <wire x2="1920" y1="3184" y2="3184" x1="1856" />
            <wire x2="1856" y1="3184" y2="3312" x1="1856" />
            <wire x2="1920" y1="3312" y2="3312" x1="1856" />
            <wire x2="1856" y1="3312" y2="3376" x1="1856" />
            <wire x2="1920" y1="3376" y2="3376" x1="1856" />
            <wire x2="1856" y1="3376" y2="3440" x1="1856" />
            <wire x2="1920" y1="3440" y2="3440" x1="1856" />
            <wire x2="1856" y1="3440" y2="3504" x1="1856" />
            <wire x2="1920" y1="3504" y2="3504" x1="1856" />
            <wire x2="1856" y1="3504" y2="3568" x1="1856" />
            <wire x2="1920" y1="3568" y2="3568" x1="1856" />
            <wire x2="1856" y1="3568" y2="3680" x1="1856" />
        </branch>
        <instance x="1712" y="3584" name="XLXI_109" orien="R0" />
        <branch name="XLXN_166">
            <wire x2="1776" y1="3584" y2="3632" x1="1776" />
            <wire x2="1920" y1="3632" y2="3632" x1="1776" />
        </branch>
        <instance x="1792" y="3008" name="XLXI_110" orien="R0" />
        <branch name="XLXN_167">
            <wire x2="1920" y1="2256" y2="2256" x1="1856" />
            <wire x2="1856" y1="2256" y2="2320" x1="1856" />
            <wire x2="1920" y1="2320" y2="2320" x1="1856" />
            <wire x2="1856" y1="2320" y2="2384" x1="1856" />
            <wire x2="1920" y1="2384" y2="2384" x1="1856" />
            <wire x2="1856" y1="2384" y2="2512" x1="1856" />
            <wire x2="1920" y1="2512" y2="2512" x1="1856" />
            <wire x2="1856" y1="2512" y2="2576" x1="1856" />
            <wire x2="1920" y1="2576" y2="2576" x1="1856" />
            <wire x2="1856" y1="2576" y2="2640" x1="1856" />
            <wire x2="1920" y1="2640" y2="2640" x1="1856" />
            <wire x2="1856" y1="2640" y2="2704" x1="1856" />
            <wire x2="1920" y1="2704" y2="2704" x1="1856" />
            <wire x2="1856" y1="2704" y2="2768" x1="1856" />
            <wire x2="1920" y1="2768" y2="2768" x1="1856" />
            <wire x2="1856" y1="2768" y2="2880" x1="1856" />
        </branch>
        <instance x="1712" y="2784" name="XLXI_111" orien="R0" />
        <branch name="XLXN_168">
            <wire x2="1776" y1="2784" y2="2832" x1="1776" />
            <wire x2="1920" y1="2832" y2="2832" x1="1776" />
        </branch>
        <instance x="1792" y="2208" name="XLXI_112" orien="R0" />
        <branch name="XLXN_169">
            <wire x2="1920" y1="1456" y2="1456" x1="1856" />
            <wire x2="1856" y1="1456" y2="1520" x1="1856" />
            <wire x2="1920" y1="1520" y2="1520" x1="1856" />
            <wire x2="1856" y1="1520" y2="1584" x1="1856" />
            <wire x2="1920" y1="1584" y2="1584" x1="1856" />
            <wire x2="1856" y1="1584" y2="1712" x1="1856" />
            <wire x2="1920" y1="1712" y2="1712" x1="1856" />
            <wire x2="1856" y1="1712" y2="1776" x1="1856" />
            <wire x2="1920" y1="1776" y2="1776" x1="1856" />
            <wire x2="1856" y1="1776" y2="1840" x1="1856" />
            <wire x2="1920" y1="1840" y2="1840" x1="1856" />
            <wire x2="1856" y1="1840" y2="1904" x1="1856" />
            <wire x2="1920" y1="1904" y2="1904" x1="1856" />
            <wire x2="1856" y1="1904" y2="1968" x1="1856" />
            <wire x2="1920" y1="1968" y2="1968" x1="1856" />
            <wire x2="1856" y1="1968" y2="2080" x1="1856" />
        </branch>
        <instance x="1712" y="1984" name="XLXI_113" orien="R0" />
        <branch name="XLXN_170">
            <wire x2="1776" y1="1984" y2="2032" x1="1776" />
            <wire x2="1920" y1="2032" y2="2032" x1="1776" />
        </branch>
        <instance x="1792" y="1408" name="XLXI_114" orien="R0" />
        <branch name="XLXN_171">
            <wire x2="1920" y1="656" y2="656" x1="1856" />
            <wire x2="1856" y1="656" y2="720" x1="1856" />
            <wire x2="1920" y1="720" y2="720" x1="1856" />
            <wire x2="1856" y1="720" y2="784" x1="1856" />
            <wire x2="1920" y1="784" y2="784" x1="1856" />
            <wire x2="1856" y1="784" y2="912" x1="1856" />
            <wire x2="1920" y1="912" y2="912" x1="1856" />
            <wire x2="1856" y1="912" y2="976" x1="1856" />
            <wire x2="1920" y1="976" y2="976" x1="1856" />
            <wire x2="1856" y1="976" y2="1040" x1="1856" />
            <wire x2="1920" y1="1040" y2="1040" x1="1856" />
            <wire x2="1856" y1="1040" y2="1104" x1="1856" />
            <wire x2="1920" y1="1104" y2="1104" x1="1856" />
            <wire x2="1856" y1="1104" y2="1168" x1="1856" />
            <wire x2="1920" y1="1168" y2="1168" x1="1856" />
            <wire x2="1856" y1="1168" y2="1280" x1="1856" />
        </branch>
        <instance x="1712" y="1184" name="XLXI_115" orien="R0" />
        <branch name="XLXN_172">
            <wire x2="1776" y1="1184" y2="1232" x1="1776" />
            <wire x2="1920" y1="1232" y2="1232" x1="1776" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="836" y="768">RXD(3:0)</text>
        <bustap x2="1456" y1="848" y2="848" x1="1360" />
        <branch name="RXD(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1520" y="848" type="branch" />
            <wire x2="1520" y1="848" y2="848" x1="1456" />
            <wire x2="1920" y1="848" y2="848" x1="1520" />
        </branch>
        <branch name="RXD(3:0)">
            <wire x2="1360" y1="768" y2="768" x1="1200" />
            <wire x2="1360" y1="768" y2="848" x1="1360" />
            <wire x2="1360" y1="848" y2="1648" x1="1360" />
            <wire x2="1360" y1="1648" y2="2448" x1="1360" />
            <wire x2="1360" y1="2448" y2="3248" x1="1360" />
        </branch>
        <bustap x2="1456" y1="1648" y2="1648" x1="1360" />
        <branch name="RXD(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1520" y="1648" type="branch" />
            <wire x2="1520" y1="1648" y2="1648" x1="1456" />
            <wire x2="1920" y1="1648" y2="1648" x1="1520" />
        </branch>
        <bustap x2="1456" y1="2448" y2="2448" x1="1360" />
        <branch name="RXD(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1520" y="2448" type="branch" />
            <wire x2="1520" y1="2448" y2="2448" x1="1456" />
            <wire x2="1920" y1="2448" y2="2448" x1="1520" />
        </branch>
        <bustap x2="1456" y1="3248" y2="3248" x1="1360" />
        <branch name="RXD(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1520" y="3248" type="branch" />
            <wire x2="1520" y1="3248" y2="3248" x1="1456" />
            <wire x2="1920" y1="3248" y2="3248" x1="1520" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="840" y="4052">RX_DV</text>
        <branch name="RX_DV">
            <wire x2="1920" y1="4048" y2="4048" x1="1200" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="840" y="4724">RX_CLK</text>
        <iomarker fontsize="28" x="1200" y="768" name="RXD(3:0)" orien="R180" />
        <iomarker fontsize="28" x="1200" y="4048" name="RX_DV" orien="R180" />
        <iomarker fontsize="28" x="1200" y="4720" name="RX_CLK" orien="R180" />
        <branch name="RX_CLK">
            <wire x2="2640" y1="4720" y2="4720" x1="1200" />
            <wire x2="3520" y1="4720" y2="4720" x1="2640" />
            <wire x2="3040" y1="864" y2="864" x1="2640" />
            <wire x2="2640" y1="864" y2="928" x1="2640" />
            <wire x2="2688" y1="928" y2="928" x1="2640" />
            <wire x2="2640" y1="928" y2="1664" x1="2640" />
            <wire x2="3040" y1="1664" y2="1664" x1="2640" />
            <wire x2="2640" y1="1664" y2="1728" x1="2640" />
            <wire x2="2688" y1="1728" y2="1728" x1="2640" />
            <wire x2="2640" y1="1728" y2="2464" x1="2640" />
            <wire x2="3040" y1="2464" y2="2464" x1="2640" />
            <wire x2="2640" y1="2464" y2="2528" x1="2640" />
            <wire x2="2688" y1="2528" y2="2528" x1="2640" />
            <wire x2="2640" y1="2528" y2="3264" x1="2640" />
            <wire x2="3040" y1="3264" y2="3264" x1="2640" />
            <wire x2="2640" y1="3264" y2="3328" x1="2640" />
            <wire x2="2688" y1="3328" y2="3328" x1="2640" />
            <wire x2="2640" y1="3328" y2="4064" x1="2640" />
            <wire x2="3040" y1="4064" y2="4064" x1="2640" />
            <wire x2="2640" y1="4064" y2="4128" x1="2640" />
            <wire x2="2688" y1="4128" y2="4128" x1="2640" />
            <wire x2="2640" y1="4128" y2="4720" x1="2640" />
            <wire x2="3600" y1="912" y2="912" x1="3520" />
            <wire x2="3520" y1="912" y2="1712" x1="3520" />
            <wire x2="3600" y1="1712" y2="1712" x1="3520" />
            <wire x2="3520" y1="1712" y2="2512" x1="3520" />
            <wire x2="3600" y1="2512" y2="2512" x1="3520" />
            <wire x2="3520" y1="2512" y2="3312" x1="3520" />
            <wire x2="3600" y1="3312" y2="3312" x1="3520" />
            <wire x2="3520" y1="3312" y2="4112" x1="3520" />
            <wire x2="3600" y1="4112" y2="4112" x1="3520" />
            <wire x2="3520" y1="4112" y2="4720" x1="3520" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4536" y="4064">RX_DVQ</text>
        <instance x="3984" y="4288" name="XLXI_21" orien="R0" />
        <branch name="XLXN_42">
            <wire x2="3840" y1="4224" y2="4224" x1="3360" />
            <wire x2="3984" y1="4224" y2="4224" x1="3840" />
        </branch>
        <branch name="RX_ER">
            <wire x2="4320" y1="4192" y2="4192" x1="4240" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4536" y="4192">RX_ER</text>
        <iomarker fontsize="28" x="4320" y="4064" name="RX_DVQ" orien="R0" />
        <iomarker fontsize="28" x="4320" y="4192" name="RX_ER" orien="R0" />
        <branch name="RX_DVQ">
            <wire x2="3920" y1="4064" y2="4064" x1="3808" />
            <wire x2="4320" y1="4064" y2="4064" x1="3920" />
            <wire x2="3920" y1="4064" y2="4160" x1="3920" />
            <wire x2="3984" y1="4160" y2="4160" x1="3920" />
        </branch>
        <instance x="3600" y="4144" name="XLXI_117" orien="R0">
        </instance>
        <text style="fontsize:40;fontname:Arial" x="4568" y="800">RXDQ(3:0)</text>
        <bustap x2="4064" y1="864" y2="864" x1="4160" />
        <bustap x2="4064" y1="1024" y2="1024" x1="4160" />
        <bustap x2="4064" y1="1664" y2="1664" x1="4160" />
        <bustap x2="4064" y1="1824" y2="1824" x1="4160" />
        <bustap x2="4064" y1="2464" y2="2464" x1="4160" />
        <bustap x2="4064" y1="2624" y2="2624" x1="4160" />
        <bustap x2="4064" y1="3264" y2="3264" x1="4160" />
        <bustap x2="4064" y1="3424" y2="3424" x1="4160" />
        <branch name="RXDQ(7:0)">
            <wire x2="4320" y1="800" y2="800" x1="4160" />
            <wire x2="4160" y1="800" y2="864" x1="4160" />
            <wire x2="4160" y1="864" y2="1024" x1="4160" />
            <wire x2="4160" y1="1024" y2="1664" x1="4160" />
            <wire x2="4160" y1="1664" y2="1824" x1="4160" />
            <wire x2="4160" y1="1824" y2="2464" x1="4160" />
            <wire x2="4160" y1="2464" y2="2624" x1="4160" />
            <wire x2="4160" y1="2624" y2="3264" x1="4160" />
            <wire x2="4160" y1="3264" y2="3424" x1="4160" />
        </branch>
        <branch name="RXDQ(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4000" y="864" type="branch" />
            <wire x2="4000" y1="864" y2="864" x1="3808" />
            <wire x2="4064" y1="864" y2="864" x1="4000" />
        </branch>
        <branch name="RXDQ(4)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4000" y="1024" type="branch" />
            <wire x2="4000" y1="1024" y2="1024" x1="3360" />
            <wire x2="4064" y1="1024" y2="1024" x1="4000" />
        </branch>
        <branch name="RXDQ(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4000" y="1664" type="branch" />
            <wire x2="4000" y1="1664" y2="1664" x1="3808" />
            <wire x2="4064" y1="1664" y2="1664" x1="4000" />
        </branch>
        <branch name="RXDQ(5)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4000" y="1824" type="branch" />
            <wire x2="4000" y1="1824" y2="1824" x1="3360" />
            <wire x2="4064" y1="1824" y2="1824" x1="4000" />
        </branch>
        <branch name="RXDQ(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4000" y="2464" type="branch" />
            <wire x2="4000" y1="2464" y2="2464" x1="3808" />
            <wire x2="4064" y1="2464" y2="2464" x1="4000" />
        </branch>
        <branch name="RXDQ(6)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4000" y="2624" type="branch" />
            <wire x2="4000" y1="2624" y2="2624" x1="3360" />
            <wire x2="4064" y1="2624" y2="2624" x1="4000" />
        </branch>
        <branch name="RXDQ(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4000" y="3264" type="branch" />
            <wire x2="4000" y1="3264" y2="3264" x1="3808" />
            <wire x2="4064" y1="3264" y2="3264" x1="4000" />
        </branch>
        <branch name="RXDQ(7)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4000" y="3424" type="branch" />
            <wire x2="4000" y1="3424" y2="3424" x1="3360" />
            <wire x2="4064" y1="3424" y2="3424" x1="4000" />
        </branch>
        <iomarker fontsize="28" x="4320" y="800" name="RXDQ(7:0)" orien="R0" />
        <instance x="3600" y="3344" name="XLXI_118" orien="R0">
        </instance>
        <instance x="3600" y="2544" name="XLXI_119" orien="R0">
        </instance>
        <instance x="3600" y="1744" name="XLXI_120" orien="R0">
        </instance>
        <instance x="3600" y="944" name="XLXI_121" orien="R0">
        </instance>
        <branch name="XLXN_177">
            <wire x2="3600" y1="864" y2="864" x1="3360" />
        </branch>
        <branch name="XLXN_178">
            <wire x2="3600" y1="1664" y2="1664" x1="3360" />
        </branch>
        <branch name="XLXN_179">
            <wire x2="3600" y1="2464" y2="2464" x1="3360" />
        </branch>
        <branch name="XLXN_180">
            <wire x2="3600" y1="3264" y2="3264" x1="3360" />
        </branch>
        <branch name="XLXN_181">
            <wire x2="3600" y1="4064" y2="4064" x1="3360" />
        </branch>
    </sheet>
</drawing>
<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <signal name="XLXN_6" />
        <signal name="TXC_CLK" />
        <signal name="TXC" />
        <signal name="XLXN_12" />
        <signal name="TXD(0)" />
        <signal name="XLXN_11" />
        <signal name="XLXN_10" />
        <signal name="TXD_IN(0)" />
        <signal name="CLK" />
        <signal name="XLXN_22" />
        <signal name="TXD(1)" />
        <signal name="XLXN_24" />
        <signal name="XLXN_25" />
        <signal name="TXD_IN(3)" />
        <signal name="XLXN_29" />
        <signal name="TXD(2)" />
        <signal name="XLXN_31" />
        <signal name="XLXN_32" />
        <signal name="TXD_IN(2)" />
        <signal name="TXD_IN(5)" />
        <signal name="XLXN_36" />
        <signal name="TXD(3)" />
        <signal name="XLXN_38" />
        <signal name="XLXN_39" />
        <signal name="TXD_IN(7)" />
        <signal name="XLXN_196" />
        <signal name="TX_CTL" />
        <signal name="XLXN_198" />
        <signal name="XLXN_199" />
        <signal name="TX_EN" />
        <signal name="TXD_IN(7:0)" />
        <signal name="TXD_IN(1)" />
        <signal name="TX_ER" />
        <signal name="XLXN_208" />
        <signal name="TXD(3:0)" />
        <signal name="TXD_IN(4)" />
        <signal name="TXD_IN(6)" />
        <signal name="CLK_OE" />
        <port polarity="Input" name="TXC_CLK" />
        <port polarity="Output" name="TXC" />
        <port polarity="Input" name="CLK" />
        <port polarity="Output" name="TX_CTL" />
        <port polarity="Input" name="TX_EN" />
        <port polarity="Input" name="TXD_IN(7:0)" />
        <port polarity="Input" name="TX_ER" />
        <port polarity="Output" name="TXD(3:0)" />
        <port polarity="Input" name="CLK_OE" />
        <blockdef name="oddr2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="192" x="64" y="-304" height="484" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="64" y2="64" x1="64" />
            <line x2="0" y1="0" y2="0" x1="64" />
            <line x2="0" y1="-192" y2="-192" x1="64" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="320" y1="-192" y2="-192" x1="256" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="0" y1="128" y2="128" x1="64" />
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
        <block symbolname="gnd" name="XLXI_2">
            <blockpin signalname="XLXN_3" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_3">
            <blockpin signalname="XLXN_4" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_4">
            <blockpin signalname="TXC_CLK" name="I" />
            <blockpin signalname="XLXN_6" name="O" />
        </block>
        <block symbolname="gnd" name="XLXI_6">
            <blockpin signalname="XLXN_10" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_7">
            <blockpin signalname="XLXN_11" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_8">
            <blockpin signalname="CLK" name="I" />
            <blockpin signalname="XLXN_12" name="O" />
        </block>
        <block symbolname="gnd" name="XLXI_14">
            <blockpin signalname="XLXN_25" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_15">
            <blockpin signalname="XLXN_24" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_16">
            <blockpin signalname="CLK" name="I" />
            <blockpin signalname="XLXN_22" name="O" />
        </block>
        <block symbolname="gnd" name="XLXI_18">
            <blockpin signalname="XLXN_32" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_19">
            <blockpin signalname="XLXN_31" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_20">
            <blockpin signalname="CLK" name="I" />
            <blockpin signalname="XLXN_29" name="O" />
        </block>
        <block symbolname="gnd" name="XLXI_22">
            <blockpin signalname="XLXN_39" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_23">
            <blockpin signalname="XLXN_38" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_24">
            <blockpin signalname="CLK" name="I" />
            <blockpin signalname="XLXN_36" name="O" />
        </block>
        <block symbolname="gnd" name="XLXI_118">
            <blockpin signalname="XLXN_199" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_119">
            <blockpin signalname="XLXN_198" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_120">
            <blockpin signalname="CLK" name="I" />
            <blockpin signalname="XLXN_196" name="O" />
        </block>
        <block symbolname="xor2" name="XLXI_121">
            <blockpin signalname="TX_ER" name="I0" />
            <blockpin signalname="TX_EN" name="I1" />
            <blockpin signalname="XLXN_208" name="O" />
        </block>
        <block symbolname="oddr2" name="XLXI_122">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <attr value="ASYNC" name="SRTYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SYNC ASYNC" />
            </attr>
            <blockpin signalname="CLK_OE" name="D0" />
            <blockpin signalname="XLXN_3" name="D1" />
            <blockpin signalname="TXC_CLK" name="C0" />
            <blockpin signalname="XLXN_6" name="C1" />
            <blockpin signalname="XLXN_4" name="CE" />
            <blockpin signalname="XLXN_3" name="R" />
            <blockpin signalname="TXC" name="Q" />
            <blockpin signalname="XLXN_3" name="S" />
        </block>
        <block symbolname="oddr2" name="XLXI_127">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <attr value="ASYNC" name="SRTYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SYNC ASYNC" />
            </attr>
            <blockpin signalname="TXD_IN(0)" name="D0" />
            <blockpin signalname="TXD_IN(4)" name="D1" />
            <blockpin signalname="CLK" name="C0" />
            <blockpin signalname="XLXN_12" name="C1" />
            <blockpin signalname="XLXN_11" name="CE" />
            <blockpin signalname="XLXN_10" name="R" />
            <blockpin signalname="TXD(0)" name="Q" />
            <blockpin signalname="XLXN_10" name="S" />
        </block>
        <block symbolname="oddr2" name="XLXI_128">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <attr value="ASYNC" name="SRTYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SYNC ASYNC" />
            </attr>
            <blockpin signalname="TXD_IN(1)" name="D0" />
            <blockpin signalname="TXD_IN(5)" name="D1" />
            <blockpin signalname="CLK" name="C0" />
            <blockpin signalname="XLXN_22" name="C1" />
            <blockpin signalname="XLXN_24" name="CE" />
            <blockpin signalname="XLXN_25" name="R" />
            <blockpin signalname="TXD(1)" name="Q" />
            <blockpin signalname="XLXN_25" name="S" />
        </block>
        <block symbolname="oddr2" name="XLXI_129">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <attr value="ASYNC" name="SRTYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SYNC ASYNC" />
            </attr>
            <blockpin signalname="TXD_IN(2)" name="D0" />
            <blockpin signalname="TXD_IN(6)" name="D1" />
            <blockpin signalname="CLK" name="C0" />
            <blockpin signalname="XLXN_29" name="C1" />
            <blockpin signalname="XLXN_31" name="CE" />
            <blockpin signalname="XLXN_32" name="R" />
            <blockpin signalname="TXD(2)" name="Q" />
            <blockpin signalname="XLXN_32" name="S" />
        </block>
        <block symbolname="oddr2" name="XLXI_130">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <attr value="ASYNC" name="SRTYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SYNC ASYNC" />
            </attr>
            <blockpin signalname="TXD_IN(3)" name="D0" />
            <blockpin signalname="TXD_IN(7)" name="D1" />
            <blockpin signalname="CLK" name="C0" />
            <blockpin signalname="XLXN_36" name="C1" />
            <blockpin signalname="XLXN_38" name="CE" />
            <blockpin signalname="XLXN_39" name="R" />
            <blockpin signalname="TXD(3)" name="Q" />
            <blockpin signalname="XLXN_39" name="S" />
        </block>
        <block symbolname="oddr2" name="XLXI_131">
            <attr value="C0" name="DDR_ALIGNMENT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE C0 C1" />
            </attr>
            <attr value="ASYNC" name="SRTYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SYNC ASYNC" />
            </attr>
            <blockpin signalname="TX_EN" name="D0" />
            <blockpin signalname="XLXN_208" name="D1" />
            <blockpin signalname="CLK" name="C0" />
            <blockpin signalname="XLXN_196" name="C1" />
            <blockpin signalname="XLXN_198" name="CE" />
            <blockpin signalname="XLXN_199" name="R" />
            <blockpin signalname="TX_CTL" name="Q" />
            <blockpin signalname="XLXN_199" name="S" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="6832" y="5132">rgmii_tx</text>
        <instance x="2512" y="1120" name="XLXI_2" orien="R0" />
        <branch name="XLXN_3">
            <wire x2="2640" y1="624" y2="624" x1="2576" />
            <wire x2="2576" y1="624" y2="880" x1="2576" />
            <wire x2="2640" y1="880" y2="880" x1="2576" />
            <wire x2="2576" y1="880" y2="944" x1="2576" />
            <wire x2="2640" y1="944" y2="944" x1="2576" />
            <wire x2="2576" y1="944" y2="992" x1="2576" />
        </branch>
        <instance x="2448" y="512" name="XLXI_3" orien="R0" />
        <instance x="2224" y="784" name="XLXI_4" orien="R0" />
        <branch name="XLXN_6">
            <wire x2="2640" y1="752" y2="752" x1="2448" />
        </branch>
        <branch name="TXC_CLK">
            <wire x2="2160" y1="688" y2="688" x1="1680" />
            <wire x2="2640" y1="688" y2="688" x1="2160" />
            <wire x2="2160" y1="688" y2="752" x1="2160" />
            <wire x2="2224" y1="752" y2="752" x1="2160" />
        </branch>
        <branch name="TXC">
            <wire x2="3440" y1="624" y2="624" x1="2960" />
        </branch>
        <branch name="XLXN_12">
            <wire x2="2464" y1="1552" y2="1552" x1="2448" />
            <wire x2="2640" y1="1552" y2="1552" x1="2464" />
        </branch>
        <branch name="TXD(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="3120" y="1424" type="branch" />
            <wire x2="3120" y1="1424" y2="1424" x1="2960" />
            <wire x2="3184" y1="1424" y2="1424" x1="3120" />
        </branch>
        <instance x="2512" y="1920" name="XLXI_6" orien="R0" />
        <instance x="2448" y="1312" name="XLXI_7" orien="R0" />
        <instance x="2224" y="1584" name="XLXI_8" orien="R0" />
        <branch name="XLXN_11">
            <wire x2="2512" y1="1312" y2="1328" x1="2512" />
            <wire x2="2512" y1="1328" y2="1616" x1="2512" />
            <wire x2="2640" y1="1616" y2="1616" x1="2512" />
        </branch>
        <branch name="XLXN_10">
            <wire x2="2640" y1="1680" y2="1680" x1="2576" />
            <wire x2="2576" y1="1680" y2="1744" x1="2576" />
            <wire x2="2640" y1="1744" y2="1744" x1="2576" />
            <wire x2="2576" y1="1744" y2="1792" x1="2576" />
        </branch>
        <branch name="TXD_IN(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2000" y="1360" type="branch" />
            <wire x2="2000" y1="1360" y2="1360" x1="1936" />
            <wire x2="2640" y1="1360" y2="1360" x1="2000" />
        </branch>
        <branch name="TXD_IN(4)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2000" y="1424" type="branch" />
            <wire x2="2000" y1="1424" y2="1424" x1="1936" />
            <wire x2="2640" y1="1424" y2="1424" x1="2000" />
        </branch>
        <branch name="XLXN_22">
            <wire x2="2640" y1="2352" y2="2352" x1="2448" />
        </branch>
        <branch name="TXD(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="3120" y="2224" type="branch" />
            <wire x2="3120" y1="2224" y2="2224" x1="2960" />
            <wire x2="3184" y1="2224" y2="2224" x1="3120" />
        </branch>
        <instance x="2512" y="2720" name="XLXI_14" orien="R0" />
        <instance x="2448" y="2112" name="XLXI_15" orien="R0" />
        <instance x="2224" y="2384" name="XLXI_16" orien="R0" />
        <branch name="XLXN_24">
            <wire x2="2512" y1="2112" y2="2416" x1="2512" />
            <wire x2="2640" y1="2416" y2="2416" x1="2512" />
        </branch>
        <branch name="XLXN_25">
            <wire x2="2640" y1="2480" y2="2480" x1="2576" />
            <wire x2="2576" y1="2480" y2="2544" x1="2576" />
            <wire x2="2640" y1="2544" y2="2544" x1="2576" />
            <wire x2="2576" y1="2544" y2="2592" x1="2576" />
        </branch>
        <branch name="TXD_IN(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2000" y="2160" type="branch" />
            <wire x2="2000" y1="2160" y2="2160" x1="1936" />
            <wire x2="2640" y1="2160" y2="2160" x1="2000" />
        </branch>
        <branch name="TXD_IN(5)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2000" y="2224" type="branch" />
            <wire x2="2000" y1="2224" y2="2224" x1="1936" />
            <wire x2="2640" y1="2224" y2="2224" x1="2000" />
        </branch>
        <branch name="XLXN_29">
            <wire x2="2640" y1="3152" y2="3152" x1="2448" />
        </branch>
        <branch name="TXD(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="3120" y="3024" type="branch" />
            <wire x2="3120" y1="3024" y2="3024" x1="2960" />
            <wire x2="3184" y1="3024" y2="3024" x1="3120" />
        </branch>
        <instance x="2512" y="3520" name="XLXI_18" orien="R0" />
        <instance x="2448" y="2912" name="XLXI_19" orien="R0" />
        <instance x="2224" y="3184" name="XLXI_20" orien="R0" />
        <branch name="XLXN_31">
            <wire x2="2512" y1="2912" y2="3216" x1="2512" />
            <wire x2="2640" y1="3216" y2="3216" x1="2512" />
        </branch>
        <branch name="XLXN_32">
            <wire x2="2640" y1="3280" y2="3280" x1="2576" />
            <wire x2="2576" y1="3280" y2="3344" x1="2576" />
            <wire x2="2640" y1="3344" y2="3344" x1="2576" />
            <wire x2="2576" y1="3344" y2="3392" x1="2576" />
        </branch>
        <branch name="TXD_IN(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2000" y="2960" type="branch" />
            <wire x2="2000" y1="2960" y2="2960" x1="1936" />
            <wire x2="2640" y1="2960" y2="2960" x1="2000" />
        </branch>
        <branch name="TXD_IN(6)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2000" y="3024" type="branch" />
            <wire x2="2000" y1="3024" y2="3024" x1="1936" />
            <wire x2="2640" y1="3024" y2="3024" x1="2000" />
        </branch>
        <branch name="XLXN_36">
            <wire x2="2640" y1="3952" y2="3952" x1="2448" />
        </branch>
        <branch name="TXD(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="3120" y="3824" type="branch" />
            <wire x2="3120" y1="3824" y2="3824" x1="2960" />
            <wire x2="3184" y1="3824" y2="3824" x1="3120" />
        </branch>
        <instance x="2512" y="4320" name="XLXI_22" orien="R0" />
        <instance x="2448" y="3712" name="XLXI_23" orien="R0" />
        <instance x="2224" y="3984" name="XLXI_24" orien="R0" />
        <branch name="XLXN_38">
            <wire x2="2512" y1="3712" y2="4016" x1="2512" />
            <wire x2="2640" y1="4016" y2="4016" x1="2512" />
        </branch>
        <branch name="XLXN_39">
            <wire x2="2640" y1="4080" y2="4080" x1="2576" />
            <wire x2="2576" y1="4080" y2="4144" x1="2576" />
            <wire x2="2640" y1="4144" y2="4144" x1="2576" />
            <wire x2="2576" y1="4144" y2="4192" x1="2576" />
        </branch>
        <branch name="TXD_IN(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2000" y="3760" type="branch" />
            <wire x2="2000" y1="3760" y2="3760" x1="1936" />
            <wire x2="2640" y1="3760" y2="3760" x1="2000" />
        </branch>
        <branch name="TXD_IN(7)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2000" y="3824" type="branch" />
            <wire x2="2000" y1="3824" y2="3824" x1="1936" />
            <wire x2="2640" y1="3824" y2="3824" x1="2000" />
        </branch>
        <branch name="XLXN_196">
            <wire x2="2640" y1="4752" y2="4752" x1="2448" />
        </branch>
        <branch name="TX_CTL">
            <wire x2="3440" y1="4624" y2="4624" x1="2960" />
        </branch>
        <instance x="2512" y="5120" name="XLXI_118" orien="R0" />
        <instance x="2448" y="4512" name="XLXI_119" orien="R0" />
        <instance x="2224" y="4784" name="XLXI_120" orien="R0" />
        <branch name="XLXN_198">
            <wire x2="2512" y1="4512" y2="4816" x1="2512" />
            <wire x2="2640" y1="4816" y2="4816" x1="2512" />
        </branch>
        <branch name="XLXN_199">
            <wire x2="2640" y1="4880" y2="4880" x1="2576" />
            <wire x2="2576" y1="4880" y2="4944" x1="2576" />
            <wire x2="2640" y1="4944" y2="4944" x1="2576" />
            <wire x2="2576" y1="4944" y2="4992" x1="2576" />
        </branch>
        <branch name="TX_EN">
            <wire x2="1776" y1="4560" y2="4560" x1="1680" />
            <wire x2="2640" y1="4560" y2="4560" x1="1776" />
            <wire x2="1776" y1="4560" y2="4592" x1="1776" />
            <wire x2="1840" y1="4592" y2="4592" x1="1776" />
        </branch>
        <branch name="TXD_IN(7:0)">
            <wire x2="1840" y1="1280" y2="1280" x1="1680" />
            <wire x2="1840" y1="1280" y2="1360" x1="1840" />
            <wire x2="1840" y1="1360" y2="1424" x1="1840" />
            <wire x2="1840" y1="1424" y2="2160" x1="1840" />
            <wire x2="1840" y1="2160" y2="2224" x1="1840" />
            <wire x2="1840" y1="2224" y2="2960" x1="1840" />
            <wire x2="1840" y1="2960" y2="3024" x1="1840" />
            <wire x2="1840" y1="3024" y2="3760" x1="1840" />
            <wire x2="1840" y1="3760" y2="3824" x1="1840" />
        </branch>
        <bustap x2="1936" y1="1360" y2="1360" x1="1840" />
        <bustap x2="1936" y1="1424" y2="1424" x1="1840" />
        <bustap x2="1936" y1="2160" y2="2160" x1="1840" />
        <bustap x2="1936" y1="2224" y2="2224" x1="1840" />
        <bustap x2="1936" y1="2960" y2="2960" x1="1840" />
        <bustap x2="1936" y1="3024" y2="3024" x1="1840" />
        <bustap x2="1936" y1="3760" y2="3760" x1="1840" />
        <bustap x2="1936" y1="3824" y2="3824" x1="1840" />
        <branch name="CLK">
            <wire x2="2160" y1="4752" y2="4752" x1="1680" />
            <wire x2="2224" y1="4752" y2="4752" x1="2160" />
            <wire x2="2640" y1="1488" y2="1488" x1="2160" />
            <wire x2="2160" y1="1488" y2="1552" x1="2160" />
            <wire x2="2224" y1="1552" y2="1552" x1="2160" />
            <wire x2="2160" y1="1552" y2="2288" x1="2160" />
            <wire x2="2640" y1="2288" y2="2288" x1="2160" />
            <wire x2="2160" y1="2288" y2="2352" x1="2160" />
            <wire x2="2224" y1="2352" y2="2352" x1="2160" />
            <wire x2="2160" y1="2352" y2="3088" x1="2160" />
            <wire x2="2640" y1="3088" y2="3088" x1="2160" />
            <wire x2="2160" y1="3088" y2="3152" x1="2160" />
            <wire x2="2224" y1="3152" y2="3152" x1="2160" />
            <wire x2="2160" y1="3152" y2="3888" x1="2160" />
            <wire x2="2640" y1="3888" y2="3888" x1="2160" />
            <wire x2="2160" y1="3888" y2="3952" x1="2160" />
            <wire x2="2224" y1="3952" y2="3952" x1="2160" />
            <wire x2="2160" y1="3952" y2="4688" x1="2160" />
            <wire x2="2640" y1="4688" y2="4688" x1="2160" />
            <wire x2="2160" y1="4688" y2="4752" x1="2160" />
        </branch>
        <instance x="1840" y="4720" name="XLXI_121" orien="R0" />
        <iomarker fontsize="28" x="1680" y="4560" name="TX_EN" orien="R180" />
        <branch name="TX_ER">
            <wire x2="1840" y1="4656" y2="4656" x1="1680" />
        </branch>
        <iomarker fontsize="28" x="1680" y="4656" name="TX_ER" orien="R180" />
        <iomarker fontsize="28" x="1680" y="4752" name="CLK" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="1360" y="4556">TX_EN</text>
        <text style="fontsize:40;fontname:Arial" x="1396" y="4748">CLK</text>
        <text style="fontsize:40;fontname:Arial" x="1360" y="4656">TX_ER</text>
        <branch name="XLXN_208">
            <wire x2="2640" y1="4624" y2="4624" x1="2096" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1224" y="1280">TXD_IN(7:0)</text>
        <iomarker fontsize="28" x="1680" y="1280" name="TXD_IN(7:0)" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="1300" y="688">TXC_CLK</text>
        <iomarker fontsize="28" x="1680" y="688" name="TXC_CLK" orien="R180" />
        <branch name="TXD(3:0)">
            <wire x2="3440" y1="1360" y2="1360" x1="3280" />
            <wire x2="3280" y1="1360" y2="1424" x1="3280" />
            <wire x2="3280" y1="1424" y2="2224" x1="3280" />
            <wire x2="3280" y1="2224" y2="3024" x1="3280" />
            <wire x2="3280" y1="3024" y2="3824" x1="3280" />
        </branch>
        <iomarker fontsize="28" x="3440" y="1360" name="TXD(3:0)" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="3640" y="1364">TXD(3:0)</text>
        <bustap x2="3184" y1="1424" y2="1424" x1="3280" />
        <bustap x2="3184" y1="2224" y2="2224" x1="3280" />
        <bustap x2="3184" y1="3024" y2="3024" x1="3280" />
        <bustap x2="3184" y1="3824" y2="3824" x1="3280" />
        <iomarker fontsize="28" x="3440" y="4624" name="TX_CTL" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="3604" y="624">TXC</text>
        <iomarker fontsize="28" x="3440" y="624" name="TXC" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="3668" y="4624">TX_CTL</text>
        <branch name="XLXN_4">
            <wire x2="2512" y1="512" y2="816" x1="2512" />
            <wire x2="2640" y1="816" y2="816" x1="2512" />
        </branch>
        <branch name="CLK_OE">
            <wire x2="2640" y1="560" y2="560" x1="1680" />
        </branch>
        <iomarker fontsize="28" x="1680" y="560" name="CLK_OE" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="1300" y="560">CLK_OE</text>
        <instance x="2640" y="816" name="XLXI_122" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="212" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="SRTYPE" x="32" y="256" type="instance" />
        </instance>
        <instance x="2640" y="1616" name="XLXI_127" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="212" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="SRTYPE" x="32" y="256" type="instance" />
        </instance>
        <instance x="2640" y="2416" name="XLXI_128" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="212" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="SRTYPE" x="32" y="256" type="instance" />
        </instance>
        <instance x="2640" y="3216" name="XLXI_129" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="212" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="SRTYPE" x="32" y="256" type="instance" />
        </instance>
        <instance x="2640" y="4016" name="XLXI_130" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="212" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="SRTYPE" x="32" y="256" type="instance" />
        </instance>
        <instance x="2640" y="4816" name="XLXI_131" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DDR_ALIGNMENT" x="32" y="212" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="SRTYPE" x="32" y="256" type="instance" />
        </instance>
    </sheet>
</drawing>
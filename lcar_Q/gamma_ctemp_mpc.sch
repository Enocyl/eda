<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="CLK" />
        <signal name="DIN(9:0)" />
        <signal name="XLXN_61(15:0)" />
        <signal name="XLXN_64(15:0)" />
        <signal name="GAIN(3:0)" />
        <signal name="DOUT(15:0)" />
        <signal name="CT_GAIN(3:0)" />
        <signal name="OVP" />
        <signal name="GAMMA(2:0)" />
        <signal name="XLXN_74" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="DIN(9:0)" />
        <port polarity="Output" name="DOUT(15:0)" />
        <port polarity="Input" name="CT_GAIN(3:0)" />
        <port polarity="Input" name="OVP" />
        <port polarity="Input" name="GAMMA(2:0)" />
        <blockdef name="gamma28_rom_mpc">
            <timestamp>2010-5-16T6:43:34</timestamp>
            <rect width="256" x="64" y="-192" height="160" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
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
        <blockdef name="ctemp_multi_mpc">
            <timestamp>2010-5-16T7:16:38</timestamp>
            <rect width="256" x="64" y="-256" height="160" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <rect width="64" x="0" y="-188" height="24" />
            <line x2="0" y1="-176" y2="-176" x1="64" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
        </blockdef>
        <blockdef name="fd4e">
            <timestamp>2005-10-20T11:19:1</timestamp>
            <rect width="160" x="64" y="-192" height="160" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
            <rect width="64" x="224" y="-172" height="24" />
            <line x2="288" y1="-160" y2="-160" x1="224" />
        </blockdef>
        <block symbolname="gamma28_rom_mpc" name="XLXI_8">
            <blockpin signalname="XLXN_61(15:0)" name="douta(15:0)" />
            <blockpin signalname="CLK" name="clka" />
            <blockpin signalname="DIN(9:0)" name="addra(9:0)" />
            <blockpin signalname="XLXN_74" name="ena" />
        </block>
        <block symbolname="vcc" name="XLXI_11">
            <blockpin signalname="XLXN_74" name="P" />
        </block>
        <block symbolname="f1d16" name="XLXI_21">
            <blockpin signalname="XLXN_61(15:0)" name="D(15:0)" />
            <blockpin signalname="CLK" name="CK" />
            <blockpin signalname="XLXN_64(15:0)" name="Q(15:0)" />
        </block>
        <block symbolname="ctemp_multi_mpc" name="XLXI_22">
            <blockpin signalname="XLXN_64(15:0)" name="din(15:0)" />
            <blockpin signalname="DOUT(15:0)" name="dout(15:0)" />
            <blockpin signalname="GAIN(3:0)" name="gain(3:0)" />
            <blockpin signalname="CLK" name="clk" />
        </block>
        <block symbolname="fd4e" name="XLXI_52">
            <blockpin signalname="CT_GAIN(3:0)" name="D(3:0)" />
            <blockpin signalname="CLK" name="CK" />
            <blockpin signalname="OVP" name="CE" />
            <blockpin signalname="GAIN(3:0)" name="Q(3:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="6748" y="5156">gamma_ctemp_mpc</text>
        <branch name="DIN(9:0)">
            <wire x2="3744" y1="800" y2="800" x1="3536" />
        </branch>
        <instance x="4560" y="880" name="XLXI_21" orien="R0">
        </instance>
        <branch name="XLXN_61(15:0)">
            <wire x2="4560" y1="800" y2="800" x1="4128" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4512" y="848" type="branch" />
            <wire x2="4560" y1="848" y2="848" x1="4512" />
        </branch>
        <instance x="5120" y="1024" name="XLXI_22" orien="R0">
        </instance>
        <text style="fontsize:40;fontname:Arial" x="5212" y="656">3clk delay</text>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="5072" y="896" type="branch" />
            <wire x2="5120" y1="896" y2="896" x1="5072" />
        </branch>
        <branch name="XLXN_64(15:0)">
            <wire x2="5120" y1="800" y2="800" x1="4848" />
        </branch>
        <branch name="DOUT(15:0)">
            <wire x2="5680" y1="800" y2="800" x1="5504" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5940" y="804">DOUT(15:0)</text>
        <iomarker fontsize="28" x="5680" y="800" name="DOUT(15:0)" orien="R0" />
        <branch name="GAIN(3:0)">
            <wire x2="5008" y1="1152" y2="1152" x1="4368" />
            <wire x2="5008" y1="848" y2="1152" x1="5008" />
            <wire x2="5120" y1="848" y2="848" x1="5008" />
        </branch>
        <instance x="3744" y="960" name="XLXI_8" orien="R0">
        </instance>
        <iomarker fontsize="28" x="3536" y="800" name="DIN(9:0)" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="3220" y="800">DIN(9:0)</text>
        <instance x="4080" y="1312" name="XLXI_52" orien="R0">
        </instance>
        <branch name="CT_GAIN(3:0)">
            <wire x2="4080" y1="1152" y2="1152" x1="3840" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3300" y="1152">CT_GAIN(3:0)</text>
        <branch name="CLK">
            <wire x2="4016" y1="1248" y2="1248" x1="3840" />
            <wire x2="4080" y1="1248" y2="1248" x1="4016" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3448" y="1252">CLK</text>
        <branch name="OVP">
            <wire x2="3952" y1="1200" y2="1200" x1="3840" />
            <wire x2="4080" y1="1200" y2="1200" x1="3952" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3448" y="1204">OVP</text>
        <iomarker fontsize="28" x="3840" y="1152" name="CT_GAIN(3:0)" orien="R180" />
        <iomarker fontsize="28" x="3840" y="1248" name="CLK" orien="R180" />
        <iomarker fontsize="28" x="3840" y="1200" name="OVP" orien="R180" />
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3728" y="896" type="branch" />
            <wire x2="3744" y1="896" y2="896" x1="3728" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1140" y="768">GAMMA(2:0)</text>
        <branch name="GAMMA(2:0)">
            <wire x2="1728" y1="768" y2="768" x1="1680" />
        </branch>
        <iomarker fontsize="28" x="1680" y="768" name="GAMMA(2:0)" orien="R180" />
        <instance x="3648" y="912" name="XLXI_11" orien="R270" />
        <branch name="XLXN_74">
            <wire x2="3744" y1="848" y2="848" x1="3648" />
        </branch>
    </sheet>
</drawing>
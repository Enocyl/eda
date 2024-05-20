<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="Spartan2E" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="CE" />
        <signal name="CK" />
        <signal name="D" />
        <signal name="Q" />
        <port polarity="Input" name="CE" />
        <port polarity="Input" name="CK" />
        <port polarity="Input" name="D" />
        <port polarity="Output" name="Q" />
        <blockdef name="fdce">
            <timestamp>2001-2-2T12:52:25</timestamp>
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <rect width="256" x="64" y="-320" height="256" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2001-2-2T12:52:44</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <block symbolname="fdce" name="XLXI_1">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="CE" name="CE" />
            <blockpin signalname="XLXN_1" name="CLR" />
            <blockpin signalname="D" name="D" />
            <blockpin signalname="Q" name="Q" />
        </block>
        <block symbolname="gnd" name="XLXI_2">
            <blockpin signalname="XLXN_1" name="G" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1520" y="1440" name="XLXI_1" orien="R0" />
        <branch name="XLXN_1">
            <wire x2="1520" y1="1408" y2="1408" x1="1472" />
            <wire x2="1472" y1="1408" y2="1472" x1="1472" />
            <wire x2="1472" y1="1472" y2="1488" x1="1472" />
        </branch>
        <instance x="1408" y="1616" name="XLXI_2" orien="R0" />
        <branch name="CE">
            <wire x2="1504" y1="1248" y2="1248" x1="1248" />
            <wire x2="1520" y1="1248" y2="1248" x1="1504" />
        </branch>
        <branch name="CK">
            <wire x2="1488" y1="1312" y2="1312" x1="1248" />
            <wire x2="1504" y1="1312" y2="1312" x1="1488" />
            <wire x2="1520" y1="1312" y2="1312" x1="1504" />
        </branch>
        <branch name="D">
            <wire x2="1504" y1="1184" y2="1184" x1="1232" />
            <wire x2="1520" y1="1184" y2="1184" x1="1504" />
        </branch>
        <branch name="Q">
            <wire x2="1920" y1="1184" y2="1184" x1="1904" />
            <wire x2="2176" y1="1184" y2="1184" x1="1920" />
        </branch>
        <iomarker fontsize="28" x="1248" y="1312" name="CK" orien="R180" />
        <iomarker fontsize="28" x="2176" y="1184" name="Q" orien="R0" />
        <iomarker fontsize="28" x="1248" y="1248" name="CE" orien="R180" />
        <iomarker fontsize="28" x="1232" y="1184" name="D" orien="R180" />
    </sheet>
</drawing>
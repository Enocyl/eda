<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan2e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="I(7:0)" />
        <signal name="CK" />
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <signal name="O(7:0)" />
        <port polarity="Input" name="I(7:0)" />
        <port polarity="Input" name="CK" />
        <port polarity="Output" name="O(7:0)" />
        <blockdef name="fd8ce">
            <timestamp>2001-2-2T12:52:25</timestamp>
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <rect width="64" x="320" y="-268" height="24" />
            <rect width="64" x="0" y="-268" height="24" />
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
        <blockdef name="vcc">
            <timestamp>2001-2-2T12:52:44</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <block symbolname="fd8ce" name="XLXI_1">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="XLXN_4" name="CE" />
            <blockpin signalname="XLXN_3" name="CLR" />
            <blockpin signalname="I(7:0)" name="D(7:0)" />
            <blockpin signalname="O(7:0)" name="Q(7:0)" />
        </block>
        <block symbolname="gnd" name="XLXI_2">
            <blockpin signalname="XLXN_3" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_3">
            <blockpin signalname="XLXN_4" name="P" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1440" y="1344" name="XLXI_1" orien="R0" />
        <branch name="I(7:0)">
            <wire x2="1424" y1="1088" y2="1088" x1="1040" />
            <wire x2="1440" y1="1088" y2="1088" x1="1424" />
        </branch>
        <branch name="CK">
            <wire x2="1424" y1="1216" y2="1216" x1="1040" />
            <wire x2="1440" y1="1216" y2="1216" x1="1424" />
        </branch>
        <branch name="XLXN_3">
            <wire x2="1440" y1="1312" y2="1312" x1="1360" />
            <wire x2="1360" y1="1312" y2="1536" x1="1360" />
        </branch>
        <branch name="XLXN_4">
            <wire x2="1360" y1="864" y2="1152" x1="1360" />
            <wire x2="1440" y1="1152" y2="1152" x1="1360" />
        </branch>
        <branch name="O(7:0)">
            <wire x2="1840" y1="1088" y2="1088" x1="1824" />
            <wire x2="2064" y1="1088" y2="1088" x1="1840" />
        </branch>
        <iomarker fontsize="28" x="1040" y="1088" name="I(7:0)" orien="R180" />
        <iomarker fontsize="28" x="1040" y="1216" name="CK" orien="R180" />
        <iomarker fontsize="28" x="2064" y="1088" name="O(7:0)" orien="R0" />
        <instance x="1296" y="1664" name="XLXI_2" orien="R0" />
        <instance x="1296" y="864" name="XLXI_3" orien="R0" />
    </sheet>
</drawing>
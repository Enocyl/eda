<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="virtex4" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="D" />
        <signal name="CK" />
        <signal name="Q" />
        <port polarity="Input" name="D" />
        <port polarity="Input" name="CK" />
        <port polarity="Output" name="Q" />
        <blockdef name="fd">
            <timestamp>2001-2-2T12:37:14</timestamp>
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
        </blockdef>
        <block symbolname="fd" name="XLXI_1">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="D" name="D" />
            <blockpin signalname="Q" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="5382" height="3801">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <instance x="1696" y="1120" name="XLXI_1" orien="R0" />
        <branch name="D">
            <wire x2="1696" y1="864" y2="864" x1="1536" />
        </branch>
        <branch name="CK">
            <wire x2="1696" y1="992" y2="992" x1="1552" />
        </branch>
        <branch name="Q">
            <wire x2="2240" y1="864" y2="864" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="1536" y="864" name="D" orien="R180" />
        <iomarker fontsize="28" x="1552" y="992" name="CK" orien="R180" />
        <iomarker fontsize="28" x="2240" y="864" name="Q" orien="R0" />
    </sheet>
</drawing>
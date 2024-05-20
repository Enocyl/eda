<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="D" />
        <signal name="Q" />
        <signal name="CK" />
        <port polarity="Input" name="D" />
        <port polarity="Output" name="Q" />
        <port polarity="Input" name="CK" />
        <blockdef name="ofd">
            <timestamp>2001-2-2T12:37:59</timestamp>
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="64" y1="-128" y2="-140" x1="84" />
            <line x2="84" y1="-116" y2="-128" x1="64" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
        </blockdef>
        <block symbolname="ofd" name="XLXI_1">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="D" name="D" />
            <blockpin signalname="Q" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <text style="fontsize:64;fontname:Arial" x="3048" y="2556">ofd1s</text>
        <instance x="1440" y="736" name="XLXI_1" orien="R0" />
        <branch name="D">
            <wire x2="1440" y1="480" y2="480" x1="1280" />
        </branch>
        <branch name="Q">
            <wire x2="2000" y1="480" y2="480" x1="1824" />
        </branch>
        <iomarker fontsize="28" x="1280" y="480" name="D" orien="R180" />
        <iomarker fontsize="28" x="2000" y="480" name="Q" orien="R0" />
        <branch name="CK">
            <wire x2="1424" y1="608" y2="608" x1="1280" />
            <wire x2="1440" y1="608" y2="608" x1="1424" />
        </branch>
        <iomarker fontsize="28" x="1280" y="608" name="CK" orien="R180" />
    </sheet>
</drawing>
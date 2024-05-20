<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="virtex2p" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="D0" />
        <signal name="D1" />
        <signal name="D2" />
        <signal name="Q2" />
        <signal name="Q1" />
        <signal name="Q0" />
        <signal name="CK" />
        <port polarity="Input" name="D0" />
        <port polarity="Input" name="D1" />
        <port polarity="Input" name="D2" />
        <port polarity="Output" name="Q2" />
        <port polarity="Output" name="Q1" />
        <port polarity="Output" name="Q0" />
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
            <blockpin signalname="D0" name="D" />
            <blockpin signalname="Q0" name="Q" />
        </block>
        <block symbolname="ofd" name="XLXI_2">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="D1" name="D" />
            <blockpin signalname="Q1" name="Q" />
        </block>
        <block symbolname="ofd" name="XLXI_3">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="D2" name="D" />
            <blockpin signalname="Q2" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <text style="fontsize:64;fontname:Arial" x="3048" y="2556">ofd3</text>
        <instance x="1440" y="736" name="XLXI_1" orien="R0" />
        <instance x="1440" y="1136" name="XLXI_2" orien="R0" />
        <instance x="1440" y="1536" name="XLXI_3" orien="R0" />
        <branch name="D0">
            <wire x2="1440" y1="480" y2="480" x1="1280" />
        </branch>
        <branch name="D1">
            <wire x2="1440" y1="880" y2="880" x1="1280" />
        </branch>
        <branch name="D2">
            <wire x2="1440" y1="1280" y2="1280" x1="1280" />
        </branch>
        <branch name="Q2">
            <wire x2="2000" y1="1280" y2="1280" x1="1824" />
        </branch>
        <branch name="Q1">
            <wire x2="2000" y1="880" y2="880" x1="1824" />
        </branch>
        <branch name="Q0">
            <wire x2="2000" y1="480" y2="480" x1="1824" />
        </branch>
        <branch name="CK">
            <wire x2="1360" y1="1408" y2="1408" x1="1280" />
            <wire x2="1440" y1="1408" y2="1408" x1="1360" />
            <wire x2="1440" y1="608" y2="608" x1="1360" />
            <wire x2="1360" y1="608" y2="1008" x1="1360" />
            <wire x2="1440" y1="1008" y2="1008" x1="1360" />
            <wire x2="1360" y1="1008" y2="1408" x1="1360" />
        </branch>
        <iomarker fontsize="28" x="1280" y="480" name="D0" orien="R180" />
        <iomarker fontsize="28" x="1280" y="880" name="D1" orien="R180" />
        <iomarker fontsize="28" x="1280" y="1280" name="D2" orien="R180" />
        <iomarker fontsize="28" x="1280" y="1408" name="CK" orien="R180" />
        <iomarker fontsize="28" x="2000" y="1280" name="Q2" orien="R0" />
        <iomarker fontsize="28" x="2000" y="880" name="Q1" orien="R0" />
        <iomarker fontsize="28" x="2000" y="480" name="Q0" orien="R0" />
    </sheet>
</drawing>
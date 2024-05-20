<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
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
        <signal name="Q3" />
        <signal name="D3" />
        <signal name="D4" />
        <signal name="Q4" />
        <port polarity="Input" name="D0" />
        <port polarity="Input" name="D1" />
        <port polarity="Input" name="D2" />
        <port polarity="Output" name="Q2" />
        <port polarity="Output" name="Q1" />
        <port polarity="Output" name="Q0" />
        <port polarity="Input" name="CK" />
        <port polarity="Output" name="Q3" />
        <port polarity="Input" name="D3" />
        <port polarity="Input" name="D4" />
        <port polarity="Output" name="Q4" />
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
        <block symbolname="ofd" name="XLXI_4">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="D3" name="D" />
            <blockpin signalname="Q3" name="Q" />
        </block>
        <block symbolname="ofd" name="XLXI_5">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="D4" name="D" />
            <blockpin signalname="Q4" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <text style="fontsize:64;fontname:Arial" x="3048" y="2556">ofd5</text>
        <instance x="1440" y="656" name="XLXI_1" orien="R0" />
        <instance x="1440" y="1056" name="XLXI_2" orien="R0" />
        <instance x="1440" y="1456" name="XLXI_3" orien="R0" />
        <branch name="D0">
            <wire x2="1440" y1="400" y2="400" x1="1280" />
        </branch>
        <branch name="D1">
            <wire x2="1440" y1="800" y2="800" x1="1280" />
        </branch>
        <branch name="D2">
            <wire x2="1440" y1="1200" y2="1200" x1="1280" />
        </branch>
        <branch name="Q2">
            <wire x2="2000" y1="1200" y2="1200" x1="1824" />
        </branch>
        <branch name="Q1">
            <wire x2="2000" y1="800" y2="800" x1="1824" />
        </branch>
        <branch name="Q0">
            <wire x2="2000" y1="400" y2="400" x1="1824" />
        </branch>
        <instance x="1440" y="1856" name="XLXI_4" orien="R0" />
        <branch name="Q3">
            <wire x2="2000" y1="1600" y2="1600" x1="1824" />
        </branch>
        <branch name="D3">
            <wire x2="1440" y1="1600" y2="1600" x1="1280" />
        </branch>
        <instance x="1440" y="2256" name="XLXI_5" orien="R0" />
        <branch name="D4">
            <wire x2="1440" y1="2000" y2="2000" x1="1280" />
        </branch>
        <branch name="Q4">
            <wire x2="2000" y1="2000" y2="2000" x1="1824" />
        </branch>
        <iomarker fontsize="28" x="1280" y="400" name="D0" orien="R180" />
        <iomarker fontsize="28" x="1280" y="800" name="D1" orien="R180" />
        <iomarker fontsize="28" x="1280" y="1200" name="D2" orien="R180" />
        <iomarker fontsize="28" x="2000" y="1200" name="Q2" orien="R0" />
        <iomarker fontsize="28" x="2000" y="800" name="Q1" orien="R0" />
        <iomarker fontsize="28" x="2000" y="400" name="Q0" orien="R0" />
        <iomarker fontsize="28" x="2000" y="1600" name="Q3" orien="R0" />
        <iomarker fontsize="28" x="1280" y="1600" name="D3" orien="R180" />
        <iomarker fontsize="28" x="1280" y="2000" name="D4" orien="R180" />
        <iomarker fontsize="28" x="2000" y="2000" name="Q4" orien="R0" />
        <branch name="CK">
            <wire x2="1360" y1="2128" y2="2128" x1="1280" />
            <wire x2="1440" y1="2128" y2="2128" x1="1360" />
            <wire x2="1440" y1="528" y2="528" x1="1360" />
            <wire x2="1360" y1="528" y2="928" x1="1360" />
            <wire x2="1440" y1="928" y2="928" x1="1360" />
            <wire x2="1360" y1="928" y2="1328" x1="1360" />
            <wire x2="1440" y1="1328" y2="1328" x1="1360" />
            <wire x2="1360" y1="1328" y2="1728" x1="1360" />
            <wire x2="1440" y1="1728" y2="1728" x1="1360" />
            <wire x2="1360" y1="1728" y2="2128" x1="1360" />
        </branch>
        <iomarker fontsize="28" x="1280" y="2128" name="CK" orien="R180" />
    </sheet>
</drawing>
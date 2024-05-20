<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="virtex2p" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="D(0)" />
        <signal name="D(1)" />
        <signal name="D(2)" />
        <signal name="D(3)" />
        <signal name="Q(0)" />
        <signal name="Q(1)" />
        <signal name="Q(2)" />
        <signal name="Q(3)" />
        <signal name="Q(3:0)" />
        <signal name="D(3:0)" />
        <signal name="CK" />
        <signal name="XLXN_3" />
        <signal name="CE" />
        <port polarity="Output" name="Q(3:0)" />
        <port polarity="Input" name="D(3:0)" />
        <port polarity="Input" name="CK" />
        <port polarity="Input" name="CE" />
        <blockdef name="fd4ce">
            <timestamp>2001-2-2T12:37:14</timestamp>
            <line x2="320" y1="-448" y2="-448" x1="384" />
            <line x2="320" y1="-384" y2="-384" x1="384" />
            <line x2="64" y1="-384" y2="-384" x1="0" />
            <line x2="64" y1="-448" y2="-448" x1="0" />
            <line x2="64" y1="-320" y2="-320" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="320" y1="-320" y2="-320" x1="384" />
            <rect width="256" x="64" y="-512" height="448" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2001-2-2T12:37:29</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <block symbolname="fd4ce" name="XLXI_1">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="CE" name="CE" />
            <blockpin signalname="XLXN_3" name="CLR" />
            <blockpin signalname="D(0)" name="D0" />
            <blockpin signalname="D(1)" name="D1" />
            <blockpin signalname="D(2)" name="D2" />
            <blockpin signalname="D(3)" name="D3" />
            <blockpin signalname="Q(0)" name="Q0" />
            <blockpin signalname="Q(1)" name="Q1" />
            <blockpin signalname="Q(2)" name="Q2" />
            <blockpin signalname="Q(3)" name="Q3" />
        </block>
        <block symbolname="gnd" name="XLXI_7">
            <blockpin signalname="XLXN_3" name="G" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <text style="fontsize:64;fontname:Arial" x="3048" y="2552">fd4e</text>
        <instance x="1440" y="1088" name="XLXI_1" orien="R0" />
        <bustap x2="1056" y1="640" y2="640" x1="960" />
        <branch name="D(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1120" y="640" type="branch" />
            <wire x2="1120" y1="640" y2="640" x1="1056" />
            <wire x2="1440" y1="640" y2="640" x1="1120" />
        </branch>
        <bustap x2="1056" y1="704" y2="704" x1="960" />
        <branch name="D(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1120" y="704" type="branch" />
            <wire x2="1120" y1="704" y2="704" x1="1056" />
            <wire x2="1440" y1="704" y2="704" x1="1120" />
        </branch>
        <bustap x2="1056" y1="768" y2="768" x1="960" />
        <branch name="D(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1120" y="768" type="branch" />
            <wire x2="1120" y1="768" y2="768" x1="1056" />
            <wire x2="1440" y1="768" y2="768" x1="1120" />
        </branch>
        <bustap x2="1056" y1="832" y2="832" x1="960" />
        <branch name="D(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1120" y="832" type="branch" />
            <wire x2="1120" y1="832" y2="832" x1="1056" />
            <wire x2="1440" y1="832" y2="832" x1="1120" />
        </branch>
        <bustap x2="2144" y1="640" y2="640" x1="2240" />
        <branch name="Q(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2080" y="640" type="branch" />
            <wire x2="2080" y1="640" y2="640" x1="1824" />
            <wire x2="2144" y1="640" y2="640" x1="2080" />
        </branch>
        <bustap x2="2144" y1="704" y2="704" x1="2240" />
        <branch name="Q(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2080" y="704" type="branch" />
            <wire x2="2080" y1="704" y2="704" x1="1824" />
            <wire x2="2144" y1="704" y2="704" x1="2080" />
        </branch>
        <bustap x2="2144" y1="768" y2="768" x1="2240" />
        <branch name="Q(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2080" y="768" type="branch" />
            <wire x2="2080" y1="768" y2="768" x1="1824" />
            <wire x2="2144" y1="768" y2="768" x1="2080" />
        </branch>
        <bustap x2="2144" y1="832" y2="832" x1="2240" />
        <branch name="Q(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2080" y="832" type="branch" />
            <wire x2="2080" y1="832" y2="832" x1="1824" />
            <wire x2="2144" y1="832" y2="832" x1="2080" />
        </branch>
        <branch name="Q(3:0)">
            <wire x2="2400" y1="480" y2="480" x1="2240" />
            <wire x2="2240" y1="480" y2="640" x1="2240" />
            <wire x2="2240" y1="640" y2="704" x1="2240" />
            <wire x2="2240" y1="704" y2="768" x1="2240" />
            <wire x2="2240" y1="768" y2="832" x1="2240" />
        </branch>
        <branch name="D(3:0)">
            <wire x2="960" y1="480" y2="480" x1="800" />
            <wire x2="960" y1="480" y2="640" x1="960" />
            <wire x2="960" y1="640" y2="704" x1="960" />
            <wire x2="960" y1="704" y2="768" x1="960" />
            <wire x2="960" y1="768" y2="832" x1="960" />
        </branch>
        <branch name="CK">
            <wire x2="1440" y1="960" y2="960" x1="800" />
        </branch>
        <branch name="XLXN_3">
            <wire x2="1360" y1="1056" y2="1120" x1="1360" />
            <wire x2="1440" y1="1056" y2="1056" x1="1360" />
        </branch>
        <instance x="1296" y="1248" name="XLXI_7" orien="R0" />
        <iomarker fontsize="28" x="800" y="480" name="D(3:0)" orien="R180" />
        <iomarker fontsize="28" x="2400" y="480" name="Q(3:0)" orien="R0" />
        <iomarker fontsize="28" x="800" y="960" name="CK" orien="R180" />
        <branch name="CE">
            <wire x2="1440" y1="896" y2="896" x1="800" />
        </branch>
        <iomarker fontsize="28" x="800" y="896" name="CE" orien="R180" />
    </sheet>
</drawing>
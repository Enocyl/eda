<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="O(0)" />
        <signal name="O(1)" />
        <signal name="O(2)" />
        <signal name="O(3)" />
        <signal name="I(3)" />
        <signal name="I(2)" />
        <signal name="I(1)" />
        <signal name="I(0)" />
        <signal name="I(3:0)" />
        <signal name="O(3:0)" />
        <port polarity="Input" name="I(3:0)" />
        <port polarity="Output" name="O(3:0)" />
        <blockdef name="buf">
            <timestamp>2001-2-2T12:35:54</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="0" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="64" y1="-64" y2="0" x1="64" />
        </blockdef>
        <block symbolname="buf" name="XLXI_3">
            <blockpin signalname="I(3)" name="I" />
            <blockpin signalname="O(3)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_4">
            <blockpin signalname="I(2)" name="I" />
            <blockpin signalname="O(2)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_5">
            <blockpin signalname="I(1)" name="I" />
            <blockpin signalname="O(1)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_7">
            <blockpin signalname="I(0)" name="I" />
            <blockpin signalname="O(0)" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3801" height="2688">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <branch name="O(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1600" y="640" type="branch" />
            <wire x2="1600" y1="640" y2="640" x1="1504" />
            <wire x2="1664" y1="640" y2="640" x1="1600" />
        </branch>
        <branch name="O(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1600" y="720" type="branch" />
            <wire x2="1600" y1="720" y2="720" x1="1504" />
            <wire x2="1664" y1="720" y2="720" x1="1600" />
        </branch>
        <branch name="O(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1600" y="800" type="branch" />
            <wire x2="1600" y1="800" y2="800" x1="1504" />
            <wire x2="1664" y1="800" y2="800" x1="1600" />
        </branch>
        <branch name="O(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1600" y="880" type="branch" />
            <wire x2="1600" y1="880" y2="880" x1="1504" />
            <wire x2="1664" y1="880" y2="880" x1="1600" />
        </branch>
        <branch name="I(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1120" y="880" type="branch" />
            <wire x2="1120" y1="880" y2="880" x1="1056" />
            <wire x2="1280" y1="880" y2="880" x1="1120" />
        </branch>
        <branch name="I(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1120" y="800" type="branch" />
            <wire x2="1120" y1="800" y2="800" x1="1056" />
            <wire x2="1280" y1="800" y2="800" x1="1120" />
        </branch>
        <branch name="I(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1120" y="720" type="branch" />
            <wire x2="1120" y1="720" y2="720" x1="1056" />
            <wire x2="1280" y1="720" y2="720" x1="1120" />
        </branch>
        <branch name="I(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1120" y="640" type="branch" />
            <wire x2="1120" y1="640" y2="640" x1="1056" />
            <wire x2="1280" y1="640" y2="640" x1="1120" />
        </branch>
        <bustap x2="1664" y1="640" y2="640" x1="1760" />
        <bustap x2="1664" y1="720" y2="720" x1="1760" />
        <bustap x2="1664" y1="800" y2="800" x1="1760" />
        <bustap x2="1664" y1="880" y2="880" x1="1760" />
        <bustap x2="1056" y1="880" y2="880" x1="960" />
        <bustap x2="1056" y1="800" y2="800" x1="960" />
        <bustap x2="1056" y1="720" y2="720" x1="960" />
        <bustap x2="1056" y1="640" y2="640" x1="960" />
        <instance x="1280" y="912" name="XLXI_3" orien="R0" />
        <instance x="1280" y="832" name="XLXI_4" orien="R0" />
        <instance x="1280" y="752" name="XLXI_5" orien="R0" />
        <instance x="1280" y="672" name="XLXI_7" orien="R0" />
        <text style="fontsize:64;fontname:Arial" x="3048" y="2396">buf4b</text>
        <iomarker fontsize="28" x="1920" y="480" name="O(3:0)" orien="R0" />
        <iomarker fontsize="28" x="800" y="480" name="I(3:0)" orien="R180" />
        <branch name="O(3:0)">
            <wire x2="1920" y1="480" y2="480" x1="1760" />
            <wire x2="1760" y1="480" y2="640" x1="1760" />
            <wire x2="1760" y1="640" y2="720" x1="1760" />
            <wire x2="1760" y1="720" y2="800" x1="1760" />
            <wire x2="1760" y1="800" y2="880" x1="1760" />
        </branch>
        <branch name="I(3:0)">
            <wire x2="960" y1="480" y2="480" x1="800" />
            <wire x2="960" y1="480" y2="640" x1="960" />
            <wire x2="960" y1="640" y2="720" x1="960" />
            <wire x2="960" y1="720" y2="800" x1="960" />
            <wire x2="960" y1="800" y2="880" x1="960" />
        </branch>
    </sheet>
</drawing>
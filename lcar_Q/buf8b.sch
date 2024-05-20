<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="virtex2p" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="I(7:0)" />
        <signal name="O(7:0)" />
        <signal name="I(0)" />
        <signal name="I(1)" />
        <signal name="I(2)" />
        <signal name="I(3)" />
        <signal name="I(4)" />
        <signal name="I(5)" />
        <signal name="I(6)" />
        <signal name="I(7)" />
        <signal name="O(7)" />
        <signal name="O(6)" />
        <signal name="O(5)" />
        <signal name="O(4)" />
        <signal name="O(3)" />
        <signal name="O(2)" />
        <signal name="O(1)" />
        <signal name="O(0)" />
        <port polarity="Input" name="I(7:0)" />
        <port polarity="Output" name="O(7:0)" />
        <blockdef name="buf">
            <timestamp>2001-2-2T12:35:54</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="0" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="64" y1="-64" y2="0" x1="64" />
        </blockdef>
        <block symbolname="buf" name="XLXI_1">
            <blockpin signalname="I(0)" name="I" />
            <blockpin signalname="O(0)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_2">
            <blockpin signalname="I(1)" name="I" />
            <blockpin signalname="O(1)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_3">
            <blockpin signalname="I(2)" name="I" />
            <blockpin signalname="O(2)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_4">
            <blockpin signalname="I(3)" name="I" />
            <blockpin signalname="O(3)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_5">
            <blockpin signalname="I(4)" name="I" />
            <blockpin signalname="O(4)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_6">
            <blockpin signalname="I(5)" name="I" />
            <blockpin signalname="O(5)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_7">
            <blockpin signalname="I(6)" name="I" />
            <blockpin signalname="O(6)" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_8">
            <blockpin signalname="I(7)" name="I" />
            <blockpin signalname="O(7)" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3801" height="2688">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="3208" y="2396">buf8b</text>
        <instance x="1440" y="672" name="XLXI_1" orien="R0" />
        <instance x="1440" y="752" name="XLXI_2" orien="R0" />
        <instance x="1440" y="832" name="XLXI_3" orien="R0" />
        <instance x="1440" y="912" name="XLXI_4" orien="R0" />
        <instance x="1440" y="992" name="XLXI_5" orien="R0" />
        <instance x="1440" y="1072" name="XLXI_6" orien="R0" />
        <instance x="1440" y="1152" name="XLXI_7" orien="R0" />
        <instance x="1440" y="1232" name="XLXI_8" orien="R0" />
        <iomarker fontsize="28" x="960" y="480" name="I(7:0)" orien="R180" />
        <branch name="O(7:0)">
            <wire x2="2080" y1="480" y2="480" x1="1920" />
            <wire x2="1920" y1="480" y2="640" x1="1920" />
            <wire x2="1920" y1="640" y2="720" x1="1920" />
            <wire x2="1920" y1="720" y2="800" x1="1920" />
            <wire x2="1920" y1="800" y2="880" x1="1920" />
            <wire x2="1920" y1="880" y2="960" x1="1920" />
            <wire x2="1920" y1="960" y2="1040" x1="1920" />
            <wire x2="1920" y1="1040" y2="1120" x1="1920" />
            <wire x2="1920" y1="1120" y2="1200" x1="1920" />
        </branch>
        <iomarker fontsize="28" x="2080" y="480" name="O(7:0)" orien="R0" />
        <bustap x2="1216" y1="640" y2="640" x1="1120" />
        <branch name="I(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1280" y="640" type="branch" />
            <wire x2="1280" y1="640" y2="640" x1="1216" />
            <wire x2="1440" y1="640" y2="640" x1="1280" />
        </branch>
        <bustap x2="1216" y1="720" y2="720" x1="1120" />
        <branch name="I(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1280" y="720" type="branch" />
            <wire x2="1280" y1="720" y2="720" x1="1216" />
            <wire x2="1440" y1="720" y2="720" x1="1280" />
        </branch>
        <bustap x2="1216" y1="800" y2="800" x1="1120" />
        <branch name="I(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1280" y="800" type="branch" />
            <wire x2="1280" y1="800" y2="800" x1="1216" />
            <wire x2="1440" y1="800" y2="800" x1="1280" />
        </branch>
        <bustap x2="1216" y1="880" y2="880" x1="1120" />
        <branch name="I(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1280" y="880" type="branch" />
            <wire x2="1280" y1="880" y2="880" x1="1216" />
            <wire x2="1440" y1="880" y2="880" x1="1280" />
        </branch>
        <branch name="I(7:0)">
            <wire x2="1120" y1="480" y2="480" x1="960" />
            <wire x2="1120" y1="480" y2="640" x1="1120" />
            <wire x2="1120" y1="640" y2="720" x1="1120" />
            <wire x2="1120" y1="720" y2="800" x1="1120" />
            <wire x2="1120" y1="800" y2="880" x1="1120" />
            <wire x2="1120" y1="880" y2="960" x1="1120" />
            <wire x2="1120" y1="960" y2="1040" x1="1120" />
            <wire x2="1120" y1="1040" y2="1120" x1="1120" />
            <wire x2="1120" y1="1120" y2="1200" x1="1120" />
        </branch>
        <bustap x2="1216" y1="960" y2="960" x1="1120" />
        <branch name="I(4)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1280" y="960" type="branch" />
            <wire x2="1280" y1="960" y2="960" x1="1216" />
            <wire x2="1440" y1="960" y2="960" x1="1280" />
        </branch>
        <bustap x2="1216" y1="1040" y2="1040" x1="1120" />
        <branch name="I(5)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1280" y="1040" type="branch" />
            <wire x2="1280" y1="1040" y2="1040" x1="1216" />
            <wire x2="1440" y1="1040" y2="1040" x1="1280" />
        </branch>
        <bustap x2="1216" y1="1120" y2="1120" x1="1120" />
        <branch name="I(6)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1280" y="1120" type="branch" />
            <wire x2="1280" y1="1120" y2="1120" x1="1216" />
            <wire x2="1440" y1="1120" y2="1120" x1="1280" />
        </branch>
        <bustap x2="1216" y1="1200" y2="1200" x1="1120" />
        <branch name="I(7)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1280" y="1200" type="branch" />
            <wire x2="1280" y1="1200" y2="1200" x1="1216" />
            <wire x2="1440" y1="1200" y2="1200" x1="1280" />
        </branch>
        <bustap x2="1824" y1="1200" y2="1200" x1="1920" />
        <branch name="O(7)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1760" y="1200" type="branch" />
            <wire x2="1760" y1="1200" y2="1200" x1="1664" />
            <wire x2="1824" y1="1200" y2="1200" x1="1760" />
        </branch>
        <bustap x2="1824" y1="1120" y2="1120" x1="1920" />
        <branch name="O(6)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1760" y="1120" type="branch" />
            <wire x2="1760" y1="1120" y2="1120" x1="1664" />
            <wire x2="1824" y1="1120" y2="1120" x1="1760" />
        </branch>
        <bustap x2="1824" y1="1040" y2="1040" x1="1920" />
        <branch name="O(5)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1760" y="1040" type="branch" />
            <wire x2="1760" y1="1040" y2="1040" x1="1664" />
            <wire x2="1824" y1="1040" y2="1040" x1="1760" />
        </branch>
        <bustap x2="1824" y1="960" y2="960" x1="1920" />
        <branch name="O(4)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1760" y="960" type="branch" />
            <wire x2="1760" y1="960" y2="960" x1="1664" />
            <wire x2="1824" y1="960" y2="960" x1="1760" />
        </branch>
        <bustap x2="1824" y1="880" y2="880" x1="1920" />
        <branch name="O(3)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1760" y="880" type="branch" />
            <wire x2="1760" y1="880" y2="880" x1="1664" />
            <wire x2="1824" y1="880" y2="880" x1="1760" />
        </branch>
        <bustap x2="1824" y1="800" y2="800" x1="1920" />
        <branch name="O(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1760" y="800" type="branch" />
            <wire x2="1760" y1="800" y2="800" x1="1664" />
            <wire x2="1824" y1="800" y2="800" x1="1760" />
        </branch>
        <bustap x2="1824" y1="720" y2="720" x1="1920" />
        <branch name="O(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1760" y="720" type="branch" />
            <wire x2="1760" y1="720" y2="720" x1="1664" />
            <wire x2="1824" y1="720" y2="720" x1="1760" />
        </branch>
        <bustap x2="1824" y1="640" y2="640" x1="1920" />
        <branch name="O(0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1760" y="640" type="branch" />
            <wire x2="1760" y1="640" y2="640" x1="1664" />
            <wire x2="1824" y1="640" y2="640" x1="1760" />
        </branch>
    </sheet>
</drawing>
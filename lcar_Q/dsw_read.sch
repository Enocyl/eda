<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="aspartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="CLK" />
        <signal name="DSW_TP" />
        <signal name="C_DONE" />
        <signal name="C_DONE_DLY" />
        <port polarity="Input" name="CLK" />
        <port polarity="Output" name="DSW_TP" />
        <port polarity="Input" name="C_DONE" />
        <port polarity="Output" name="C_DONE_DLY" />
        <blockdef name="dsw_rd">
            <timestamp>2021-12-6T1:58:50</timestamp>
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <line x2="384" y1="-16" y2="-16" x1="320" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <rect width="256" x="64" y="-192" height="256" />
        </blockdef>
        <block symbolname="dsw_rd" name="dsw_rd_0">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="C_DONE" name="c_done" />
            <blockpin signalname="DSW_TP" name="dsw_tp" />
            <blockpin signalname="C_DONE_DLY" name="c_done_dly" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3801" height="2688">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <instance x="880" y="640" name="dsw_rd_0" orien="R0">
        </instance>
        <branch name="CLK">
            <wire x2="880" y1="576" y2="576" x1="480" />
        </branch>
        <text style="fontsize:32;fontname:Arial" x="200" y="572">CLK</text>
        <iomarker fontsize="28" x="480" y="576" name="CLK" orien="R180" />
        <branch name="DSW_TP">
            <wire x2="1376" y1="624" y2="624" x1="1264" />
            <wire x2="1376" y1="624" y2="1280" x1="1376" />
            <wire x2="2160" y1="1280" y2="1280" x1="1376" />
        </branch>
        <text style="fontsize:32;fontname:Arial" x="2400" y="1280">DSW_TP</text>
        <iomarker fontsize="28" x="2160" y="1280" name="DSW_TP" orien="R0" />
        <branch name="C_DONE">
            <wire x2="880" y1="672" y2="672" x1="480" />
        </branch>
        <iomarker fontsize="28" x="480" y="672" name="C_DONE" orien="R180" />
        <text style="fontsize:32;fontname:Arial" x="132" y="672">C_DONE</text>
        <branch name="C_DONE_DLY">
            <wire x2="1312" y1="672" y2="672" x1="1264" />
            <wire x2="1312" y1="672" y2="1440" x1="1312" />
            <wire x2="2160" y1="1440" y2="1440" x1="1312" />
        </branch>
        <iomarker fontsize="28" x="2160" y="1440" name="C_DONE_DLY" orien="R0" />
        <text style="fontsize:32;fontname:Arial" x="2416" y="1440">C_DONE_DLY</text>
        <text style="fontsize:40;fontname:Arial" x="3316" y="2520">dsw_read</text>
    </sheet>
</drawing>
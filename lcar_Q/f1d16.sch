<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="Spartan2E" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="D(15:0)" />
        <signal name="Q(15:0)" />
        <signal name="CK" />
        <signal name="XLXN_16" />
        <signal name="XLXN_19" />
        <port polarity="Input" name="D(15:0)" />
        <port polarity="Output" name="Q(15:0)" />
        <port polarity="Input" name="CK" />
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
        <blockdef name="fd16ce">
            <timestamp>2001-2-2T12:52:25</timestamp>
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <rect width="64" x="320" y="-268" height="24" />
            <rect width="64" x="0" y="-268" height="24" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <rect width="256" x="64" y="-320" height="256" />
        </blockdef>
        <block symbolname="fd16ce" name="XLXI_11">
            <blockpin signalname="CK" name="C" />
            <blockpin signalname="XLXN_19" name="CE" />
            <blockpin signalname="XLXN_16" name="CLR" />
            <blockpin signalname="D(15:0)" name="D(15:0)" />
            <blockpin signalname="Q(15:0)" name="Q(15:0)" />
        </block>
        <block symbolname="gnd" name="XLXI_12">
            <blockpin signalname="XLXN_16" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_13">
            <blockpin signalname="XLXN_19" name="P" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <instance x="3136" y="1888" name="XLXI_11" orien="R0" />
        <branch name="D(15:0)">
            <wire x2="3136" y1="1632" y2="1632" x1="2864" />
        </branch>
        <branch name="Q(15:0)">
            <wire x2="3728" y1="1632" y2="1632" x1="3520" />
        </branch>
        <branch name="CK">
            <wire x2="3136" y1="1760" y2="1760" x1="2976" />
        </branch>
        <iomarker fontsize="28" x="3728" y="1632" name="Q(15:0)" orien="R0" />
        <iomarker fontsize="28" x="2864" y="1632" name="D(15:0)" orien="R180" />
        <iomarker fontsize="28" x="2976" y="1760" name="CK" orien="R180" />
        <instance x="2960" y="1520" name="XLXI_13" orien="R0" />
        <branch name="XLXN_16">
            <wire x2="3040" y1="1856" y2="1952" x1="3040" />
            <wire x2="3136" y1="1856" y2="1856" x1="3040" />
        </branch>
        <instance x="2976" y="2080" name="XLXI_12" orien="R0" />
        <branch name="XLXN_19">
            <wire x2="3024" y1="1520" y2="1696" x1="3024" />
            <wire x2="3136" y1="1696" y2="1696" x1="3024" />
        </branch>
    </sheet>
</drawing>
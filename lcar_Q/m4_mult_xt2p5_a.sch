<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="CF0D(12:0)" />
        <signal name="CLK" />
        <signal name="L,L,L,L,L,CF0D(12:0)" />
        <signal name="CF1D(12),CF1D(12),CF1D(12),CF1D(12),CF1D(12),CF1D(12:0)" />
        <signal name="CF2D(12),CF2D(12),CF2D(12),CF2D(12),CF2D(12),CF2D(12:0)" />
        <signal name="L,L,RIN(15:0)" />
        <signal name="CF3D(12),CF3D(12),CF3D(12),CF3D(12),CF3D(12),CF3D(12:0)" />
        <signal name="L,L,L,L,L,CF4D(12:0)" />
        <signal name="CF4D(12:0)" />
        <signal name="CF5D(12),CF5D(12),CF5D(12),CF5D(12),CF5D(12),CF5D(12:0)" />
        <signal name="L,L,GIN(15:0)" />
        <signal name="RIN(15:0)" />
        <signal name="GIN(15:0)" />
        <signal name="CF6D(12),CF6D(12),CF6D(12),CF6D(12),CF6D(12),CF6D(12:0)" />
        <signal name="CF7D(12),CF7D(12),CF7D(12),CF7D(12),CF7D(12),CF7D(12:0)" />
        <signal name="L,L,L,L,L,CF8D(12:0)" />
        <signal name="CF8D(12:0)" />
        <signal name="BIN(15:0)" />
        <signal name="M4_ON" />
        <signal name="L" />
        <signal name="L,L,BIN(15:0)" />
        <signal name="CF1D(12:0)" />
        <signal name="CF2D(12:0)" />
        <signal name="CF3D(12:0)" />
        <signal name="CF5D(12:0)" />
        <signal name="CF6D(12:0)" />
        <signal name="CF7D(12:0)" />
        <signal name="RG(30:0)" />
        <signal name="RB(30:0)" />
        <signal name="GR(30:0)" />
        <signal name="GG(30:0)" />
        <signal name="GB(30:0)" />
        <signal name="BG(30:0)" />
        <signal name="BB(30:0)" />
        <signal name="RR(30:0)" />
        <signal name="ROUT(15:0)" />
        <signal name="GOUT(15:0)" />
        <signal name="BOUT(15:0)" />
        <signal name="BR(30:0)" />
        <signal name="RR(35:0)" />
        <signal name="RG(35:0)" />
        <signal name="RB(35:0)" />
        <signal name="GR(35:0)" />
        <signal name="GG(35:0)" />
        <signal name="GB(35:0)" />
        <signal name="BR(35:0)" />
        <signal name="BG(35:0)" />
        <signal name="BB(35:0)" />
        <signal name="XLXN_1" />
        <signal name="OVP" />
        <port polarity="Input" name="CF0D(12:0)" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="CF4D(12:0)" />
        <port polarity="Input" name="RIN(15:0)" />
        <port polarity="Input" name="GIN(15:0)" />
        <port polarity="Input" name="CF8D(12:0)" />
        <port polarity="Input" name="BIN(15:0)" />
        <port polarity="Input" name="M4_ON" />
        <port polarity="Input" name="CF1D(12:0)" />
        <port polarity="Input" name="CF2D(12:0)" />
        <port polarity="Input" name="CF3D(12:0)" />
        <port polarity="Input" name="CF5D(12:0)" />
        <port polarity="Input" name="CF6D(12:0)" />
        <port polarity="Input" name="CF7D(12:0)" />
        <port polarity="Output" name="ROUT(15:0)" />
        <port polarity="Output" name="GOUT(15:0)" />
        <port polarity="Output" name="BOUT(15:0)" />
        <port polarity="Output" name="BR(35:0)" />
        <port polarity="Input" name="OVP" />
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="signed_mult_18x18">
            <timestamp>2011-11-5T2:48:49</timestamp>
            <rect width="192" x="64" y="-192" height="160" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-124" height="24" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
            <rect width="64" x="256" y="-172" height="24" />
            <line x2="320" y1="-160" y2="-160" x1="256" />
        </blockdef>
        <blockdef name="m4_postmult_xt2p5_a">
            <timestamp>2015-5-16T5:15:19</timestamp>
            <rect width="64" x="320" y="-876" height="24" />
            <line x2="384" y1="-864" y2="-864" x1="320" />
            <rect width="64" x="0" y="-876" height="24" />
            <line x2="0" y1="-864" y2="-864" x1="64" />
            <rect width="64" x="0" y="-828" height="24" />
            <line x2="0" y1="-816" y2="-816" x1="64" />
            <rect width="64" x="0" y="-780" height="24" />
            <line x2="0" y1="-768" y2="-768" x1="64" />
            <rect width="64" x="0" y="-684" height="24" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <rect width="64" x="0" y="-636" height="24" />
            <line x2="0" y1="-624" y2="-624" x1="64" />
            <rect width="64" x="0" y="-588" height="24" />
            <line x2="0" y1="-576" y2="-576" x1="64" />
            <rect width="64" x="0" y="-540" height="24" />
            <line x2="0" y1="-528" y2="-528" x1="64" />
            <rect width="64" x="0" y="-492" height="24" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <rect width="64" x="0" y="-444" height="24" />
            <line x2="0" y1="-432" y2="-432" x1="64" />
            <rect width="64" x="0" y="-396" height="24" />
            <line x2="0" y1="-384" y2="-384" x1="64" />
            <rect width="64" x="0" y="-348" height="24" />
            <line x2="0" y1="-336" y2="-336" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="320" y="-828" height="24" />
            <line x2="384" y1="-816" y2="-816" x1="320" />
            <rect width="64" x="320" y="-780" height="24" />
            <line x2="384" y1="-768" y2="-768" x1="320" />
            <rect width="256" x="64" y="-896" height="880" />
            <rect width="64" x="0" y="-252" height="24" />
            <line x2="0" y1="-240" y2="-240" x1="64" />
            <rect width="64" x="0" y="-204" height="24" />
            <line x2="0" y1="-192" y2="-192" x1="64" />
            <rect width="64" x="0" y="-156" height="24" />
            <line x2="0" y1="-144" y2="-144" x1="64" />
            <line x2="0" y1="-48" y2="-48" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="fd1e">
            <timestamp>2010-5-9T2:6:53</timestamp>
            <rect width="80" x="64" y="-128" height="128" />
            <line x2="0" y1="-16" y2="-16" x1="64" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
            <line x2="208" y1="-112" y2="-112" x1="144" />
        </blockdef>
        <block symbolname="gnd" name="XLXI_15">
            <blockpin signalname="L" name="G" />
        </block>
        <block symbolname="signed_mult_18x18" name="XLXI_39">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="L,L,RIN(15:0)" name="a(17:0)" />
            <blockpin signalname="L,L,L,L,L,CF0D(12:0)" name="b(17:0)" />
            <blockpin signalname="RR(35:0)" name="p(35:0)" />
        </block>
        <block symbolname="signed_mult_18x18" name="XLXI_42">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="L,L,RIN(15:0)" name="a(17:0)" />
            <blockpin signalname="CF1D(12),CF1D(12),CF1D(12),CF1D(12),CF1D(12),CF1D(12:0)" name="b(17:0)" />
            <blockpin signalname="RG(35:0)" name="p(35:0)" />
        </block>
        <block symbolname="signed_mult_18x18" name="XLXI_43">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="L,L,RIN(15:0)" name="a(17:0)" />
            <blockpin signalname="CF2D(12),CF2D(12),CF2D(12),CF2D(12),CF2D(12),CF2D(12:0)" name="b(17:0)" />
            <blockpin signalname="RB(35:0)" name="p(35:0)" />
        </block>
        <block symbolname="signed_mult_18x18" name="XLXI_44">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="L,L,GIN(15:0)" name="a(17:0)" />
            <blockpin signalname="CF3D(12),CF3D(12),CF3D(12),CF3D(12),CF3D(12),CF3D(12:0)" name="b(17:0)" />
            <blockpin signalname="GR(35:0)" name="p(35:0)" />
        </block>
        <block symbolname="signed_mult_18x18" name="XLXI_45">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="L,L,GIN(15:0)" name="a(17:0)" />
            <blockpin signalname="L,L,L,L,L,CF4D(12:0)" name="b(17:0)" />
            <blockpin signalname="GG(35:0)" name="p(35:0)" />
        </block>
        <block symbolname="signed_mult_18x18" name="XLXI_46">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="L,L,GIN(15:0)" name="a(17:0)" />
            <blockpin signalname="CF5D(12),CF5D(12),CF5D(12),CF5D(12),CF5D(12),CF5D(12:0)" name="b(17:0)" />
            <blockpin signalname="GB(35:0)" name="p(35:0)" />
        </block>
        <block symbolname="signed_mult_18x18" name="XLXI_47">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="L,L,BIN(15:0)" name="a(17:0)" />
            <blockpin signalname="CF6D(12),CF6D(12),CF6D(12),CF6D(12),CF6D(12),CF6D(12:0)" name="b(17:0)" />
            <blockpin signalname="BR(35:0)" name="p(35:0)" />
        </block>
        <block symbolname="signed_mult_18x18" name="XLXI_48">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="L,L,BIN(15:0)" name="a(17:0)" />
            <blockpin signalname="CF7D(12),CF7D(12),CF7D(12),CF7D(12),CF7D(12),CF7D(12:0)" name="b(17:0)" />
            <blockpin signalname="BG(35:0)" name="p(35:0)" />
        </block>
        <block symbolname="signed_mult_18x18" name="XLXI_49">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="L,L,BIN(15:0)" name="a(17:0)" />
            <blockpin signalname="L,L,L,L,L,CF8D(12:0)" name="b(17:0)" />
            <blockpin signalname="BB(35:0)" name="p(35:0)" />
        </block>
        <block symbolname="m4_postmult_xt2p5_a" name="XLXI_50">
            <blockpin signalname="XLXN_1" name="m4_on" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="RIN(15:0)" name="rin(15:0)" />
            <blockpin signalname="GIN(15:0)" name="gin(15:0)" />
            <blockpin signalname="BIN(15:0)" name="bin(15:0)" />
            <blockpin signalname="RR(30:0)" name="rr(30:0)" />
            <blockpin signalname="RG(30:0)" name="rg(30:0)" />
            <blockpin signalname="RB(30:0)" name="rb(30:0)" />
            <blockpin signalname="GR(30:0)" name="gr(30:0)" />
            <blockpin signalname="GG(30:0)" name="gg(30:0)" />
            <blockpin signalname="GB(30:0)" name="gb(30:0)" />
            <blockpin signalname="BR(30:0)" name="br(30:0)" />
            <blockpin signalname="BG(30:0)" name="bg(30:0)" />
            <blockpin signalname="BB(30:0)" name="bb(30:0)" />
            <blockpin signalname="CF0D(12:0)" name="cf0d(12:0)" />
            <blockpin signalname="CF4D(12:0)" name="cf4d(12:0)" />
            <blockpin signalname="CF8D(12:0)" name="cf8d(12:0)" />
            <blockpin signalname="ROUT(15:0)" name="rout(15:0)" />
            <blockpin signalname="GOUT(15:0)" name="gout(15:0)" />
            <blockpin signalname="BOUT(15:0)" name="bout(15:0)" />
        </block>
        <block symbolname="fd1e" name="XLXI_51">
            <blockpin signalname="OVP" name="CE" />
            <blockpin signalname="CLK" name="CK" />
            <blockpin signalname="M4_ON" name="D" />
            <blockpin signalname="XLXN_1" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="1616" type="branch" />
            <wire x2="2160" y1="1616" y2="1616" x1="2112" />
        </branch>
        <branch name="L,L,L,L,L,CF0D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="1568" type="branch" />
            <wire x2="2160" y1="1568" y2="1568" x1="1920" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="1936" type="branch" />
            <wire x2="2160" y1="1936" y2="1936" x1="2112" />
        </branch>
        <branch name="CF1D(12),CF1D(12),CF1D(12),CF1D(12),CF1D(12),CF1D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="1888" type="branch" />
            <wire x2="2160" y1="1888" y2="1888" x1="1920" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="2256" type="branch" />
            <wire x2="2160" y1="2256" y2="2256" x1="2112" />
        </branch>
        <branch name="CF2D(12),CF2D(12),CF2D(12),CF2D(12),CF2D(12),CF2D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="2208" type="branch" />
            <wire x2="2160" y1="2208" y2="2208" x1="1920" />
        </branch>
        <branch name="L,L,RIN(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="1520" type="branch" />
            <wire x2="2000" y1="1520" y2="1520" x1="1920" />
            <wire x2="2160" y1="1520" y2="1520" x1="2000" />
            <wire x2="2000" y1="1520" y2="1840" x1="2000" />
            <wire x2="2160" y1="1840" y2="1840" x1="2000" />
            <wire x2="2000" y1="1840" y2="2160" x1="2000" />
            <wire x2="2160" y1="2160" y2="2160" x1="2000" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="2576" type="branch" />
            <wire x2="2160" y1="2576" y2="2576" x1="2112" />
        </branch>
        <branch name="CF3D(12),CF3D(12),CF3D(12),CF3D(12),CF3D(12),CF3D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="2528" type="branch" />
            <wire x2="2160" y1="2528" y2="2528" x1="1920" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="2896" type="branch" />
            <wire x2="2160" y1="2896" y2="2896" x1="2112" />
        </branch>
        <branch name="L,L,L,L,L,CF4D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="2848" type="branch" />
            <wire x2="2160" y1="2848" y2="2848" x1="1920" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="3216" type="branch" />
            <wire x2="2160" y1="3216" y2="3216" x1="2112" />
        </branch>
        <branch name="CF5D(12),CF5D(12),CF5D(12),CF5D(12),CF5D(12),CF5D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="3168" type="branch" />
            <wire x2="2160" y1="3168" y2="3168" x1="1920" />
        </branch>
        <branch name="L,L,GIN(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="2480" type="branch" />
            <wire x2="2000" y1="2480" y2="2480" x1="1920" />
            <wire x2="2160" y1="2480" y2="2480" x1="2000" />
            <wire x2="2000" y1="2480" y2="2800" x1="2000" />
            <wire x2="2160" y1="2800" y2="2800" x1="2000" />
            <wire x2="2000" y1="2800" y2="3120" x1="2000" />
            <wire x2="2160" y1="3120" y2="3120" x1="2000" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="3536" type="branch" />
            <wire x2="2160" y1="3536" y2="3536" x1="2112" />
        </branch>
        <branch name="CF6D(12),CF6D(12),CF6D(12),CF6D(12),CF6D(12),CF6D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="3488" type="branch" />
            <wire x2="2160" y1="3488" y2="3488" x1="1920" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="3856" type="branch" />
            <wire x2="2160" y1="3856" y2="3856" x1="2112" />
        </branch>
        <branch name="CF7D(12),CF7D(12),CF7D(12),CF7D(12),CF7D(12),CF7D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="3808" type="branch" />
            <wire x2="2160" y1="3808" y2="3808" x1="1920" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2112" y="4176" type="branch" />
            <wire x2="2160" y1="4176" y2="4176" x1="2112" />
        </branch>
        <branch name="L,L,L,L,L,CF8D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="4128" type="branch" />
            <wire x2="2160" y1="4128" y2="4128" x1="1920" />
        </branch>
        <branch name="L,L,BIN(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1920" y="3440" type="branch" />
            <wire x2="2000" y1="3440" y2="3440" x1="1920" />
            <wire x2="2160" y1="3440" y2="3440" x1="2000" />
            <wire x2="2000" y1="3440" y2="3760" x1="2000" />
            <wire x2="2160" y1="3760" y2="3760" x1="2000" />
            <wire x2="2000" y1="3760" y2="4080" x1="2000" />
            <wire x2="2160" y1="4080" y2="4080" x1="2000" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1048" y="4484">M4_ON</text>
        <branch name="L">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="1440" y="4752" type="branch" />
            <wire x2="1360" y1="4752" y2="4800" x1="1360" />
            <wire x2="1440" y1="4752" y2="4752" x1="1360" />
        </branch>
        <instance x="1296" y="4928" name="XLXI_15" orien="R0" />
        <iomarker fontsize="28" x="1360" y="4480" name="M4_ON" orien="R180" />
        <branch name="CF0D(12:0)">
            <wire x2="960" y1="1568" y2="1568" x1="880" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="456" y="1572">CF0D(12:0)</text>
        <branch name="CF1D(12:0)">
            <wire x2="960" y1="1888" y2="1888" x1="880" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="456" y="1892">CF1D(12:0)</text>
        <branch name="CF2D(12:0)">
            <wire x2="960" y1="2208" y2="2208" x1="880" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="456" y="2212">CF2D(12:0)</text>
        <branch name="CF3D(12:0)">
            <wire x2="960" y1="2528" y2="2528" x1="880" />
        </branch>
        <branch name="CF4D(12:0)">
            <wire x2="960" y1="2848" y2="2848" x1="880" />
        </branch>
        <branch name="CF5D(12:0)">
            <wire x2="960" y1="3168" y2="3168" x1="880" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="456" y="2532">CF3D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="456" y="2852">CF4D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="456" y="3172">CF5D(12:0)</text>
        <branch name="RIN(15:0)">
            <wire x2="960" y1="1520" y2="1520" x1="720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="316" y="1524">RIN(15:0)</text>
        <branch name="GIN(15:0)">
            <wire x2="960" y1="2480" y2="2480" x1="720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="316" y="2484">GIN(15:0)</text>
        <branch name="CF6D(12:0)">
            <wire x2="960" y1="3488" y2="3488" x1="880" />
        </branch>
        <branch name="CF7D(12:0)">
            <wire x2="960" y1="3808" y2="3808" x1="880" />
        </branch>
        <branch name="CF8D(12:0)">
            <wire x2="960" y1="4128" y2="4128" x1="880" />
        </branch>
        <branch name="BIN(15:0)">
            <wire x2="960" y1="3440" y2="3440" x1="720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="456" y="3492">CF6D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="456" y="3812">CF7D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="456" y="4132">CF8D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="316" y="3444">BIN(15:0)</text>
        <iomarker fontsize="28" x="880" y="1568" name="CF0D(12:0)" orien="R180" />
        <iomarker fontsize="28" x="880" y="1888" name="CF1D(12:0)" orien="R180" />
        <iomarker fontsize="28" x="880" y="2208" name="CF2D(12:0)" orien="R180" />
        <iomarker fontsize="28" x="880" y="2528" name="CF3D(12:0)" orien="R180" />
        <iomarker fontsize="28" x="880" y="2848" name="CF4D(12:0)" orien="R180" />
        <iomarker fontsize="28" x="880" y="3168" name="CF5D(12:0)" orien="R180" />
        <iomarker fontsize="28" x="720" y="1520" name="RIN(15:0)" orien="R180" />
        <iomarker fontsize="28" x="720" y="2480" name="GIN(15:0)" orien="R180" />
        <iomarker fontsize="28" x="880" y="3488" name="CF6D(12:0)" orien="R180" />
        <iomarker fontsize="28" x="880" y="3808" name="CF7D(12:0)" orien="R180" />
        <iomarker fontsize="28" x="880" y="4128" name="CF8D(12:0)" orien="R180" />
        <iomarker fontsize="28" x="720" y="3440" name="BIN(15:0)" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="1296" y="2148">CF2D(12),---,CF2D(12),CF2D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1296" y="1840">CF1D(12),---,CF1D(12),CF1D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1512" y="1620">L,L,L,L,L,CF0D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1680" y="1468">L,L,RIN(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1676" y="2432">L,L,GIN(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1312" y="2584">CF3D(12),---,CF3D(12),CF3D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1520" y="2800">L,L,L,L,L,CF4D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1300" y="3100">CF5D(12),---,CF5D(12),CF5D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1676" y="3392">L,L,BIN(15:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1304" y="3548">CF6D(12),---,CF6D(12),CF6D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1308" y="3756">CF7D(12),---,CF7D(12),CF7D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="1520" y="4076">L,L,L,L,L,CF8D(12:0)</text>
        <branch name="RG(30:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="1920" type="branch" />
            <wire x2="2880" y1="1920" y2="1920" x1="2816" />
            <wire x2="3040" y1="1920" y2="1920" x1="2880" />
            <wire x2="3040" y1="1648" y2="1920" x1="3040" />
            <wire x2="3840" y1="1648" y2="1648" x1="3040" />
        </branch>
        <branch name="RB(30:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="2240" type="branch" />
            <wire x2="2880" y1="2240" y2="2240" x1="2816" />
            <wire x2="3088" y1="2240" y2="2240" x1="2880" />
            <wire x2="3088" y1="1696" y2="2240" x1="3088" />
            <wire x2="3840" y1="1696" y2="1696" x1="3088" />
        </branch>
        <branch name="GR(30:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="2560" type="branch" />
            <wire x2="2880" y1="2560" y2="2560" x1="2816" />
            <wire x2="3136" y1="2560" y2="2560" x1="2880" />
            <wire x2="3136" y1="1744" y2="2560" x1="3136" />
            <wire x2="3840" y1="1744" y2="1744" x1="3136" />
        </branch>
        <branch name="GG(30:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="2880" type="branch" />
            <wire x2="2880" y1="2880" y2="2880" x1="2816" />
            <wire x2="3184" y1="2880" y2="2880" x1="2880" />
            <wire x2="3184" y1="1792" y2="2880" x1="3184" />
            <wire x2="3840" y1="1792" y2="1792" x1="3184" />
        </branch>
        <branch name="GB(30:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="3200" type="branch" />
            <wire x2="2880" y1="3200" y2="3200" x1="2816" />
            <wire x2="3232" y1="3200" y2="3200" x1="2880" />
            <wire x2="3232" y1="1840" y2="3200" x1="3232" />
            <wire x2="3840" y1="1840" y2="1840" x1="3232" />
        </branch>
        <branch name="BG(30:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="3840" type="branch" />
            <wire x2="2880" y1="3840" y2="3840" x1="2816" />
            <wire x2="3328" y1="3840" y2="3840" x1="2880" />
            <wire x2="3328" y1="1936" y2="3840" x1="3328" />
            <wire x2="3840" y1="1936" y2="1936" x1="3328" />
        </branch>
        <branch name="BB(30:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="4160" type="branch" />
            <wire x2="2880" y1="4160" y2="4160" x1="2816" />
            <wire x2="3376" y1="4160" y2="4160" x1="2880" />
            <wire x2="3376" y1="1984" y2="4160" x1="3376" />
            <wire x2="3840" y1="1984" y2="1984" x1="3376" />
        </branch>
        <branch name="RR(30:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="1600" type="branch" />
            <wire x2="2880" y1="1600" y2="1600" x1="2816" />
            <wire x2="3840" y1="1600" y2="1600" x1="2880" />
        </branch>
        <branch name="RIN(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3760" y="1408" type="branch" />
            <wire x2="3840" y1="1408" y2="1408" x1="3760" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3396" y="1408">RIN(15:0)</text>
        <branch name="GIN(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3760" y="1456" type="branch" />
            <wire x2="3840" y1="1456" y2="1456" x1="3760" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3396" y="1456">GIN(15:0)</text>
        <branch name="BIN(15:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3760" y="1504" type="branch" />
            <wire x2="3840" y1="1504" y2="1504" x1="3760" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3396" y="1504">BIN(15:0)</text>
        <branch name="ROUT(15:0)">
            <wire x2="4320" y1="1408" y2="1408" x1="4224" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4596" y="1408">ROUT(15:0)</text>
        <branch name="GOUT(15:0)">
            <wire x2="4320" y1="1456" y2="1456" x1="4224" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4596" y="1456">GOUT(15:0)</text>
        <branch name="BOUT(15:0)">
            <wire x2="4320" y1="1504" y2="1504" x1="4224" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4596" y="1504">BOUT(15:0)</text>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3792" y="2224" type="branch" />
            <wire x2="3840" y1="2224" y2="2224" x1="3792" />
        </branch>
        <branch name="CF0D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3776" y="2032" type="branch" />
            <wire x2="3840" y1="2032" y2="2032" x1="3776" />
        </branch>
        <branch name="CF4D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3776" y="2080" type="branch" />
            <wire x2="3840" y1="2080" y2="2080" x1="3776" />
        </branch>
        <branch name="CF8D(12:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3776" y="2128" type="branch" />
            <wire x2="3840" y1="2128" y2="2128" x1="3776" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3400" y="2036">CF0D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="3400" y="2084">CF4D(12:0)</text>
        <text style="fontsize:40;fontname:Arial" x="3400" y="2132">CF8D(12:0)</text>
        <iomarker fontsize="28" x="4320" y="1408" name="ROUT(15:0)" orien="R0" />
        <iomarker fontsize="28" x="4320" y="1456" name="GOUT(15:0)" orien="R0" />
        <iomarker fontsize="28" x="4320" y="1504" name="BOUT(15:0)" orien="R0" />
        <instance x="2160" y="1680" name="XLXI_39" orien="R0">
        </instance>
        <branch name="RR(35:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2640" y="1520" type="branch" />
            <wire x2="2640" y1="1520" y2="1520" x1="2480" />
            <wire x2="2720" y1="1520" y2="1520" x1="2640" />
            <wire x2="2720" y1="1520" y2="1600" x1="2720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2608" y="1460">RR(35:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2836" y="1532">RR(30:0)</text>
        <instance x="2160" y="2000" name="XLXI_42" orien="R0">
        </instance>
        <branch name="RG(35:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2640" y="1840" type="branch" />
            <wire x2="2640" y1="1840" y2="1840" x1="2480" />
            <wire x2="2720" y1="1840" y2="1840" x1="2640" />
            <wire x2="2720" y1="1840" y2="1920" x1="2720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2608" y="1780">RG(35:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2836" y="1852">RG(30:0)</text>
        <instance x="2160" y="2320" name="XLXI_43" orien="R0">
        </instance>
        <branch name="RB(35:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2640" y="2160" type="branch" />
            <wire x2="2640" y1="2160" y2="2160" x1="2480" />
            <wire x2="2720" y1="2160" y2="2160" x1="2640" />
            <wire x2="2720" y1="2160" y2="2240" x1="2720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2608" y="2100">RB(35:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2836" y="2172">RB(30:0)</text>
        <instance x="2160" y="2640" name="XLXI_44" orien="R0">
        </instance>
        <branch name="GR(35:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2640" y="2480" type="branch" />
            <wire x2="2640" y1="2480" y2="2480" x1="2480" />
            <wire x2="2720" y1="2480" y2="2480" x1="2640" />
            <wire x2="2720" y1="2480" y2="2560" x1="2720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2608" y="2420">GR(35:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2836" y="2492">GR(30:0)</text>
        <instance x="2160" y="2960" name="XLXI_45" orien="R0">
        </instance>
        <branch name="GG(35:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2640" y="2800" type="branch" />
            <wire x2="2640" y1="2800" y2="2800" x1="2480" />
            <wire x2="2720" y1="2800" y2="2800" x1="2640" />
            <wire x2="2720" y1="2800" y2="2880" x1="2720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2608" y="2740">GG(35:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2836" y="2812">GG(30:0)</text>
        <instance x="2160" y="3280" name="XLXI_46" orien="R0">
        </instance>
        <branch name="GB(35:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2640" y="3120" type="branch" />
            <wire x2="2640" y1="3120" y2="3120" x1="2480" />
            <wire x2="2720" y1="3120" y2="3120" x1="2640" />
            <wire x2="2720" y1="3120" y2="3200" x1="2720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2608" y="3060">GB(35:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2836" y="3132">GB(30:0)</text>
        <instance x="2160" y="3600" name="XLXI_47" orien="R0">
        </instance>
        <branch name="BR(35:0)">
            <wire x2="2720" y1="3440" y2="3440" x1="2480" />
            <wire x2="2720" y1="3440" y2="3520" x1="2720" />
            <wire x2="2864" y1="3440" y2="3440" x1="2720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2608" y="3380">BR(35:0)</text>
        <instance x="2160" y="3920" name="XLXI_48" orien="R0">
        </instance>
        <branch name="BG(35:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2640" y="3760" type="branch" />
            <wire x2="2640" y1="3760" y2="3760" x1="2480" />
            <wire x2="2720" y1="3760" y2="3760" x1="2640" />
            <wire x2="2720" y1="3760" y2="3840" x1="2720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2608" y="3700">BG(35:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2836" y="3772">BG(30:0)</text>
        <instance x="2160" y="4240" name="XLXI_49" orien="R0">
        </instance>
        <branch name="BB(35:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2640" y="4080" type="branch" />
            <wire x2="2640" y1="4080" y2="4080" x1="2480" />
            <wire x2="2720" y1="4080" y2="4080" x1="2640" />
            <wire x2="2720" y1="4080" y2="4160" x1="2720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2608" y="4020">BB(35:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2836" y="4092">BB(30:0)</text>
        <bustap x2="2816" y1="1600" y2="1600" x1="2720" />
        <bustap x2="2816" y1="1920" y2="1920" x1="2720" />
        <bustap x2="2816" y1="2240" y2="2240" x1="2720" />
        <bustap x2="2816" y1="2560" y2="2560" x1="2720" />
        <bustap x2="2816" y1="2880" y2="2880" x1="2720" />
        <bustap x2="2816" y1="3200" y2="3200" x1="2720" />
        <bustap x2="2816" y1="3520" y2="3520" x1="2720" />
        <bustap x2="2816" y1="3840" y2="3840" x1="2720" />
        <bustap x2="2816" y1="4160" y2="4160" x1="2720" />
        <iomarker fontsize="28" x="2864" y="3440" name="BR(35:0)" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="2840" y="3568">BR(30:0)</text>
        <text style="fontsize:40;fontname:Arial" x="2856" y="3380">for debug</text>
        <branch name="BR(30:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="3520" type="branch" />
            <wire x2="2880" y1="3520" y2="3520" x1="2816" />
            <wire x2="3280" y1="3520" y2="3520" x1="2880" />
            <wire x2="3280" y1="1888" y2="3520" x1="3280" />
            <wire x2="3840" y1="1888" y2="1888" x1="3280" />
        </branch>
        <text style="fontsize:64;fontname:Arial" x="6924" y="5196">m4_mult_xt2p5_a</text>
        <instance x="3840" y="2272" name="XLXI_50" orien="R0">
        </instance>
        <branch name="M4_ON">
            <wire x2="1520" y1="4480" y2="4480" x1="1360" />
        </branch>
        <instance x="1520" y="4592" name="XLXI_51" orien="R0">
        </instance>
        <branch name="XLXN_1">
            <wire x2="3680" y1="4480" y2="4480" x1="1728" />
            <wire x2="3840" y1="2176" y2="2176" x1="3680" />
            <wire x2="3680" y1="2176" y2="4480" x1="3680" />
        </branch>
        <branch name="OVP">
            <wire x2="1520" y1="4528" y2="4528" x1="1360" />
        </branch>
        <iomarker fontsize="28" x="1360" y="4528" name="OVP" orien="R180" />
        <branch name="CLK">
            <wire x2="1440" y1="4576" y2="4576" x1="1360" />
            <wire x2="1520" y1="4576" y2="4576" x1="1440" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1104" y="4580">CLK</text>
        <iomarker fontsize="28" x="1360" y="4576" name="CLK" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="1100" y="4532">OVP</text>
    </sheet>
</drawing>
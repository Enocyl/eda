<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="aspartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="XCLK_IN" />
        <signal name="CLK25M" />
        <signal name="XLXN_7" />
        <signal name="XLXN_8" />
        <signal name="XLXN_14" />
        <signal name="PA_CLK25M" />
        <signal name="XLXN_46" />
        <signal name="XLXN_47" />
        <signal name="C_DONE" />
        <signal name="CLK125MHZ" />
        <signal name="CLK31MHZ" />
        <signal name="XLXN_67" />
        <signal name="XLXN_69" />
        <signal name="VP" />
        <signal name="XLXN_74" />
        <signal name="CLK31M" />
        <signal name="CLK125M" />
        <signal name="MEM_CLKOA" />
        <signal name="XLXN_96" />
        <signal name="XLXN_97" />
        <signal name="XLXN_98" />
        <signal name="MEM_CLKO" />
        <signal name="MEM_CLKI" />
        <signal name="XLXN_93" />
        <signal name="XLXN_130" />
        <signal name="XLXN_131" />
        <signal name="DCM1_ST(7:0)" />
        <signal name="DCM1_ST(1)" />
        <signal name="XLXN_135" />
        <signal name="XLXN_139" />
        <signal name="XLXN_141" />
        <signal name="XLXN_151" />
        <signal name="DCM2_ST(7:0)" />
        <signal name="DCM2_ST(1)" />
        <signal name="XLXN_155" />
        <signal name="XLXN_159" />
        <signal name="XLXN_161" />
        <signal name="XLXN_162" />
        <signal name="CLK72MHZ" />
        <signal name="CLK72M" />
        <signal name="CLK20M" />
        <signal name="XLXN_214" />
        <port polarity="Input" name="XCLK_IN" />
        <port polarity="Output" name="CLK25M" />
        <port polarity="Output" name="PA_CLK25M" />
        <port polarity="Input" name="C_DONE" />
        <port polarity="Output" name="VP" />
        <port polarity="Output" name="CLK31M" />
        <port polarity="Output" name="CLK125M" />
        <port polarity="Output" name="MEM_CLKO" />
        <port polarity="Input" name="MEM_CLKI" />
        <port polarity="Output" name="CLK72M" />
        <blockdef name="ibufg">
            <timestamp>2009-3-20T10:10:10</timestamp>
            <line x2="64" y1="0" y2="-64" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
        </blockdef>
        <blockdef name="bufg">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="0" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="128" y1="0" y2="-32" x1="64" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
        </blockdef>
        <blockdef name="oddr2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="192" x="64" y="-304" height="484" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="64" y2="64" x1="64" />
            <line x2="0" y1="0" y2="0" x1="64" />
            <line x2="0" y1="-192" y2="-192" x1="64" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="320" y1="-192" y2="-192" x1="256" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="0" y1="128" y2="128" x1="64" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <blockdef name="pll_base">
            <timestamp>2005-6-1T10:10:10</timestamp>
            <rect width="256" x="64" y="-288" height="288" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="0" y1="-144" y2="-144" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-256" y2="-256" x1="320" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-192" y2="-192" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-128" y2="-128" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <line x2="384" y1="-64" y2="-64" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="or2b1">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="32" y1="-64" y2="-64" x1="0" />
            <circle r="12" cx="44" cy="-64" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
        </blockdef>
        <blockdef name="dcm_rst_mpc">
            <timestamp>2010-5-11T6:15:14</timestamp>
            <rect width="256" x="64" y="-384" height="304" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <line x2="0" y1="-304" y2="-304" x1="64" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="0" y1="-208" y2="-208" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
        </blockdef>
        <blockdef name="dcm_sp">
            <timestamp>2007-4-11T22:49:47</timestamp>
            <line x2="0" y1="-832" y2="-832" x1="64" />
            <rect width="256" x="64" y="-1024" height="960" />
            <line x2="320" y1="-960" y2="-960" x1="384" />
            <line x2="320" y1="-896" y2="-896" x1="384" />
            <line x2="320" y1="-832" y2="-832" x1="384" />
            <line x2="320" y1="-576" y2="-576" x1="384" />
            <line x2="320" y1="-768" y2="-768" x1="384" />
            <line x2="320" y1="-640" y2="-640" x1="384" />
            <line x2="320" y1="-704" y2="-704" x1="384" />
            <line x2="320" y1="-512" y2="-512" x1="384" />
            <line x2="320" y1="-448" y2="-448" x1="384" />
            <line x2="320" y1="-384" y2="-384" x1="384" />
            <line x2="64" y1="-960" y2="-960" x1="0" />
            <line x2="64" y1="-896" y2="-896" x1="0" />
            <line x2="64" y1="-384" y2="-384" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="320" y1="-128" y2="-128" x1="384" />
            <line x2="320" y1="-320" y2="-320" x1="384" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <rect width="64" x="320" y="-336" height="32" />
            <line x2="80" y1="-944" y2="-960" x1="64" />
            <line x2="64" y1="-960" y2="-976" x1="80" />
            <line x2="80" y1="-880" y2="-896" x1="64" />
            <line x2="64" y1="-896" y2="-912" x1="80" />
        </blockdef>
        <blockdef name="int_ovp_gen">
            <timestamp>2014-9-27T9:38:13</timestamp>
            <rect width="128" x="64" y="-128" height="112" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-48" y2="-48" x1="64" />
            <line x2="256" y1="-96" y2="-96" x1="192" />
        </blockdef>
        <block symbolname="ibufg" name="XLXI_1">
            <blockpin signalname="XCLK_IN" name="I" />
            <blockpin signalname="XLXN_1" name="O" />
        </block>
        <block symbolname="bufg" name="XLXI_2">
            <blockpin signalname="XLXN_1" name="I" />
            <blockpin signalname="CLK25M" name="O" />
        </block>
        <block symbolname="oddr2" name="XLXI_5">
            <blockpin signalname="XLXN_8" name="D0" />
            <blockpin signalname="XLXN_7" name="D1" />
            <blockpin signalname="CLK25M" name="C0" />
            <blockpin signalname="XLXN_14" name="C1" />
            <blockpin signalname="XLXN_8" name="CE" />
            <blockpin signalname="XLXN_7" name="R" />
            <blockpin signalname="PA_CLK25M" name="Q" />
            <blockpin signalname="XLXN_7" name="S" />
        </block>
        <block symbolname="gnd" name="XLXI_6">
            <blockpin signalname="XLXN_7" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_7">
            <blockpin signalname="XLXN_8" name="P" />
        </block>
        <block symbolname="inv" name="XLXI_11">
            <blockpin signalname="CLK25M" name="I" />
            <blockpin signalname="XLXN_14" name="O" />
        </block>
        <block symbolname="or2b1" name="XLXI_39">
            <blockpin signalname="C_DONE" name="I0" />
            <blockpin signalname="XLXN_74" name="I1" />
            <blockpin signalname="XLXN_46" name="O" />
        </block>
        <block symbolname="pll_base" name="PLL_CLK125M">
            <attr value="0.01" name="REF_JITTER">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Float 0 0.999" />
            </attr>
            <attr value="25" name="CLKOUT3_DIVIDE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 1 128" />
            </attr>
            <attr value="16" name="CLKOUT2_DIVIDE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 1 128" />
            </attr>
            <attr value="90" name="CLKOUT1_PHASE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Float 0 360" />
            </attr>
            <attr value="4" name="CLKOUT1_DIVIDE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 1 128" />
            </attr>
            <attr value="4" name="CLKOUT0_DIVIDE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 1 128" />
            </attr>
            <attr value="40" name="CLKIN_PERIOD">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Float 1 52.63" />
            </attr>
            <attr value="20" name="CLKFBOUT_MULT">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 1 74" />
            </attr>
            <blockpin signalname="CLK25M" name="CLKIN" />
            <blockpin signalname="XLXN_47" name="CLKFBIN" />
            <blockpin signalname="XLXN_46" name="RST" />
            <blockpin signalname="CLK125MHZ" name="CLKOUT0" />
            <blockpin name="CLKOUT1" />
            <blockpin signalname="CLK31MHZ" name="CLKOUT2" />
            <blockpin signalname="CLK20M" name="CLKOUT3" />
            <blockpin name="CLKOUT4" />
            <blockpin name="CLKOUT5" />
            <blockpin signalname="XLXN_47" name="CLKFBOUT" />
            <blockpin signalname="XLXN_67" name="LOCKED" />
        </block>
        <block symbolname="dcm_rst_mpc" name="XLXI_44">
            <blockpin signalname="XLXN_67" name="locked" />
            <blockpin signalname="XLXN_74" name="dcm_rst" />
            <blockpin signalname="XLXN_69" name="clkin_stop" />
            <blockpin signalname="XLXN_69" name="f59hz" />
            <blockpin signalname="C_DONE" name="c_done" />
            <blockpin signalname="VP" name="ovp" />
            <blockpin signalname="CLK25M" name="clk" />
        </block>
        <block symbolname="gnd" name="XLXI_49">
            <blockpin signalname="XLXN_69" name="G" />
        </block>
        <block symbolname="oddr2" name="XLXI_53">
            <blockpin signalname="XLXN_97" name="D0" />
            <blockpin signalname="XLXN_96" name="D1" />
            <blockpin signalname="MEM_CLKOA" name="C0" />
            <blockpin signalname="XLXN_98" name="C1" />
            <blockpin signalname="XLXN_97" name="CE" />
            <blockpin signalname="XLXN_96" name="R" />
            <blockpin signalname="MEM_CLKO" name="Q" />
            <blockpin signalname="XLXN_96" name="S" />
        </block>
        <block symbolname="inv" name="XLXI_54">
            <blockpin signalname="MEM_CLKOA" name="I" />
            <blockpin signalname="XLXN_98" name="O" />
        </block>
        <block symbolname="gnd" name="XLXI_55">
            <blockpin signalname="XLXN_96" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_56">
            <blockpin signalname="XLXN_97" name="P" />
        </block>
        <block symbolname="dcm_sp" name="DCM_SP_MEM_CLK">
            <attr value="8" name="CLKIN_PERIOD">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Float 0.0001 1000" />
            </attr>
            <blockpin signalname="XLXN_93" name="CLKFB" />
            <blockpin signalname="CLK125M" name="CLKIN" />
            <blockpin signalname="XLXN_130" name="DSSEN" />
            <blockpin signalname="XLXN_130" name="PSCLK" />
            <blockpin signalname="XLXN_130" name="PSEN" />
            <blockpin signalname="XLXN_130" name="PSINCDEC" />
            <blockpin signalname="XLXN_131" name="RST" />
            <blockpin signalname="MEM_CLKOA" name="CLK0" />
            <blockpin name="CLK180" />
            <blockpin name="CLK270" />
            <blockpin name="CLK2X" />
            <blockpin name="CLK2X180" />
            <blockpin name="CLK90" />
            <blockpin name="CLKDV" />
            <blockpin name="CLKFX" />
            <blockpin name="CLKFX180" />
            <blockpin signalname="XLXN_139" name="LOCKED" />
            <blockpin name="PSDONE" />
            <blockpin signalname="DCM1_ST(7:0)" name="STATUS(7:0)" />
        </block>
        <block symbolname="ibufg" name="XLXI_52">
            <blockpin signalname="MEM_CLKI" name="I" />
            <blockpin signalname="XLXN_93" name="O" />
        </block>
        <block symbolname="gnd" name="XLXI_75">
            <blockpin signalname="XLXN_130" name="G" />
        </block>
        <block symbolname="or2b1" name="XLXI_76">
            <blockpin signalname="C_DONE" name="I0" />
            <blockpin signalname="XLXN_141" name="I1" />
            <blockpin signalname="XLXN_131" name="O" />
        </block>
        <block symbolname="dcm_rst_mpc" name="XLXI_77">
            <blockpin signalname="XLXN_139" name="locked" />
            <blockpin signalname="XLXN_141" name="dcm_rst" />
            <blockpin signalname="DCM1_ST(1)" name="clkin_stop" />
            <blockpin signalname="XLXN_135" name="f59hz" />
            <blockpin signalname="C_DONE" name="c_done" />
            <blockpin signalname="VP" name="ovp" />
            <blockpin signalname="CLK25M" name="clk" />
        </block>
        <block symbolname="gnd" name="XLXI_78">
            <blockpin signalname="XLXN_135" name="G" />
        </block>
        <block symbolname="dcm_sp" name="DCM_SP_CLK72M">
            <attr value="50" name="CLKIN_PERIOD">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Float 0.0001 1000" />
            </attr>
            <attr value="NONE" name="CLK_FEEDBACK">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList 1X 2X NONE" />
            </attr>
            <attr value="18" name="CLKFX_MULTIPLY">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 1 32" />
            </attr>
            <attr value="5" name="CLKFX_DIVIDE">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 1 32" />
            </attr>
            <blockpin signalname="XLXN_162" name="CLKFB" />
            <blockpin signalname="CLK20M" name="CLKIN" />
            <blockpin signalname="XLXN_162" name="DSSEN" />
            <blockpin signalname="XLXN_162" name="PSCLK" />
            <blockpin signalname="XLXN_162" name="PSEN" />
            <blockpin signalname="XLXN_162" name="PSINCDEC" />
            <blockpin signalname="XLXN_151" name="RST" />
            <blockpin name="CLK0" />
            <blockpin name="CLK180" />
            <blockpin name="CLK270" />
            <blockpin name="CLK2X" />
            <blockpin name="CLK2X180" />
            <blockpin name="CLK90" />
            <blockpin name="CLKDV" />
            <blockpin signalname="CLK72MHZ" name="CLKFX" />
            <blockpin name="CLKFX180" />
            <blockpin signalname="XLXN_159" name="LOCKED" />
            <blockpin name="PSDONE" />
            <blockpin signalname="DCM2_ST(7:0)" name="STATUS(7:0)" />
        </block>
        <block symbolname="gnd" name="XLXI_85">
            <blockpin signalname="XLXN_162" name="G" />
        </block>
        <block symbolname="or2b1" name="XLXI_86">
            <blockpin signalname="C_DONE" name="I0" />
            <blockpin signalname="XLXN_161" name="I1" />
            <blockpin signalname="XLXN_151" name="O" />
        </block>
        <block symbolname="dcm_rst_mpc" name="XLXI_87">
            <blockpin signalname="XLXN_159" name="locked" />
            <blockpin signalname="XLXN_161" name="dcm_rst" />
            <blockpin signalname="DCM2_ST(1)" name="clkin_stop" />
            <blockpin signalname="XLXN_155" name="f59hz" />
            <blockpin signalname="C_DONE" name="c_done" />
            <blockpin signalname="VP" name="ovp" />
            <blockpin signalname="CLK25M" name="clk" />
        </block>
        <block symbolname="gnd" name="XLXI_88">
            <blockpin signalname="XLXN_155" name="G" />
        </block>
        <block symbolname="bufg" name="XLXI_89">
            <blockpin signalname="CLK72MHZ" name="I" />
            <blockpin signalname="CLK72M" name="O" />
        </block>
        <block symbolname="int_ovp_gen" name="XLXI_109">
            <blockpin signalname="XLXN_214" name="f50hz" />
            <blockpin signalname="CLK25M" name="clk" />
            <blockpin signalname="VP" name="vp" />
        </block>
        <block symbolname="gnd" name="XLXI_110">
            <blockpin signalname="XLXN_214" name="G" />
        </block>
        <block symbolname="bufg" name="XLXI_45">
            <blockpin signalname="CLK125MHZ" name="I" />
            <blockpin signalname="CLK125M" name="O" />
        </block>
        <block symbolname="bufg" name="XLXI_47">
            <blockpin signalname="CLK31MHZ" name="I" />
            <blockpin signalname="CLK31M" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="7044" y="5204">clk_gen</text>
        <branch name="XLXN_1">
            <wire x2="1200" y1="480" y2="480" x1="1104" />
        </branch>
        <instance x="880" y="512" name="XLXI_1" orien="R0" />
        <instance x="1200" y="512" name="XLXI_2" orien="R0" />
        <branch name="XCLK_IN">
            <wire x2="880" y1="480" y2="480" x1="800" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="412" y="480">XCLK_IN</text>
        <text style="fontsize:40;fontname:Arial" x="440" y="544">25MHz</text>
        <branch name="CLK25M">
            <wire x2="1520" y1="480" y2="480" x1="1424" />
            <wire x2="1680" y1="480" y2="480" x1="1520" />
            <wire x2="1520" y1="480" y2="928" x1="1520" />
            <wire x2="2000" y1="928" y2="928" x1="1520" />
            <wire x2="1520" y1="928" y2="992" x1="1520" />
            <wire x2="1584" y1="992" y2="992" x1="1520" />
            <wire x2="1520" y1="992" y2="1728" x1="1520" />
            <wire x2="1520" y1="1728" y2="1792" x1="1520" />
            <wire x2="1520" y1="1792" y2="2400" x1="1520" />
            <wire x2="2000" y1="2400" y2="2400" x1="1520" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1900" y="480">CLK25M</text>
        <instance x="2000" y="1056" name="XLXI_5" orien="R0" />
        <branch name="XLXN_7">
            <wire x2="2000" y1="864" y2="864" x1="1936" />
            <wire x2="1936" y1="864" y2="1120" x1="1936" />
            <wire x2="2000" y1="1120" y2="1120" x1="1936" />
            <wire x2="1936" y1="1120" y2="1184" x1="1936" />
            <wire x2="1936" y1="1184" y2="1232" x1="1936" />
            <wire x2="2000" y1="1184" y2="1184" x1="1936" />
        </branch>
        <branch name="XLXN_8">
            <wire x2="1872" y1="752" y2="800" x1="1872" />
            <wire x2="2000" y1="800" y2="800" x1="1872" />
            <wire x2="1872" y1="800" y2="1056" x1="1872" />
            <wire x2="2000" y1="1056" y2="1056" x1="1872" />
        </branch>
        <instance x="1584" y="1024" name="XLXI_11" orien="R0" />
        <branch name="XLXN_14">
            <wire x2="2000" y1="992" y2="992" x1="1808" />
        </branch>
        <branch name="PA_CLK25M">
            <wire x2="2400" y1="864" y2="864" x1="2320" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2636" y="864">PA_CLK25M</text>
        <iomarker fontsize="28" x="800" y="480" name="XCLK_IN" orien="R180" />
        <iomarker fontsize="28" x="1680" y="480" name="CLK25M" orien="R0" />
        <iomarker fontsize="28" x="2400" y="864" name="PA_CLK25M" orien="R0" />
        <instance x="1680" y="2720" name="XLXI_39" orien="R0" />
        <instance x="2000" y="2656" name="PLL_CLK125M" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="REF_JITTER" x="80" y="112" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DIVCLK_DIVIDE" x="80" y="144" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKOUT3_DIVIDE" x="80" y="336" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKOUT2_DIVIDE" x="80" y="304" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKOUT1_PHASE" x="80" y="272" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKOUT0_DIVIDE" x="80" y="208" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKIN_PERIOD" x="80" y="80" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKFBOUT_MULT" x="80" y="176" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial" attrname="InstName" x="80" y="28" type="instance" />
        </instance>
        <branch name="XLXN_46">
            <wire x2="2000" y1="2624" y2="2624" x1="1936" />
        </branch>
        <branch name="XLXN_47">
            <wire x2="1936" y1="2288" y2="2512" x1="1936" />
            <wire x2="2000" y1="2512" y2="2512" x1="1936" />
            <wire x2="2448" y1="2288" y2="2288" x1="1936" />
            <wire x2="2448" y1="2288" y2="2592" x1="2448" />
            <wire x2="2448" y1="2592" y2="2592" x1="2384" />
        </branch>
        <branch name="C_DONE">
            <wire x2="1680" y1="2656" y2="2656" x1="1360" />
        </branch>
        <iomarker fontsize="28" x="1360" y="2656" name="C_DONE" orien="R180" />
        <text style="fontsize:40;fontname:Arial" x="972" y="2656">C_DONE</text>
        <branch name="CLK125MHZ">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="2400" type="branch" />
            <wire x2="2880" y1="2400" y2="2400" x1="2384" />
            <wire x2="3056" y1="2400" y2="2400" x1="2880" />
        </branch>
        <branch name="CLK31MHZ">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2880" y="2560" type="branch" />
            <wire x2="2640" y1="2464" y2="2464" x1="2384" />
            <wire x2="2640" y1="2464" y2="2560" x1="2640" />
            <wire x2="2880" y1="2560" y2="2560" x1="2640" />
            <wire x2="3056" y1="2560" y2="2560" x1="2880" />
        </branch>
        <instance x="2800" y="3312" name="XLXI_44" orien="R0">
        </instance>
        <branch name="XLXN_67">
            <wire x2="2448" y1="2624" y2="2624" x1="2384" />
            <wire x2="2448" y1="2624" y2="2960" x1="2448" />
            <wire x2="2800" y1="2960" y2="2960" x1="2448" />
        </branch>
        <instance x="2672" y="3376" name="XLXI_49" orien="R0" />
        <instance x="1872" y="1360" name="XLXI_6" orien="R0" />
        <instance x="1808" y="752" name="XLXI_7" orien="R0" />
        <branch name="XLXN_69">
            <wire x2="2800" y1="3008" y2="3008" x1="2736" />
            <wire x2="2736" y1="3008" y2="3056" x1="2736" />
            <wire x2="2800" y1="3056" y2="3056" x1="2736" />
            <wire x2="2736" y1="3056" y2="3248" x1="2736" />
        </branch>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2672" y="3104" type="branch" />
            <wire x2="2800" y1="3104" y2="3104" x1="2672" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2332" y="3104">C_DONE</text>
        <branch name="VP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2672" y="3152" type="branch" />
            <wire x2="2800" y1="3152" y2="3152" x1="2672" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2332" y="3152">VP</text>
        <branch name="CLK25M">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2672" y="3200" type="branch" />
            <wire x2="2800" y1="3200" y2="3200" x1="2672" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2332" y="3200">CLK25M</text>
        <branch name="XLXN_74">
            <wire x2="1680" y1="2592" y2="2592" x1="1616" />
            <wire x2="1616" y1="2592" y2="3440" x1="1616" />
            <wire x2="3248" y1="3440" y2="3440" x1="1616" />
            <wire x2="3248" y1="2960" y2="2960" x1="3184" />
            <wire x2="3248" y1="2960" y2="3440" x1="3248" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3900" y="2640">CLK20M</text>
        <text style="fontsize:40;fontname:Arial" x="3900" y="2560">CLK31M</text>
        <branch name="CLK31M">
            <wire x2="3600" y1="2560" y2="2560" x1="3280" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="3900" y="2400">CLK125M</text>
        <iomarker fontsize="28" x="3600" y="2560" name="CLK31M" orien="R0" />
        <iomarker fontsize="28" x="3600" y="2400" name="CLK125M" orien="R0" />
        <branch name="MEM_CLKOA">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2512" y="4000" type="branch" />
            <wire x2="2512" y1="4000" y2="4000" x1="2384" />
            <wire x2="2640" y1="4000" y2="4000" x1="2512" />
            <wire x2="3120" y1="4000" y2="4000" x1="2640" />
            <wire x2="2640" y1="4000" y2="4064" x1="2640" />
            <wire x2="2704" y1="4064" y2="4064" x1="2640" />
        </branch>
        <branch name="XLXN_96">
            <wire x2="3120" y1="3936" y2="3936" x1="3056" />
            <wire x2="3056" y1="3936" y2="4192" x1="3056" />
            <wire x2="3120" y1="4192" y2="4192" x1="3056" />
            <wire x2="3056" y1="4192" y2="4256" x1="3056" />
            <wire x2="3056" y1="4256" y2="4304" x1="3056" />
            <wire x2="3120" y1="4256" y2="4256" x1="3056" />
        </branch>
        <branch name="XLXN_97">
            <wire x2="2992" y1="3824" y2="3872" x1="2992" />
            <wire x2="3120" y1="3872" y2="3872" x1="2992" />
            <wire x2="2992" y1="3872" y2="4128" x1="2992" />
            <wire x2="3120" y1="4128" y2="4128" x1="2992" />
        </branch>
        <branch name="XLXN_98">
            <wire x2="3120" y1="4064" y2="4064" x1="2928" />
        </branch>
        <branch name="MEM_CLKO">
            <wire x2="3520" y1="3936" y2="3936" x1="3440" />
        </branch>
        <instance x="3120" y="4128" name="XLXI_53" orien="R0" />
        <instance x="2704" y="4096" name="XLXI_54" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="3756" y="3936">MEM_CLKO</text>
        <instance x="2992" y="4432" name="XLXI_55" orien="R0" />
        <instance x="2928" y="3824" name="XLXI_56" orien="R0" />
        <iomarker fontsize="28" x="3520" y="3936" name="MEM_CLKO" orien="R0" />
        <branch name="MEM_CLKI">
            <wire x2="1440" y1="4064" y2="4064" x1="1360" />
        </branch>
        <branch name="XLXN_93">
            <wire x2="2000" y1="4064" y2="4064" x1="1664" />
        </branch>
        <instance x="2000" y="4960" name="DCM_SP_MEM_CLK" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLK_FEEDBACK" x="64" y="48" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKIN_PERIOD" x="64" y="16" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial" attrname="InstName" x="64" y="-36" type="instance" />
        </instance>
        <instance x="1440" y="4096" name="XLXI_52" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="916" y="4068">MEM_CLKI</text>
        <iomarker fontsize="28" x="1360" y="4064" name="MEM_CLKI" orien="R180" />
        <branch name="CLK125M">
            <wire x2="3360" y1="3600" y2="3600" x1="1936" />
            <wire x2="1936" y1="3600" y2="4000" x1="1936" />
            <wire x2="2000" y1="4000" y2="4000" x1="1936" />
            <wire x2="3360" y1="2400" y2="2400" x1="3280" />
            <wire x2="3600" y1="2400" y2="2400" x1="3360" />
            <wire x2="3360" y1="2400" y2="3600" x1="3360" />
        </branch>
        <instance x="1872" y="5008" name="XLXI_75" orien="R0" />
        <branch name="XLXN_130">
            <wire x2="2000" y1="4128" y2="4128" x1="1936" />
            <wire x2="1936" y1="4128" y2="4704" x1="1936" />
            <wire x2="2000" y1="4704" y2="4704" x1="1936" />
            <wire x2="1936" y1="4704" y2="4768" x1="1936" />
            <wire x2="2000" y1="4768" y2="4768" x1="1936" />
            <wire x2="1936" y1="4768" y2="4832" x1="1936" />
            <wire x2="2000" y1="4832" y2="4832" x1="1936" />
            <wire x2="1936" y1="4832" y2="4880" x1="1936" />
        </branch>
        <instance x="1600" y="4672" name="XLXI_76" orien="R0" />
        <branch name="XLXN_131">
            <wire x2="2000" y1="4576" y2="4576" x1="1856" />
        </branch>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1456" y="4608" type="branch" />
            <wire x2="1600" y1="4608" y2="4608" x1="1456" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1108" y="4608">C_DONE</text>
        <branch name="DCM1_ST(7:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2512" y="4640" type="branch" />
            <wire x2="2512" y1="4640" y2="4640" x1="2384" />
            <wire x2="2640" y1="4640" y2="4640" x1="2512" />
            <wire x2="2640" y1="4640" y2="4704" x1="2640" />
        </branch>
        <bustap x2="2736" y1="4704" y2="4704" x1="2640" />
        <branch name="DCM1_ST(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2832" y="4704" type="branch" />
            <wire x2="2832" y1="4704" y2="4704" x1="2736" />
            <wire x2="3200" y1="4704" y2="4704" x1="2832" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2716" y="4636">CLKIN_STOP</text>
        <instance x="3200" y="5008" name="XLXI_77" orien="R0">
        </instance>
        <instance x="3072" y="5072" name="XLXI_78" orien="R0" />
        <branch name="XLXN_135">
            <wire x2="3200" y1="4752" y2="4752" x1="3136" />
            <wire x2="3136" y1="4752" y2="4944" x1="3136" />
        </branch>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3072" y="4800" type="branch" />
            <wire x2="3200" y1="4800" y2="4800" x1="3072" />
        </branch>
        <branch name="VP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3072" y="4848" type="branch" />
            <wire x2="3200" y1="4848" y2="4848" x1="3072" />
        </branch>
        <branch name="CLK25M">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="3072" y="4896" type="branch" />
            <wire x2="3200" y1="4896" y2="4896" x1="3072" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2732" y="4800">C_DONE</text>
        <text style="fontsize:40;fontname:Arial" x="2732" y="4848">VP</text>
        <text style="fontsize:40;fontname:Arial" x="2732" y="4896">CLK25M</text>
        <branch name="XLXN_139">
            <wire x2="3136" y1="4576" y2="4576" x1="2384" />
            <wire x2="3136" y1="4576" y2="4656" x1="3136" />
            <wire x2="3200" y1="4656" y2="4656" x1="3136" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2716" y="4540">LOCKED</text>
        <text style="fontsize:40;fontname:Arial" x="2524" y="2924">LOCKED</text>
        <branch name="XLXN_141">
            <wire x2="1600" y1="4544" y2="4544" x1="1536" />
            <wire x2="1536" y1="4544" y2="5120" x1="1536" />
            <wire x2="3648" y1="5120" y2="5120" x1="1536" />
            <wire x2="3648" y1="4656" y2="4656" x1="3584" />
            <wire x2="3648" y1="4656" y2="5120" x1="3648" />
        </branch>
        <branch name="XLXN_151">
            <wire x2="5280" y1="3296" y2="3296" x1="5136" />
        </branch>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4736" y="3328" type="branch" />
            <wire x2="4880" y1="3328" y2="3328" x1="4736" />
        </branch>
        <branch name="DCM2_ST(7:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="5792" y="3360" type="branch" />
            <wire x2="5792" y1="3360" y2="3360" x1="5664" />
            <wire x2="5920" y1="3360" y2="3360" x1="5792" />
            <wire x2="5920" y1="3360" y2="3424" x1="5920" />
        </branch>
        <branch name="DCM2_ST(1)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="6112" y="3424" type="branch" />
            <wire x2="6112" y1="3424" y2="3424" x1="6016" />
            <wire x2="6480" y1="3424" y2="3424" x1="6112" />
        </branch>
        <branch name="XLXN_155">
            <wire x2="6480" y1="3472" y2="3472" x1="6416" />
            <wire x2="6416" y1="3472" y2="3664" x1="6416" />
        </branch>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="6352" y="3520" type="branch" />
            <wire x2="6480" y1="3520" y2="3520" x1="6352" />
        </branch>
        <branch name="VP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="6352" y="3568" type="branch" />
            <wire x2="6480" y1="3568" y2="3568" x1="6352" />
        </branch>
        <branch name="CLK25M">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="6352" y="3616" type="branch" />
            <wire x2="6480" y1="3616" y2="3616" x1="6352" />
        </branch>
        <branch name="XLXN_159">
            <wire x2="6416" y1="3296" y2="3296" x1="5664" />
            <wire x2="6416" y1="3296" y2="3376" x1="6416" />
            <wire x2="6480" y1="3376" y2="3376" x1="6416" />
        </branch>
        <branch name="XLXN_161">
            <wire x2="4880" y1="3264" y2="3264" x1="4816" />
            <wire x2="4816" y1="3264" y2="3840" x1="4816" />
            <wire x2="6928" y1="3840" y2="3840" x1="4816" />
            <wire x2="6928" y1="3376" y2="3376" x1="6864" />
            <wire x2="6928" y1="3376" y2="3840" x1="6928" />
        </branch>
        <instance x="5280" y="3680" name="DCM_SP_CLK72M" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKIN_PERIOD" x="64" y="16" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKFX_MULTIPLY" x="64" y="92" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKFX_DIVIDE" x="64" y="60" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial" attrname="InstName" x="64" y="-40" type="instance" />
        </instance>
        <instance x="5152" y="3728" name="XLXI_85" orien="R0" />
        <instance x="4880" y="3392" name="XLXI_86" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="4388" y="3328">C_DONE</text>
        <text style="fontsize:40;fontname:Arial" x="5996" y="3356">CLKIN_STOP</text>
        <instance x="6480" y="3728" name="XLXI_87" orien="R0">
        </instance>
        <instance x="6352" y="3792" name="XLXI_88" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="6012" y="3520">C_DONE</text>
        <text style="fontsize:40;fontname:Arial" x="6012" y="3568">VP</text>
        <text style="fontsize:40;fontname:Arial" x="6012" y="3616">CLK25M</text>
        <text style="fontsize:40;fontname:Arial" x="5996" y="3260">LOCKED</text>
        <bustap x2="6016" y1="3424" y2="3424" x1="5920" />
        <branch name="XLXN_162">
            <wire x2="5280" y1="2784" y2="2784" x1="5216" />
            <wire x2="5216" y1="2784" y2="2848" x1="5216" />
            <wire x2="5280" y1="2848" y2="2848" x1="5216" />
            <wire x2="5216" y1="2848" y2="3424" x1="5216" />
            <wire x2="5280" y1="3424" y2="3424" x1="5216" />
            <wire x2="5216" y1="3424" y2="3488" x1="5216" />
            <wire x2="5280" y1="3488" y2="3488" x1="5216" />
            <wire x2="5216" y1="3488" y2="3552" x1="5216" />
            <wire x2="5280" y1="3552" y2="3552" x1="5216" />
            <wire x2="5216" y1="3552" y2="3600" x1="5216" />
        </branch>
        <branch name="CLK72MHZ">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="6080" y="3168" type="branch" />
            <wire x2="6080" y1="3168" y2="3168" x1="5664" />
            <wire x2="6560" y1="3168" y2="3168" x1="6080" />
        </branch>
        <instance x="6560" y="3200" name="XLXI_89" orien="R0" />
        <branch name="CLK72M">
            <wire x2="6960" y1="3168" y2="3168" x1="6784" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="7196" y="3168">CLK72M</text>
        <iomarker fontsize="28" x="6960" y="3168" name="CLK72M" orien="R0" />
        <branch name="CLK20M">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4000" y="2720" type="branch" />
            <wire x2="2576" y1="2496" y2="2496" x1="2384" />
            <wire x2="2576" y1="2496" y2="2720" x1="2576" />
            <wire x2="4000" y1="2720" y2="2720" x1="2576" />
            <wire x2="5280" y1="2720" y2="2720" x1="4000" />
        </branch>
        <instance x="4480" y="4736" name="XLXI_109" orien="R0">
        </instance>
        <instance x="4352" y="4864" name="XLXI_110" orien="R0" />
        <branch name="XLXN_214">
            <wire x2="4480" y1="4640" y2="4640" x1="4416" />
            <wire x2="4416" y1="4640" y2="4736" x1="4416" />
        </branch>
        <branch name="CLK25M">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4352" y="4688" type="branch" />
            <wire x2="4480" y1="4688" y2="4688" x1="4352" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4044" y="4688">CLK25M</text>
        <branch name="VP">
            <wire x2="4880" y1="4640" y2="4640" x1="4736" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4996" y="4644">VP</text>
        <iomarker fontsize="28" x="4880" y="4640" name="VP" orien="R0" />
        <instance x="3056" y="2432" name="XLXI_45" orien="R0" />
        <instance x="3056" y="2592" name="XLXI_47" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="6012" y="3088">CLK72MHZ</text>
        <text style="fontsize:40;fontname:Arial" x="2768" y="2288">CLK31MHZ</text>
        <text style="fontsize:40;fontname:Arial" x="2768" y="2228">CLK125MHZ_TXC</text>
        <text style="fontsize:40;fontname:Arial" x="2768" y="2176">CLK125MHZ</text>
        <text style="fontsize:40;fontname:Arial" x="2428" y="3920">MEM_CLKOA</text>
    </sheet>
</drawing>
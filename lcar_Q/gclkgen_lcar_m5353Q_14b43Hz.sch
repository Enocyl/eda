<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="aspartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_151" />
        <signal name="C_DONE" />
        <signal name="DCM60_ST(7:0)" />
        <signal name="DCM60_ST(2)" />
        <signal name="XLXN_155" />
        <signal name="OVP" />
        <signal name="CLK25M" />
        <signal name="XLXN_159" />
        <signal name="XGCLK60_DCM_RST" />
        <signal name="XLXN_162" />
        <signal name="CLK31M" />
        <signal name="F50HZ" />
        <signal name="BLANK" />
        <signal name="XGCLK" />
        <signal name="GCLK" />
        <signal name="GCLKOUT_START" />
        <signal name="M4_SET_DONE" />
        <signal name="XLXN_354" />
        <signal name="XLXN_355" />
        <signal name="XLXN_362" />
        <signal name="XLXN_367" />
        <signal name="XLXN_368" />
        <signal name="CLK125M_SSCG" />
        <signal name="CLK125M_SS" />
        <signal name="DCM_SS_ST(2:1)" />
        <signal name="DCM_SS_ST(2)" />
        <port polarity="Input" name="C_DONE" />
        <port polarity="Input" name="OVP" />
        <port polarity="Input" name="CLK25M" />
        <port polarity="Output" name="XGCLK60_DCM_RST" />
        <port polarity="Input" name="CLK31M" />
        <port polarity="Input" name="BLANK" />
        <port polarity="Output" name="XGCLK" />
        <port polarity="Output" name="GCLK" />
        <port polarity="Output" name="GCLKOUT_START" />
        <port polarity="Input" name="M4_SET_DONE" />
        <port polarity="Output" name="CLK125M_SS" />
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
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
        <blockdef name="dcm_clkgen">
            <timestamp>2010-7-30T0:36:20</timestamp>
            <rect width="304" x="64" y="-384" height="384" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="368" y="-364" height="24" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <line x2="432" y1="-160" y2="-160" x1="368" />
            <line x2="432" y1="-96" y2="-96" x1="368" />
            <line x2="432" y1="-32" y2="-32" x1="368" />
        </blockdef>
        <blockdef name="bufg">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="0" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="128" y1="0" y2="-32" x1="64" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
        </blockdef>
        <blockdef name="gclkout_lcar_m5353Q_14b43Hz">
            <timestamp>2021-11-1T9:1:30</timestamp>
            <line x2="416" y1="-320" y2="-320" x1="352" />
            <line x2="0" y1="-320" y2="-320" x1="64" />
            <line x2="0" y1="-272" y2="-272" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="-176" y2="-176" x1="64" />
            <line x2="416" y1="-128" y2="-128" x1="352" />
            <rect width="288" x="64" y="-352" height="352" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
        </blockdef>
        <block symbolname="dcm_sp" name="DCM_SP_XGCLK60">
            <attr value="8" name="CLKIN_PERIOD">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Float 0.0001 1000" />
            </attr>
            <attr value="NONE" name="CLK_FEEDBACK">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList 1X 2X NONE" />
            </attr>
            <attr value="4" name="CLKFX_MULTIPLY">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 1 32" />
            </attr>
            <attr value="10" name="CLKFX_DIVIDE">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 1 32" />
            </attr>
            <attr value="SYSTEM_SYNCHRONOUS" name="DESKEW_ADJUST">
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SYSTEM_SYNCHRONOUS SOURCE_SYNCHRONOUS 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15" />
            </attr>
            <blockpin signalname="XLXN_162" name="CLKFB" />
            <blockpin signalname="CLK125M_SS" name="CLKIN" />
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
            <blockpin signalname="XGCLK" name="CLKFX" />
            <blockpin name="CLKFX180" />
            <blockpin signalname="XLXN_159" name="LOCKED" />
            <blockpin name="PSDONE" />
            <blockpin signalname="DCM60_ST(7:0)" name="STATUS(7:0)" />
        </block>
        <block symbolname="gnd" name="XLXI_85">
            <blockpin signalname="XLXN_162" name="G" />
        </block>
        <block symbolname="or2b1" name="XLXI_86">
            <blockpin signalname="C_DONE" name="I0" />
            <blockpin signalname="XGCLK60_DCM_RST" name="I1" />
            <blockpin signalname="XLXN_151" name="O" />
        </block>
        <block symbolname="dcm_rst_mpc" name="XLXI_87">
            <blockpin signalname="XLXN_159" name="locked" />
            <blockpin signalname="XGCLK60_DCM_RST" name="dcm_rst" />
            <blockpin signalname="DCM60_ST(2)" name="clkin_stop" />
            <blockpin signalname="XLXN_155" name="f59hz" />
            <blockpin signalname="C_DONE" name="c_done" />
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="CLK25M" name="clk" />
        </block>
        <block symbolname="gnd" name="XLXI_88">
            <blockpin signalname="XLXN_155" name="G" />
        </block>
        <block symbolname="dcm_clkgen" name="DCM_CLK125M_SS">
            <attr value="CENTER_HIGH_SPREAD" name="SPREAD_SPECTRUM">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList NONE CENTER_HIGH_SPREAD CENTER_LOW_SPREAD VIDEO_LINK_M0 VIDEO_LINK_M1 VIDEO_LINK_M2" />
            </attr>
            <attr value="32.0" name="CLKIN_PERIOD">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Float 0.0001 1000" />
            </attr>
            <attr value="8" name="CLKFX_MULTIPLY">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="IntegerList 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256" />
            </attr>
            <attr value="4.000" name="CLKFX_MD_MAX">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 wa:1 wd:1" />
                <trait valuetype="Float 0 256" />
            </attr>
            <attr value="2" name="CLKFX_DIVIDE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="IntegerList 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256" />
            </attr>
            <blockpin signalname="CLK31M" name="CLKIN" />
            <blockpin signalname="XLXN_354" name="FREEZEDCM" />
            <blockpin signalname="XLXN_354" name="PROGCLK" />
            <blockpin signalname="XLXN_354" name="PROGDATA" />
            <blockpin signalname="XLXN_354" name="PROGEN" />
            <blockpin signalname="XLXN_355" name="RST" />
            <blockpin signalname="DCM_SS_ST(2:1)" name="STATUS(2:1)" />
            <blockpin signalname="CLK125M_SSCG" name="CLKFX" />
            <blockpin name="CLKFX180" />
            <blockpin name="CLKFXDV" />
            <blockpin signalname="XLXN_367" name="LOCKED" />
            <blockpin name="PROGDONE" />
        </block>
        <block symbolname="gnd" name="XLXI_169">
            <blockpin signalname="XLXN_354" name="G" />
        </block>
        <block symbolname="or2b1" name="XLXI_170">
            <blockpin signalname="C_DONE" name="I0" />
            <blockpin signalname="XLXN_368" name="I1" />
            <blockpin signalname="XLXN_355" name="O" />
        </block>
        <block symbolname="dcm_rst_mpc" name="XLXI_171">
            <blockpin signalname="XLXN_367" name="locked" />
            <blockpin signalname="XLXN_368" name="dcm_rst" />
            <blockpin signalname="DCM_SS_ST(2)" name="clkin_stop" />
            <blockpin signalname="XLXN_362" name="f59hz" />
            <blockpin signalname="C_DONE" name="c_done" />
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="CLK25M" name="clk" />
        </block>
        <block symbolname="gnd" name="XLXI_172">
            <blockpin signalname="XLXN_362" name="G" />
        </block>
        <block symbolname="bufg" name="XLXI_175">
            <blockpin signalname="CLK125M_SSCG" name="I" />
            <blockpin signalname="CLK125M_SS" name="O" />
        </block>
        <block symbolname="gclkout_lcar_m5353Q_14b43Hz" name="gclkout_0">
            <blockpin signalname="BLANK" name="blank" />
            <blockpin signalname="CLK25M" name="clk" />
            <blockpin signalname="C_DONE" name="c_done" />
            <blockpin signalname="F50HZ" name="f50hz" />
            <blockpin signalname="M4_SET_DONE" name="m4_set_done" />
            <blockpin signalname="OVP" name="ovp" />
            <blockpin signalname="XGCLK" name="xgclk" />
            <blockpin signalname="GCLK" name="gclk" />
            <blockpin signalname="GCLKOUT_START" name="gclkout_start" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <branch name="XLXN_151">
            <wire x2="1440" y1="2576" y2="2576" x1="1296" />
        </branch>
        <branch name="C_DONE">
            <wire x2="1040" y1="2608" y2="2608" x1="880" />
        </branch>
        <branch name="DCM60_ST(7:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1952" y="2640" type="branch" />
            <wire x2="1952" y1="2640" y2="2640" x1="1824" />
            <wire x2="2080" y1="2640" y2="2640" x1="1952" />
            <wire x2="2080" y1="2640" y2="2704" x1="2080" />
        </branch>
        <branch name="DCM60_ST(2)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2272" y="2704" type="branch" />
            <wire x2="2272" y1="2704" y2="2704" x1="2176" />
            <wire x2="2640" y1="2704" y2="2704" x1="2272" />
        </branch>
        <branch name="XLXN_155">
            <wire x2="2640" y1="2752" y2="2752" x1="2576" />
            <wire x2="2576" y1="2752" y2="2944" x1="2576" />
        </branch>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2512" y="2800" type="branch" />
            <wire x2="2640" y1="2800" y2="2800" x1="2512" />
        </branch>
        <branch name="OVP">
            <wire x2="2640" y1="2848" y2="2848" x1="2512" />
        </branch>
        <branch name="CLK25M">
            <wire x2="2640" y1="2896" y2="2896" x1="2512" />
        </branch>
        <branch name="XLXN_159">
            <wire x2="2576" y1="2576" y2="2576" x1="1824" />
            <wire x2="2576" y1="2576" y2="2656" x1="2576" />
            <wire x2="2640" y1="2656" y2="2656" x1="2576" />
        </branch>
        <branch name="XGCLK60_DCM_RST">
            <wire x2="1040" y1="2544" y2="2544" x1="976" />
            <wire x2="976" y1="2544" y2="3120" x1="976" />
            <wire x2="2640" y1="3120" y2="3120" x1="976" />
            <wire x2="3088" y1="3120" y2="3120" x1="2640" />
            <wire x2="2640" y1="3120" y2="3200" x1="2640" />
            <wire x2="2720" y1="3200" y2="3200" x1="2640" />
            <wire x2="3088" y1="2656" y2="2656" x1="3024" />
            <wire x2="3088" y1="2656" y2="3120" x1="3088" />
        </branch>
        <instance x="1440" y="2960" name="DCM_SP_XGCLK60" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKIN_PERIOD" x="64" y="16" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKFX_MULTIPLY" x="64" y="76" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKFX_DIVIDE" x="64" y="44" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial" attrname="InstName" x="64" y="-24" type="instance" />
        </instance>
        <instance x="1312" y="3008" name="XLXI_85" orien="R0" />
        <instance x="1040" y="2672" name="XLXI_86" orien="R0" />
        <instance x="2640" y="3008" name="XLXI_87" orien="R0">
        </instance>
        <instance x="2512" y="3072" name="XLXI_88" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="2172" y="2800">C_DONE</text>
        <text style="fontsize:40;fontname:Arial" x="2172" y="2848">OVP</text>
        <text style="fontsize:40;fontname:Arial" x="2172" y="2896">CLK25M</text>
        <text style="fontsize:40;fontname:Arial" x="2156" y="2540">LOCKED</text>
        <bustap x2="2176" y1="2704" y2="2704" x1="2080" />
        <branch name="XLXN_162">
            <wire x2="1440" y1="2064" y2="2064" x1="1376" />
            <wire x2="1376" y1="2064" y2="2128" x1="1376" />
            <wire x2="1440" y1="2128" y2="2128" x1="1376" />
            <wire x2="1376" y1="2128" y2="2704" x1="1376" />
            <wire x2="1440" y1="2704" y2="2704" x1="1376" />
            <wire x2="1376" y1="2704" y2="2768" x1="1376" />
            <wire x2="1440" y1="2768" y2="2768" x1="1376" />
            <wire x2="1376" y1="2768" y2="2832" x1="1376" />
            <wire x2="1440" y1="2832" y2="2832" x1="1376" />
            <wire x2="1376" y1="2832" y2="2880" x1="1376" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2172" y="2368">XGCLK60 (50MHz)</text>
        <text style="fontsize:40;fontname:Arial" x="3384" y="2632">F50HZ</text>
        <branch name="BLANK">
            <wire x2="4800" y1="2496" y2="2496" x1="4720" />
        </branch>
        <branch name="XGCLK">
            <wire x2="3984" y1="2448" y2="2448" x1="1824" />
            <wire x2="4080" y1="2448" y2="2448" x1="3984" />
            <wire x2="4800" y1="2448" y2="2448" x1="4080" />
            <wire x2="4080" y1="2240" y2="2448" x1="4080" />
            <wire x2="4160" y1="2240" y2="2240" x1="4080" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4324" y="2244">XGCLK</text>
        <branch name="GCLK">
            <wire x2="5360" y1="2448" y2="2448" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5680" y="2448">GCLK (12.5MHz / 8.681MHz)</text>
        <text style="fontsize:40;fontname:Arial" x="504" y="2612">C_DONE</text>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4720" y="2640" type="branch" />
            <wire x2="4800" y1="2640" y2="2640" x1="4720" />
        </branch>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4720" y="2688" type="branch" />
            <wire x2="4800" y1="2688" y2="2688" x1="4720" />
        </branch>
        <branch name="CLK25M">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4720" y="2736" type="branch" />
            <wire x2="4800" y1="2736" y2="2736" x1="4720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4296" y="2640">C_DONE</text>
        <text style="fontsize:40;fontname:Arial" x="4296" y="2688">OVP</text>
        <text style="fontsize:40;fontname:Arial" x="4296" y="2736">CLK25M</text>
        <branch name="GCLKOUT_START">
            <wire x2="5360" y1="2640" y2="2640" x1="5216" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="5680" y="2640">GCLKOUT_START</text>
        <branch name="M4_SET_DONE">
            <wire x2="4800" y1="2592" y2="2592" x1="4720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4164" y="2596">M4_SET_DONE</text>
        <iomarker fontsize="28" x="880" y="2608" name="C_DONE" orien="R180" />
        <iomarker fontsize="28" x="2512" y="2848" name="OVP" orien="R180" />
        <iomarker fontsize="28" x="2512" y="2896" name="CLK25M" orien="R180" />
        <iomarker fontsize="28" x="4160" y="2240" name="XGCLK" orien="R0" />
        <iomarker fontsize="28" x="5360" y="2448" name="GCLK" orien="R0" />
        <iomarker fontsize="28" x="4720" y="2496" name="BLANK" orien="R180" />
        <iomarker fontsize="28" x="5360" y="2640" name="GCLKOUT_START" orien="R0" />
        <iomarker fontsize="28" x="4720" y="2592" name="M4_SET_DONE" orien="R180" />
        <instance x="1440" y="1312" name="DCM_CLK125M_SS" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="SPREAD_SPECTRUM" x="0" y="80" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKIN_PERIOD" x="0" y="112" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKFX_MULTIPLY" x="0" y="176" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKFX_DIVIDE" x="0" y="144" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="CLKFX_MD_MAX" x="0" y="204" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial" attrname="InstName" x="0" y="44" type="instance" />
        </instance>
        <instance x="1296" y="1456" name="XLXI_169" orien="R0" />
        <branch name="XLXN_354">
            <wire x2="1440" y1="1024" y2="1024" x1="1360" />
            <wire x2="1360" y1="1024" y2="1088" x1="1360" />
            <wire x2="1440" y1="1088" y2="1088" x1="1360" />
            <wire x2="1360" y1="1088" y2="1152" x1="1360" />
            <wire x2="1440" y1="1152" y2="1152" x1="1360" />
            <wire x2="1360" y1="1152" y2="1216" x1="1360" />
            <wire x2="1440" y1="1216" y2="1216" x1="1360" />
            <wire x2="1360" y1="1216" y2="1328" x1="1360" />
        </branch>
        <branch name="XLXN_355">
            <wire x2="1440" y1="1280" y2="1280" x1="1296" />
        </branch>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="880" y="1312" type="branch" />
            <wire x2="1040" y1="1312" y2="1312" x1="880" />
        </branch>
        <instance x="1040" y="1376" name="XLXI_170" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="512" y="1312">C_DONE</text>
        <branch name="C_DONE">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2592" y="1360" type="branch" />
            <wire x2="2720" y1="1360" y2="1360" x1="2592" />
        </branch>
        <branch name="OVP">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2592" y="1408" type="branch" />
            <wire x2="2720" y1="1408" y2="1408" x1="2592" />
        </branch>
        <branch name="CLK25M">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2592" y="1456" type="branch" />
            <wire x2="2720" y1="1456" y2="1456" x1="2592" />
        </branch>
        <instance x="2720" y="1568" name="XLXI_171" orien="R0">
        </instance>
        <instance x="2592" y="1632" name="XLXI_172" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="2252" y="1360">C_DONE</text>
        <text style="fontsize:40;fontname:Arial" x="2252" y="1408">OVP</text>
        <text style="fontsize:40;fontname:Arial" x="2252" y="1456">CLK25M</text>
        <branch name="XLXN_367">
            <wire x2="2720" y1="1216" y2="1216" x1="1872" />
        </branch>
        <branch name="XLXN_368">
            <wire x2="1040" y1="1248" y2="1248" x1="976" />
            <wire x2="976" y1="1248" y2="1680" x1="976" />
            <wire x2="3200" y1="1680" y2="1680" x1="976" />
            <wire x2="3200" y1="1216" y2="1216" x1="3104" />
            <wire x2="3200" y1="1216" y2="1680" x1="3200" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="496" y="960">CLK31M</text>
        <branch name="CLK31M">
            <wire x2="1440" y1="960" y2="960" x1="880" />
        </branch>
        <iomarker fontsize="28" x="880" y="960" name="CLK31M" orien="R180" />
        <instance x="2320" y="1056" name="XLXI_175" orien="R0" />
        <branch name="CLK125M_SSCG">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2128" y="1024" type="branch" />
            <wire x2="2128" y1="1024" y2="1024" x1="1872" />
            <wire x2="2320" y1="1024" y2="1024" x1="2128" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1988" y="952">CLK125M_SSCG</text>
        <branch name="CLK125M_SS">
            <wire x2="400" y1="1760" y2="2000" x1="400" />
            <wire x2="1440" y1="2000" y2="2000" x1="400" />
            <wire x2="3280" y1="1760" y2="1760" x1="400" />
            <wire x2="3280" y1="1024" y2="1024" x1="2544" />
            <wire x2="3280" y1="1024" y2="1760" x1="3280" />
            <wire x2="3360" y1="1024" y2="1024" x1="3280" />
        </branch>
        <iomarker fontsize="28" x="3360" y="1024" name="CLK125M_SS" orien="R0" />
        <text style="fontsize:40;fontname:Arial" x="3624" y="1024">CLK125M_SS</text>
        <text style="fontsize:40;fontname:Arial" x="4160" y="2500">BLANK</text>
        <branch name="F50HZ">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4720" y="2544" type="branch" />
            <wire x2="4800" y1="2544" y2="2544" x1="4720" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="4296" y="2544">F50HZ</text>
        <text style="fontsize:40;fontname:Arial" x="496" y="1024">(31.25MHz = 125MHz / 4)</text>
        <text style="fontsize:40;fontname:Arial" x="2156" y="2604">DCM60_ST(2)</text>
        <text style="fontsize:40;fontname:Arial" x="2156" y="2648">(CLKFX_STOP)</text>
        <iomarker fontsize="28" x="2720" y="3200" name="XGCLK60_DCM_RST" orien="R0" />
        <branch name="DCM_SS_ST(2:1)">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="2000" y="880" type="branch" />
            <wire x2="1920" y1="960" y2="960" x1="1872" />
            <wire x2="1920" y1="880" y2="960" x1="1920" />
            <wire x2="2000" y1="880" y2="880" x1="1920" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2292" y="880">DCM_SS_ST(2:1)</text>
        <branch name="XLXN_362">
            <wire x2="2720" y1="1312" y2="1312" x1="2656" />
            <wire x2="2656" y1="1312" y2="1504" x1="2656" />
        </branch>
        <branch name="DCM_SS_ST(2)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2592" y="1264" type="branch" />
            <wire x2="2720" y1="1264" y2="1264" x1="2592" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="2020" y="1264">DCM_SS_ST(2)</text>
        <text style="fontsize:40;fontname:Arial" x="2016" y="1316">(CLKFX_STOP)</text>
        <text style="fontsize:64;fontname:Arial" x="6536" y="5188">gclkgen_pv2_m5051b_ss</text>
        <instance x="4800" y="2768" name="gclkout_0" orien="R0">
        </instance>
    </sheet>
</drawing>
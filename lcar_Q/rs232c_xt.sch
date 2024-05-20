<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="RXD" />
        <signal name="L,L" />
        <signal name="L" />
        <signal name="CMD_BAUD_RATE(1:0)" />
        <signal name="RST" />
        <signal name="CLK" />
        <signal name="H" />
        <signal name="XLXN_12(7:0)" />
        <signal name="XLXN_14(6:0)" />
        <signal name="XLXN_18" />
        <signal name="RAM_OPE_SEL(2:0)" />
        <signal name="RAM_CMD_AD(21:0)" />
        <signal name="RAM_CMD_STARTP" />
        <signal name="RAM_CMD_RD_WE" />
        <signal name="RAM_CMD_RD(7:0)" />
        <signal name="IM_OPE_SEL(3:0)" />
        <signal name="IM_CMD_AD(15:0)" />
        <signal name="IM_CMD_RD(7:0)" />
        <signal name="IM_CMD_RD_RSTW" />
        <signal name="IM_CMD_RD_WE" />
        <signal name="IM_CMD_STARTP" />
        <signal name="CMD_M4_ON" />
        <signal name="CMD_M4_BANK1" />
        <signal name="CMD_CT_RED(3:0)" />
        <signal name="CMD_CT_GREEN(3:0)" />
        <signal name="CMD_CT_BLUE(3:0)" />
        <signal name="CMD_GAMMA(2:0)" />
        <signal name="CMD_TEST_PAT(7:0)" />
        <signal name="CMD_REBOOT_N" />
        <signal name="CMD_BRIGHTNESS(6:0)" />
        <signal name="PIXEL1_DISP_ON" />
        <signal name="PIXEL4_DISP_ON" />
        <signal name="PIXEL1_DISP_MODE(23:0)" />
        <signal name="PIXEL_DISP_RGB_ON(2:0)" />
        <signal name="XLXN_80" />
        <signal name="XLXN_81(7:0)" />
        <signal name="XLXN_82" />
        <signal name="XLXN_83" />
        <signal name="XLXN_84" />
        <signal name="XLXN_85" />
        <signal name="XLXN_86(7:0)" />
        <signal name="XLXN_87(7:0)" />
        <signal name="XLXN_88(7:0)" />
        <signal name="XLXN_89(7:0)" />
        <signal name="XLXN_90(7:0)" />
        <signal name="XLXN_91(7:0)" />
        <signal name="XLXN_92(5:0)" />
        <signal name="XLXN_93(7:0)" />
        <signal name="XLXN_96" />
        <signal name="XLXN_98" />
        <signal name="XLXN_99" />
        <signal name="TX_DONE" />
        <signal name="COLOR_LOSS(2:0)" />
        <signal name="TESTP_LEVEL(7:0)" />
        <signal name="TESTP_RGB_EN(2:0)" />
        <signal name="RGB_OUT_ZERO(2:0)" />
        <signal name="RSP_RAM_RD_RSTW" />
        <signal name="RSP_RAM_RD_WE" />
        <signal name="RSP_RAM_RD(7:0)" />
        <signal name="RSP_IM_RD_RSTW" />
        <signal name="RSP_IM_RD_WE" />
        <signal name="RSP_IM_RD(7:0)" />
        <signal name="IM_BUSY" />
        <signal name="IM_ERR_DET" />
        <signal name="M4_ON" />
        <signal name="M4_BANK1" />
        <signal name="CT_RED(3:0)" />
        <signal name="CT_GREEN(3:0)" />
        <signal name="CT_BLUE(3:0)" />
        <signal name="GAMMA(2:0)" />
        <signal name="TEST_PAT(7:0)" />
        <signal name="FPGA_VER(7:0)" />
        <signal name="BRIGHTNESS(6:0)" />
        <signal name="DSW_LOSS_BRT100" />
        <signal name="MEM_COLOR_LOSS(2:0)" />
        <signal name="XLXN_95" />
        <signal name="XLXN_94" />
        <signal name="XLXN_132" />
        <signal name="XLXN_133(7:0)" />
        <signal name="XLXN_134" />
        <signal name="STARTN" />
        <signal name="XLXN_138" />
        <signal name="COEFF_OFFSET_WE" />
        <signal name="PANEL_CORRECT_STARTP" />
        <signal name="PANEL_CORRECT_IM" />
        <signal name="TP1" />
        <signal name="TP2" />
        <signal name="TP3" />
        <signal name="IM_COPY_CORRECT_BUSY" />
        <signal name="ONE_IM_TO_RAM_COPY" />
        <signal name="RX_IM_DOWNLOAD_ON" />
        <signal name="IM_DOWNLOAD_EXE_TIM" />
        <signal name="XLXN_141" />
        <signal name="XLXN_143" />
        <signal name="EMB_RSP_REQ" />
        <signal name="EMB_RSP_DATA(79:0)" />
        <signal name="XLXN_148(79:0)" />
        <signal name="EMB_TX_DATA(79:0)" />
        <signal name="EMB_TX_REQ" />
        <signal name="XLXN_163" />
        <signal name="XLXN_165" />
        <signal name="M5_TX_REQ" />
        <signal name="M5_TX_DATA(79:0)" />
        <signal name="M5_RSP_RAM_RE" />
        <signal name="M5_RSP_REQ" />
        <signal name="M5_RSP_DATA(79:0)" />
        <signal name="TXD" />
        <signal name="PANEL_CORRECT_ONE_IM" />
        <signal name="IM_VADRS(3:0)" />
        <signal name="IM_HADRS(3:0)" />
        <signal name="EXE_EN" />
        <signal name="OVPX" />
        <signal name="PANEL_SEL(3:0)" />
        <port polarity="Input" name="RXD" />
        <port polarity="Output" name="CMD_BAUD_RATE(1:0)" />
        <port polarity="Input" name="CLK" />
        <port polarity="Output" name="RAM_OPE_SEL(2:0)" />
        <port polarity="Output" name="RAM_CMD_AD(21:0)" />
        <port polarity="Output" name="RAM_CMD_STARTP" />
        <port polarity="Output" name="RAM_CMD_RD_WE" />
        <port polarity="Output" name="RAM_CMD_RD(7:0)" />
        <port polarity="Output" name="IM_OPE_SEL(3:0)" />
        <port polarity="Output" name="IM_CMD_AD(15:0)" />
        <port polarity="Output" name="IM_CMD_RD(7:0)" />
        <port polarity="Output" name="IM_CMD_RD_RSTW" />
        <port polarity="Output" name="IM_CMD_RD_WE" />
        <port polarity="Output" name="IM_CMD_STARTP" />
        <port polarity="Output" name="CMD_M4_ON" />
        <port polarity="Output" name="CMD_M4_BANK1" />
        <port polarity="Output" name="CMD_CT_RED(3:0)" />
        <port polarity="Output" name="CMD_CT_GREEN(3:0)" />
        <port polarity="Output" name="CMD_CT_BLUE(3:0)" />
        <port polarity="Output" name="CMD_GAMMA(2:0)" />
        <port polarity="Output" name="CMD_TEST_PAT(7:0)" />
        <port polarity="Output" name="CMD_REBOOT_N" />
        <port polarity="Output" name="CMD_BRIGHTNESS(6:0)" />
        <port polarity="Output" name="PIXEL1_DISP_ON" />
        <port polarity="Output" name="PIXEL4_DISP_ON" />
        <port polarity="Output" name="PIXEL1_DISP_MODE(23:0)" />
        <port polarity="Output" name="PIXEL_DISP_RGB_ON(2:0)" />
        <port polarity="Output" name="TX_DONE" />
        <port polarity="Output" name="COLOR_LOSS(2:0)" />
        <port polarity="Output" name="TESTP_LEVEL(7:0)" />
        <port polarity="Output" name="TESTP_RGB_EN(2:0)" />
        <port polarity="Output" name="RGB_OUT_ZERO(2:0)" />
        <port polarity="Input" name="RSP_RAM_RD_RSTW" />
        <port polarity="Input" name="RSP_RAM_RD_WE" />
        <port polarity="Input" name="RSP_RAM_RD(7:0)" />
        <port polarity="Input" name="RSP_IM_RD_RSTW" />
        <port polarity="Input" name="RSP_IM_RD_WE" />
        <port polarity="Input" name="RSP_IM_RD(7:0)" />
        <port polarity="Input" name="IM_BUSY" />
        <port polarity="Input" name="IM_ERR_DET" />
        <port polarity="Input" name="M4_ON" />
        <port polarity="Input" name="M4_BANK1" />
        <port polarity="Input" name="CT_RED(3:0)" />
        <port polarity="Input" name="CT_GREEN(3:0)" />
        <port polarity="Input" name="CT_BLUE(3:0)" />
        <port polarity="Input" name="GAMMA(2:0)" />
        <port polarity="Input" name="TEST_PAT(7:0)" />
        <port polarity="Input" name="FPGA_VER(7:0)" />
        <port polarity="Input" name="BRIGHTNESS(6:0)" />
        <port polarity="Input" name="DSW_LOSS_BRT100" />
        <port polarity="Input" name="MEM_COLOR_LOSS(2:0)" />
        <port polarity="Input" name="STARTN" />
        <port polarity="Output" name="COEFF_OFFSET_WE" />
        <port polarity="Output" name="PANEL_CORRECT_STARTP" />
        <port polarity="Output" name="PANEL_CORRECT_IM" />
        <port polarity="Output" name="TP1" />
        <port polarity="Output" name="TP2" />
        <port polarity="Output" name="TP3" />
        <port polarity="Input" name="IM_COPY_CORRECT_BUSY" />
        <port polarity="Output" name="ONE_IM_TO_RAM_COPY" />
        <port polarity="Input" name="RX_IM_DOWNLOAD_ON" />
        <port polarity="Output" name="IM_DOWNLOAD_EXE_TIM" />
        <port polarity="Input" name="EMB_RSP_REQ" />
        <port polarity="Input" name="EMB_RSP_DATA(79:0)" />
        <port polarity="Output" name="EMB_TX_DATA(79:0)" />
        <port polarity="Output" name="EMB_TX_REQ" />
        <port polarity="Output" name="M5_TX_REQ" />
        <port polarity="Output" name="M5_TX_DATA(79:0)" />
        <port polarity="Output" name="M5_RSP_RAM_RE" />
        <port polarity="Input" name="M5_RSP_REQ" />
        <port polarity="Input" name="M5_RSP_DATA(79:0)" />
        <port polarity="Output" name="TXD" />
        <port polarity="Output" name="PANEL_CORRECT_ONE_IM" />
        <port polarity="Output" name="IM_VADRS(3:0)" />
        <port polarity="Output" name="IM_HADRS(3:0)" />
        <port polarity="Input" name="EXE_EN" />
        <port polarity="Input" name="OVPX" />
        <port polarity="Input" name="PANEL_SEL(3:0)" />
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
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
        <blockdef name="fd1">
            <timestamp>2010-5-11T8:39:30</timestamp>
            <rect width="80" x="64" y="-112" height="112" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="208" y1="-80" y2="-80" x1="144" />
        </blockdef>
        <blockdef name="or2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
        </blockdef>
        <blockdef name="uart_if_impact_a">
            <timestamp>2014-3-14T8:33:19</timestamp>
            <line x2="0" y1="-240" y2="-240" x1="64" />
            <line x2="0" y1="-1248" y2="-1248" x1="64" />
            <rect width="64" x="0" y="-1212" height="24" />
            <line x2="0" y1="-1200" y2="-1200" x1="64" />
            <line x2="0" y1="-1152" y2="-1152" x1="64" />
            <line x2="0" y1="-1104" y2="-1104" x1="64" />
            <line x2="0" y1="-1056" y2="-1056" x1="64" />
            <line x2="512" y1="-1248" y2="-1248" x1="448" />
            <line x2="512" y1="-1200" y2="-1200" x1="448" />
            <rect width="64" x="448" y="-1164" height="24" />
            <line x2="512" y1="-1152" y2="-1152" x1="448" />
            <rect width="64" x="448" y="-1116" height="24" />
            <line x2="512" y1="-1104" y2="-1104" x1="448" />
            <rect width="64" x="448" y="-1068" height="24" />
            <line x2="512" y1="-1056" y2="-1056" x1="448" />
            <rect width="64" x="448" y="-1020" height="24" />
            <line x2="512" y1="-1008" y2="-1008" x1="448" />
            <rect width="64" x="448" y="-972" height="24" />
            <line x2="512" y1="-960" y2="-960" x1="448" />
            <rect width="64" x="448" y="-924" height="24" />
            <line x2="512" y1="-912" y2="-912" x1="448" />
            <rect width="64" x="448" y="-876" height="24" />
            <line x2="512" y1="-864" y2="-864" x1="448" />
            <rect width="64" x="448" y="-828" height="24" />
            <line x2="512" y1="-816" y2="-816" x1="448" />
            <line x2="512" y1="-768" y2="-768" x1="448" />
            <rect width="64" x="0" y="-780" height="24" />
            <line x2="0" y1="-768" y2="-768" x1="64" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <rect width="64" x="0" y="-636" height="24" />
            <line x2="0" y1="-624" y2="-624" x1="64" />
            <line x2="0" y1="-528" y2="-528" x1="64" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-384" y2="-384" x1="64" />
            <line x2="0" y1="-336" y2="-336" x1="64" />
            <line x2="512" y1="-720" y2="-720" x1="448" />
            <line x2="512" y1="-480" y2="-480" x1="448" />
            <line x2="512" y1="-528" y2="-528" x1="448" />
            <line x2="512" y1="-624" y2="-624" x1="448" />
            <rect width="64" x="448" y="-684" height="24" />
            <line x2="512" y1="-672" y2="-672" x1="448" />
            <line x2="512" y1="-432" y2="-432" x1="448" />
            <line x2="512" y1="-384" y2="-384" x1="448" />
            <line x2="512" y1="-336" y2="-336" x1="448" />
            <rect width="64" x="448" y="-300" height="24" />
            <line x2="512" y1="-288" y2="-288" x1="448" />
            <rect width="384" x="64" y="-1280" height="1456" />
            <line x2="512" y1="-240" y2="-240" x1="448" />
            <line x2="512" y1="-192" y2="-192" x1="448" />
            <line x2="512" y1="-144" y2="-144" x1="448" />
            <line x2="512" y1="144" y2="144" x1="448" />
            <rect width="64" x="448" y="84" height="24" />
            <line x2="512" y1="96" y2="96" x1="448" />
            <line x2="512" y1="48" y2="48" x1="448" />
            <line x2="512" y1="-48" y2="-48" x1="448" />
            <rect width="64" x="448" y="-108" height="24" />
            <line x2="512" y1="-96" y2="-96" x1="448" />
        </blockdef>
        <blockdef name="uart_core_mpc_a">
            <timestamp>2013-3-28T9:22:58</timestamp>
            <rect width="256" x="64" y="-576" height="544" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="384" y1="-544" y2="-544" x1="320" />
            <rect width="64" x="320" y="-508" height="24" />
            <line x2="384" y1="-496" y2="-496" x1="320" />
            <line x2="384" y1="-448" y2="-448" x1="320" />
            <line x2="384" y1="-400" y2="-400" x1="320" />
            <rect width="64" x="0" y="-460" height="24" />
            <line x2="0" y1="-448" y2="-448" x1="64" />
            <line x2="0" y1="-400" y2="-400" x1="64" />
            <rect width="64" x="0" y="-364" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-220" height="24" />
            <line x2="0" y1="-208" y2="-208" x1="64" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="384" y1="-256" y2="-256" x1="320" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-112" y2="-112" x1="320" />
        </blockdef>
        <blockdef name="cmd_if_pv2_4_4x4">
            <timestamp>2017-4-13T6:49:57</timestamp>
            <rect width="64" x="0" y="1140" height="24" />
            <line x2="0" y1="1152" y2="1152" x1="64" />
            <line x2="0" y1="1104" y2="1104" x1="64" />
            <line x2="0" y1="1056" y2="1056" x1="64" />
            <line x2="0" y1="864" y2="864" x1="64" />
            <line x2="0" y1="912" y2="912" x1="64" />
            <line x2="0" y1="960" y2="960" x1="64" />
            <rect width="64" x="0" y="996" height="24" />
            <line x2="0" y1="1008" y2="1008" x1="64" />
            <line x2="0" y1="672" y2="672" x1="64" />
            <line x2="0" y1="720" y2="720" x1="64" />
            <line x2="0" y1="768" y2="768" x1="64" />
            <rect width="64" x="0" y="804" height="24" />
            <line x2="0" y1="816" y2="816" x1="64" />
            <line x2="576" y1="576" y2="576" x1="512" />
            <line x2="0" y1="528" y2="528" x1="64" />
            <line x2="0" y1="-2400" y2="-2400" x1="64" />
            <line x2="0" y1="-2352" y2="-2352" x1="64" />
            <rect width="64" x="0" y="-2316" height="24" />
            <line x2="0" y1="-2304" y2="-2304" x1="64" />
            <rect width="64" x="0" y="-2268" height="24" />
            <line x2="0" y1="-2256" y2="-2256" x1="64" />
            <rect width="64" x="0" y="-2220" height="24" />
            <line x2="0" y1="-2208" y2="-2208" x1="64" />
            <rect width="64" x="0" y="-2172" height="24" />
            <line x2="0" y1="-2160" y2="-2160" x1="64" />
            <rect width="64" x="0" y="-2124" height="24" />
            <line x2="0" y1="-2112" y2="-2112" x1="64" />
            <rect width="64" x="0" y="-2076" height="24" />
            <line x2="0" y1="-2064" y2="-2064" x1="64" />
            <rect width="64" x="0" y="-2028" height="24" />
            <line x2="0" y1="-2016" y2="-2016" x1="64" />
            <rect width="64" x="0" y="-1980" height="24" />
            <line x2="0" y1="-1968" y2="-1968" x1="64" />
            <rect width="64" x="512" y="-2412" height="24" />
            <line x2="576" y1="-2400" y2="-2400" x1="512" />
            <line x2="576" y1="-2304" y2="-2304" x1="512" />
            <rect width="64" x="512" y="-2268" height="24" />
            <line x2="576" y1="-2256" y2="-2256" x1="512" />
            <rect width="64" x="512" y="-2172" height="24" />
            <line x2="576" y1="-2160" y2="-2160" x1="512" />
            <rect width="64" x="512" y="-2124" height="24" />
            <line x2="576" y1="-2112" y2="-2112" x1="512" />
            <line x2="576" y1="-2064" y2="-2064" x1="512" />
            <line x2="576" y1="-2016" y2="-2016" x1="512" />
            <rect width="64" x="512" y="-1980" height="24" />
            <line x2="576" y1="-1968" y2="-1968" x1="512" />
            <rect width="64" x="512" y="-1884" height="24" />
            <line x2="576" y1="-1872" y2="-1872" x1="512" />
            <rect width="64" x="512" y="-1836" height="24" />
            <line x2="576" y1="-1824" y2="-1824" x1="512" />
            <rect width="64" x="512" y="-1788" height="24" />
            <line x2="576" y1="-1776" y2="-1776" x1="512" />
            <line x2="576" y1="-1728" y2="-1728" x1="512" />
            <rect width="64" x="512" y="-396" height="24" />
            <line x2="576" y1="-384" y2="-384" x1="512" />
            <rect width="64" x="512" y="-444" height="24" />
            <line x2="576" y1="-432" y2="-432" x1="512" />
            <line x2="576" y1="-480" y2="-480" x1="512" />
            <line x2="576" y1="-528" y2="-528" x1="512" />
            <rect width="64" x="512" y="-588" height="24" />
            <line x2="576" y1="-576" y2="-576" x1="512" />
            <rect width="64" x="512" y="-636" height="24" />
            <line x2="576" y1="-624" y2="-624" x1="512" />
            <line x2="576" y1="-672" y2="-672" x1="512" />
            <rect width="64" x="512" y="-780" height="24" />
            <line x2="576" y1="-768" y2="-768" x1="512" />
            <rect width="64" x="512" y="-828" height="24" />
            <line x2="576" y1="-816" y2="-816" x1="512" />
            <rect width="64" x="512" y="-876" height="24" />
            <line x2="576" y1="-864" y2="-864" x1="512" />
            <rect width="64" x="512" y="-924" height="24" />
            <line x2="576" y1="-912" y2="-912" x1="512" />
            <rect width="64" x="512" y="-348" height="24" />
            <line x2="576" y1="-336" y2="-336" x1="512" />
            <rect width="64" x="512" y="-732" height="24" />
            <line x2="576" y1="-720" y2="-720" x1="512" />
            <rect width="64" x="512" y="-300" height="24" />
            <line x2="576" y1="-288" y2="-288" x1="512" />
            <rect width="64" x="512" y="-252" height="24" />
            <line x2="576" y1="-240" y2="-240" x1="512" />
            <rect width="64" x="512" y="-204" height="24" />
            <line x2="576" y1="-192" y2="-192" x1="512" />
            <line x2="576" y1="-960" y2="-960" x1="512" />
            <line x2="576" y1="-1008" y2="-1008" x1="512" />
            <line x2="0" y1="-1872" y2="-1872" x1="64" />
            <line x2="0" y1="0" y2="0" x1="64" />
            <rect width="64" x="0" y="-156" height="24" />
            <line x2="0" y1="-144" y2="-144" x1="64" />
            <line x2="0" y1="-240" y2="-240" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-348" height="24" />
            <line x2="0" y1="-336" y2="-336" x1="64" />
            <rect width="64" x="0" y="-396" height="24" />
            <line x2="0" y1="-384" y2="-384" x1="64" />
            <rect width="64" x="0" y="-444" height="24" />
            <line x2="0" y1="-432" y2="-432" x1="64" />
            <rect width="64" x="0" y="-492" height="24" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <rect width="64" x="0" y="-540" height="24" />
            <line x2="0" y1="-528" y2="-528" x1="64" />
            <rect width="64" x="0" y="-588" height="24" />
            <line x2="0" y1="-576" y2="-576" x1="64" />
            <line x2="0" y1="-624" y2="-624" x1="64" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <rect width="64" x="0" y="-1164" height="24" />
            <line x2="0" y1="-1152" y2="-1152" x1="64" />
            <line x2="0" y1="-1200" y2="-1200" x1="64" />
            <line x2="0" y1="-1248" y2="-1248" x1="64" />
            <rect width="64" x="0" y="-1356" height="24" />
            <line x2="0" y1="-1344" y2="-1344" x1="64" />
            <line x2="0" y1="-1392" y2="-1392" x1="64" />
            <line x2="0" y1="-1440" y2="-1440" x1="64" />
            <line x2="0" y1="-1536" y2="-1536" x1="64" />
            <line x2="0" y1="-1584" y2="-1584" x1="64" />
            <line x2="0" y1="-1632" y2="-1632" x1="64" />
            <line x2="0" y1="-1680" y2="-1680" x1="64" />
            <rect width="64" x="0" y="-1836" height="24" />
            <line x2="0" y1="-1824" y2="-1824" x1="64" />
            <line x2="0" y1="-1776" y2="-1776" x1="64" />
            <rect width="64" x="0" y="-1740" height="24" />
            <line x2="0" y1="-1728" y2="-1728" x1="64" />
            <line x2="0" y1="-48" y2="-48" x1="64" />
            <line x2="576" y1="-48" y2="-48" x1="512" />
            <line x2="576" y1="-96" y2="-96" x1="512" />
            <line x2="576" y1="480" y2="480" x1="512" />
            <line x2="576" y1="432" y2="432" x1="512" />
            <line x2="576" y1="384" y2="384" x1="512" />
            <line x2="576" y1="288" y2="288" x1="512" />
            <line x2="576" y1="-1680" y2="-1680" x1="512" />
            <line x2="576" y1="-1632" y2="-1632" x1="512" />
            <line x2="576" y1="0" y2="0" x1="512" />
            <line x2="576" y1="48" y2="48" x1="512" />
            <rect width="64" x="512" y="180" height="24" />
            <line x2="576" y1="192" y2="192" x1="512" />
            <rect width="64" x="512" y="228" height="24" />
            <line x2="576" y1="240" y2="240" x1="512" />
            <line x2="0" y1="-1104" y2="-1104" x1="64" />
            <line x2="0" y1="-1056" y2="-1056" x1="64" />
            <line x2="0" y1="336" y2="336" x1="64" />
            <rect width="448" x="64" y="-2432" height="3616" />
        </blockdef>
        <block symbolname="vcc" name="XLXI_5">
            <blockpin signalname="H" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_6">
            <blockpin signalname="L" name="G" />
        </block>
        <block symbolname="fd1" name="XLXI_7">
            <blockpin signalname="STARTN" name="D" />
            <blockpin signalname="CLK" name="CK" />
            <blockpin signalname="XLXN_138" name="Q" />
        </block>
        <block symbolname="or2" name="XLXI_8">
            <blockpin signalname="XLXN_138" name="I0" />
            <blockpin signalname="STARTN" name="I1" />
            <blockpin signalname="RST" name="O" />
        </block>
        <block symbolname="uart_if_impact_a" name="XLXI_15">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="RST" name="rst" />
            <blockpin signalname="XLXN_80" name="rx_vld" />
            <blockpin signalname="XLXN_82" name="rx_frm_err" />
            <blockpin signalname="XLXN_83" name="rx_prty_err" />
            <blockpin signalname="H" name="rx_time_out_on" />
            <blockpin signalname="L" name="xl_mode" />
            <blockpin signalname="XLXN_99" name="tx_busy" />
            <blockpin signalname="TX_DONE" name="tx_done" />
            <blockpin signalname="XLXN_18" name="rsp_req" />
            <blockpin signalname="XLXN_81(7:0)" name="rx_data(7:0)" />
            <blockpin signalname="XLXN_14(6:0)" name="cmd_ram_ra(6:0)" />
            <blockpin signalname="XLXN_148(79:0)" name="rsp_data(79:0)" />
            <blockpin name="rx_time_out" />
            <blockpin signalname="XLXN_84" name="exe_req" />
            <blockpin signalname="XLXN_85" name="rcv_ok" />
            <blockpin signalname="XLXN_141" name="emb_cmd" />
            <blockpin signalname="XLXN_143" name="emb_cmd_rcv_ok" />
            <blockpin signalname="XLXN_163" name="m5_cmd" />
            <blockpin signalname="XLXN_165" name="m5_cmd_rcv_ok" />
            <blockpin signalname="EMB_TX_REQ" name="emb_tx_req" />
            <blockpin signalname="M5_TX_REQ" name="m5_tx_req" />
            <blockpin signalname="XLXN_132" name="cmd_com_buf_write" />
            <blockpin signalname="XLXN_134" name="cmd_com_buf_we" />
            <blockpin signalname="XLXN_98" name="tx_vld" />
            <blockpin signalname="XLXN_96" name="tx_brk" />
            <blockpin signalname="XLXN_94" name="rsp_done" />
            <blockpin signalname="XLXN_95" name="rsp_ram_re" />
            <blockpin signalname="M5_RSP_RAM_RE" name="m5_rsp_ram_re" />
            <blockpin signalname="XLXN_86(7:0)" name="exe_p5(7:0)" />
            <blockpin signalname="XLXN_87(7:0)" name="exe_p4(7:0)" />
            <blockpin signalname="XLXN_88(7:0)" name="exe_p3(7:0)" />
            <blockpin signalname="XLXN_89(7:0)" name="exe_p2(7:0)" />
            <blockpin signalname="XLXN_90(7:0)" name="exe_p1(7:0)" />
            <blockpin signalname="XLXN_91(7:0)" name="exe_p0(7:0)" />
            <blockpin signalname="XLXN_92(5:0)" name="exe_cmd_num(5:0)" />
            <blockpin signalname="EMB_TX_DATA(79:0)" name="emb_tx_data(79:0)" />
            <blockpin signalname="M5_TX_DATA(79:0)" name="m5_tx_data(79:0)" />
            <blockpin signalname="XLXN_93(7:0)" name="cmd_ram_do(7:0)" />
            <blockpin signalname="XLXN_133(7:0)" name="cmd_com_buf_wa(7:0)" />
            <blockpin signalname="XLXN_12(7:0)" name="tx_data(7:0)" />
        </block>
        <block symbolname="uart_core_mpc_a" name="XLXI_16">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="RST" name="rst" />
            <blockpin signalname="RXD" name="rxd" />
            <blockpin signalname="XLXN_98" name="tx_vld" />
            <blockpin signalname="XLXN_96" name="tx_brk" />
            <blockpin signalname="L" name="stpsel" />
            <blockpin signalname="XLXN_12(7:0)" name="tx_data(7:0)" />
            <blockpin signalname="L,L" name="prtysel(1:0)" />
            <blockpin signalname="CMD_BAUD_RATE(1:0)" name="brdsel(1:0)" />
            <blockpin signalname="TXD" name="txd" />
            <blockpin signalname="XLXN_99" name="tx_busy" />
            <blockpin signalname="TX_DONE" name="tx_done" />
            <blockpin signalname="XLXN_80" name="rx_vld" />
            <blockpin signalname="XLXN_82" name="rx_frm_err" />
            <blockpin signalname="XLXN_83" name="rx_prty_err" />
            <blockpin name="rx_brk" />
            <blockpin signalname="XLXN_81(7:0)" name="rx_data(7:0)" />
        </block>
        <block symbolname="cmd_if_pv2_4_4x4" name="XLXI_23">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="RST" name="rst" />
            <blockpin signalname="XLXN_84" name="exe_req" />
            <blockpin signalname="XLXN_85" name="rcv_ok" />
            <blockpin signalname="RSP_RAM_RD_RSTW" name="rsp_ram_rd_rstw" />
            <blockpin signalname="RSP_RAM_RD_WE" name="rsp_ram_rd_we" />
            <blockpin signalname="RSP_IM_RD_RSTW" name="rsp_im_rd_rstw" />
            <blockpin signalname="RSP_IM_RD_WE" name="rsp_im_rd_we" />
            <blockpin signalname="XLXN_95" name="rsp_ram_re" />
            <blockpin signalname="TX_DONE" name="tx_done" />
            <blockpin signalname="IM_ERR_DET" name="im_err_det" />
            <blockpin signalname="M4_ON" name="m4_on" />
            <blockpin signalname="M4_BANK1" name="m4_bank1" />
            <blockpin signalname="IM_BUSY" name="im_busy" />
            <blockpin signalname="IM_COPY_CORRECT_BUSY" name="im_copy_correct_busy" />
            <blockpin signalname="XLXN_94" name="rsp_done" />
            <blockpin signalname="XLXN_99" name="tx_busy" />
            <blockpin signalname="DSW_LOSS_BRT100" name="dsw_loss_brt100" />
            <blockpin signalname="XLXN_132" name="cmd_com_buf_write" />
            <blockpin signalname="XLXN_134" name="cmd_com_buf_we" />
            <blockpin signalname="RX_IM_DOWNLOAD_ON" name="rx_im_download_on" />
            <blockpin signalname="XLXN_141" name="emb_cmd" />
            <blockpin signalname="XLXN_143" name="emb_cmd_rcv_ok" />
            <blockpin signalname="EMB_RSP_REQ" name="emb_rsp_req" />
            <blockpin signalname="XLXN_163" name="m5_cmd" />
            <blockpin signalname="XLXN_165" name="m5_cmd_rcv_ok" />
            <blockpin signalname="M5_RSP_REQ" name="m5_rsp_req" />
            <blockpin signalname="EXE_EN" name="exe_en" />
            <blockpin signalname="OVPX" name="ovpx" />
            <blockpin signalname="PANEL_SEL(3:0)" name="panel_sel(3:0)" />
            <blockpin signalname="XLXN_86(7:0)" name="exe_p5(7:0)" />
            <blockpin signalname="XLXN_87(7:0)" name="exe_p4(7:0)" />
            <blockpin signalname="XLXN_88(7:0)" name="exe_p3(7:0)" />
            <blockpin signalname="XLXN_89(7:0)" name="exe_p2(7:0)" />
            <blockpin signalname="XLXN_90(7:0)" name="exe_p1(7:0)" />
            <blockpin signalname="XLXN_91(7:0)" name="exe_p0(7:0)" />
            <blockpin signalname="XLXN_92(5:0)" name="exe_cmd_num(5:0)" />
            <blockpin signalname="XLXN_93(7:0)" name="cmd_ram_do(7:0)" />
            <blockpin signalname="RSP_RAM_RD(7:0)" name="rsp_ram_rd(7:0)" />
            <blockpin signalname="RSP_IM_RD(7:0)" name="rsp_im_rd(7:0)" />
            <blockpin signalname="CT_RED(3:0)" name="ct_red(3:0)" />
            <blockpin signalname="CT_GREEN(3:0)" name="ct_green(3:0)" />
            <blockpin signalname="CT_BLUE(3:0)" name="ct_blue(3:0)" />
            <blockpin signalname="GAMMA(2:0)" name="gamma(2:0)" />
            <blockpin signalname="TEST_PAT(7:0)" name="test_pat(7:0)" />
            <blockpin signalname="FPGA_VER(7:0)" name="fpga_ver(7:0)" />
            <blockpin signalname="BRIGHTNESS(6:0)" name="brightness(6:0)" />
            <blockpin signalname="MEM_COLOR_LOSS(2:0)" name="mem_color_loss(2:0)" />
            <blockpin signalname="XLXN_133(7:0)" name="cmd_com_buf_wa(7:0)" />
            <blockpin signalname="XLXN_81(7:0)" name="rx_data(7:0)" />
            <blockpin signalname="EMB_RSP_DATA(79:0)" name="emb_rsp_data(79:0)" />
            <blockpin signalname="M5_RSP_DATA(79:0)" name="m5_rsp_data(79:0)" />
            <blockpin signalname="RAM_CMD_RD_WE" name="ram_cmd_rd_we" />
            <blockpin signalname="COEFF_OFFSET_WE" name="coeff_offset_we" />
            <blockpin signalname="IM_CMD_RD_RSTW" name="im_cmd_rd_rstw" />
            <blockpin signalname="IM_CMD_RD_WE" name="im_cmd_rd_we" />
            <blockpin signalname="RAM_CMD_STARTP" name="ram_cmd_startp" />
            <blockpin signalname="PANEL_CORRECT_STARTP" name="panel_correct_startp" />
            <blockpin signalname="ONE_IM_TO_RAM_COPY" name="one_im_to_ram_copy" />
            <blockpin signalname="IM_CMD_STARTP" name="im_cmd_startp" />
            <blockpin signalname="XLXN_18" name="rsp_req" />
            <blockpin signalname="CMD_REBOOT_N" name="cmd_reboot_n" />
            <blockpin signalname="PIXEL1_DISP_ON" name="pixel1_disp_on" />
            <blockpin signalname="PIXEL4_DISP_ON" name="pixel4_disp_on" />
            <blockpin signalname="CMD_M4_ON" name="sel_m4_on" />
            <blockpin signalname="CMD_M4_BANK1" name="sel_m4_bank1" />
            <blockpin signalname="PANEL_CORRECT_IM" name="panel_correct_im" />
            <blockpin signalname="PANEL_CORRECT_ONE_IM" name="panel_correct_one_im" />
            <blockpin signalname="IM_DOWNLOAD_EXE_TIM" name="rx_im_download_exe_tim" />
            <blockpin signalname="TP1" name="tp1" />
            <blockpin signalname="TP2" name="tp2" />
            <blockpin signalname="TP3" name="tp3" />
            <blockpin signalname="IM_OPE_SEL(3:0)" name="im_ope_sel(3:0)" />
            <blockpin signalname="RAM_OPE_SEL(2:0)" name="ram_ope_sel(2:0)" />
            <blockpin signalname="IM_CMD_AD(15:0)" name="im_cmd_ad(15:0)" />
            <blockpin signalname="RAM_CMD_AD(21:0)" name="ram_cmd_ad(21:0)" />
            <blockpin signalname="XLXN_14(6:0)" name="cmd_ram_ra(6:0)" />
            <blockpin signalname="RAM_CMD_RD(7:0)" name="ram_cmd_rd(7:0)" />
            <blockpin signalname="IM_CMD_RD(7:0)" name="im_cmd_rd(7:0)" />
            <blockpin signalname="IM_VADRS(3:0)" name="im_vadrs(3:0)" />
            <blockpin signalname="IM_HADRS(3:0)" name="im_hadrs(3:0)" />
            <blockpin signalname="XLXN_148(79:0)" name="rsp_data(79:0)" />
            <blockpin signalname="CMD_CT_RED(3:0)" name="cmd_ct_red(3:0)" />
            <blockpin signalname="CMD_CT_GREEN(3:0)" name="cmd_ct_green(3:0)" />
            <blockpin signalname="CMD_CT_BLUE(3:0)" name="cmd_ct_blue(3:0)" />
            <blockpin signalname="CMD_GAMMA(2:0)" name="cmd_gamma(2:0)" />
            <blockpin signalname="CMD_BAUD_RATE(1:0)" name="cmd_baud_rate(1:0)" />
            <blockpin signalname="CMD_BRIGHTNESS(6:0)" name="cmd_brightness(6:0)" />
            <blockpin signalname="PIXEL1_DISP_MODE(23:0)" name="pixel1_disp_mode(23:0)" />
            <blockpin signalname="PIXEL_DISP_RGB_ON(2:0)" name="pixel_disp_rgb_on(2:0)" />
            <blockpin signalname="COLOR_LOSS(2:0)" name="color_loss(2:0)" />
            <blockpin signalname="TESTP_LEVEL(7:0)" name="testp_level(7:0)" />
            <blockpin signalname="RGB_OUT_ZERO(2:0)" name="rgb_out_zero(2:0)" />
            <blockpin signalname="CMD_TEST_PAT(7:0)" name="sel_test_pat(7:0)" />
            <blockpin signalname="TESTP_RGB_EN(2:0)" name="testp_rgb_en(2:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7609" height="5382">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <text style="fontsize:64;fontname:Arial" x="7048" y="5224">rs232c_xt</text>
        <branch name="RXD">
            <wire x2="1520" y1="1600" y2="1600" x1="1440" />
        </branch>
        <iomarker fontsize="28" x="1440" y="1600" name="RXD" orien="R180" />
        <branch name="L,L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1456" y="1696" type="branch" />
            <wire x2="1520" y1="1696" y2="1696" x1="1456" />
        </branch>
        <branch name="L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1456" y="1744" type="branch" />
            <wire x2="1520" y1="1744" y2="1744" x1="1456" />
        </branch>
        <branch name="CMD_BAUD_RATE(1:0)">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1456" y="1792" type="branch" />
            <wire x2="1520" y1="1792" y2="1792" x1="1456" />
        </branch>
        <branch name="RST">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1456" y="2032" type="branch" />
            <wire x2="1520" y1="2032" y2="2032" x1="1456" />
        </branch>
        <branch name="CLK">
            <wire x2="1520" y1="2080" y2="2080" x1="1440" />
        </branch>
        <iomarker fontsize="28" x="1440" y="2080" name="CLK" orien="R180" />
        <instance x="576" y="1760" name="XLXI_5" orien="R0" />
        <instance x="576" y="2048" name="XLXI_6" orien="R0" />
        <branch name="H">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="720" y="1808" type="branch" />
            <wire x2="640" y1="1760" y2="1808" x1="640" />
            <wire x2="720" y1="1808" y2="1808" x1="640" />
        </branch>
        <branch name="L">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="720" y="1872" type="branch" />
            <wire x2="640" y1="1872" y2="1920" x1="640" />
            <wire x2="720" y1="1872" y2="1872" x1="640" />
        </branch>
        <branch name="XLXN_14(6:0)">
            <wire x2="2560" y1="1440" y2="2080" x1="2560" />
            <wire x2="2720" y1="2080" y2="2080" x1="2560" />
            <wire x2="5120" y1="1440" y2="1440" x1="2560" />
            <wire x2="5120" y1="1440" y2="1600" x1="5120" />
            <wire x2="5120" y1="1600" y2="1600" x1="5056" />
        </branch>
        <branch name="XLXN_18">
            <wire x2="2496" y1="1376" y2="2176" x1="2496" />
            <wire x2="2720" y1="2176" y2="2176" x1="2496" />
            <wire x2="5184" y1="1376" y2="1376" x1="2496" />
            <wire x2="5184" y1="1376" y2="1696" x1="5184" />
            <wire x2="5184" y1="1696" y2="1696" x1="5056" />
        </branch>
        <branch name="RAM_OPE_SEL(2:0)">
            <wire x2="5120" y1="1840" y2="1840" x1="5056" />
        </branch>
        <branch name="RAM_CMD_AD(21:0)">
            <wire x2="5120" y1="1888" y2="1888" x1="5056" />
        </branch>
        <branch name="RAM_CMD_STARTP">
            <wire x2="5120" y1="1936" y2="1936" x1="5056" />
        </branch>
        <branch name="RAM_CMD_RD_WE">
            <wire x2="5120" y1="1984" y2="1984" x1="5056" />
        </branch>
        <branch name="RAM_CMD_RD(7:0)">
            <wire x2="5120" y1="2032" y2="2032" x1="5056" />
        </branch>
        <branch name="IM_OPE_SEL(3:0)">
            <wire x2="5120" y1="2128" y2="2128" x1="5056" />
        </branch>
        <branch name="IM_CMD_AD(15:0)">
            <wire x2="5120" y1="2176" y2="2176" x1="5056" />
        </branch>
        <branch name="IM_CMD_RD(7:0)">
            <wire x2="5120" y1="2224" y2="2224" x1="5056" />
        </branch>
        <branch name="IM_CMD_RD_RSTW">
            <wire x2="5120" y1="2272" y2="2272" x1="5056" />
        </branch>
        <branch name="IM_CMD_RD_WE">
            <wire x2="5120" y1="2320" y2="2320" x1="5056" />
        </branch>
        <branch name="IM_CMD_STARTP">
            <wire x2="5120" y1="2368" y2="2368" x1="5056" />
        </branch>
        <branch name="CMD_M4_ON">
            <wire x2="5120" y1="2992" y2="2992" x1="5056" />
        </branch>
        <branch name="CMD_M4_BANK1">
            <wire x2="5120" y1="3040" y2="3040" x1="5056" />
        </branch>
        <branch name="CMD_CT_RED(3:0)">
            <wire x2="5120" y1="3088" y2="3088" x1="5056" />
        </branch>
        <branch name="CMD_CT_GREEN(3:0)">
            <wire x2="5120" y1="3136" y2="3136" x1="5056" />
        </branch>
        <branch name="CMD_CT_BLUE(3:0)">
            <wire x2="5120" y1="3184" y2="3184" x1="5056" />
        </branch>
        <branch name="CMD_GAMMA(2:0)">
            <wire x2="5120" y1="3232" y2="3232" x1="5056" />
        </branch>
        <branch name="CMD_TEST_PAT(7:0)">
            <wire x2="5120" y1="3280" y2="3280" x1="5056" />
        </branch>
        <branch name="CMD_REBOOT_N">
            <wire x2="5120" y1="3328" y2="3328" x1="5056" />
        </branch>
        <branch name="CMD_BAUD_RATE(1:0)">
            <wire x2="5120" y1="3376" y2="3376" x1="5056" />
        </branch>
        <branch name="CMD_BRIGHTNESS(6:0)">
            <wire x2="5120" y1="3424" y2="3424" x1="5056" />
        </branch>
        <branch name="PIXEL1_DISP_ON">
            <wire x2="5120" y1="3472" y2="3472" x1="5056" />
        </branch>
        <branch name="PIXEL4_DISP_ON">
            <wire x2="5120" y1="3520" y2="3520" x1="5056" />
        </branch>
        <branch name="PIXEL1_DISP_MODE(23:0)">
            <wire x2="5120" y1="3568" y2="3568" x1="5056" />
        </branch>
        <branch name="PIXEL_DISP_RGB_ON(2:0)">
            <wire x2="5120" y1="3616" y2="3616" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="3616" name="PIXEL_DISP_RGB_ON(2:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3568" name="PIXEL1_DISP_MODE(23:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3520" name="PIXEL4_DISP_ON" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3472" name="PIXEL1_DISP_ON" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3424" name="CMD_BRIGHTNESS(6:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3376" name="CMD_BAUD_RATE(1:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3328" name="CMD_REBOOT_N" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3280" name="CMD_TEST_PAT(7:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3232" name="CMD_GAMMA(2:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3184" name="CMD_CT_BLUE(3:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3136" name="CMD_CT_GREEN(3:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3088" name="CMD_CT_RED(3:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3040" name="CMD_M4_BANK1" orien="R0" />
        <iomarker fontsize="28" x="5120" y="2992" name="CMD_M4_ON" orien="R0" />
        <iomarker fontsize="28" x="5120" y="2368" name="IM_CMD_STARTP" orien="R0" />
        <iomarker fontsize="28" x="5120" y="2320" name="IM_CMD_RD_WE" orien="R0" />
        <iomarker fontsize="28" x="5120" y="2272" name="IM_CMD_RD_RSTW" orien="R0" />
        <iomarker fontsize="28" x="5120" y="2224" name="IM_CMD_RD(7:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="2176" name="IM_CMD_AD(15:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="2128" name="IM_OPE_SEL(3:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="2032" name="RAM_CMD_RD(7:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="1984" name="RAM_CMD_RD_WE" orien="R0" />
        <iomarker fontsize="28" x="5120" y="1936" name="RAM_CMD_STARTP" orien="R0" />
        <iomarker fontsize="28" x="5120" y="1888" name="RAM_CMD_AD(21:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="1840" name="RAM_OPE_SEL(2:0)" orien="R0" />
        <branch name="XLXN_80">
            <wire x2="2720" y1="1600" y2="1600" x1="1904" />
        </branch>
        <branch name="XLXN_81(7:0)">
            <wire x2="2368" y1="1648" y2="1648" x1="1904" />
            <wire x2="2368" y1="1648" y2="3120" x1="2368" />
            <wire x2="3904" y1="3120" y2="3120" x1="2368" />
            <wire x2="2720" y1="1648" y2="1648" x1="2368" />
            <wire x2="4480" y1="2272" y2="2272" x1="3904" />
            <wire x2="3904" y1="2272" y2="3120" x1="3904" />
        </branch>
        <branch name="XLXN_82">
            <wire x2="2720" y1="1696" y2="1696" x1="1904" />
        </branch>
        <branch name="XLXN_83">
            <wire x2="2720" y1="1744" y2="1744" x1="1904" />
        </branch>
        <branch name="XLXN_84">
            <wire x2="4480" y1="1600" y2="1600" x1="3232" />
        </branch>
        <branch name="XLXN_85">
            <wire x2="4480" y1="1648" y2="1648" x1="3232" />
        </branch>
        <branch name="XLXN_86(7:0)">
            <wire x2="4480" y1="1696" y2="1696" x1="3232" />
        </branch>
        <branch name="XLXN_87(7:0)">
            <wire x2="4480" y1="1744" y2="1744" x1="3232" />
        </branch>
        <branch name="XLXN_88(7:0)">
            <wire x2="4480" y1="1792" y2="1792" x1="3232" />
        </branch>
        <branch name="XLXN_89(7:0)">
            <wire x2="4480" y1="1840" y2="1840" x1="3232" />
        </branch>
        <branch name="XLXN_90(7:0)">
            <wire x2="4480" y1="1888" y2="1888" x1="3232" />
        </branch>
        <branch name="XLXN_91(7:0)">
            <wire x2="4480" y1="1936" y2="1936" x1="3232" />
        </branch>
        <branch name="XLXN_92(5:0)">
            <wire x2="4480" y1="1984" y2="1984" x1="3232" />
        </branch>
        <branch name="XLXN_93(7:0)">
            <wire x2="4480" y1="2032" y2="2032" x1="3232" />
        </branch>
        <branch name="XLXN_99">
            <wire x2="2032" y1="1984" y2="1984" x1="1904" />
            <wire x2="2032" y1="1984" y2="2320" x1="2032" />
            <wire x2="2032" y1="2320" y2="3184" x1="2032" />
            <wire x2="3968" y1="3184" y2="3184" x1="2032" />
            <wire x2="2720" y1="2320" y2="2320" x1="2032" />
            <wire x2="4480" y1="2416" y2="2416" x1="3968" />
            <wire x2="3968" y1="2416" y2="3184" x1="3968" />
        </branch>
        <branch name="TX_DONE">
            <wire x2="1968" y1="2032" y2="2032" x1="1904" />
            <wire x2="1968" y1="2032" y2="2368" x1="1968" />
            <wire x2="1968" y1="2368" y2="3248" x1="1968" />
            <wire x2="4032" y1="3248" y2="3248" x1="1968" />
            <wire x2="2720" y1="2368" y2="2368" x1="1968" />
            <wire x2="2112" y1="2032" y2="2032" x1="1968" />
            <wire x2="4480" y1="2464" y2="2464" x1="4032" />
            <wire x2="4032" y1="2464" y2="3248" x1="4032" />
        </branch>
        <branch name="COLOR_LOSS(2:0)">
            <wire x2="5120" y1="3664" y2="3664" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="3664" name="COLOR_LOSS(2:0)" orien="R0" />
        <branch name="TESTP_LEVEL(7:0)">
            <wire x2="5120" y1="3712" y2="3712" x1="5056" />
        </branch>
        <branch name="TESTP_RGB_EN(2:0)">
            <wire x2="5120" y1="3760" y2="3760" x1="5056" />
        </branch>
        <branch name="RGB_OUT_ZERO(2:0)">
            <wire x2="5120" y1="3808" y2="3808" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="3712" name="TESTP_LEVEL(7:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3760" name="TESTP_RGB_EN(2:0)" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3808" name="RGB_OUT_ZERO(2:0)" orien="R0" />
        <branch name="RSP_RAM_RD_RSTW">
            <wire x2="4480" y1="2560" y2="2560" x1="4400" />
        </branch>
        <branch name="RSP_RAM_RD_WE">
            <wire x2="4480" y1="2608" y2="2608" x1="4400" />
        </branch>
        <branch name="RSP_RAM_RD(7:0)">
            <wire x2="4480" y1="2656" y2="2656" x1="4400" />
        </branch>
        <branch name="RSP_IM_RD_RSTW">
            <wire x2="4480" y1="2752" y2="2752" x1="4400" />
        </branch>
        <branch name="RSP_IM_RD_WE">
            <wire x2="4480" y1="2800" y2="2800" x1="4400" />
        </branch>
        <branch name="RSP_IM_RD(7:0)">
            <wire x2="4480" y1="2848" y2="2848" x1="4400" />
        </branch>
        <branch name="IM_BUSY">
            <wire x2="4480" y1="2896" y2="2896" x1="4400" />
        </branch>
        <branch name="IM_ERR_DET">
            <wire x2="4480" y1="2944" y2="2944" x1="4400" />
        </branch>
        <branch name="M4_ON">
            <wire x2="4480" y1="3328" y2="3328" x1="4400" />
        </branch>
        <branch name="M4_BANK1">
            <wire x2="4480" y1="3376" y2="3376" x1="4400" />
        </branch>
        <branch name="CT_RED(3:0)">
            <wire x2="4480" y1="3424" y2="3424" x1="4400" />
        </branch>
        <branch name="CT_GREEN(3:0)">
            <wire x2="4480" y1="3472" y2="3472" x1="4400" />
        </branch>
        <branch name="CT_BLUE(3:0)">
            <wire x2="4480" y1="3520" y2="3520" x1="4400" />
        </branch>
        <branch name="GAMMA(2:0)">
            <wire x2="4480" y1="3568" y2="3568" x1="4400" />
        </branch>
        <branch name="TEST_PAT(7:0)">
            <wire x2="4480" y1="3616" y2="3616" x1="4400" />
        </branch>
        <branch name="FPGA_VER(7:0)">
            <wire x2="4480" y1="3664" y2="3664" x1="4400" />
        </branch>
        <branch name="BRIGHTNESS(6:0)">
            <wire x2="4480" y1="3712" y2="3712" x1="4400" />
        </branch>
        <branch name="DSW_LOSS_BRT100">
            <wire x2="4480" y1="3760" y2="3760" x1="4400" />
        </branch>
        <branch name="RST">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="3952" type="branch" />
            <wire x2="4480" y1="3952" y2="3952" x1="4416" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="4416" y="4000" type="branch" />
            <wire x2="4480" y1="4000" y2="4000" x1="4416" />
        </branch>
        <branch name="MEM_COLOR_LOSS(2:0)">
            <wire x2="4480" y1="3856" y2="3856" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="2944" name="IM_ERR_DET" orien="R180" />
        <iomarker fontsize="28" x="4400" y="2896" name="IM_BUSY" orien="R180" />
        <iomarker fontsize="28" x="4400" y="2848" name="RSP_IM_RD(7:0)" orien="R180" />
        <iomarker fontsize="28" x="4400" y="2800" name="RSP_IM_RD_WE" orien="R180" />
        <iomarker fontsize="28" x="4400" y="2752" name="RSP_IM_RD_RSTW" orien="R180" />
        <iomarker fontsize="28" x="4400" y="2656" name="RSP_RAM_RD(7:0)" orien="R180" />
        <iomarker fontsize="28" x="4400" y="2608" name="RSP_RAM_RD_WE" orien="R180" />
        <iomarker fontsize="28" x="4400" y="2560" name="RSP_RAM_RD_RSTW" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3760" name="DSW_LOSS_BRT100" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3712" name="BRIGHTNESS(6:0)" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3664" name="FPGA_VER(7:0)" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3616" name="TEST_PAT(7:0)" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3568" name="GAMMA(2:0)" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3520" name="CT_BLUE(3:0)" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3472" name="CT_GREEN(3:0)" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3424" name="CT_RED(3:0)" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3376" name="M4_BANK1" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3328" name="M4_ON" orien="R180" />
        <iomarker fontsize="28" x="4400" y="3856" name="MEM_COLOR_LOSS(2:0)" orien="R180" />
        <branch name="XLXN_95">
            <wire x2="4480" y1="2368" y2="2368" x1="3232" />
        </branch>
        <branch name="XLXN_94">
            <wire x2="4480" y1="2320" y2="2320" x1="3232" />
        </branch>
        <branch name="XLXN_132">
            <wire x2="4480" y1="2128" y2="2128" x1="3232" />
        </branch>
        <branch name="XLXN_133(7:0)">
            <wire x2="4480" y1="2176" y2="2176" x1="3232" />
        </branch>
        <branch name="XLXN_134">
            <wire x2="4480" y1="2224" y2="2224" x1="3232" />
        </branch>
        <instance x="1600" y="3840" name="XLXI_7" orien="R0">
        </instance>
        <instance x="1936" y="3728" name="XLXI_8" orien="R0" />
        <branch name="STARTN">
            <wire x2="1536" y1="3600" y2="3600" x1="1440" />
            <wire x2="1936" y1="3600" y2="3600" x1="1536" />
            <wire x2="1536" y1="3600" y2="3760" x1="1536" />
            <wire x2="1600" y1="3760" y2="3760" x1="1536" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1536" y="3808" type="branch" />
            <wire x2="1600" y1="3808" y2="3808" x1="1536" />
        </branch>
        <branch name="XLXN_138">
            <wire x2="1872" y1="3760" y2="3760" x1="1808" />
            <wire x2="1936" y1="3664" y2="3664" x1="1872" />
            <wire x2="1872" y1="3664" y2="3760" x1="1872" />
        </branch>
        <branch name="RST">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="2256" y="3632" type="branch" />
            <wire x2="2256" y1="3632" y2="3632" x1="2192" />
        </branch>
        <iomarker fontsize="28" x="1440" y="3600" name="STARTN" orien="R180" />
        <branch name="COEFF_OFFSET_WE">
            <wire x2="5120" y1="3904" y2="3904" x1="5056" />
        </branch>
        <branch name="PANEL_CORRECT_STARTP">
            <wire x2="5120" y1="3952" y2="3952" x1="5056" />
        </branch>
        <branch name="PANEL_CORRECT_IM">
            <wire x2="5120" y1="4000" y2="4000" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="3904" name="COEFF_OFFSET_WE" orien="R0" />
        <iomarker fontsize="28" x="5120" y="3952" name="PANEL_CORRECT_STARTP" orien="R0" />
        <iomarker fontsize="28" x="5120" y="4000" name="PANEL_CORRECT_IM" orien="R0" />
        <branch name="TP1">
            <wire x2="5120" y1="4384" y2="4384" x1="5056" />
        </branch>
        <branch name="TP2">
            <wire x2="5120" y1="4432" y2="4432" x1="5056" />
        </branch>
        <branch name="TP3">
            <wire x2="5120" y1="4480" y2="4480" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="4384" name="TP1" orien="R0" />
        <iomarker fontsize="28" x="5120" y="4432" name="TP2" orien="R0" />
        <iomarker fontsize="28" x="5120" y="4480" name="TP3" orien="R0" />
        <branch name="IM_COPY_CORRECT_BUSY">
            <wire x2="4480" y1="4336" y2="4336" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="4336" name="IM_COPY_CORRECT_BUSY" orien="R180" />
        <branch name="ONE_IM_TO_RAM_COPY">
            <wire x2="5120" y1="4288" y2="4288" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="4288" name="ONE_IM_TO_RAM_COPY" orien="R0" />
        <branch name="RX_IM_DOWNLOAD_ON">
            <wire x2="4480" y1="4528" y2="4528" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="4528" name="RX_IM_DOWNLOAD_ON" orien="R180" />
        <branch name="IM_DOWNLOAD_EXE_TIM">
            <wire x2="5120" y1="4576" y2="4576" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="4576" name="IM_DOWNLOAD_EXE_TIM" orien="R0" />
        <branch name="XLXN_96">
            <wire x2="1520" y1="1984" y2="1984" x1="1280" />
            <wire x2="1280" y1="1984" y2="3360" x1="1280" />
            <wire x2="3296" y1="3360" y2="3360" x1="1280" />
            <wire x2="3296" y1="2992" y2="2992" x1="3232" />
            <wire x2="3296" y1="2992" y2="3360" x1="3296" />
        </branch>
        <branch name="XLXN_12(7:0)">
            <wire x2="1520" y1="1936" y2="1936" x1="1216" />
            <wire x2="1216" y1="1936" y2="3424" x1="1216" />
            <wire x2="3360" y1="3424" y2="3424" x1="1216" />
            <wire x2="3360" y1="2944" y2="2944" x1="3232" />
            <wire x2="3360" y1="2944" y2="3424" x1="3360" />
        </branch>
        <branch name="XLXN_98">
            <wire x2="1520" y1="1888" y2="1888" x1="1152" />
            <wire x2="1152" y1="1888" y2="3488" x1="1152" />
            <wire x2="3424" y1="3488" y2="3488" x1="1152" />
            <wire x2="3424" y1="2896" y2="2896" x1="3232" />
            <wire x2="3424" y1="2896" y2="3488" x1="3424" />
        </branch>
        <branch name="XLXN_141">
            <wire x2="3840" y1="2416" y2="2416" x1="3232" />
            <wire x2="3840" y1="2416" y2="4672" x1="3840" />
            <wire x2="4480" y1="4672" y2="4672" x1="3840" />
        </branch>
        <branch name="XLXN_143">
            <wire x2="3776" y1="2464" y2="2464" x1="3232" />
            <wire x2="3776" y1="2464" y2="4720" x1="3776" />
            <wire x2="4480" y1="4720" y2="4720" x1="3776" />
        </branch>
        <branch name="EMB_RSP_REQ">
            <wire x2="4480" y1="4768" y2="4768" x1="4400" />
        </branch>
        <branch name="EMB_RSP_DATA(79:0)">
            <wire x2="4480" y1="4816" y2="4816" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="4768" name="EMB_RSP_REQ" orien="R180" />
        <iomarker fontsize="28" x="4400" y="4816" name="EMB_RSP_DATA(79:0)" orien="R180" />
        <branch name="XLXN_148(79:0)">
            <wire x2="2432" y1="1312" y2="2224" x1="2432" />
            <wire x2="2720" y1="2224" y2="2224" x1="2432" />
            <wire x2="5248" y1="1312" y2="1312" x1="2432" />
            <wire x2="5248" y1="1312" y2="1744" x1="5248" />
            <wire x2="5248" y1="1744" y2="1744" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="2112" y="2032" name="TX_DONE" orien="R0" />
        <branch name="RST">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2656" y="2464" type="branch" />
            <wire x2="2720" y1="2464" y2="2464" x1="2656" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2656" y="2512" type="branch" />
            <wire x2="2720" y1="2512" y2="2512" x1="2656" />
        </branch>
        <branch name="L">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2656" y="2608" type="branch" />
            <wire x2="2720" y1="2608" y2="2608" x1="2656" />
        </branch>
        <branch name="H">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="2656" y="1792" type="branch" />
            <wire x2="2720" y1="1792" y2="1792" x1="2656" />
        </branch>
        <branch name="EMB_TX_DATA(79:0)">
            <wire x2="3280" y1="2560" y2="2560" x1="3232" />
        </branch>
        <branch name="EMB_TX_REQ">
            <wire x2="3280" y1="2512" y2="2512" x1="3232" />
        </branch>
        <iomarker fontsize="28" x="3280" y="2560" name="EMB_TX_DATA(79:0)" orien="R0" />
        <iomarker fontsize="28" x="3280" y="2512" name="EMB_TX_REQ" orien="R0" />
        <branch name="XLXN_163">
            <wire x2="3712" y1="2608" y2="2608" x1="3232" />
            <wire x2="3712" y1="2608" y2="4864" x1="3712" />
            <wire x2="4480" y1="4864" y2="4864" x1="3712" />
        </branch>
        <branch name="XLXN_165">
            <wire x2="3648" y1="2656" y2="2656" x1="3232" />
            <wire x2="3648" y1="2656" y2="4912" x1="3648" />
            <wire x2="4480" y1="4912" y2="4912" x1="3648" />
        </branch>
        <branch name="M5_TX_REQ">
            <wire x2="3280" y1="2704" y2="2704" x1="3232" />
        </branch>
        <branch name="M5_TX_DATA(79:0)">
            <wire x2="3280" y1="2752" y2="2752" x1="3232" />
        </branch>
        <branch name="M5_RSP_RAM_RE">
            <wire x2="3280" y1="2800" y2="2800" x1="3232" />
        </branch>
        <iomarker fontsize="28" x="3280" y="2704" name="M5_TX_REQ" orien="R0" />
        <iomarker fontsize="28" x="3280" y="2752" name="M5_TX_DATA(79:0)" orien="R0" />
        <iomarker fontsize="28" x="3280" y="2800" name="M5_RSP_RAM_RE" orien="R0" />
        <branch name="M5_RSP_REQ">
            <wire x2="4480" y1="4960" y2="4960" x1="4400" />
        </branch>
        <branch name="M5_RSP_DATA(79:0)">
            <wire x2="4480" y1="5008" y2="5008" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="4960" name="M5_RSP_REQ" orien="R180" />
        <iomarker fontsize="28" x="4400" y="5008" name="M5_RSP_DATA(79:0)" orien="R180" />
        <branch name="TXD">
            <wire x2="2000" y1="1888" y2="1888" x1="1904" />
        </branch>
        <iomarker fontsize="28" x="2000" y="1888" name="TXD" orien="R0" />
        <instance x="2720" y="2848" name="XLXI_15" orien="R0">
        </instance>
        <instance x="1520" y="2144" name="XLXI_16" orien="R0">
        </instance>
        <branch name="PANEL_CORRECT_ONE_IM">
            <wire x2="5120" y1="4048" y2="4048" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="4048" name="PANEL_CORRECT_ONE_IM" orien="R0" />
        <branch name="IM_VADRS(3:0)">
            <wire x2="5120" y1="4192" y2="4192" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="4192" name="IM_VADRS(3:0)" orien="R0" />
        <branch name="IM_HADRS(3:0)">
            <wire x2="5120" y1="4240" y2="4240" x1="5056" />
        </branch>
        <iomarker fontsize="28" x="5120" y="4240" name="IM_HADRS(3:0)" orien="R0" />
        <branch name="EXE_EN">
            <wire x2="4480" y1="5056" y2="5056" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="5056" name="EXE_EN" orien="R180" />
        <branch name="OVPX">
            <wire x2="4480" y1="5104" y2="5104" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="5104" name="OVPX" orien="R180" />
        <branch name="PANEL_SEL(3:0)">
            <wire x2="4480" y1="5152" y2="5152" x1="4400" />
        </branch>
        <iomarker fontsize="28" x="4400" y="5152" name="PANEL_SEL(3:0)" orien="R180" />
        <instance x="4480" y="4000" name="XLXI_23" orien="R0">
        </instance>
    </sheet>
</drawing>
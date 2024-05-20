`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// リターン情報の重畳
//
// 2016.02.19 Power1 bit14 : Panel Presence
//
// 2016.06 Modified module name : rtn_mux => rtn_mux_a
//         Added input signals  : "[15:0] rcv_ctrl_radd", "[15:0] rcv_ctrl_rdat"
//                                (Answer for Receiver BD Control Command)
// 2017.03 Modified module name : rtn_mux_a => rtn_mux_b
//                                信号video_timeの作成回路変更
// 2017.10 Modified             : 信号video_timeの作成回路修正
//                                カウンタqvt_thのリセット信号をovpからvpに変更
//

module rtn_mux_lcar_ru (//pn_in, pac_stp, rtn_signal, panel_num, clk,
                power1, power2, //power3, power4, power5, power6, power7, power8, power9,
                temp1, temp2, humid1, humid2, //rcv_ctrl_radd, rcv_ctrl_rdat, d,
                rx_ok, link_on//, ovp
				, ss_ne, tx_clk, tcm_ra, clk25M, tcm_e, tcm_v, tcm_wd, tx_done, frame_alt, //Hasco 2021.11
                dout, tx_en, tx_on);

    input [15:0] power1, power2;//, power3, power4, power5, power6, power7, power8, power9;
    input [15:0] temp1, temp2, humid1, humid2;

    input rx_ok;
    input link_on;
    //input ovp;
	input ss_ne;
	input tx_done;
	input frame_alt;
	
	input tx_clk;			//Hasco 2021.10
	input [8:0] tcm_ra;
	input clk25M;
	input tcm_e;
	input tcm_v;
	input [7:0] tcm_wd;

    output reg [7:0] dout;
    output reg tx_en;
    output tx_on;

    reg [15:0] pwr1, pwr2;//, pwr3, pwr4, pwr5, pwr6, pwr7, pwr8, pwr9;
    reg [15:0] tmp1, tmp2, hmd1, hmd2;

    reg tx_on_1d;

    reg tx_en_a;
    reg rx_ok_1d;

    wire tx_en_oe;

	reg frame_alt_1d, frame_alt_2d;
	reg vsf;	
    always @(posedge clk25M) begin
		frame_alt_1d <= frame_alt;
		frame_alt_2d <= frame_alt_1d;
		vsf 		 <= frame_alt_1d ^ frame_alt_2d;
	end

    always @(posedge clk25M) begin
		if(vsf) begin
			pwr1 <= power1;  
			pwr2 <= power2;
			//pwr3 <= power3;
			//pwr4 <= power4;
			//pwr5 <= power5;
			//pwr6 <= power6;
			//pwr7 <= power7;
			//pwr8 <= power8;
			//pwr9 <= power9;
			tmp1 <= temp1;
			tmp2 <= temp2;
			hmd1 <= humid1;
			hmd2 <= humid2;
			//rcv_radd <= rcv_ctrl_radd;
			//rcv_rdat <= rcv_ctrl_rdat;
		end
    end

	reg[3:0] qa;
	always @(posedge clk25M)begin
		if(~link_on)
			qa <= 0;
		else if(vsf)
			qa <= qa + 1;
	end
	
	reg tx_done_1d, tx_done_2d;
	reg tx_endp;
    always @(posedge clk25M) begin
        tx_done_1d <= tx_done;
        tx_done_2d <= tx_done_1d;
		tx_endp    <= tx_done_2d | tx_done_1d;
    end	
	
	reg ss_ne_1d, ss_ne_2d, sne;
	always @(posedge clk25M)begin
		ss_ne_1d <= ss_ne;
		ss_ne_2d <= ss_ne_1d;
		sne 	 <= ss_ne_2d;
	end
	
	reg sen , sen_1d, sen_2d;
	always @(posedge clk25M)begin
		//if(~link_on | tx_endp | dsen | sne)begin
		if(~link_on | dsen | sne)begin
			sen 	<= 0;
			sen_1d 	<= 0;
			sen_2d 	<= 0;
		end
		else begin
			sen 	<= (qa == 0);
			sen_1d  <= sen;
			sen_2d  <= sen_1d;
		end
	end		

	wire dsen = |qa;	//qa > 0;
	
	wire sen_rst = sen_1d & ~sen_2d;

	reg tcm_e_1d, tcm_e_2d;
	reg tcm_v_1d, tcm_v_2d;
	reg[7:0] tcm_wd_1d, tcm_wd_2d;
	always @(posedge clk25M)begin
		tcm_e_1d  <= tcm_e;
		tcm_e_2d  <= tcm_e_1d;
		
		tcm_v_1d  <= tcm_v;
		tcm_v_2d  <= tcm_v_1d;	

		tcm_wd_1d  <= tcm_wd;
		tcm_wd_2d  <= tcm_wd_1d;			
	end

	wire cmd_rst = tcm_e_1d & ~tcm_e_2d;
	
	//wire ram1_wen = (sen_2d | tcm_v_2d);

	reg ram1_we;
	always @(posedge clk25M) begin 
		//ram1_we <= ram1_wen ? ram1_wen : (ram1_wa < 279) ? 1 : 0;
		//ram1_we <= (ram1_wen & (ram1_wa < 279));
		if(sden)
			ram1_we <= (ram1_wa < 279);
		else if(tcm_e_2d)
			ram1_we <= tcm_v_2d;
		//ram1_we <= (tcm_e_2d & cmd_wren) ? tcm_v_2d : (ram1_wa_rst | (ram1_wa < 279));
	end	

	wire cmd_wren = (ram1_wa < 274);

	//wire ram1_rstp = cmd_rst | sen_rst;
	
	reg[9:0] ram1_wa;	
	always @(posedge clk25M) begin
		if(ram1_wa_rst)
			ram1_wa <= 0;
		//else if(~ram1_wa_end & ram1_we)
		else if(ram1_we)
			ram1_wa <= ram1_wa + 1;
 	end	

	//wire ram1_wae = tcm_v_2d | sen_2d;

	reg ram1_wa_rst;
	always @(posedge clk25M) begin 
		ram1_wa_rst <= cmd_rst | sen_rst;
		//ram1_wa_rst <= (ram1_wa >= 278);
	end		
	
	wire ram1_wa_end = ram1_wa[8] & ram1_wa[4] & ram1_wa[3]; //256+16+8

    //
    function [4:0] sdata;
    input [3:0] sel;
      case(sel)
        4'h0   : sdata = pwr1[15:8];
        4'h1   : sdata = pwr1[7 :0];
        4'h2   : sdata = pwr2[15:8];
        4'h3   : sdata = pwr2[7 :0];
        4'h4   : sdata = tmp1[15:8];
        4'h5   : sdata = tmp1[7 :0];
        4'h6   : sdata = tmp2[15:8];
        4'h7   : sdata = tmp2[7 :0];
        4'h8   : sdata = hmd1[15:8];
        4'h9   : sdata = hmd1[7 :0];
        4'ha   : sdata = hmd2[15:8];
        4'hb   : sdata = hmd2[7 :0];
        4'hc   : sdata = 8'h00;
        4'hd   : sdata = 8'h00;
        4'he   : sdata = 8'h00;
        4'hf   : sdata = 8'h00;
        default: sdata = 8'h00;
      endcase
    endfunction
	
	reg ssd_stp;
	always @(posedge clk25M)begin
		if(tcm_e_1d)
			ssd_stp <= (ram1_wa == 263) & tcm_v_1d;
		else
			ssd_stp <= (ram1_wa == 261);
	end	
	
	wire ram1_wa_endp = (ram1_wa == 279);
	
	reg sden;
	always @(posedge clk25M)begin
		if(ssd_stp)
			sden <= 1;
		else if(ram1_wa_endp)
			sden <= 0;
	end
	
	//wire sden = (ram1_wa > 262 & ram1_wa < 279);
	
	wire[3:0] qra = sden ? (ram1_wa - 263) : 4'hf;
	
    wire[7:0] sens_dat = sdata(qra);
	
	reg[7:0] ram1_di;
	always @(posedge clk25M)begin
		if(tcm_v_2d)		
			ram1_di <= tcm_wd_2d;
		else if(sden)
			ram1_di <= sens_dat;
		else	
			ram1_di <= 8'h00;
	end

	wire[7:0] ram1_rd;
	
	//tcm1
	ram4x256B ram1_inst (
		.clka(clk25M), 
		.wea(ram1_we), 
		.addra(ram1_wa), 
		.dina(ram1_di), 
		.clkb(tx_clk), 
		.addrb({1'b0,tcm_ra}), 
		.doutb(ram1_rd)
		);

	reg ram1_we_1d, ram1_we_2d, ram1_wendp;
	always @(posedge clk25M)begin
		ram1_we_1d  <= ram1_we;
		ram1_we_2d  <= ram1_we_1d;
		ram1_wendp  <= ~ram1_we_1d & ram1_we_2d & ram1_wa_end;
	end

	reg tx_oe;
	always @(posedge clk25M)begin
		if(~link_on | tx_endp | ram1_wa_rst)
			tx_oe <= 0;
		//else if(ram1_wendp)
		else if(ram1_wendp)
			tx_oe <= 1;
	end

	reg tx_oe_1d, tx_oe_2d;
	always @(posedge tx_clk)begin
		tx_oe_1d  <= tx_oe;
		tx_oe_2d  <= tx_oe_1d;
		tx_en     <= tx_oe_2d;
	end	
	
    // rx_ok_1d
    always @(posedge tx_clk) begin
      rx_ok_1d   <= rx_ok;
    end

    // dout_on
    assign dout_on = rx_ok_1d & link_on;
	
    // dout  8bit
    always @(posedge tx_clk) begin
      dout <= dout_on ? ram1_rd : 8'd0;
    end
	
    // tx_on
    assign tx_on = link_on;

endmodule
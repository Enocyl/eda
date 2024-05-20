module flash_ctrl_s25fl (

	clk,
	c_done,
	
	bsm_re,
	rcm_ra,
	rcm_rd,
	
	//ovp,
	frame_alt,
	
    clk_en,
	cs_en,
    sdo,
	
	//rx_v,
	rx_q,
	
	tx_e,
	tx_d,
	tx_v


);

	input       	clk;
	input       	c_done;
	//input 			ovp;
	input 			frame_alt;
	
	input 			bsm_re;					//bitstream RAM read enable
	output 	[9:0]	rcm_ra;					//bs data valid
	input 	[7:0]	rcm_rd;					//bitstream data and command from packet 10 
		
	output  clk_en;							//clk enable
	output  cs_en;							//CS enable
	output  sdo;							//serial data sending to flash
	
	//input 	rx_v;							//serial data readback from flash
	input 	rx_q;							//serial data readback valid

	output reg tx_e;						//pipline data enable
	output reg [7:0] tx_d;					//pipline data sending to upstream(PC or MCU)
	output reg tx_v;						//pipline data valid
        
	
// ST 
//    06 is Write Enable
//    D8 is Sector Erase (64K Bytes)
//    02 is Page Program
//    05 is Read Status Register
//    01 is Write Status Register
//    24 bit address

	//S deselected cycle	
	parameter		FCLK  				= 25;									//MHz
	parameter		TCLK  				= 1000/FCLK;							//ns
	parameter		S_TCD  				= 100;									//ns
	parameter		N  					= FCLK*S_TCD/1000;						//MHz
	parameter		CS_DEP  			= N;									//CS DESELECT ENDPOINT
       	
	//CMD arguments
	parameter		MEMO_WIDTH			= 8-1;									//flash capacity width in sector 
	parameter		SADR_WIDTH			= 24-1;									//old 24 - new 32  send_addr width
	parameter		PAGE_WBYTE			= 256-1;							    //PP write 256B once
	parameter		SDAT_SECTS			= 24-1;									//send data size acount on sector
	parameter		SDAT_WIDTH			= 8-1;									//send data width one byte once
	
	//CMD
	parameter		NORMAL_UPDOWN		= 0;									//standby
	parameter		HEADER_UPDATE		= 1;									//header image update begin at 0x0
	parameter		MTBOOT_UPDATE		= 2;									//multiboot image update
	parameter		GOLDEN_UPDATE		= 3;									//golden image update
	parameter		CHANGE_CONFIG		= 4;									//for Test - Fast read back header 	
	parameter		RDBACK_HEADER		= 5;									//configuration update - write a byte to config register
	parameter		PICKUP_CONFIG		= 6;									//readback configuration 
		
	//phase						
	//GOLDEN_UPDATE_BP: IDLE → WREN → RDSR → WRSR → RDSR → WREN → RDSR → SE → RDSR → [WREN → RDSR → PP → RDSR →]*n → WREN → WRSR → RDSR → IDLE		
	//GOLDEN_UPDATE: 	IDLE → [WREN → RDSR → SE → RDSR]*n → [WREN → RDSR → PP → RDSR →]*n → IDLE		
	//MTBOOT_UPDATE: 	IDLE → [WREN → RDSR → SE → RDSR]*n → [WREN → RDSR → PP → RDSR →]*n → IDLE		
	//HEADER_UPDATE: 	IDLE → [WREN → RDSR → SE → RDSR]*n → [WREN → RDSR → PP → RDSR →]*n → IDLE		
	//CHANGE_CONFIG: 	IDLE → WREN → RDSR → WRSR → RDSR → IDLE	
	//PICKUP_CONFIG:	IDLE → RDSR → IDLE	
	//RDBACK_HEADER:	IDLE → WREN → RDSR → FSRD → RD*256 → IDLE	
	
	//instruction
	parameter       IDLE      			= 0, 
					WREN    			= 1,
					RDSR    			= 2,
					SE    				= 3, 					
					WRSR    			= 4,
					PP    				= 5,
					FSRD				= 6,		
					BE  				= 7;	
	
	parameter       //IDLE_INC      		= 8'h00, 
					WREN_INC    		= 8'h06,
					RDSR_INC    		= 8'h05,
					SE_INC  			= 8'hD8, 					
					WRSR_INC    		= 8'h01,
					PP_INC  			= 8'h02,
					FSRD_INC			= 8'h0B,		
					BE_INC				= 8'hC7;  

	//operation type   						INC ADDR DATA
	//parameter		OP_I     			= 3'b100;								//WREN  BE  RDSR  
	//parameter		OP_IA     			= 3'b110;								//SE  Read 
	//parameter		OP_ID     			= 3'b101;								//WRSR
	//parameter		OP_IAD     			= 3'b111;								//PP
	
	//operation
	parameter      	NOPE_STAY			= 0,
					SEND_INSC      		= 1, 
					SEND_ADDR    		= 2, 
					SEND_DATA    		= 3,
					WAIT_DONE			= 4,
					SEND_DUMB			= 5,
					SEND_CONF			= 6,
					REST_DOWM			= 7;
					//CS_HWAIT    		= 4,
					//WEL_CHECK			= 5,
					//WIP_CHECK			= 6,
					
							//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
							//                    Rcv Processing			      //
							//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
														
	reg	[7:0]  rcm_rd_d1, rcm_rd_d2, rcm_rd_d3, rcm_rd_d4;									//command

	always @(posedge clk) begin
		rcm_rd_d1 <= rcm_rd;
		//rcm_rd_d2 <= rcm_rd_d1;
		//rcm_rd_d3 <= rcm_rd_d2;
		//rcm_rd_d4 <= rcm_rd_d3;
	end
	
	reg[8:0] qc;
	always @(posedge clk) begin
		//if(~c_done | qc_stp | pp_endp)	
		if(~c_done | qc_endp | qc_npp | ~fop)	
			qc <= 0;
		else if(pp_stp)
			qc <= 8;
		//else if(rc_time | rd_time && ~qc_end)
		else if(rc_time | rd_time)
			qc <= qc + 1;
	end

	//wire qc_end   = qc[8] & qc[3] & ~(|instr);						//256+8
	wire qc_end   = qc[8] & qc[3];						//256+8
	wire qc_last  = (qc == 263);
	//wire qc_264p  = qc_last & pp_endp;
	//wire qc_endp  = qc_end & pp_on;			
	wire qc_endp  = qc_end & rest_endp;			
	//wire qc_stp   = ~cen_d3 & cen_d2;
	wire qc_npp  = qc[3] & fop & (instr != PP);
	wire rc_time = ~qc[3] & (instr != PP);
	//wire rd_time = (instr == PP & cnt_sbit == 3) & (qc < 264);
	wire rd_time = (instr == PP & cnt_sbit == 2) & (qc < 264);
	
	reg pp_stp;
	always @(posedge clk) begin
		pp_stp <= (phase == 4'b1010) & rest_endp;
	end	

	//reg[8:0] qc;
	//always @(posedge clk) begin
	//	qc <= qg;
	//end
	
	reg qc_eq0, qc_eq1;
	always @(posedge clk) begin
		qc_eq0 <= (qc == 0);	
		qc_eq1 <= (qc == 1);	
	end
		
	//wire qc_eq0   = (qc == 0);
	//wire qc_lt8   = (qc < 8);
	
	reg qd;
	always @(posedge clk) begin
		if(~c_done | fop_endp)	
			qd <= 1;
		else if(qc_endp)
			qd <= ~qd;
	end
	
	//assign rcm_ra = {qd, qc};
	assign rcm_ra = {1'b0, qc};
	
	reg qc_eq0_d1, qc_eq0_d2, qc_eq0_d3, qc_eq0_d4;
	always @(posedge clk) begin
		qc_eq0_d1 <= qc_eq0;
		qc_eq0_d2 <= qc_eq0_d1;
		qc_eq0_d3 <= qc_eq0_d2;
		qc_eq0_d4 <= qc_eq0_d3;
	end
	
	reg cen, cen_d1, cen_d2, cen_d3;
	always @(posedge clk) begin
		if(~c_done)
			cen <= 0;
		//else if(qc_eq0 & ~fop)
		else if(qc_eq0_d1)
			cen <= rcm_rd[7];
	end
	
	//reg qc_stp;
	always @(posedge clk) begin
		cen_d1 <= cen;
		cen_d2 <= cen_d1;
		cen_d3 <= cen_d2;
	end

	wire cen_stp = cen & ~cen_d1;
	
	//flash operation enable flag
	reg	fop, fop_d1;																																	
	always @(posedge clk) begin
		//if(~c_done | pha_endp)
		if(~c_done)
			fop <= 0;
		//else if(cen_stp)
		//	fop <= 1;
		else 
			fop <= cen;
	end

	always @(posedge clk) begin
		fop_d1 <= fop;
	end
	
	//wire fop_stp  = ~fop_d1 & fop;
	wire fop_stp  = ~cen_d1 & cen;
	wire fop_endp = fop_d1 & ~fop;
	
	reg[3:0] qw;
	always @(posedge clk) begin
		if(~c_done | ~cen)
			qw <= 0;
		else if(qw_on & ~qw_stop)
			qw <= qw + 1;
	end

	wire qw_stop = qw[3];
	//wire qw_on =  (qc >= 2);
	wire qw_on =  (qc >= 3);
	
	reg rm_w1_time, rm_w2_time, rm_w3_time, rm_w4_time, rm_w5_time, rm_w6_time, rm_w7_time, rm_w8_time; 
	always @(posedge clk) begin
		//rm_w1_time <= qc_stp;
		//rm_w1_time <= qc_eq0;
		rm_w1_time <= qc_eq0_d1;
		//rm_w2_time <= rm_w1_time;
		rm_w2_time <= (qw == 0);
		//rm_w3_time <= rm_w2_time;
		rm_w3_time <= (qw == 1);
		//rm_w4_time <= rm_w3_time;
		rm_w4_time <= (qw == 2);
		//rm_w5_time <= rm_w4_time;
		rm_w5_time <= (qw == 3);
		//rm_w6_time <= rm_w5_time;
		rm_w6_time <= (qw == 4);
		//rm_w7_time <= rm_w6_time;
		rm_w7_time <= (qw == 5);
		//rm_w8_time <= rm_w7_time;
		rm_w8_time <= (qw == 6);
	end

	//reg bsd_time;
	//always @(posedge clk) begin
	//	bsd_time <= rd_time;
	//end
	
	//reg bsdat_time;
	//always @(posedge clk) begin
	//	if(bsd_stp)
	//		bsdat_time <= 1;
	//	else if(qc_endp)
	//		bsdat_time <= 0;
	//end
	//
	//wire bsd_stp = rm_w8_time;
	
	reg	[3:0]  	cmd;				//command																//cmd enable
	reg 		cmd_en;
	reg 		bsd_en;					//bitstream data valid
	reg 		newp;
	reg	[23:0] 	adda;			//address or config data													//address begin to update
	reg [7:0]  	adda_w1;
	reg [7:0]  	adda_w2;
	reg [7:0]  	adda_w3;
	reg	[7:0]  	sects;														//bitstream size in sector
	reg [7:0]  	bs_dat;
	
	always @(posedge clk) begin
		if(~c_done | ~fop)begin
		//if(~c_done | fop_stp)begin
			cmd_en  <= 0;
			bsd_en  <= 0;
			newp	<= 0;
			cmd     <= NORMAL_UPDOWN;
			sects   <= 0;
			//bs_dat  <= 8'hff;
		end
		else if(rm_w1_time)begin
			cmd_en  <= rcm_rd_d1[7];
			bsd_en  <= rcm_rd_d1[5];
			newp    <= rcm_rd_d1[4];
			cmd		<= rcm_rd_d1[3:0];
		end
		else if(rm_w3_time)
			sects	<= rcm_rd_d1;								//24bit adda begin from 0x??0000
			//sects	<= rcm_rd_d1 - 1;								//24bit adda begin from 0x??0000
		//else if(rd_time)
		////else if(bsd_time)
		//	bs_dat  <= rcm_rd_d1;
	end

	always @(posedge clk) begin
		if(~c_done | ~fop)
			bs_dat  <= 8'hff;
		else
			bs_dat  <= rcm_rd_d1;
	end	
	
	//address
	always @(posedge clk) begin
		if(rm_w4_time)
			adda_w1 <= rcm_rd_d1[7:0];
		else if(rm_w5_time)
			adda_w2 <= rcm_rd_d1[7:0];
		else if(rm_w6_time)
			adda_w3 <= rcm_rd_d1[7:0];
	end

	//address
	always @(posedge clk) begin
		if(rm_w7_time & ~qb | erz_endp)
			adda <= {adda_w1,adda_w2,adda_w3};
		//else if(se_endp)
		else if(insc_sendp & instr == SE)
			//adda <= adda + {cnt_sect, 16'h0000};	
			adda <= {adda_w1,adda_w2,adda_w3} + {cnt_sect, 16'h0000};	
		else if(pp_endp)
			adda <= adda + 24'h000100;
	end
	
	reg frame_alt_d1, frame_alt_d2;
	reg ovp, ovp1, ovp2, ovp3;	
	always @(posedge clk) begin
		frame_alt_d1 <= frame_alt;
		frame_alt_d2 <= frame_alt_d1;
				//ovp  <= ~frame_alt_d2 & frame_alt_d1;
				ovp  <= frame_alt_d1 ^ frame_alt_d2;
				ovp1 <= ovp;
				ovp2 <= ovp1;
				ovp3 <= ovp2;
	end
	
	//reg	[2:0] cnt_ovp;	
	//always @(posedge clk) begin
	//	if(~c_done | fop_stp)
	//		cnt_ovp <= 0;
	//	else if(ovp & ~cnt_ovp_stop)
	//		cnt_ovp <= cnt_ovp + 1;
	//end
	
	//wire cnt_ovp_stop = cnt_ovp[2];											//after 4 checkout frame, flash operation enable
	
	//cnt_insc  8bit instruction code acount
	reg	[2:0] cnt_insc;
	wire cnt_insc_plus = (op == SEND_INSC);
	always @(posedge clk) begin
		if(~c_done | ~cnt_insc_plus)
			cnt_insc <= 0;
		else if(cnt_insc_plus)	
			cnt_insc <= cnt_insc + 1;
	end	
	
	wire insc_sendp = &cnt_insc;				//instruction code send endpoint
	
	//cnt_addr  5bit length 24
	reg	[4:0] cnt_addr;
	wire cnt_addr_plus = (op == SEND_ADDR);
	always @(posedge clk) begin
		if(~c_done | ~cnt_addr_plus)
			cnt_addr <= 8;
		else if(cnt_addr_plus)	
			cnt_addr <= cnt_addr + 1;
	end	
	
	wire addr_sendp	= &cnt_addr;

	//cnt_sbit  3bit  0 ~ 7 
	reg	[2:0] cnt_sbit;
	wire cnt_sbit_plus = (op == SEND_DATA | op == SEND_DUMB);
	always @(posedge clk) begin
		if(~c_done | ~cnt_sbit_plus)
			cnt_sbit <= 0;
		else if(cnt_sbit_plus)	
			cnt_sbit <= cnt_sbit + 1;
	end	
	
	wire bit_eq8 = &cnt_sbit;
	
	//cnt_sbyt  8bit  0 ~ 255 
	reg	[7:0] cnt_sbyt;
	wire cnt_sbyt_plus = (op == SEND_DATA & bit_eq8);
	wire cnt_sbyt_end  = ~(op == SEND_DATA);
	always @(posedge clk) begin
		if(~c_done | cnt_sbyt_end)
			cnt_sbyt <= 0;
		else if(cnt_sbyt_plus)	
			cnt_sbyt <= cnt_sbyt + 1;
	end	
		
	wire byt_eq256 = &cnt_sbyt;

	//cnt_page  8bit  0 ~ 255 
	reg	[7:0] cnt_page;
	//wire cnt_page_plus =  (op == WAIT_DONE & byt_eq256);
	//wire cnt_page_end  = ~(op == WAIT_DONE);
	always @(posedge clk) begin
		//if(~c_done | fop_stp)
		if(~c_done | ~fop)
			cnt_page <= 0;
		else if(pp_endp)	
			cnt_page <= cnt_page + 1;
	end	
	
	wire pg_eq256 = &cnt_page;
	
	wire pg_endp = pg_eq256 & pp_endp;

	//cnt_sect  sectors or blocks erased or written acount
	reg	[MEMO_WIDTH:0] cnt_sect;	
	always @(posedge clk) begin
		//if(~c_done | erz_endp | fop_stp)
		if(~c_done | erz_endp | ~fop)
			cnt_sect <= 0;
		else if(se_endp | pg_endp && ~sect_stop)	
			cnt_sect <= cnt_sect + 1;
	end	

	//cnt_rest  4bit  CS deselected cycle
	reg	[3:0] cnt_rest;
	wire cnt_rest_plus = (op == REST_DOWM & cnt_rest < CS_DEP);
	always @(posedge clk) begin
		if(~c_done | ~cnt_rest_plus)
			cnt_rest <= 0;
		else if(cnt_rest_plus)	
			cnt_rest <= cnt_rest + 1;
	end

	//wire rest_endp	= (cnt_rest == CS_DEP) | idle_endp;
	wire rest_endp = (cnt_rest == CS_DEP);
	
	wire idle_mid = ~(|qa) & (|cmd) & qe_end;	//Not occur in initial RDSR for CMD reset purpose
	
	//wire idle_end = qb & bsm_re | ~qb;
	wire idle_end = qb & pp_on | ~qb;
	
	wire ini_rst = fop & ~qe_end;
	
	//reg idle_midp;
	//always @(posedge clk) begin
	//	idle_midp <= idle_mid & idle_end;
	//end
	wire idle_midp = idle_mid & idle_end;

	reg bsm_re_d1, bsm_re_d2;
	//reg bsm_re_stp;
	//always @(posedge clk) begin
	//	if(ovp) begin
	//		bsm_re_d1  <= bsm_re;
	//		bsm_re_d2  <= bsm_re_d1;
	//		//bsm_re_stp <= bsm_re & ~bsm_re_d1;
	//	end
	//end
	
	reg pp_on_a;
	reg pp_on;
	always @(posedge clk) begin
		//if(bsm_re_stp)
		//	pp_on <= 1;
		//else if(qc_endp | ini_rst)
		//	pp_on <= 0;
		//pp_on_a <= bsm_re_d1 & ~bsm_re_d2;
		//pp_on   <= pp_on_a & ovp2;
		bsm_re_d1  <= bsm_re;
		bsm_re_d2  <= bsm_re_d1;
		pp_on      <= bsm_re_d1 & ~bsm_re_d2;
	end						
	//wire idle_endp  = ~(|qa) & (|cmd) & qe[0];
	//wire idle_rst	= phase

	reg[1:0] qe;
	always @(posedge clk) begin
		//if(fop_stp)
		if(~fop)
			qe <= 0;
		else if(fop & rest_endp & ~qe_end)
			qe <= qe + 1;
	end
	
	wire qe_end = qe[0];
	
	//qa    instruction acount
	reg	[2:0]  qa;																			
	always @(posedge clk) begin
		//if(~c_done | qa_endp | fop_stp)
		if(~c_done | qa_endp | ~fop)
			qa <= 0;
		//else if(mid_idle | rest_endp & ~sect_stop)	
		//else if(idle_endp | rest_endp & ~sect_stop)	
		else if(idle_midp | rest_endp && ~sect_stop)	
			qa <= qa + 1;
	end
	
	wire qa_endp = qa[2] & rest_endp & (cmd < 4) & ~sect_stop;		//qa < 5 but not update
	
	//wire qa_stop = burn_endp;
	
	////mid_bstr  a bootstrap pulse make update cycle go on 
	//reg mid_idle;
	//always @(posedge clk) begin
	//	mid_idle <= qa_endp;
	//end
	
	//qb    phase acount 
	reg qb;																																					
	always @(posedge clk) begin
		//if(~c_done | fop_stp)
		if(~c_done | ~fop)
			qb <= 0;
		else if(erz_endp)	
			qb <= 1;
	end

	//wel_S WEL set
	reg wel, wel_d1, wel_S;
	//wip_Z WIP reset
	reg wip, wip_d1, wip_Z;
	always @(posedge clk) begin
		wel 	<= rxd[1];
		wel_d1 	<= wel;
		//wel_S 	<= ~wel_d1 & wel;
		wel_S 	<= wel & ~wip;
		
		wip 	<= rxd[0];
		wip_d1 	<= wip;
		wip_Z  	<= ini_rst ? ~wip : wip_d1 & ~wip;
	end

	//SE done
	//wire wren_endp = (instr == WREN & insc_sendp);
	//rdsr_endp   
	//WIP: 0 write in process 1 write process finished   WEL: 1 WREN commited
    //waiting for WEL Enable or WIP Reset, otherwise additional operation is make nonsense 	
	//wire rdsr_endp = (instr == RDSR & op == WAIT_DONE & (wel_S | wip_Z));
	//wire rdsr_endp = (wel_S | wip_Z) & (instr == RDSR);

	wire rdsr_endp = wel_S | wip_Z && rbyt_rdy_d3;
	
    //se_endp 	asserted while WIP low down 	
	wire se_endp   = (instr == SE & op == SEND_ADDR & addr_sendp);
	//wire se_endp   = (cmd < 4 & ~phase[3] & phase[2] & rest_endp);
	//wire se_endp   = (cmd < 4 & ~phase[3] & phase[2] & rdsr_endp);
	//pp_endp 	
	//wire pp_endp   = (cmd < 4 & phase[3]  & phase[2] & rest_endp);
	//wire pp_endp   = phase[3]  & phase[2] & rest_endp;
	wire pp_endp   = byt_eq256 & bit_eq8;
	//wire wrsr_endp = (instr == WRSR & op == SEND_DATA & bit_eq8);						//for test
	//wire be_endp   = (instr == BE   & insc_sendp);
	
	//rest_endp  any instruction finished
	//wire rest_endp = wren_endp | rdsr_endp | se_endp | wrsr_endp | pp_endp | fsrd_endp | be_endp; 
	//wire instr_endp = (op == REST_DOWM & rest_endp); 

	//erase  SE*n instructions finished
	//wire sect_stop = (cnt_sect > sects);
	wire sect_last = (cnt_sect == sects);
	//wire sect_endp = sect_last & rest_endp;
	//wire erz_endp = sect_last & se_endp;
	wire erz_endp = sect_last & ~qb & qa[2] & rest_endp;

	//wire update_endp = qb & qa[2] & rest_endp & sect_last;		//RU 
	//wire update_endp = sect_stop & ~bsd_en;		//RU 
	wire update_endp = sect_last & cmd_w8_time;		//RU 
	wire nru_endp    = phase[2] & rest_endp & (cmd > 3);		//not RU

	reg sect_stop;
	always @(posedge clk) begin
		if(~c_done | ~fop)
			sect_stop <= 0;
		else if(update_endp)
			sect_stop <= 1;
	end
	
	reg pha_endp;
	always @(posedge clk) begin
		pha_endp <= update_endp | nru_endp;
	end	

	//reg pp_on_a1, pp_on_a2, pp_on;
	//always @(posedge clk) begin
	//	pp_on_a1 <= pp_on_a;
	//	pp_on_a2 <= pp_on_a1;
	//	pp_on 	 <= pp_on_a1 & ~pp_on_a2;
	//end
	//wire pp_on = bsm_re & bsd_en & newp;
	
	//update_end  PP*n instructions fninished
	wire update_end = sect_stop;	
	
	wire[3:0] phase = cmd < 5 ? {qb, qa} : {qb, qa[0], 2'b00};
	
	reg [3:0] instr;																				//Write Enable Latch	
	//instr fsm
	always @(posedge clk) begin
		if(~c_done | ~fop)
			instr <= IDLE;
		//[→ IDLE → WREN → RDSR → SE → RDSR →]*n → [→ WREN → RDSR → PP → RDSR → IDLE]*n
		else if(cmd == HEADER_UPDATE | cmd == MTBOOT_UPDATE | cmd == GOLDEN_UPDATE) begin
			casez(phase)
				4'b0_000: //instr <= WREN;
					begin
						if(ini_rst & ~rest_endp)
							instr <= RDSR;
						else if(ini_rst & rest_endp | fop)
							instr <= WREN;
						////else if(~update_end & fop)
						//else if(fop)
						//	instr <= WREN;
						else
							instr <= IDLE;
					end
				4'b1_000: //instr <= WREN;
					begin
						if(~update_end & fop & pp_on)
							instr <= WREN;
						else
							instr <= IDLE;
					end					
				4'b?_001:
					begin
						if(rest_endp)
							instr <= RDSR;
						else
							instr <= WREN;
					end				
				4'b0_010:
					begin
						if(rest_endp)
							instr <= SE;
						else
							instr <= RDSR;
					end
				4'b1_010:
					begin
						//if(instr == RDSR & rest_endp & pp_on)
						if(rest_endp)
							instr <= PP;
						//else if(instr == RDSR & rest_endp)
						//	instr <= IDLE;
						else
							instr <= RDSR; 
					end				
				4'b0_011:
					begin
						if(rest_endp)
							instr <= RDSR;
						else
							instr <= SE;
					end
				4'b1_011:
					begin
						if(rest_endp)
							instr <= RDSR;
						//else if(instr == IDLE & pp_on)
						else
							instr <= PP;
						//else if(instr == IDLE)
						//	instr <= IDLE;							
					end				
				4'b?_100:
					begin
						if(rest_endp)
							instr <= IDLE;			//idle 1 cycle when two phase end 
						else
							instr <= RDSR;
					end
				default: instr <= IDLE;
			endcase			
		end	
		//CHANGE_CONFIG: 	IDLE → WREN → RDSR → WRSR → RDSR → IDLE
		else if(cmd == CHANGE_CONFIG) begin
			case(phase)
				4'b0_000: //instr <= WREN;
					begin
						if(ini_rst & ~rest_endp)
							instr <= RDSR;
						else if(ini_rst & rest_endp)
							instr <= WREN;
						else
							instr <= IDLE;
					end
				4'b0_001:
					begin
						if(rest_endp)
							instr <= RDSR;
						else
							instr <= WREN;
					end				
				4'b0_010:
					begin
						if(rest_endp)
							instr <= WRSR;
						else
							instr <= RDSR;
					end				
				4'b0_011:
					begin
						if(rest_endp)
							instr <= RDSR;
						else
							instr <= WRSR;
					end			
				4'b0_100:
					begin
						if(rest_endp)
							instr <= IDLE;			 
						else
							instr <= RDSR;
					end
				default: instr <= IDLE;
			endcase
		end		
		//RDBACK_HEADER:	IDLE → FSRD → IDLE		
		else if(cmd == RDBACK_HEADER) begin
			case(phase)
				4'b0_000: //instr <= FSRD;
					begin
						if(ini_rst & ~rest_endp)
							instr <= RDSR;
						else if(ini_rst & rest_endp)
							instr <= FSRD;
						else
							instr <= IDLE;
					end
				4'b0_100:
					begin
						if(rest_endp)
							instr <= IDLE;
						else
							instr <= FSRD;
					end				
				default: instr <= IDLE;
			endcase
		end	
		//PICKUP_CONFIG:	IDLE → RDSR → IDLE	
		else if(cmd == PICKUP_CONFIG) begin
			case(phase)
				4'b0_000: //instr <= RDSR;
					begin
						if(fop)
							instr <= RDSR;
						else
							instr <= IDLE;
					end
				4'b0_100:
					begin
						if(rest_endp)
							instr <= IDLE;
						else
							instr <= RDSR;
					end				
				default: instr <= IDLE;
			endcase		
		end			
	end
	
	//op fsm
	reg	[3:0] op;						//operation	
	//reg	[7:0] insc;						//instruction code
	//reg [SADR_WIDTH:0] sadr;			//sending address
	reg [23:0] sdat_a;
	reg clk_en_a;
	reg cs_en_a;
	
	always @(posedge clk) begin
		if(~c_done | ~fop) begin
			op 			<= NOPE_STAY;
			clk_en_a 	<= 0;
			cs_en_a		<= 0;
			sdat_a 		<= 24'hffffff;
			//re_a		<= 0;
		end
		else if(instr == WREN) begin
			//re_a <= 0;
			case(op)
				NOPE_STAY:
					begin
						op 			<= SEND_INSC;
						clk_en_a 	<= 1;
						cs_en_a		<= 1;
						sdat_a 		<= {16'd0, WREN_INC};
					end
					//op <= SEND_INSC;
				SEND_INSC:
					begin
						if(insc_sendp)begin
							op 			<= REST_DOWM;
							clk_en_a 	<= 0;
							cs_en_a		<= 0;
							sdat_a 		<= 24'hffffff;							
						end
						else
							op <= SEND_INSC;
					end
				REST_DOWM:
					begin
						if(rest_endp)
							op <= NOPE_STAY;							
						else
							op <= REST_DOWM;
					end
				default: op <= NOPE_STAY;
			endcase
		end
		else if(instr == RDSR) begin
			case(op)
				NOPE_STAY:
					begin
						op 			<= SEND_INSC;
						clk_en_a 	<= 1;
						cs_en_a		<= 1;
						sdat_a 		<= {16'd0, RDSR_INC};
						//re_a		<= 0;						
					end
				SEND_INSC:
					begin
						if(insc_sendp)begin
							op 			<= WAIT_DONE;
							clk_en_a 	<= 1;
							cs_en_a		<= 1;							
							sdat_a 		<= 24'hffffff;
						end
						else
							op <= SEND_INSC;
					end
				WAIT_DONE:
					begin
						if(rdsr_endp)begin
							op 			<= REST_DOWM;
							clk_en_a 	<= 0;
							cs_en_a		<= 0;
							sdat_a 		<= 24'hffffff;	
						end
						else
							op <= WAIT_DONE;
					end
				REST_DOWM:
					begin
						if(rest_endp)
							op <= NOPE_STAY;
						else
							op <= REST_DOWM;
					end
				default: op <= NOPE_STAY;
			endcase
		end
		else if(instr == SE) begin
			case(op)
				NOPE_STAY:
					begin
						op 			<= SEND_INSC;
						clk_en_a 	<= 1;
						cs_en_a		<= 1;
						sdat_a 		<= {16'd0, SE_INC};					
					end
				SEND_INSC:
					begin
						if(insc_sendp)begin
							op 			<= SEND_ADDR;
							clk_en_a 	<= 1;
							cs_en_a		<= 1;
							//sdat_a 		<= {adda, 8'd0};																	
							sdat_a 		<= adda;																	
						end
						else
							op <= SEND_INSC;
					end
				SEND_ADDR:
					begin
						if(addr_sendp)begin
							op 			<= REST_DOWM;
							clk_en_a 	<= 0;
							cs_en_a		<= 0;
							sdat_a 		<= 24'hffffff;		
						end
						else
							op <= SEND_ADDR;
					end
				REST_DOWM:
					begin
						if(rest_endp)
							op <= NOPE_STAY;
						else
							op <= REST_DOWM;
					end
				default: op <= NOPE_STAY;
			endcase
		end	
		else if(instr == WRSR) begin
			case(op)
				NOPE_STAY:
					begin
						op 			<= SEND_INSC;
						clk_en_a 	<= 1;
						cs_en_a		<= 1;
						sdat_a 		<= {16'd0, WRSR_INC};					
					end
				SEND_INSC:
					begin
						if(insc_sendp)begin
							op 			<= SEND_DATA;
							clk_en_a 	<= 1;
							cs_en_a		<= 1;
							//sdat_a 		<= {adda, 8'd0};
							sdat_a 		<= adda;
						end
						else
							op <= SEND_INSC;
					end
				SEND_CONF:
					begin
						if(bit_eq8)begin
							op 			<= REST_DOWM;
							clk_en_a 	<= 0;
							cs_en_a		<= 0;
							sdat_a 		<= 24'hffffff;
						end
						else
							op <= SEND_DATA;
					end				
				REST_DOWM:
					begin
						if(rest_endp)
							op <= NOPE_STAY;
						else
							op <= REST_DOWM;
					end
				default: op <= NOPE_STAY;
			endcase
		end		
		else if(instr == PP) begin
			case(op)
				NOPE_STAY:
					begin
						op 			<= SEND_INSC;
						clk_en_a 	<= 1;
						cs_en_a		<= 1;
						sdat_a 		<= {16'd0, PP_INC};					
					end
				SEND_INSC:
					begin
						if(insc_sendp)begin
							op 			<= SEND_ADDR;
							clk_en_a 	<= 1;
							cs_en_a		<= 1;
							//sdat_a 		<= {adda, 8'd0};																	
							sdat_a 		<= adda;																	
						end
						else
							op <= SEND_INSC;
					end
				SEND_ADDR:
					begin
						if(addr_sendp)begin
							op 			<= SEND_DATA;
							clk_en_a 	<= 1;
							cs_en_a		<= 1;
							sdat_a 		<= {16'd0, bs_dat};																	
						end							
						else
							op <= SEND_ADDR;
					end
				SEND_DATA:
					begin
						if(pp_endp)begin
							op 			<= REST_DOWM;
							clk_en_a 	<= 0;
							cs_en_a		<= 0;
							sdat_a 		<= 24'hffffff;																	
						end							
						else begin
							op 			<= SEND_DATA;
							clk_en_a 	<= 1;
							cs_en_a		<= 1;
							//if(bit_eq8)
								//sdat_a  <= {16'd0, bs_dat};
							sdat_a  <= {16'd0, bs_dat};
						end
					end				
				REST_DOWM:
					begin
						if(rest_endp)
							op <= NOPE_STAY;
						else
							op <= REST_DOWM;
					end
				default: op <= NOPE_STAY;
			endcase
		end	
		else if(instr == FSRD) begin
			case(op)
				NOPE_STAY:
					begin
						op 			<= SEND_INSC;
						clk_en_a 	<= 1;
						cs_en_a		<= 1;
						sdat_a 		<= {16'd0, FSRD_INC};					
					end
				SEND_INSC:
					begin
						if(insc_sendp)begin
							op 			<= SEND_ADDR;
							clk_en_a 	<= 1;
							cs_en_a		<= 1;
							//sdat_a 		<= {adda, 8'd0};																	
							sdat_a 		<= adda;																	
						end
						else
							op <= SEND_INSC;
					end
				SEND_ADDR:
					begin
						if(addr_sendp)begin
							op 			<= SEND_DUMB;
							clk_en_a 	<= 1;
							cs_en_a		<= 1;
							sdat_a 		<= 24'hffffff;					//Dummy Byte																
						end
						else
							op <= SEND_ADDR;
					end
				SEND_DUMB:
					begin
						if(bit_eq8)begin
							op 			<= WAIT_DONE;
							clk_en_a 	<= 1;
							cs_en_a		<= 1;							
							sdat_a 		<= 24'hffffff;
						end
						else
							op <= SEND_DUMB;
					end	
				WAIT_DONE:
					begin
						if(fsrd_endp)begin						//Only Get Header Out
							op 			<= REST_DOWM;
							clk_en_a 	<= 0;
							cs_en_a		<= 0;
							sdat_a 		<= 24'hffffff;																	
						end
						else
							op <= WAIT_DONE;
					end
				REST_DOWM:
					begin
						if(rest_endp)
							op <= NOPE_STAY;
						else
							op <= REST_DOWM;
					end
				default: op <= NOPE_STAY;
			endcase
		end		
		else if(instr == BE) begin
			case(op)
				NOPE_STAY:
					begin
						op 		 <= SEND_INSC;
						clk_en_a <= 1;
						cs_en_a	 <= 1;
						sdat_a 	 <= {16'd0, BE_INC};					
					end
				SEND_INSC:
					begin
						if(insc_sendp)begin						//Only Get Header Out
							op 		 <= REST_DOWM;
							clk_en_a <= 0;
							cs_en_a	 <= 0;
							sdat_a 	 <= 24'hffffff;																
						end
						else
							op <= SEND_INSC;
					end
				REST_DOWM:
					begin
						if(rest_endp)
							op <= NOPE_STAY;
						else
							op <= REST_DOWM;
					end
				default: op <= NOPE_STAY;				
			endcase
		end
	end

	//rcm_ra
	
	//clk_en,cs_en,sdo
	reg clk_en_pre, clk_en;
	reg cs_en_pre, cs_en;
	reg[23:0] sdat_pre;
	reg[23:0] sdat;
	
	always @(posedge clk) begin
		clk_en_pre 	<= clk_en_a;			//CS 1 cycle enable ahead CLK
		clk_en 		<= clk_en_pre;
		//clk_en 		<= clk_en_a;
		//cs_en_pre  	<= cs_en_a | ~(|op) & (|qa);
		//cs_en  		<= cs_en_a | ~(|op) & (|qa);
		//cs_en  		<= cs_en_a | ~(|instr) & fop;
		cs_en_pre  	<= cs_en_a;
		cs_en  		<= cs_en_pre;		
		//cs_en  		<= cs_en_a;		
		//sdat_pre   	<= sdat_a;
		//sdat   		<= sdat_pre;		
		sdat   		<= sdat_a;
	end
	
	//assign clk_en = clk_en_a;
	//assign cs_en  = cs_en_a;
	//assign sdat   = sdat_a;
	
	reg[3:0] op_d1;
	always @(posedge clk) begin
		op_d1 <= op;	
	end
	
	reg [2:0]  cnt_insc_d1;
	reg [4:0]  cnt_addr_d1;
	reg [2:0]  cnt_sbit_d1;
	always @(posedge clk) begin
		cnt_insc_d1	<= cnt_insc;
	    cnt_addr_d1 <= cnt_addr;
	    cnt_sbit_d1 <= cnt_sbit;
	end
	
	//obit  the count of shifting bit  for sending data	
	reg[4:0] obit;
	always @(posedge clk) begin
		//case(op_d1)
		case(op)
			//SEND_INSC: obit <= {2'b0, ~cnt_insc_d1};
			//SEND_ADDR: obit <= ~cnt_addr_d1;
			//SEND_DUMB: obit <= {2'd0, ~cnt_sbit_d1};
			//SEND_DATA: obit <= {2'd0, ~cnt_sbit_d1};
			//SEND_CONF: obit <= ~cnt_addr_d1;
			SEND_INSC: obit <= {2'b0, ~cnt_insc};
			SEND_ADDR: obit <= ~cnt_addr;
			SEND_DUMB: obit <= {2'd0, ~cnt_sbit};
			SEND_DATA: obit <= {2'd0, ~cnt_sbit};
			SEND_CONF: obit <= ~cnt_addr;			
			default:   obit <= 5'd0;
		endcase
	end
			
	assign sdo = sdat[obit];
		
								//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
								//			        TX  Processing				      //
								//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
	
	reg rv_d1, rv_d2, rv_d3;//, rbit_stp;

	//wire rv = qa[2] & (op == WAIT_DONE);
	wire rv = (op == WAIT_DONE);
	
    always @(posedge clk) begin
		rv_d1 	 <= rv;
		rv_d2 	 <= rv_d1;
		rv_d3 	 <= rv_d2;
	end	

	wire fsrd_endp = (instr == FSRD & rv & rbyt_eq256);	
	
	wire rbit_stp = ~rv_d2 & rv_d1;		//rbit starting point
	reg rbit_stp_d1, rbit_stp_d2, rbit_stp_d3, rbit_stp_d4;
	always @(posedge clk) begin
		rbit_stp_d1 <= rbit_stp;
		rbit_stp_d2 <= rbit_stp_d1;
		rbit_stp_d3 <= rbit_stp_d2;
		rbit_stp_d4 <= rbit_stp_d3;		
	end
	
	//cnt_rbit  receive data s2p
	reg [2:0] cnt_rbit;
    always @(posedge clk) begin
		if(~c_done | rbit_stp)
			cnt_rbit <= 0;
		else if(rv_d2)
			cnt_rbit <= cnt_rbit + 1;
	end

	reg  rbyt_rdy;
	always @(posedge clk) begin
		rbyt_rdy <= &cnt_rbit;				//rxd renew point	
	end

	parameter WTXD = 9;				//256	
	//cnt_rbyt  8bit  0 ~ 255 
	reg	[WTXD-1:0] cnt_rbyt;
	wire cnt_rbyt_plus = rv & rbyt_rdy & phase[2];
	//wire cnt_rbyt_end  = ~rv;
	always @(posedge clk) begin
		//if(~c_done | fop_stp)
		if(~c_done | ~fop)
			cnt_rbyt <= 0;
		else if(cnt_rbyt_plus)	
			cnt_rbyt <= cnt_rbyt + 1;
	end

	wire rbyt_eq256 = cnt_rbyt[8];	
	//wire rbyt_eq256 = cnt_rbyt[8] & cnt_rbyt[0];	
	 
    wire[2:0] ibit = ~cnt_rbit;
	
	reg [7:0] rdo;
	reg [7:0] rxd;
    always @(posedge clk) begin
		//if(~c_done)
		//	rdo <= 8'h00;
		//else if(rv_d2)
		if(rv_d2)
			rdo[ibit] <= rx_q;
	end

    always @(posedge clk) begin
		//if(~c_done)
		//if(~c_done | ~rv_d3)
		//	rxd <= 8'hff;
		//else if(rv_d3 & rbyt_rdy)
		if(rv_d3 & rbyt_rdy)
			rxd <= rdo;
	end	

	//tbd  1: return data - 2: return state
	reg tbd;
	always @(posedge clk) begin
		if(cmd == 5)
			tbd <= 1;
		else
			tbd <= 0;
	end

	reg [3:0] cmd_d1;
	reg [3:0] cmd_sta_d1;										//Return Command status
	reg [7:0] cnt_sect_d1;
	reg [7:0] adda_w1_d1;
	reg [7:0] adda_w2_d1;
	reg [7:0] adda_w3_d1;
	
	wire cmding = ~pha_endp;
	
	reg npac;
	always @(posedge clk) begin
		if(~c_done | ~cen | cmd_w8_time)
			npac <= 0;
		else if(qc_endp)
			npac <= 1;
	end
	
	//wire cmd_sta = {pha_on, phase[3], tbd, 1'b0};
	//wire[3:0] cmd_sta = {cmding, qb, tbd, 1'b0};
	wire[3:0] cmd_sta = {cmding, qb, tbd, npac};
											
	always @(posedge clk) begin
		//if(rbit_stp_d1)begin
		if(rbit_stp)begin
			cmd_d1 		<= cmd;
			cmd_sta_d1  <= cmd_sta;		
			cnt_sect_d1 <= cnt_sect;
			adda_w1_d1  <= adda[23:16];
			adda_w2_d1  <= adda[15:8];
			adda_w3_d1  <= adda[7:0];
		end
		//cmd_d1 		<= rbit_stp_d1 ? cmd 	 : cmd_d1;	
		//cmd_sta_d1  <= rbit_stp_d1 ? cmd_sta : cmd_sta_d1;		
		//cnt_sect_d1 <= rbit_stp_d1 ? cnt_sect: cnt_sect_d1;
	end
	
	reg rbyt_rdy_d1, rbyt_rdy_d2, rbyt_rdy_d3;
	always @(posedge clk) begin
		rbyt_rdy_d1 <= rbyt_rdy;
		rbyt_rdy_d2 <= rbyt_rdy_d1;
		rbyt_rdy_d3 <= rbyt_rdy_d2;
	end
	
	reg cmd_w1_time, cmd_w2_time, cmd_w3_time, cmd_w4_time, cmd_w5_time, cmd_w6_time, cmd_w7_time, cmd_w8_time;
	
	wire txc_stp = wip_Z & qa[2];
	
	//reg txd_time;
	always @(posedge clk) begin
		//cmd_w1_time <= rbit_stp_d1;				//place_holdler
		cmd_w1_time <= (cmd == 5) ? rbit_stp_d1 : txc_stp;				//place_holdler
		//cmd_w1_time <= (cmd == 5) ? rbit_stp : txc_stp;				//place_holdler
		cmd_w2_time <= cmd_w1_time;
		cmd_w3_time <= cmd_w2_time;
		cmd_w4_time <= cmd_w3_time;
		cmd_w5_time <= cmd_w4_time;
		cmd_w6_time <= cmd_w5_time;
		cmd_w7_time <= cmd_w6_time;
		cmd_w8_time <= cmd_w7_time;
		//txd_time    <= rbyt_rdy_d1;
	end
	
	wire cmd_time = cmd_w1_time |
	     			cmd_w2_time |
	     			cmd_w3_time |
	     			cmd_w4_time |
	     			cmd_w5_time |
	     			cmd_w6_time |
	     			cmd_w7_time |
	     			cmd_w8_time; 

	//wire rxd_tp = rbyt_rdy_d1 & (cmd == 5);
	//wire txc_tp = qa[2] & rbyt_rdy_d1 & (cmd != 5);
	//wire txc_tp = qa[2] & wip_Z & (cmd != 5);
	//wire txc_tp = ~qb & qa[2] & wip_Z & (cmd != 5);
	
	//wire txd_time = rxd_tp | txc_tp;
	wire txd_time = rbyt_rdy_d1 & (cmd == 5);
	//always @(posedge clk) begin
	//	txd_time <= rxd_tp | txc_tp;
	//end

	//tx_e;
	always @(posedge clk) begin
		//tx_e <= rv_d3 & phase[2];	
		tx_e <= (cmd == 5) ? (rv_d3 & phase[2]) : cmd_time;	
		//tx_e <= (cmd == 5) ? (rv_d2 & phase[2]) : cmd_time;	
	end	
	
	//tx_v
	always @(posedge clk) begin
		tx_v <= cmd_time | txd_time;
	end
	
	//tx_d
	always @(posedge clk) begin
		if(cmd_w1_time)
			tx_d <= {cmd_sta_d1, cmd_d1};
		else if(cmd_w2_time)
			tx_d <= 8'h00;
		else if(cmd_w3_time)
			tx_d <= cnt_sect_d1;
		else if(cmd_w4_time)
			tx_d <= adda_w1_d1;		//maybe need fix
			//tx_d <= 8'h00;		
		else if(cmd_w5_time)
			tx_d <= adda_w2_d1;
		else if(cmd_w6_time)
			tx_d <= adda_w3_d1;		
		else if(cmd_w7_time)
			tx_d <= 8'h00;			
		else if(cmd_w8_time)
			tx_d <= 8'h00;	
		else if(txd_time)
			tx_d <= rxd;
		//else
		//	tx_d <= 8'h00;
	end	
	
endmodule












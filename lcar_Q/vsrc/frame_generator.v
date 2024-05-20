module frame_generator(
	clk,
	c_done,

	//ram_re,
	ram_ra,
	ram_rd,
    
	pac_stp,
	ovp,
	//rxclk,	
	rxen,
    rxerr,
	rx_ok,
    rxd
    	  
    
);

	input          clk;
	input          c_done;
	input 	[7:0]	ram_rd;
	//input			ram_re;

	output 	reg[RAM_ADDR_WIDTH - 1:0]	ram_ra;


                                  
    //output             rxclk;
	output  reg[7:0]   rxd;
    output  reg        rxerr;
	output  reg        rxen;
	output  reg        rx_ok;
	output  reg        pac_stp;
	output  reg        ovp;
    
            
  localparam
    IDLE          = 8'b00000001,
    TX_PREAMBLE   = 8'b00000010,
    TX_HEADER = 8'b00000100,
    TX_IP_HEADER  = 8'b00001000,
    TX_UDP_HEADER = 8'b00010000,
    TX_DATA       = 8'b00100000,
    TX_FILL_DATA  = 8'b01000000,
    TX_CRC        = 8'b10000000;
	
	parameter 	RAM_ADDR_WIDTH 	= 	18					;
	//parameter	RAM_DEEPTH   	=   1<<(RAM_ADDR_WIDTH)	;
	//parameter	RAM_DEEPTH   	=  85000;
	parameter	RAM_DEEPTH   	=  141316;
	//			BYTES_BY_HPIX 	= 31719	
	parameter 	PREAMBLE_LEN 	=	4					;
	parameter 	HEADER_LEN	 	=	4					;
	parameter 	CSUM_LEN	 	=	4					;
	parameter 	PKT_LEN		 	=	1452				;			//Hasco RU
	parameter	PANEL_NUM		= 	256					;
	parameter   H_PIX			=   256					;			//real H pixes
	//parameter   H_PIX			=   128					;	
	//parameter   ROWS			=   90;	
	parameter   ROWS			=   144;	
	parameter   HSIZE           =   512 				;  			//art H pixes		
	parameter 	H_LEN			=	H_PIX/4*15			;	

	parameter 	DAT_LEN			=   PKT_LEN - PREAMBLE_LEN - HEADER_LEN - CSUM_LEN;
	parameter	PANEL_CTRL_STB	=	DAT_LEN-PANEL_NUM*2;
	parameter   PKTS            =   ROWS*H_LEN/DAT_LEN + 2;	
	parameter	RA_DEEPTH       =   PKTS*DAT_LEN;	
	//parameter	BYTES_BY_HPIX   =   ROWS*H_LEN + DAT_LEN*2 - 1;		
	//parameter	RAM_VIDEO_STBN  =   DAT_LEN*2	;	

	
	parameter  	PKT_IFG 				= 	12			;
	parameter  	CMD_DATA_LEN 			= 	2048		;
	parameter  	VIDEO_DATA_LEN 			= 	1920		;
	parameter  	VIOD_DATA_LEN 			= 	HSIZE/4*15	;
	//parameter  	VIDEO_DATA_LEN 			= 	960;				//larger the writing latency of video frame sending to video256 module
	//parameter  	FRAME_IFG 				= 	3212		;
	//parameter  	FRAME_IFG 				= 	2776		;			//Hasco 2021.09		21fps
	//parameter  	FRAME_IFG 				= 	1205		;				//Hasco 2021.09		60fps
	parameter  	FRAME_IFG 				= 	1788		;				//Hasco 2021.09		43fps
	//parameter  	FRAME_IFG 				= 	36200		;			//Hasco 2021.09		
	parameter 	CMD_PKT_MAXINDEX		=	15			;
	//parameter 	VIDEO_PKT_MAXINDEX		=	1040		;				
	parameter 	VIDEO_PKT_MAXINDEX		=	ROWS + 16		;				
	//parameter 	FRAME_PKT_MAXINDEX		=	1052		;
	//parameter 	FRAME_PKT_MAXINDEX		=	1070		;				//Hasco 2021.09		60fps
	//parameter 	FRAME_PKT_MAXINDEX		=	1505		;				//Hasco 2021.09		43fps
	parameter 	FRAME_PKT_MAXINDEX		=	1506		;				//Hasco 2021.09		43fps
	//parameter 	FRAME_PKT_MAXINDEX		=	1463		;				//Hasco 2021.09		21fps
	parameter 	CTRL_WORD_NUM			=	33			;
	
	
	reg		[10:0]		pkt_cnt;

	reg		[7:0]		ctrl_csum;	//ctrl csum					

    reg [11:0]  cnt_idle;

	reg  [3:0]  cnt_preamble;
	reg  [3:0]  cnt_header;

	reg  [11:0] cnt_data;

	reg  [1:0]  cnt_crc;
	reg  [7:0]  tx_data;
	reg         tx_en;
	reg  [7:0]  curr_state;
	reg  [7:0]  next_state;

	reg           tx_done;

	reg  [7:0]  curr_state_dly1;
	reg  [7:0]  curr_state_dly2;
	reg  [1:0]  cnt_crc_dly1;
	reg  [1:0]  cnt_crc_dly2;
	reg         tx_en_dly1;
	reg  [7:0]  tx_data_dly1;
	reg         crc_init;
	reg         crc_en_temp;
	reg         crc_en;
	reg  [7:0]  crc_in;
	reg [15:0]  crc_result;
	
	reg  [7:0]  gmii_txd_renewcrc;
	reg         gmii_txen_renewcrc; 

	//assign rxclk = clk;
	
	//VPT
	wire vpt = (pkt_cnt == 0);
	
	//ram_re_pn1	-   pn1 read ram enable
	//wire ram_re_pn1;
	//assign ram_re_pn1 = (pkt_cnt == 1 & 
	//						( (curr_state == TX_DATA & 
	//							(cnt_data < PANEL_CTRL_STB - 2 | 
	//							(cnt_data >= 12'd1022 & ram_ra < DAT_LEN - 1))) |
	//						  (curr_state == TX_HEADER & cnt_header >= 4'd3) | 
	//						  tx_done
	//						)
	//					);
	////ram_re_pn2	-   pn2 read ram enable
	//wire ram_re_pn2;
	//assign ram_re_pn2 = (pkt_cnt == 2& 
	//						((curr_state == TX_DATA & cnt_data < DAT_LEN - 1) | 
	//						 (curr_state == TX_HEADER & cnt_header >= 4'd3))
	//					);
	////ram_re_pnv	-   video pkt read ram enable					
	//wire ram_re_pnv;
	//assign ram_re_pnv = ( (pkt_cnt > CMD_PKT_MAXINDEX & pkt_cnt < VIDEO_PKT_MAXINDEX)&
	//					  //( (curr_state == TX_DATA & cnt_data < VIDEO_DATA_LEN - 1)|	
	//					  ( (curr_state == TX_DATA & cnt_data < H_LEN - 1)|								//512 art hsize
	//					    (curr_state == TX_HEADER & cnt_header >= 4'd3))&
	//					//( (  (~pkt_cnt[0] & (curr_state == TX_DATA & cnt_data < 1440 - 1))|
	//					//   ( pkt_cnt[0] & (curr_state == TX_DATA & cnt_data < 960 - 1))  )|				//384 art hsize					  
	//					//    (curr_state == TX_HEADER & cnt_header >= 4'd3))&							
	//					     ram_ra <= BYTES_BY_HPIX
	//					); 

	//pn*_ra;
	wire pn1_ra  = (pkt_cnt == 1);
	wire pn2_ra  = (pkt_cnt == 2);
	//wire pn10_ra = (pkt_cnt == 10);
	wire pnv_ra  = (pkt_cnt > CMD_PKT_MAXINDEX & pkt_cnt < VIDEO_PKT_MAXINDEX);
	
	wire p1_den = (cnt_data < PANEL_CTRL_STB) | (cnt_data[10:9] == 2'b10);
		
	//b**_ra
	//wire b0_ra   = (curr_state == TX_HEADER & cnt_header >= 4'd3);
	//wire bn1_ra  = (curr_state == TX_DATA & (cnt_data < PANEL_CTRL_STB - 2 | (cnt_data >= 12'd1022 & ram_ra < DAT_LEN - 1)));
	wire bn1_ra  = curr_state[5] & p1_den;
	//wire bn2_ra  = (curr_state == TX_DATA & cnt_data < DAT_LEN - 1);
	wire bn2_ra  = curr_state[5] & (cnt_data < DAT_LEN);
	//wire bn10_ra = (curr_state == TX_DATA & cnt_data < DAT_LEN - 1);
	//wire bnv_ra  = (curr_state == TX_DATA & cnt_data < H_LEN - 1);
	wire bnv_ra  = curr_state[5] & (cnt_data < H_LEN);
	
	//rm_ra
	//wire rm_ra   = (ram_ra <= RA_DEEPTH);
	
	//ram_re_pn1	-   pn1 read ram enable
	//wire ram_re_pn1  = (pn1_ra & (b0_ra | bn1_ra | tx_done));
	wire ram_re_pn1  = (pn1_ra & bn1_ra);
	//ram_re_pn2	-   pn2 read ram enable
	wire ram_re_pn2  = (pn2_ra & bn2_ra);
	//ram_re_pn10	-   pn10 read ram enable
	//wire ram_re_pn10 = (pn10_ra & (bn10_ra | b0_ra));					//Hasco RU
	//ram_re_pnv	-   video pkt read ram enable					
	wire ram_re_pnv  = (pnv_ra & bnv_ra);			//Hasco  low down written BW of RAM256 to 512 
		
	reg ram_re;
	always@ (posedge clk or negedge c_done)begin
		if(~c_done)
			ram_re <= 0;
		else
			ram_re <= ram_re_pn1 | ram_re_pn2 | ram_re_pnv;
	end
	
	always@(posedge clk or negedge c_done)
	begin
		//if(!c_done)
		if(!c_done|vpt)
			ram_ra <= 0;
		//else if(ram_re_pn1 | ram_re_pn2 | ram_re_pnv)
		else if(ram_re)
			ram_ra <= ram_ra + 1;
	end

	reg h_fix_p;
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			h_fix_p <= 0;
		else
			h_fix_p <= pn1_ra & (cnt_data == 7);
	end
	
	//wire h_fix_p = pn1_ra & (cnt_data == 8);
	
	reg[7:0] ram_rd_d1;
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			ram_rd_d1 <= 0;
		//else if(ram_ra == 7)
		else if(h_fix_p)
			ram_rd_d1 <= 8'h01;
		else
			ram_rd_d1 <= ram_rd;
	end	
	
	always@(posedge clk or negedge c_done)
	begin
		if(!c_done)
			pkt_cnt <= 11'd0;
		else if(pkt_cnt == FRAME_PKT_MAXINDEX && tx_done)
			pkt_cnt <= 11'd0;
		else if(tx_done)
			pkt_cnt <= pkt_cnt + 1;
	end

	always@(posedge clk or negedge c_done)
	begin
		if(!c_done)
			ctrl_csum <= 8'd0;
		//else if(curr_state == TX_DATA && cnt_data < CTRL_WORD_NUM - 1 && pkt_cnt == 11'd1)
		else if(curr_state == TX_DATA && cnt_data < CTRL_WORD_NUM && pkt_cnt == 11'd1)
		begin
			ctrl_csum <= ctrl_csum + tx_data;
		end
		else
			ctrl_csum <= 8'd0;
	end

	always@(posedge clk or negedge c_done)
    begin
        if(!c_done)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
  always@(*)
  begin
    case(curr_state)
      IDLE:
        //if(tx_en_pulse)
        if(cnt_idle == PKT_IFG - 1 && pkt_cnt != 0)
            next_state = TX_PREAMBLE;
        else if(cnt_idle == FRAME_IFG - 1 && pkt_cnt == 0)
            next_state = TX_PREAMBLE;
        else
            next_state = IDLE;

      TX_PREAMBLE:
        if(cnt_preamble == 4'd3)
          next_state = TX_HEADER;
        else
          next_state = TX_PREAMBLE;

      TX_HEADER:
        if(cnt_header == 4'd3)
          next_state = TX_DATA;
        else
          next_state = TX_HEADER;

      TX_DATA:
        if(cnt_data == VIDEO_DATA_LEN - 1 && pkt_cnt > CMD_PKT_MAXINDEX)
			next_state = TX_CRC;
		else if(cnt_data == CMD_DATA_LEN - 1 && pkt_cnt <= CMD_PKT_MAXINDEX)
			next_state = TX_CRC;
        else
			next_state = TX_DATA;
 
      TX_CRC:
        if(cnt_crc == 2'd3)
          next_state = IDLE;
        else
          next_state = TX_CRC;

      default:next_state = IDLE;

    endcase
  end
//idle
	always@(posedge clk or negedge c_done)begin
        if(!c_done)
            cnt_idle <= 12'd0;
        else if(pkt_cnt == 0 && cnt_idle == FRAME_IFG - 1 && curr_state == IDLE)
            cnt_idle <= 12'd0;
		else if(pkt_cnt != 0 && cnt_idle == PKT_IFG - 1 && curr_state == IDLE)
			cnt_idle <= 12'd0;
		else if(curr_state == IDLE)
            cnt_idle <= cnt_idle + 1'b1;
    end
  //cnt_preamble
	always@(posedge clk or negedge c_done)begin
        if(!c_done)
            cnt_preamble <= 4'd0;
        else if(curr_state == TX_PREAMBLE)
            cnt_preamble <= cnt_preamble + 1'b1;
        else
            cnt_preamble <= 4'd0;
    end
  //cnt_header
	always@(posedge clk or negedge c_done)begin
        if(!c_done)
            cnt_header <= 4'd0;
        else if(curr_state == TX_HEADER)
            cnt_header <= cnt_header + 1'b1;
        else
            cnt_header <= 4'd0;
    end

  //cnt_data
	always@(posedge clk or negedge c_done)begin
        if(!c_done)
            cnt_data <= 12'd0;
        else if(curr_state == TX_DATA)
            cnt_data <= cnt_data + 1'b1;
        else
            cnt_data <= 12'd0;
    end

  //cnt_crc
	always@(posedge clk or negedge c_done)begin
        if(!c_done)begin
            cnt_crc <= 5'd0;           
        end   
        else if(curr_state == TX_CRC)
            cnt_crc <= cnt_crc + 1'b1;
        else
            cnt_crc <= 5'd0;
    end		

  //tx_data,tx_en
	always@(posedge clk or negedge c_done)begin
        if(!c_done)
        begin
            tx_en   <= 1'b0;
            tx_data <= 8'h00;
        end
        else
        begin
            case(curr_state)
            IDLE:
            begin
                tx_en   <= 1'b0;
                tx_data <= 8'h00;
            end
            
            TX_PREAMBLE:
            begin
                tx_en <= 1'b1;
                if(cnt_preamble <= 4'd2)
					tx_data <= 8'h55;
                else
					tx_data <= 8'hd5;
            end
        
            TX_HEADER:
            begin
                tx_en <= 1'b1;
                case(cnt_header)
                4'd0:   tx_data <= pkt_cnt[7:0];
                4'd1:  	tx_data <= {5'h0,pkt_cnt[10:8]};
                4'd2:   tx_data <= 8'd0;
                4'd3:   tx_data <= 8'd0;          
                default:tx_data <= 8'h00; 
                endcase
            end
                  
            //TX_DATA:
            //begin
            //    tx_en <= 1'b1;
			//	if(pkt_cnt == 0)					
			//		tx_data <= 8'd0;				//VSYNC		P
			//	else if(pkt_cnt <= 2)begin
			//		if(ram_ra == 6)					//set the low8 hsize 
			//			tx_data <= 8'hff;			
			//		else if(ram_ra == 7)			//set the high8 hsize
			//			tx_data <= 8'h01;
			//		else if(ram_ra == 33)
			//			tx_data <= ram_rd + 1;
			//		else 
			//			tx_data <= ram_rd;
			//	end
			//	else if(pkt_cnt > CMD_PKT_MAXINDEX & pkt_cnt < VIDEO_PKT_MAXINDEX)
			//		tx_data <= ram_rd;					
			//	else
			//		tx_data <= 8'h00;														
            //end
            
            TX_CRC:
            begin
                tx_en <= 1'b1;
                case(cnt_crc)
                    5'd0:   tx_data <= crc_result[7:0];
                    5'd1:   tx_data <= crc_result[15:8];
                    5'd2:   tx_data <= 8'd0;
                    5'd3:   tx_data <= 8'd0;
                    default: tx_data <= 8'd0;                   
                endcase
            end        
            endcase
        end
    end

    always@(posedge clk or negedge c_done)begin
        if(!c_done)
            crc_init <= 1'b0;
        //else if (tx_en_pulse && (curr_state == IDLE))
        else if (curr_state == IDLE)
            crc_init <= 1'b1;
        else 
            crc_init <= 1'b0;
    end 
    always@(posedge clk or negedge c_done)begin
        if(!c_done)
            crc_en_temp <= 1'b0;
        //else if (curr_state == TX_HEADER || curr_state == TX_IP_HEADER || 
        //         curr_state == TX_UDP_HEADER || curr_state == TX_FILL_DATA || curr_state == TX_DATA)  
        else if (curr_state == TX_HEADER || curr_state == TX_DATA)
            crc_en_temp <= 1'b1;
        else 
            crc_en_temp <= 1'b0;
    end
    always@(posedge clk or negedge c_done)begin
        if(!c_done)
            crc_en <= 1'b0;
        else if (crc_en_temp)
            crc_en <= 1'b1;
        else 
            crc_en <= 1'b0;
    end
    always@(posedge clk or negedge c_done)begin
        if(!c_done)
            //crc_in <= 8'h00;
            crc_result <= 16'd0;
        else if(crc_init)
            crc_result <= 16'd0;
        else if(crc_en_temp)
            crc_result <= crc_result + {8'd0,tx_data};
            //crc_result <= crc_value;
            //crc_in <= tx_data;
        else if(tx_done)
			crc_result <= 16'd0;
		else
            crc_result <= crc_result;
            //crc_in <= crc_in;
    end
    
	always@(posedge clk or negedge c_done)begin
		if(!c_done)
		begin
			tx_en_dly1   <= 1'b0;
			tx_data_dly1 <= 8'h00;
			//gmii_txd_renewcrc <= 8'h00;
		end
		else
		begin
			tx_en_dly1   <= tx_en;
			tx_data_dly1 <= tx_data;
			//gmii_txd_renewcrc <= tx_data_dly1;
		end	
	end
//
	reg[7:0] curr_state_dly3;
	always@(posedge clk or negedge c_done)begin
		if(!c_done)
		begin
			curr_state_dly1 <= 0;
			curr_state_dly2 <= 0;
			curr_state_dly3 <= 0;
			cnt_crc_dly1   <= 2'd0;
			cnt_crc_dly2   <= 2'd0;
		end
		else
		begin
			curr_state_dly1 <= curr_state;
			curr_state_dly2 <= curr_state_dly1;
			curr_state_dly3 <= curr_state_dly2;
			cnt_crc_dly1   <= cnt_crc;
			cnt_crc_dly2   <= cnt_crc_dly1;
		end
	end
	
	always@(posedge clk or negedge c_done)begin
		if(!c_done)
			gmii_txd_renewcrc <= 8'h00;
		else if(curr_state_dly2 == TX_CRC)
		begin
			case(cnt_crc_dly2)
			2'd0:gmii_txd_renewcrc <= crc_result[7:0];
			2'd1:gmii_txd_renewcrc <= crc_result[15:8];
			2'd2:gmii_txd_renewcrc <= 8'd0;
			2'd3:gmii_txd_renewcrc <= 8'd0;
			endcase
		end
		else
			gmii_txd_renewcrc <= tx_data_dly1;
	end
	
    always@(posedge clk or negedge c_done)begin
        if(!c_done)
            gmii_txen_renewcrc <= 1'b0;
        else if(tx_en_dly1)
            gmii_txen_renewcrc <= 1'b1;
        else
            gmii_txen_renewcrc <= 1'b0;
    end
	
	reg pac_stp_a0, pac_stp_a1;
	always@(posedge clk or negedge c_done)begin
        if(!c_done) begin
			pac_stp_a0 <= 0;
			pac_stp_a1 <= 0;
			pac_stp    <= 0;
		end
		else begin
			pac_stp_a0 <= (cnt_preamble == 0) & (curr_state == TX_PREAMBLE);
			pac_stp_a1 <= pac_stp_a0;
			pac_stp    <= pac_stp_a1;		
		end
	end
	
	//reg ovp;
	always@(posedge clk or negedge c_done)begin
        if(!c_done)
			ovp <= 0;
		else 
			ovp <= pac_stp_a1 & (pkt_cnt == 0);
	end

    always@(posedge clk or negedge c_done)begin
        if(!c_done)
            rxd  <= 8'h00;
        else if(curr_state_dly3[5])
            rxd  <= ram_rd_d1;
		else rxd <= gmii_txd_renewcrc;
    end
	
    always@(posedge clk or negedge c_done)begin
        if(!c_done)
        begin
            rxerr <= 1'b0;
            rxen <= 1'b0;
            //rxd  <= 8'h00;
			rx_ok <= 0;
        end
        else
        begin
            rxerr <= 1'b0;
			rx_ok <= 1'b1;
            rxen <= gmii_txen_renewcrc;
            //rxd  <= gmii_txd_renewcrc;
        end
    end
  //tx_done
    always@(posedge clk or negedge c_done)begin
        if(!c_done)
            tx_done <= 1'b0;
        else if(curr_state == TX_CRC && cnt_crc == 2'd3)
            tx_done <= 1'b1;
        else
            tx_done <= 1'b0;
    end
endmodule
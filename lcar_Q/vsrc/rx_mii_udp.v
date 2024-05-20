module rx_mii_udp(
	c_done,	

	//rxdi,
	//rxdv,

	exter_mac,
	exter_ip,
	exter_port,
	local_mac,
	local_ip,
	local_port,

	//ram_re,
	clk125M,		//Hasco 202109
	ram_ra,
	ram_rd,

	rx_er,
	pac_err,
	
	clk25M,
	ss_ne,
	bsm_re,
	rcm_ra,
	rcm_rd,
	
	rx_clk,	
	rx_dv,
	rx_d
);
	input              					c_done;	
	input        						rx_clk;
	//input  			[7:0] 				rx_d;
	input  			[3:0] 				rx_d;
	input        						rx_dv;
	
	output 		reg 					rx_er;    	
	output 		reg 					pac_err;    	
	//reg  			[7:0] 				rx_d;
	//reg        							rx_dv;
	input 								clk125M;			//Hasco 202109
	//input        						rxdv;
	//input 			[3:0]				rxdi;
	input 								clk25M;
	input 		    [9:0]				rcm_ra;
	output		reg [7:0]				rcm_rd;
	//output			[7:0]				rcm_rd;
	output		reg 					ss_ne;
	output		reg 					bsm_re;
	
	output     	reg [47:0]   			local_mac;
	output     	reg [31:0]   			local_ip;
	output     	reg [15:0]   			local_port;
	

	output 		reg[47:0]   			exter_mac;
	output 		reg[31:0]   			exter_ip;
	output 		reg[15:0]   			exter_port;

	
	parameter 	ETH_type       = 16'h0800,
				IP_ver         = 4'h4,
				IP_hdr_len     = 4'h5,
				//IP_tos         = 8'h00,
				//IP_id          = 16'h0000,
				//IP_rsv         = 1'b0,
				//IP_df          = 1'b0,
				//IP_mf          = 1'b0,
				//IP_frag_offset = 13'h0000,
				//IP_ttl         = 8'h40,
				IP_protocol    = 8'h11;
			
	localparam
		IDLE          = 9'b000000001,
		RX_PREAMBLE   = 9'b000000010,
		RX_ETH_HEADER = 9'b000000100,
		RX_IP_HEADER  = 9'b000001000,
		RX_UDP_HEADER = 9'b000010000,
		RX_DATA       = 9'b000100000,
		//RX_DRP_DATA   = 9'b001000000,
		RX_CRC        = 9'b001000000,
		//RX_CRC        = 9'b010000000,
		//PKT_CHECK     = 9'b100000000;
		PKT_CHECK     = 9'b010000000;
		
	parameter	SRC_MAC 			= 	48'hAA_BB_CC_DD_EE_FF 		;
	parameter	DST_MAC 			= 	48'h77_88_77_88_77_88		;	
	
	//parameter 	RAM_ADDR_WIDTH 	    = 	17			;	
	parameter 	RAM_ADDR_WIDTH 	    = 	18			;	
	//parameter	RAM_DEEPTH          =   1<<(RAM_ADDR_WIDTH);	
	//parameter	RAM_DEEPTH          =   85000;	
	//parameter	RAM_DEEPTH          =   94000;	
	parameter	RAM_DEEPTH          =   141316;	
	//parameter	RAM_DEEPTH          =   187460;
	parameter 	PREAMBLE_LEN 	    =	4				;
	parameter 	HEADER_LEN	 	    =	4				;
	parameter 	CSUM_LEN	 	    =	4				;
	//parameter 	PKT_LEN		 	    =	1454			;
	parameter   H_PIX		 	    =   256			;	
	parameter 	PKT_LEN		 	    =	1452;							//Hasco RU 2021/07/30
	parameter   ROWS				=   144;
	//parameter 	PKT_LEN		 	    =	1454;
	//parameter   H_PIX		 	    =   256;	
	
	parameter 	H_LEN		        =   H_PIX/4*15;
	parameter 	DAT_LEN	            =   PKT_LEN - PREAMBLE_LEN - HEADER_LEN - CSUM_LEN;
	parameter   PKTS                =   ROWS*H_LEN/DAT_LEN + 2;	
	parameter	RAM_WR_STN          =   PREAMBLE_LEN + HEADER_LEN;
	//parameter	WR_DEEPTH           =   PKTS*DAT_LEN;
	parameter	MAX_PKT           	=   PKTS + 16;				

	
	reg  [7:0]  reg_gmii_rxd;
	reg         reg_gmii_rxdv;
	reg  [7:0]  rx_data_dly1;
	reg  [7:0]  rx_data_dly2;
	reg	 [7:0] 	rx_data_dly3;
	
	reg         rx_datav_dly1;
	reg         rx_datav_dly2;
	reg			rx_datav_dly3;
  
	reg  [8:0]  curr_state;
	reg  [8:0]  next_state;
	reg	 [15:0] rx_data_length;
	
	reg  [47:0] rx_dst_mac;
	reg  [47:0] rx_src_mac;
	reg  [15:0] rx_eth_type;
	reg         eth_header_check_ok;
	
	reg  [3:0]  rx_ip_ver;
	reg  [3:0]  rx_ip_hdr_len;
	reg  [7:0]  rx_ip_tos;
	reg  [15:0] rx_total_len;
	reg  [15:0] rx_ip_id;
	reg         rx_ip_rsv;
	reg         rx_ip_df;
	reg         rx_ip_mf;
	reg  [12:0] rx_ip_frag_offset;
	reg  [7:0]  rx_ip_ttl;
	reg  [7:0]  rx_ip_protocol;
	reg  [15:0] rx_ip_check_sum;
	reg  [31:0] rx_src_ip;
	reg  [31:0] rx_dst_ip;
	reg         ip_checksum_cal_en;  
	wire [15:0] cal_check_sum;
	reg         ip_header_check_ok;
	
	reg  [15:0] rx_src_port;
	reg  [15:0] rx_dst_port;
	reg  [15:0] rx_udp_length;
	reg         udp_header_check_ok;
	
	reg         crc_init;
	reg         crc_en;
	reg  [7:0]  crc_data;
	wire [31:0] crc_check;
	reg	 [31:0] rx_crc;
	reg	 [2:0]  crc_cnt;
	
	reg  [3:0]  cnt_preamble;
	reg  [3:0]  cnt_eth_header;
	reg  [4:0]  cnt_ip_header;
	reg  [3:0]  cnt_udp_header;
	reg  [10:0] cnt_data; 
 
	reg[3:0] rx_d_d1, rx_d_d2;
	reg rx_dv_d1, rx_dv_d2;
	
	always@(posedge rx_clk or negedge c_done) begin
		if(!c_done)begin
			rx_dv_d1 <= 0;
			rx_dv_d2 <= 0;
			rx_d_d1  <= 4'd0;
			rx_d_d2  <= 4'd0;
		end
		else begin
			rx_dv_d1 <= rx_dv;
			rx_dv_d2 <= rx_dv_d1;			
			rx_d_d1  <= rx_d;			
			rx_d_d2  <= rx_d_d1;			
		end		
	end

	//reg rx_rdy_a, rx_rdy_a1, rx_rdy_a2;
	reg rx_rdy, rx_rdy_d1, rx_rdy_d2, rx_rdy_d3, rx_rdy_d4;
	always@(posedge rx_clk or negedge c_done)begin 
		if(~c_done | ~rx_dv_d2)
			rx_rdy <= 0;
		else if(rx_dv_d2)
			rx_rdy <= ~rx_rdy;
	end

	always@(posedge rx_clk or negedge c_done)begin 
		if(~c_done)begin
			rx_rdy_d1 <= 0;
			rx_rdy_d2 <= 0;
			rx_rdy_d3 <= 0;
			rx_rdy_d4 <= 0;
		end
		else begin
			rx_rdy_d1 <= rx_rdy;
			rx_rdy_d2 <= rx_rdy_d1;
			rx_rdy_d3 <= rx_rdy_d2;
			rx_rdy_d4 <= rx_rdy_d3;			
		end
	end
	
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
		begin
			reg_gmii_rxd  <= 8'h00;
			reg_gmii_rxdv <= 1'b0;
		end
		else if(~rx_rdy)
		begin
			reg_gmii_rxd[3:0] <= rx_d_d2;
			reg_gmii_rxdv 	  <= rx_dv_d2;
		end
		else if(rx_rdy)
		begin
			reg_gmii_rxd[7:4] <= rx_d_d2;
			reg_gmii_rxdv     <= rx_dv_d2;
		end		
	end
		
	always@(posedge rx_clk)
	begin
		rx_data_dly1  <= reg_gmii_rxd;
		rx_data_dly2  <= rx_data_dly1;
		rx_data_dly3  <= rx_data_dly2;
		
		rx_datav_dly1 <= reg_gmii_rxdv;
		rx_datav_dly2 <= rx_datav_dly1;
		rx_datav_dly3 <= rx_datav_dly2;

	end
		
  //cnt_preamble
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			cnt_preamble <= 4'd0;
		else if(curr_state == RX_PREAMBLE & rx_data_dly2 == 8'h55 & ~rx_rdy_d2)
			cnt_preamble <= cnt_preamble + 1'b1;
		else if(curr_state != RX_PREAMBLE)
			cnt_preamble <= 4'd0;
	end
  //cnt_eth_header
	always@(posedge rx_clk or negedge c_done)
	begin	
		if(!c_done)
			cnt_eth_header <= 4'd0;
		else if(curr_state == RX_ETH_HEADER & ~rx_rdy_d2)
			cnt_eth_header <= cnt_eth_header + 1'b1;
		else if(curr_state != RX_ETH_HEADER) 
			cnt_eth_header <= 4'd0;
	end
  //eth_header
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
		begin
			rx_dst_mac  <= 48'h00_00_00_00_00_00;
			rx_src_mac  <= 48'h00_00_00_00_00_00;
			rx_eth_type <= 16'h0000;
		end    
		else if(curr_state == RX_ETH_HEADER & ~rx_rdy_d2)
		begin
			case(cnt_eth_header)
			4'd0 :rx_dst_mac[47:40] <= rx_data_dly2;
			4'd1 :rx_dst_mac[39:32] <= rx_data_dly2;
			4'd2 :rx_dst_mac[31:24] <= rx_data_dly2;
			4'd3 :rx_dst_mac[23:16] <= rx_data_dly2;
			4'd4 :rx_dst_mac[15:8]  <= rx_data_dly2;
			4'd5 :rx_dst_mac[7:0]   <= rx_data_dly2;
		
			4'd6 :rx_src_mac[47:40] <= rx_data_dly2;
			4'd7 :rx_src_mac[39:32] <= rx_data_dly2;
			4'd8 :rx_src_mac[31:24] <= rx_data_dly2;
			4'd9 :rx_src_mac[23:16] <= rx_data_dly2;
			4'd10:rx_src_mac[15:8]  <= rx_data_dly2;
			4'd11:rx_src_mac[7:0]   <= rx_data_dly2;
		
			4'd12:rx_eth_type[15:8] <= rx_data_dly2;
			4'd13:rx_eth_type[7:0]  <= rx_data_dly2;      
			default: ;
			endcase
		end
		else
		begin
			rx_dst_mac  <= rx_dst_mac;
			rx_src_mac  <= rx_src_mac;
			rx_eth_type <= rx_eth_type;
		end  
	end	
	
	//eth_mac
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			eth_header_check_ok <= 1'b0;
		//else if(rx_eth_type == ETH_type && (rx_dst_mac == local_mac_reg || rx_dst_mac == 48'hFF_FF_FF_FF_FF_FF))
		//else if(rx_eth_type == ETH_type && (rx_src_mac == 48'hFF_FF_FF_FF_FF_FF || rx_dst_mac == 48'hFF_FF_FF_FF_FF_FF))
		//else if(rx_eth_type == ETH_type && (rx_src_mac == 48'hAA_BB_CC_DD_EE_FF || rx_dst_mac == 48'hAA_BB_CC_DD_EE_FF))
		else if(rx_eth_type == ETH_type && (rx_src_mac == SRC_MAC || rx_src_mac == DST_MAC))
			eth_header_check_ok <= 1'b1;
		else
			eth_header_check_ok <= 1'b0;
	end

	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
		begin
			exter_mac  	<= 	48'h0;
			exter_ip   	<= 	32'h0;
			exter_port 	<= 	16'h0;
			local_mac	<=	48'h0;
			local_ip	<=	32'h0;
			local_port	<=	16'h0;
		end
//		else if(curr_state == PKT_CHECK)
		else
		begin
			//exter_mac  <= (rx_src_mac == SRC_MAC) ? rx_dst_mac 	: eth_header_check_ok ? rx_src_mac 	: 48'd0;
			exter_mac  <= (rx_src_mac == SRC_MAC) ? rx_dst_mac 	: eth_header_check_ok ? rx_src_mac 	: SRC_MAC;
			//exter_ip   <= (rx_src_mac == SRC_MAC) ? rx_dst_ip 	: eth_header_check_ok ? rx_src_ip 	: 32'd0;
			exter_ip   <= (rx_src_mac == SRC_MAC) ? rx_dst_ip 	: eth_header_check_ok ? rx_src_ip 	: 32'hc0_a8_e2_01;
			//exter_port <= (rx_src_mac == SRC_MAC) ? rx_dst_port : eth_header_check_ok ? rx_src_port	: 16'd0;
			exter_port <= (rx_src_mac == SRC_MAC) ? rx_dst_port : eth_header_check_ok ? rx_src_port	: 16'h86_c5;
			
			//local_mac  <= (rx_src_mac == DST_MAC) ? rx_dst_mac 	: eth_header_check_ok ? rx_src_mac 	: 48'd0;
			local_mac  <= (rx_src_mac == DST_MAC) ? rx_dst_mac 	: eth_header_check_ok ? rx_src_mac 	: DST_MAC;
			//local_ip   <= (rx_src_mac == DST_MAC) ? rx_dst_ip 	: eth_header_check_ok ? rx_src_ip 	: 32'd0;
			local_ip   <= (rx_src_mac == DST_MAC) ? rx_dst_ip 	: eth_header_check_ok ? rx_src_ip 	: 32'hb0_10_2c_28;
			//local_port <= (rx_src_mac == DST_MAC) ? rx_dst_port : eth_header_check_ok ? rx_src_port	: 16'd0;			
			local_port <= (rx_src_mac == DST_MAC) ? rx_dst_port : eth_header_check_ok ? rx_src_port	: 16'h19_00;			
		end
	end
	
  //cnt_ip_header
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			cnt_ip_header <= 5'd0;
		else if(curr_state == RX_IP_HEADER & ~rx_rdy_d2)
			cnt_ip_header <= cnt_ip_header + 1'b1;
		else if(curr_state != RX_IP_HEADER)
			cnt_ip_header <= 5'd0;  
	end
  //ip_header
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
		begin
			{rx_ip_ver,rx_ip_hdr_len}     <= 8'h0;
			rx_ip_tos                     <= 8'h0;  
			rx_total_len                  <= 16'h0; 
			rx_ip_id                      <= 16'h0;
			{rx_ip_rsv,rx_ip_df,rx_ip_mf} <= 3'h0;  
			rx_ip_frag_offset             <= 13'h0;  
			rx_ip_ttl                     <= 8'h0;  
			rx_ip_protocol                <= 8'h0; 
			rx_ip_check_sum               <= 16'h0;
			rx_src_ip                     <= 32'h0;
			rx_dst_ip                     <= 32'h0;  
		end    
		else if(curr_state == RX_IP_HEADER & ~rx_rdy_d2)
		begin
			case(cnt_ip_header)
			5'd0:   {rx_ip_ver,rx_ip_hdr_len}                             <= rx_data_dly2;
			5'd1:   rx_ip_tos                                             <= rx_data_dly2;
			5'd2:   rx_total_len[15:8]                                    <= rx_data_dly2;
			5'd3:   rx_total_len[7:0]                                     <= rx_data_dly2;
			5'd4:   rx_ip_id[15:8]                                        <= rx_data_dly2;
			5'd5:   rx_ip_id[7:0]                                         <= rx_data_dly2;
			5'd6:   {rx_ip_rsv,rx_ip_df,rx_ip_mf,rx_ip_frag_offset[12:8]} <= rx_data_dly2;
			5'd7:   rx_ip_frag_offset[7:0]                                <= rx_data_dly2;
			5'd8:   rx_ip_ttl                                             <= rx_data_dly2;
			5'd9:   rx_ip_protocol                                        <= rx_data_dly2;
			5'd10:  rx_ip_check_sum[15:8]                                 <= rx_data_dly2;
			5'd11:  rx_ip_check_sum[7:0]                                  <= rx_data_dly2;
			5'd12:  rx_src_ip[31:24]                                      <= rx_data_dly2;
			5'd13:  rx_src_ip[23:16]                                      <= rx_data_dly2;
			5'd14:  rx_src_ip[15:8]                                       <= rx_data_dly2;
			5'd15:  rx_src_ip[7:0]                                        <= rx_data_dly2;
			5'd16:  rx_dst_ip[31:24]                                      <= rx_data_dly2;
			5'd17:  rx_dst_ip[23:16]                                      <= rx_data_dly2;
			5'd18:  rx_dst_ip[15:8]                                       <= rx_data_dly2;
			5'd19:  rx_dst_ip[7:0]                                        <= rx_data_dly2;      
			default: ;
			endcase
		end
	end
	
	//udp_header: 8byte
	//ip_header: 20byte
	//rx_data_length = rx_total_len - udp_header - ip_header;
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			rx_data_length <= 16'd0;
		else if(curr_state == RX_IP_HEADER & cnt_ip_header == 5'd19)
			rx_data_length <= rx_total_len - 8'd20 - 8'd8;
		else
			rx_data_length <= rx_data_length;
	end
	
	//always@(posedge rx_clk or negedge c_done)
	//begin
	//	if(!c_done)
	//		ip_checksum_cal_en <= 1'b0;
	//	else if(curr_state == RX_IP_HEADER && cnt_ip_header == 5'd19)
	//		ip_checksum_cal_en <= 1'b1;
	//	else
	//		ip_checksum_cal_en <= 1'b0;
	//end
	
	//ip_checksum ip_checksum(
	//	.clk            (rx_clk           ),
	//	.c_done        (c_done           ),
	//
	//	.cal_en         (ip_checksum_cal_en),
	//
	//	.IP_ver         (rx_ip_ver         ),
	//	.IP_hdr_len     (rx_ip_hdr_len     ),
	//	.IP_tos         (rx_ip_tos         ),
	//	.IP_total_len   (rx_total_len      ),
	//	.IP_id          (rx_ip_id          ),
	//	.IP_rsv         (rx_ip_rsv         ),
	//	.IP_df          (rx_ip_df          ),
	//	.IP_mf          (rx_ip_mf          ),
	//	.IP_frag_offset (rx_ip_frag_offset ),
	//	.IP_ttl         (rx_ip_ttl         ),
	//	.IP_protocol    (rx_ip_protocol    ),
	//	.src_ip         (rx_src_ip         ),
	//	.dst_ip         (rx_dst_ip         ),
	//
	//	.checksum       (cal_check_sum     )
	//); 

	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			ip_header_check_ok <= 1'b0;
		//else if({IP_ver,IP_hdr_len,IP_protocol,cal_check_sum,local_ip_reg} == 
		//		{rx_ip_ver,rx_ip_hdr_len,rx_ip_protocol,rx_ip_check_sum,rx_dst_ip})
		//	ip_header_check_ok <= 1'b1;
		else if({IP_ver,IP_hdr_len,IP_protocol,rx_ip_check_sum,rx_dst_ip} == 
				{rx_ip_ver,rx_ip_hdr_len,rx_ip_protocol,rx_ip_check_sum,rx_dst_ip})
			ip_header_check_ok <= 1'b1;			
		else
			ip_header_check_ok <= 1'b0;  
	end
  //cnt_udp_header
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			cnt_udp_header <= 4'd0;
		else if(curr_state == RX_UDP_HEADER & ~rx_rdy_d2)
			cnt_udp_header <= cnt_udp_header + 1'b1;
		else if(curr_state != RX_UDP_HEADER)
			cnt_udp_header <= 4'd0;  
	end
	
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
		begin
			rx_src_port  <= 16'h0;
			rx_dst_port  <= 16'h0;
			rx_udp_length<= 16'h0;
		end    
		else if(curr_state == RX_UDP_HEADER & ~rx_rdy_d2)
		begin
			case(cnt_udp_header)
			4'd0: rx_src_port[15:8]   <= rx_data_dly2;
			4'd1: rx_src_port[7:0]    <= rx_data_dly2;
			4'd2: rx_dst_port[15:8]   <= rx_data_dly2;
			4'd3: rx_dst_port[7:0]    <= rx_data_dly2;
			4'd4: rx_udp_length[15:8] <= rx_data_dly2;
			4'd5: rx_udp_length[7:0]  <= rx_data_dly2;  
			default: ;
			endcase
		end
	end
		
	reg [15:0] pac_num;
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			pac_num	<= 16'd0;
		else if(cnt_data == 11'd4 & ~rx_rdy_d2)
			pac_num[7:0] <= rx_data_dly2;
		else if(cnt_data == 11'd5 & ~rx_rdy_d2)
			pac_num[15:8] <= rx_data_dly2;		
	end
	
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			udp_header_check_ok <= 1'b0;
		else if(rx_dst_port == rx_dst_port)
			udp_header_check_ok <= 1'b1;
		else
			udp_header_check_ok <= 1'b0;
	end
	
  //cnt_data
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			cnt_data <= 11'd0;
		else if(curr_state == RX_DATA & ~rx_rdy_d2)
			cnt_data <= cnt_data + 1'b1;
		else if(curr_state != RX_DATA) 
			cnt_data <= 11'd0;
	end
	
  //FSM
	always@(posedge rx_clk or negedge c_done)
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
			if(!rx_datav_dly2 && rx_datav_dly1)
				next_state = RX_PREAMBLE;
			else
				next_state = IDLE;
	
		RX_PREAMBLE:
			if(rx_data_dly2 == 8'hd5 & cnt_preamble > 4'd5 & ~rx_rdy_d2)
				next_state = RX_ETH_HEADER;
			else if(cnt_preamble > 4'd7)
				next_state = IDLE;
			else
				next_state = RX_PREAMBLE;
	
		RX_ETH_HEADER:
			if(cnt_eth_header == 4'd13 & ~rx_rdy_d2)
				next_state = RX_IP_HEADER;
			else
				next_state = RX_ETH_HEADER;
	
		RX_IP_HEADER:
			if(cnt_ip_header == 5'd2 & eth_header_check_ok == 1'b0)
				next_state = IDLE;
			else if(cnt_ip_header == 5'd19 & ~rx_rdy_d2)
				next_state = RX_UDP_HEADER;
			else
				next_state = RX_IP_HEADER;
	
		RX_UDP_HEADER:
			if(cnt_udp_header == 4'd2 & ip_header_check_ok == 1'b0)
				next_state = IDLE;
			else if(cnt_udp_header == 4'd7 & udp_header_check_ok == 1'b0)        
				next_state = IDLE;
			else if(cnt_udp_header == 4'd7 & ~rx_rdy_d2)
				next_state = RX_DATA;
			else
				next_state = RX_UDP_HEADER;
	
		RX_DATA:
			if(cnt_data == rx_data_length - 1'b1 & ~rx_rdy_d2)
				next_state = RX_CRC;
			else
				next_state = RX_DATA;
		
		RX_CRC:
			if(rx_datav_dly2 == 1'b0)
				next_state = PKT_CHECK;
				//next_state = IDLE;
			else
				next_state = RX_CRC;
	
		PKT_CHECK:
			next_state = IDLE;
	
		default:next_state = IDLE;
	
		endcase
	end  	

	always @(posedge rx_clk)begin
		if(~c_done | ~eth_header_check_ok)
			rx_er <= 1;
		else
			rx_er <= 0;
	end
	
	input 	[RAM_ADDR_WIDTH - 1:0]	ram_ra;
	//output  reg						ram_re;
	output	[7:0]					ram_rd;	
	
	reg 							ram_we;
	//reg 	[12:0]	ram_wa;
	reg 	[RAM_ADDR_WIDTH - 1:0]	ram_wa;
	//reg 	[16:0]	ram_ra;
	wire	[7:0]					ram_wd;
	wire	[7:0]					ram_rd;	
	
	bram18x8 bram18x8_inst (
		.clka(rx_clk), 
		.wea(ram_we), 
		.addra(ram_wa), 
		.dina(ram_wd), 
		.clkb(clk125M), 
		.addrb(ram_ra), 
		.doutb(ram_rd)
		);	
		

	wire bn_wa = (cnt_data > RAM_WR_STN - 1 & cnt_data < DAT_LEN + RAM_WR_STN) & ~rx_rdy_d2;		//Hasco RU
	
	always@(posedge rx_clk)
	begin
		if(~c_done)
			ram_wa <= 0;
		else if(pac_num == 1 & cnt_data == 5)			
			ram_wa <= 0;			
		else if(pn_wr & bn_wa)				
			ram_wa <= ram_wa + 1;			
	end
	
	//pn_wr packet check in
	wire pn_wr = (pac_num == 1|
				  pac_num == 2|
				  (pac_num > 15 & pac_num < MAX_PKT));								
	//bn_wr bytes written in 
	//wire bn_wr = (cnt_data > RAM_WR_STN - 2 & cnt_data < DAT_LEN + RAM_WR_STN - 1) & rx_rdy_d2; 
	wire bn_wr = (cnt_data > RAM_WR_STN - 1 & cnt_data < DAT_LEN + RAM_WR_STN) & rx_rdy_d2; //Hasco 202109
											//Hasco RU
		
	always@(posedge rx_clk)
	begin
		if(~c_done)
			ram_we <= 0;				
		else if(pn_wr & bn_wr)				
			ram_we <= 1;
		else
			ram_we <= 0;
	end
	
	//always@(posedge rx_clk or negedge c_done)
	//begin
	//	if(!c_done)
	//		ram_wa <= 0;
	//	else if(pac_num == 1 & cnt_data == 5)			
	//		ram_wa <= 0;			
	//	else if((pac_num == 1|pac_num == 2|pac_num > 15)&
	//			(cnt_data > RAM_WR_STN - 1&cnt_data < DAT_LEN + RAM_WR_STN)
	//			 & ~rx_rdy_d2)				
	//		ram_wa <= ram_wa + 1;			
	//end
	//
	//always@(posedge rx_clk or negedge c_done)
	//begin
	//	if(!c_done)
	//		ram_we <= 0;
	//	else if((pac_num >= 1)
	//			&(cnt_data > RAM_WR_STN - 2 & cnt_data < DAT_LEN + RAM_WR_STN - 1)
	//			& ram_wa < RAM_DEEPTH - 1
	//			& rx_rdy_d2)				
	//		ram_we <= 1;
	//	else
	//		ram_we <= 0;
	//end	

	assign ram_wd = rx_data_dly2;

	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			crc_init <= 1'b0;
		else if (rx_datav_dly1 && (~rx_datav_dly2))
			crc_init <= 1'b1;
		else 
			crc_init <= 1'b0;
	end
  //crc_en
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			crc_en <= 1'b0;
		else if(curr_state == IDLE)
			crc_en <= 1'b0;
		else if (curr_state != RX_PREAMBLE & curr_state != RX_CRC & rx_datav_dly2 & ~rx_rdy_d2)
			crc_en <= 1'b1;
		else 
			crc_en <= 1'b0;
	end
	
	//crc_data
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			crc_data <= 8'd0;
		else if(~rx_rdy_d2)
			crc_data <= rx_data_dly2;
	end
		
	crc32_d8 crc32_d8
	(
		.clk         (rx_clk       ),
		.reset_n     (c_done       ),
	
		.data        (crc_data      ),
		.crc_init    (crc_init      ),
		.crc_en      (crc_en        ),
		.crc_result  (crc_check     )//latency=1
	);
		
	//reg [2:0] crc_cnt;
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			crc_cnt <= 3'd0;
		else if(curr_state == RX_CRC & ~rx_rdy_d2)
			crc_cnt <= crc_cnt + 1;
		else if(curr_state != RX_CRC)
			crc_cnt <= 3'd0;
	end
	
	always@(posedge rx_clk or negedge c_done)
	begin
		if(!c_done)
			rx_crc <= 32'd0;
		else if(curr_state == RX_CRC & ~rx_rdy_d2)
		begin
			case(crc_cnt)
				4'd0: rx_crc[7:0]   <= rx_data_dly2;
				4'd1: rx_crc[15:8]  <= rx_data_dly2;
				4'd2: rx_crc[23:16] <= rx_data_dly2;
				4'd3: rx_crc[31:24] <= rx_data_dly2;
				default: ;
			endcase
		end
		else if(curr_state == IDLE)
			rx_crc <= 32'd0;
	end 
	
	reg[31:0] crc_cal;
	always @(posedge rx_clk) begin
		crc_cal <= crc_check;	
	end

	wire crc_ckp = (curr_state == PKT_CHECK);
	
	wire crc_ok  = (crc_cal == rx_crc);
	
	reg pn_eq10, pn_eq11, pn_eq11_1d, pn11_endp;
	always @(posedge rx_clk)begin
		pn_eq10    <= (pac_num == 10);
		pn_eq11    <= (pac_num == 11);
		pn_eq11_1d <= pn_eq11;
		pn11_endp  <= ~pn_eq11 & pn_eq11_1d; 
	end		

	//wire pn11_endp = ~pn_eq11 & pn_eq11_1d; 
		
	reg pn10_ok, pn10_nt;
	always @(posedge rx_clk)begin
		pn10_ok <= pn_eq10 & crc_ckp & crc_ok;
		pn10_nt <= pn_eq10 & crc_ckp & ~crc_ok;
	end
		
    //pac_err
	always@(posedge rx_clk)begin
		if(~c_done | pn10_ok)
			pac_err <= 1'b0;
		else if(pn10_nt)
			pac_err <= 1'b1;
	end	

	reg pac_err_1d, pac_err_endp;
	always@(posedge rx_clk)begin
		pac_err_1d   <= pac_err;
		pac_err_endp <= ~pac_err & pac_err_1d; 
	end	

	//wire pac_err_endp = ~pac_err & pac_err_1d; 

	//pac_e2g
	reg pac_e2g;
	always@(posedge rx_clk)begin
		if(~c_done | pn11_endp)
			pac_e2g <= 1'b0;
		else if(pac_err_endp)
			pac_e2g <= 1'b1;
	end

	wire dat_en = (cnt_data > 7 & cnt_data < 272) & curr_state[5] & ~rx_rdy;			//TX_DATA

	reg ram1_we;
	always @(posedge rx_clk)begin
		ram1_we <= pn_eq10 & dat_en;
	end
	
	wire ram1_wa_rst = (cnt_data == 8) & curr_state[5] & ~rx_rdy;
	reg[9:0] ram1_wa;
	always @(posedge rx_clk)begin
		if(ram1_wa_rst)
			ram1_wa <= 0;
		else if(ram1_we)
			ram1_wa <= ram1_wa + 1;
	end	
	
	reg[7:0] ram1_di;
	always @(posedge rx_clk)begin
		if(~rx_rdy)
			ram1_di <= rx_data_dly2;
	end	
	
	wire[7:0] ram1_rd;
	
	//rcm
	ram4x256B ram1 (
		.clka(rx_clk), 
		.wea(ram1_we), 
		.addra(ram1_wa), 
		.dina(ram1_di), 
		.clkb(clk25M), 
		.addrb(rcm_ra), 
		.doutb(ram1_rd)
		//.doutb(rcm_rd)
		);


	wire cmd_de = pn_eq10 & ram1_wa_rst;
	
	wire adw1_time = pn_eq10 & (cnt_data == 11) & ~rx_rdy;
	wire adw2_time = pn_eq10 & (cnt_data == 12) & ~rx_rdy;
	//wire adw3_time = pn_eq10 & (cnt_data == 13) & curr_state[5] & ~rx_rdy;
	
	reg[7:0] adda_w1, adda_w2, adda_w3;
	always @(posedge rx_clk)begin
		if(adw1_time)
			adda_w1 <= rx_data_dly2;
		else if(adw2_time)
			adda_w2 <= rx_data_dly2;
		//else if(adw3_time)
		//	adda_w3 <= rx_data_dly2;			
	end

	reg[7:0] ad_w1, ad_w2, ad_w3;
	always @(posedge rx_clk)begin
		if(~c_done | ~bsd_en)begin
			ad_w1 <= 8'hff;
			ad_w2 <= 8'hff;
		end		
		else if(pn11_endp)begin
			ad_w1 <= adda_w1;
			ad_w2 <= adda_w2;
			//ad_w3 <= adda_w3;
		end
	end

	//reg[1:0] qa;
	//always @(posedge rx_clk)begin
	//	if(~c_done | ~cmd_en)
	//		qa <= 0;
	//	else if(~qa_stop & pn11_endp & bsd_en)
	//		qa <= qa + 1;
	//end
		
	//wire qa_stop = qa[1];
	
	//wire addr_eq0 = ~(|{adda_w1,adda_w2} ^ {ad_w1,ad_w2}) & ~(|qa);		//adda_w1 == adda_w2 & adda_w1 == 0
	reg addr_neq;
	always @(posedge rx_clk)begin
		//addr_neq <= |{adda_w1,adda_w2} ^ {ad_w1,ad_w2};
		addr_neq <= |(adda_w1 ^ ad_w1) || |(adda_w2 ^ ad_w2);
	end
	//wire addr_neq = |{adda_w1,adda_w2} ^ {ad_w1,ad_w2};
	
	//wire pp0_en = ~(|qa);
	
	reg[7:0] cmd_dat;
	always @(posedge rx_clk)begin
		if(cmd_de)
			cmd_dat <= rx_data_dly2;
	end
	
	//wire ss_nc = ~sen | cmd_en;
	
	reg cmd_en, sen, bsd_en, nxt_pp;
	always @(posedge rx_clk)begin
		cmd_en 	<= cmd_dat[7];			//Command Mode Enable
		sen	   	<= cmd_dat[6];			//Sensor Data Retrive
		bsd_en	<= cmd_dat[5];			//Bitstream Data Flag
		//nxt_pp	<= cmd_dat[4];			//Bitstream Data Update
		//nxt_pp	<= addr_neq | addr_eq0;	//Bitstream Data Update
		nxt_pp	<= addr_neq;	//Bitstream Data Update
		ss_ne   <= ~sen | cmd_en;
	end

	//wire e2g = pac_e2g;
	//wire normal = nxt_pp & ~pac_err_1d;
	wire normal = nxt_pp & ~pac_err;
	
	reg rcm_re, rcm_re_d1, rcm_re_d2;
	always @(posedge rx_clk)begin
		//rcm_re 	  <= bsd_en & ~pac_err & pn_eq11;
		//rcm_re 	  <= e2g | normal && pn_eq11_1d;
		rcm_re 	  <= pac_e2g | normal && bsd_en && pn_eq11;
		rcm_re_d1 <= rcm_re;
		rcm_re_d2 <= rcm_re_d1;
	end		
	
	reg bsm_re_a1, bsm_re_a2, bsm_re_a;
	always@(posedge clk25M)begin
		bsm_re_a2 <= rcm_re_d2;
		bsm_re_a1 <= bsm_re_a2;
		bsm_re_a  <= bsm_re_a1;
		bsm_re    <= bsm_re_a ;
	end
	
	always @(posedge clk25M)begin
		rcm_rd <= ram1_rd;
	end	 
 
 
	
endmodule
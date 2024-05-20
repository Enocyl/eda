/////////////////////////////////////////////////////////////////////////////////
// Create Date: 2021/10/20 00:00:00
// Design Name: tx_mii_udp
// Module Name: tx_mii_udp
// Project Name: lcar144x256P
// Target Devices: XA6SLX45-2CSG324Q
// Tool Versions: ISE 2013
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tx_mii_udp(
	clk,
	c_done,
	
	txen_in,
	txd_in,
	tcm_ra,
	
	tx_done,
	
	dst_mac,
	dst_port,  
	dst_ip,
	src_mac,
	src_ip,	
	src_port,

	mii_txen,
    mii_txd	
);

	input          	clk;
	input          	c_done;

	input 			txen_in;
	input[7:0]		txd_in;
	input[47:0]   	dst_mac;
	input[47:0]   	src_mac;
	input[31:0]   	dst_ip;
	input[31:0]   	src_ip;
	input[15:0]   	dst_port;
	input[15:0]   	src_port;
	
	output reg		tx_done;
	output reg[8:0] tcm_ra;
	output reg[3:0] mii_txd;
	output reg      mii_txen;	
	
	//parameter PKT_LEN 	= 16'd1454	;
	parameter PKT_LEN 	= 16'd1452	;

	parameter ETH_type  = 16'h0800	;
	parameter IP_ver         = 4'h4		;
	parameter IP_hdr_len     = 4'h5		;
	parameter IP_tos         = 8'h00		;
	parameter IP_id          = 16'h0000	;
	parameter IP_rsv         = 1'b0		;
	parameter IP_df          = 1'b0		;
	parameter IP_mf          = 1'b0		;
	parameter IP_frag_offset = 13'h0000	;
	parameter IP_ttl         = 8'h40		;
	parameter IP_protocol    = 8'h11		;
	parameter udp_check_sum  = 16'h0000;
								
	localparam                		
		IDLE            = 8'b00000001,
		TX_PREAMBLE     = 8'b00000010,
		TX_ETH_HEADER   = 8'b00000100,
		TX_IP_HEADER    = 8'b00001000,
		TX_UDP_HEADER   = 8'b00010000,
		TX_DATA         = 8'b00100000,
		TX_FILL_DATA    = 8'b01000000,
		TX_CRC          = 8'b10000000;
	
	//assign IP_ver         = 4'h4		;
	//assign IP_hdr_len     = 4'h5		;
	//assign IP_tos         = 8'h00		;
	//assign IP_id          = 16'h0000	;
	//assign IP_rsv         = 1'b0		;
	//assign IP_df          = 1'b0		;
	//assign IP_mf          = 1'b0		;
	//assign IP_frag_offset = 13'h0000	;
	//assign IP_ttl         = 8'h40		;
	//assign IP_protocol    = 8'h11		;
	
	//output [15:0] IP_total_len;
	//wire [15:0] IP_check_sum;
	
	reg[47:0] 	dst_mac_reg;
	reg[47:0] 	src_mac_reg;
	reg[15:0] 	dst_port_reg;
	reg[15:0] 	src_port_reg;
	reg[31:0] 	dst_ip_reg;
	reg[31:0] 	src_ip_reg;
	reg[15:0] 	data_length_reg; 
	reg[15:0] 	IP_total_len_reg;
	reg[15:0] 	udp_length_reg;
			
			
	reg[3:0]  	cnt_preamble;
	reg[3:0]  	cnt_eth_header;
	reg[4:0]  	cnt_ip_header;
	reg[3:0]  	cnt_udp_header;
	reg[15:0] 	cnt_data;
	reg[4:0]  	cnt_fill_data;
	reg[1:0]  	cnt_crc;
	reg[7:0]  	tx_data;
	reg       	tx_en;
	reg[7:0]  	curr_state;
	reg[7:0]  	next_state;
			
	wire      	crc_state;
	reg       	crc_state_dly1;
	reg       	crc_state_dly2;
	reg[1:0]  	cnt_crc_dly1;
	reg[1:0]  	cnt_crc_dly2;
	reg       	tx_en_dly1;
	reg[7:0]  	tx_data_dly1;
	reg       	crc_init;
	reg       	crc_en_temp;
	reg       	crc_en;
	reg[7:0]  	crc_in;
	wire[31:0]	crc_result;
	
	reg[7:0]  	gmii_txd_renewcrc;
	reg         gmii_txen_renewcrc; 

	//reg     	tx_done;	

	wire[15:0]  	IP_check_sum;
	wire[15:0] 		IP_total_len;
	wire[15:0] 		udp_length;
	
	assign udp_length = PKT_LEN + 8'd8;   		//udp_header: 8byte
	assign IP_total_len = udp_length + 8'd20; 	//ip_header: 20byte
	
	reg				txen_dly1;
	reg				txen_dly2;
	reg	[7:0]		txd_dly1;
	reg	[7:0]		txd_dly2;
	reg	[7:0]		txd_dly3;

	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			txen_dly1 <= 0;
			txen_dly2 <= 0;
		end
		else begin
			txen_dly1 <= txen_in;
			txen_dly2 <= txen_dly1;
		end
	end
  
	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			txd_dly1  <= 8'd0;
			txd_dly2  <= 8'd0;
			txd_dly3  <= 8'd0;
		end
		else if(h4_en)begin
			txd_dly1  <= txd_in;
			txd_dly2  <= txd_dly1;
			txd_dly3  <= txd_dly2;
		end
	end
	 
	wire tx_stp = ~txen_dly1 & txen_in;	
	
	reg[8:0] cnt_data_d1, cnt_data_d2, cnt_data_d3;
	//reg[8:0] tcm_ra;
	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			cnt_data_d1 <= 0;
			cnt_data_d2 <= 0;
			cnt_data_d3 <= 0;
			tcm_ra 	<= 0;
		end 
		else if(h4_en)begin
			cnt_data_d1 <= cnt_data[8:0];
			cnt_data_d2 <= cnt_data_d1;
			cnt_data_d3 <= cnt_data_d2;
			tcm_ra 	    <= cnt_data_d3;
		end
			
	end
	//assign wr_en = ~full & txen_dly2 & (curr_state != IDLE & curr_state != TX_CRC & cnt_data <= data_length_reg - 16'd54);
	//assign wd = txd_dly2;
	//assign rd_en = ~empty & ((curr_state == TX_UDP_HEADER & cnt_udp_header == 4'd7) | 
	//				(curr_state == TX_DATA & cnt_data < data_length_reg - 16'd5));
	//
	//
	//fifo6x8 fifo6x8_inst (
	//	.clk(clk), 
	//	.rst(~c_done), 
	//	.din(wd), 
	//	.wr_en(wr_en), 
	//	.rd_en(rd_en), 
	//	.dout(rd), 
	//	.full(full), 
	//	.empty(empty)
	//	);

	ip_checksum ip_checksum(
		.clk            (clk        ),
		.reset_n        (c_done        ),
	
		.cal_en         (tx_stp    ),
	
		.IP_ver         (IP_ver         ),
		.IP_hdr_len     (IP_hdr_len     ),
		.IP_tos         (IP_tos         ),
		.IP_total_len   (IP_total_len   ),
		.IP_id          (IP_id          ),
		.IP_rsv         (IP_rsv         ),
		.IP_df          (IP_df          ),
		.IP_mf          (IP_mf          ),
		.IP_frag_offset (IP_frag_offset ),
		.IP_ttl         (IP_ttl         ),
		.IP_protocol    (IP_protocol    ),
		.src_ip         (src_ip         ),
		.dst_ip         (dst_ip         ),
	
		.checksum       (IP_check_sum   )
	);
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			dst_mac_reg  <= 48'd0;
			src_mac_reg  <= 48'd0;
			dst_ip_reg   <= 32'd0;
			src_ip_reg   <= 32'd0;  
			dst_port_reg <= 16'd0;
			src_port_reg <= 16'd0;
		end
		else if(tx_stp)begin
			dst_mac_reg  <= dst_mac;
			src_mac_reg  <= src_mac;
			dst_port_reg <= dst_port;
			src_port_reg <= src_port;					//3840
			dst_ip_reg   <= dst_ip;
			src_ip_reg   <= src_ip;   			//192.168.0.10
		end
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			data_length_reg  <= 16'h0;
			IP_total_len_reg <= 16'h0;
			udp_length_reg   <= 16'h0; 
		end
		else if(tx_stp)begin
			data_length_reg  <= PKT_LEN;
			IP_total_len_reg <= IP_total_len;
			udp_length_reg   <= udp_length; 
		end
	end

	//h4_en
	reg h4_en;
	always@(posedge clk or negedge c_done)begin
		if(~c_done | tx_stp)
			h4_en <= 0;
		//else if(tx_en)
		//else if(txen_dly1)
		else if(txen_dly1 | mii_txen)
			h4_en <= ~h4_en;
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			curr_state <= IDLE;
		else
			curr_state <= next_state;
	end
	
	always@(*)begin
		case(curr_state)
		IDLE:
			//if(tx_stp)
			if(tx_stp & dst_mac != 48'd0)
				next_state = TX_PREAMBLE;
			else
				next_state = IDLE;
	
		TX_PREAMBLE:
			if((cnt_preamble == 4'd7) & h4_en)
				next_state = TX_ETH_HEADER;
			else
				next_state = TX_PREAMBLE;
	
		TX_ETH_HEADER:
			if((cnt_eth_header == 4'd13) & h4_en)
				next_state = TX_IP_HEADER;
			else
				next_state = TX_ETH_HEADER;
	
		TX_IP_HEADER:
			if((cnt_ip_header == 5'd19) & h4_en)
				next_state = TX_UDP_HEADER;
			else
				next_state = TX_IP_HEADER;
	
		TX_UDP_HEADER:
			if((cnt_udp_header == 4'd7) & h4_en)
				next_state = TX_DATA;
			else
				next_state = TX_UDP_HEADER;
	
		TX_DATA:
			if((cnt_data == data_length_reg - 1'b1) & h4_en)
				next_state = TX_CRC;
			else
				next_state = TX_DATA;
			
		TX_CRC:
			if((cnt_crc == 2'd3) & h4_en)
				next_state = IDLE;
			else
				next_state = TX_CRC;
	
		default:next_state = IDLE;
	
		endcase
	end

  //cnt_preamble
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			cnt_preamble <= 4'd0;
		else if((curr_state == TX_PREAMBLE) & h4_en)
			cnt_preamble <= cnt_preamble + 1'b1;
		else if(curr_state != TX_PREAMBLE)
			cnt_preamble <= 4'd0;
	end
	
  //cnt_eth_header
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			cnt_eth_header <= 4'd0;
		else if(curr_state == TX_ETH_HEADER & h4_en)
			cnt_eth_header <= cnt_eth_header + 1'b1;
		else if(curr_state != TX_ETH_HEADER) 
			cnt_eth_header <= 4'd0;
	end
	
  //cnt_ip_header
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			cnt_ip_header <= 5'd0;
		else if(curr_state == TX_IP_HEADER & h4_en)
			cnt_ip_header <= cnt_ip_header + 1'b1;
		else if(curr_state != TX_IP_HEADER) 
			cnt_ip_header <= 5'd0;
	end
	
  //cnt_udp_header
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			cnt_udp_header <= 4'd0;
		else if(curr_state == TX_UDP_HEADER & h4_en)
			cnt_udp_header <= cnt_udp_header + 1'b1;
		else if(curr_state != TX_UDP_HEADER) 
			cnt_udp_header <= 4'd0;
	end
	
  //cnt_data
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			cnt_data <= 0;
		else if(curr_state == TX_DATA & h4_en)
			cnt_data <= cnt_data + 1'b1;
		else if(curr_state != TX_DATA) 
			cnt_data <= 0;
	end
		
  //cnt_crc
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			cnt_crc <= 5'd0;
		else if(curr_state == TX_CRC & h4_en)
			cnt_crc <= cnt_crc + 1'b1;
		else if(curr_state != TX_CRC) 
			cnt_crc <= 5'd0;
	end
	
  //tx_data,tx_en
	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			tx_en   <= 1'b0;
			tx_data <= 8'h00;
		end
		else if(h4_en)begin
			case(curr_state)
			IDLE:
			begin
				tx_en   <= 1'b0;
				tx_data <= 8'h00;
			end
			
			TX_PREAMBLE:
			begin
				tx_en <= 1'b1;
				if(cnt_preamble <= 4'd6)
					tx_data <= 8'h55;
				else
					tx_data <= 8'hd5;
			end
		
			TX_ETH_HEADER:
			begin
				tx_en <= 1'b1;
				case(cnt_eth_header)
				4'd0:   tx_data <= dst_mac_reg[47:40];
				4'd1:   tx_data <= dst_mac_reg[39:32];
				4'd2:   tx_data <= dst_mac_reg[31:24];
				4'd3:   tx_data <= dst_mac_reg[23:16];
				4'd4:   tx_data <= dst_mac_reg[15:8];
				4'd5:   tx_data <= dst_mac_reg[7:0];
				4'd6:   tx_data <= src_mac_reg[47:40];
				4'd7:   tx_data <= src_mac_reg[39:32];
				4'd8:   tx_data <= src_mac_reg[31:24];
				4'd9:   tx_data <= src_mac_reg[23:16];
				4'd10:  tx_data <= src_mac_reg[15:8];
				4'd11:  tx_data <= src_mac_reg[7:0];
				4'd12:  tx_data <= ETH_type[15:8];
				4'd13:  tx_data <= ETH_type[7:0];
				default:tx_data <= 8'h00; 
				endcase
			end
		
			TX_IP_HEADER:
			begin
				tx_en <= 1'b1;
				case(cnt_ip_header)
				5'd0:   tx_data <= {IP_ver,IP_hdr_len};
				5'd1:   tx_data <= IP_tos;
				5'd2:   tx_data <= IP_total_len_reg[15:8];
				5'd3:   tx_data <= IP_total_len_reg[7:0];
				5'd4:   tx_data <= IP_id[15:8];
				5'd5:   tx_data <= IP_id[7:0];
				5'd6:   tx_data <= {IP_rsv,IP_df,IP_mf,IP_frag_offset[12:8]};
				5'd7:   tx_data <= IP_frag_offset[7:0];
				5'd8:   tx_data <= IP_ttl;
				5'd9:   tx_data <= IP_protocol;
				5'd10:  tx_data <= IP_check_sum[15:8];
				5'd11:  tx_data <= IP_check_sum[7:0];
				5'd12:  tx_data <= src_ip_reg[31:24];
				5'd13:  tx_data <= src_ip_reg[23:16];
				5'd14:  tx_data <= src_ip_reg[15:8];
				5'd15:  tx_data <= src_ip_reg[7:0];
				5'd16:  tx_data <= dst_ip_reg[31:24];
				5'd17:  tx_data <= dst_ip_reg[23:16];
				5'd18:  tx_data <= dst_ip_reg[15:8];
				5'd19:  tx_data <= dst_ip_reg[7:0];
				default:tx_data <= 8'h00; 
				endcase
			end
		
			TX_UDP_HEADER:
			begin
				tx_en <= 1'b1;
				case(cnt_udp_header)
				4'd0:   tx_data <= src_port_reg[15:8];
				4'd1:   tx_data <= src_port_reg[7:0];
				4'd2:   tx_data <= dst_port_reg[15:8];
				4'd3:   tx_data <= dst_port_reg[7:0];
				4'd4:   tx_data <= udp_length_reg[15:8];
				4'd5:   tx_data <= udp_length_reg[7:0];
				4'd6:   tx_data <= udp_check_sum[15:8];
				4'd7:   tx_data <= udp_check_sum[7:0];
				default:tx_data <= 8'h00; 
				endcase
			end
			
			TX_DATA:
			begin
				tx_en <= 1'b1;
				case(cnt_data)
					11'd0  :  tx_data <= 8'h55;
					11'd1  :  tx_data <= 8'h55;
					11'd2  :  tx_data <= 8'h55;
					11'd3  :  tx_data <= 8'hd5;
					11'd4  :  tx_data <= 8'h0b;
					11'd5  :  tx_data <= 8'h00;
					11'd6  :  tx_data <= 8'h00;
					11'd7  :  tx_data <= 8'h00;
					default:  tx_data <= txd_dly3; 
				endcase
				//tx_en <= 1'b1;
				//if(cnt_data < 3)
				//	tx_data <= 8'h55;
				//else if(cnt_data == 3)
				//	tx_data <= 8'hd5;
				//
				//else if(cnt_data < 280)
				//	tx_data <= txd_dly1;
				//else 
				//	tx_data <= 8'h00;
			end
			
			TX_CRC:
			begin
				tx_en <= 1'b1;
				tx_data <= 8'h00;
			end
		
			endcase
		end
	end

	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			crc_init <= 1'b0;
		else if (tx_stp && (curr_state == IDLE))
			crc_init <= 1'b1;
		else 
			crc_init <= 1'b0;
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			crc_en_temp <= 1'b0;
		else if (curr_state == TX_ETH_HEADER | curr_state == TX_IP_HEADER | 
				curr_state == TX_UDP_HEADER | curr_state == TX_DATA && h4_en)
			crc_en_temp <= 1'b1;
		else 
			crc_en_temp <= 1'b0;
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			crc_en <= 1'b0;
		else if (crc_en_temp & ~h4_en)
			crc_en <= 1'b1;
		else 
			crc_en <= 1'b0;
	end

	reg [31:0] tx_csum;
	reg [31:0] tx_csum_dly1;
	reg [31:0] tx_csum_dly2;
	reg 	   tx_csum_en;
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			tx_csum_en <= 1'b0;
		else if(cnt_data >= 16'd4 & cnt_data <= data_length_reg - 16'd5 & ~h4_en)
			tx_csum_en <= 1'b1;
		else
			tx_csum_en <= 1'b0;
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			tx_csum <= 32'd0;
		else if(tx_csum_en)
			tx_csum <= tx_csum + {24'd0,tx_data};
		else if(tx_done)
			tx_csum <= 32'd0;
		else
			tx_csum <= tx_csum;
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			tx_csum_dly1 <= 32'd0;
			tx_csum_dly2 <= 32'd0;
		end
		else if(h4_en)begin
			tx_csum_dly1 <= tx_csum;
			tx_csum_dly2 <= tx_csum_dly1;
		end
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			crc_in <= 8'h00;
		else if(crc_en_temp & cnt_data < data_length_reg - 3 & ~h4_en)
			crc_in <= tx_data;
		else if(crc_en_temp && cnt_data >= data_length_reg - 3 & ~h4_en)begin
			case({cnt_data == data_length_reg - 2 , cnt_data == data_length_reg - 3})
			2'b01:   crc_in <= tx_csum[7:0];
			2'b10:   crc_in <= tx_csum[15:8];
			default: crc_in <= 8'd0;
			endcase
		end
		else
			crc_in <= crc_in;
	end
	
	crc32_d8 crc32_d8
	(
		.clk         (clk    ),
		.reset_n     (c_done    ),
	
		.data        (crc_in     ),
		.crc_init    (crc_init   ),
		.crc_en      (crc_en     ),
		.crc_result  (crc_result )//latency=1
	);
  
	assign crc_state = curr_state == TX_CRC;
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			crc_state_dly1 <= 1'b0;
			crc_state_dly2 <= 1'b0;
			cnt_crc_dly1   <= 2'd0;
			cnt_crc_dly2   <= 2'd0;
		end
		else if(h4_en)begin
			crc_state_dly1 <= crc_state;
			crc_state_dly2 <= crc_state_dly1;
			cnt_crc_dly1   <= cnt_crc;
			cnt_crc_dly2   <= cnt_crc_dly1;
		end
	end

	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			tx_en_dly1   <= 1'b0;
			tx_data_dly1 <= 8'h00;
		end
		else if(h4_en)begin
			tx_en_dly1   <= tx_en;
			tx_data_dly1 <= tx_data;
		end
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			gmii_txd_renewcrc <= 8'h00;
		else if(cnt_data >= data_length_reg - 2 & cnt_data <= data_length_reg - 1 & h4_en)begin
			case({cnt_data == data_length_reg - 1 , cnt_data == data_length_reg - 2})
			2'b01:gmii_txd_renewcrc <= tx_csum_dly2[7:0];
			2'b10:gmii_txd_renewcrc <= tx_csum_dly2[15:8];
			default: gmii_txd_renewcrc <= 8'd0;
			endcase    
		end
		else if(crc_state_dly2)begin
			case(cnt_crc_dly2 & h4_en)
			2'd0:gmii_txd_renewcrc <= crc_result[7:0];
			2'd1:gmii_txd_renewcrc <= crc_result[15:8];
			2'd2:gmii_txd_renewcrc <= crc_result[23:16];
			2'd3:gmii_txd_renewcrc <= crc_result[31:24];
			endcase
		end
		else if(h4_en)
			gmii_txd_renewcrc <= tx_data_dly1;
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			gmii_txen_renewcrc <= 1'b0;
		else if(h4_en)
			gmii_txen_renewcrc <= tx_en_dly1;
		//else
		//	gmii_txen_renewcrc <= 1'b0;
	end
	
	always@(posedge clk or negedge c_done)begin
		if(~c_done)begin
			mii_txen <= 1'b0;
			mii_txd  <= 4'h0;
		end
		else if(~h4_en)begin
			mii_txen <= gmii_txen_renewcrc;
			mii_txd  <= gmii_txd_renewcrc[3:0];
		end
		else begin
			mii_txen <= gmii_txen_renewcrc;
			mii_txd  <= gmii_txd_renewcrc[7:4];		
		end
	end
	
  //tx_done
	always@(posedge clk or negedge c_done)begin
		if(~c_done)
			tx_done <= 1'b0;
		else if(curr_state == TX_CRC & cnt_crc == 2'd3 & h4_en)
			tx_done <= 1'b1;
		else
			tx_done <= 1'b0;
	end
	
endmodule
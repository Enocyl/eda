`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board
// DIP SW 状態リード

module dsw_rd (//dsw_dat, 
			   clk, c_done,
               //dsw_sht, dsw_clk, 
			   dsw_tp, 
			   //dsw_on, 
			   c_done_dly);

    //input dsw_dat;
    input clk;      // 25MHz
    input c_done;

    //output dsw_sht;
    //output dsw_clk;
    output reg dsw_tp;
    //output reg [8:1] dsw_on;
    output c_done_dly;

    reg [18:0] qa;
    reg [4:0] qb;
    //reg lat1, lat2, lat3, lat4, lat5, lat6, lat7, lat8, lat_all;
    //reg [8:1] dsw_latd;
    reg [4:0] qc;

    wire rstp;
    wire qb_stop;
    wire qc_stop;


 // DIP SW 状態リード

    // qa  19bitカウンタ (DIP SW リード周期設定 : 10ms)
    always @(posedge clk) begin
      if(rstp)
        qa <= 19'd12145;
      else
        qa <= qa + 1;
    end

    // rstp
    assign rstp = qa[18];  // 262144

    // dsw_sht
    //assign dsw_sht = ~rstp;

    // qb  5bitカウンタ
    always @(posedge clk) begin
      if(rstp)
        qb <= 0;
      else if(~qb_stop)
        qb <= qb + 1;
    end

    // qb_stop
    assign qb_stop = qb[4];

    // dsw_clk
    //assign dsw_clk = qb[0] | qb[4];

    // lat1, lat2, lat3, lat4, lat5, lat6, lat7, lat8, lat_all
    //always @(posedge clk) begin
    //  lat1    <= (qb == 5'd0);
    //  lat2    <= (qb == 5'd2);
    //  lat3    <= (qb == 5'd4);
    //  lat4    <= (qb == 5'd6);
    //  lat5    <= (qb == 5'd8);
    //  lat6    <= (qb == 5'd10);
    //  lat7    <= (qb == 5'd12);
    //  lat8    <= (qb == 5'd14);
    //  lat_all <= (qb == 5'd15);
    //end

    // dsw_tp
    always @(posedge clk) begin
      dsw_tp <= (qb == 5'd15);
    end

    // dsw_latd  8bit
    //always @(posedge clk) begin
    //  if(lat1)
    //    dsw_latd[8] <= ~dsw_dat;
    //end
	//
    //always @(posedge clk) begin
    //  if(lat2)
    //    dsw_latd[7] <= ~dsw_dat;
    //end
	//
    //always @(posedge clk) begin
    //  if(lat3)
    //    dsw_latd[6] <= ~dsw_dat;
    //end
	//
    //always @(posedge clk) begin
    //  if(lat4)
    //    dsw_latd[5] <= ~dsw_dat;
    //end
	//
    //always @(posedge clk) begin
    //  if(lat5)
    //    dsw_latd[4] <= ~dsw_dat;
    //end
	//
    //always @(posedge clk) begin
    //  if(lat6)
    //    dsw_latd[3] <= ~dsw_dat;
    //end
	//
    //always @(posedge clk) begin
    //  if(lat7)
    //    dsw_latd[2] <= ~dsw_dat;
    //end
	//
    //always @(posedge clk) begin
    //  if(lat8)
    //    dsw_latd[1] <= ~dsw_dat;
    //end
	//
    //// dsw_on  8bit
    //always @(posedge clk) begin
    //  if(lat_all)
    //    dsw_on[8:1] <= dsw_latd[8:1];
    //end



 // c_done ディレイ

    // qc  5bitカウンタ
    always @(posedge clk) begin
      if(~c_done)
        qc <= 0;
      else if(dsw_tp & ~qc_stop)
        qc <= qc + 1;
    end

    // qc_stop
    assign qc_stop = qc[4];

    // c_done_dly
    assign c_done_dly = c_done & qc_stop;  // 150ms--160msディレイ 

endmodule
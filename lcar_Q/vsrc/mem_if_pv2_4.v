`timescale 1ns / 1ns
// `default_nettype none

// Receiver Board for PVII-4
// SDRAM interface

module mem_if_pv2_4 (c_done, clk,
               in_vid_wr_req, in_vid_wr_adrs, in_vid_wr_d,
               in_vid_rd_req, in_vid_rd_adrs,
               m4_bank1, m4_cf_rd_adrs,
               out_vid_rd_req, out_vid_rd_adrs,
               m4_cf_cmd_rd_req, m4_cf_cmd_rd_bank1, m4_cf_cmd_rd_adrs,
               m4_cf_cmd_wr_req, m4_cf_cmd_wr_bank1, m4_cf_cmd_wr_adrs,
               m4_cf_cmd_wr_byten, m4_cf_cmd_wr_d,
               out_vid_wr_req, out_vid_wr_adrs, out_vid_wr_d,
               cycle_stp, cycle_stp_adv, pup_time, m4_cmd_cycle,
               cke, cs_n, ras_n, cas_n, we_n, ba, adrs, dqm, dq, dot);


    input c_done;      // Configuration done
    input clk;         // 125MHz
    input in_vid_wr_req;
    input [16:0] in_vid_wr_adrs;
    input [29:0] in_vid_wr_d;
    input in_vid_rd_req;
    input [16:0] in_vid_rd_adrs;
    input m4_bank1;
    input [18:0] m4_cf_rd_adrs;
    input out_vid_rd_req;
    input [18:0] out_vid_rd_adrs;
    input m4_cf_cmd_rd_req;
    input m4_cf_cmd_rd_bank1;
    input [18:0] m4_cf_cmd_rd_adrs;
    input m4_cf_cmd_wr_req;
    input m4_cf_cmd_wr_bank1;
    input [18:0] m4_cf_cmd_wr_adrs;
    input [3:0] m4_cf_cmd_wr_byten;
    input [31:0] m4_cf_cmd_wr_d;
    input out_vid_wr_req;
    input [18:0] out_vid_wr_adrs;
    input [31:0] out_vid_wr_d;

    output reg cycle_stp;
    output reg cycle_stp_adv;
    output pup_time;
    output reg m4_cmd_cycle;
    output reg cke, cs_n, ras_n, cas_n, we_n;
    output reg [1:0] ba;
    output reg [10:0] adrs;
    output reg [3:0] dqm;
    output reg [31:0] dq;
    output reg dot;

    reg [6:0] qa;
    reg [1:0] qb;
    reg [3:0] qc;
    reg qc_eq0;
    reg auto_ref_cycle;
    reg qa_0to20, qa_3to18;
    reg qa_8to11, qa_0to7, qa_3to7, qa_20to23, qa_12to19, qa_15to19;
    reg qa_32to35, qa_44to47;
    reg qa_24to31, qa_36to43, qa_27to31, qa_39to43;
    reg qa_21to47, qa_24to47;
    reg qa_48to62;
    reg qa_48to58;
    reg qa_59to62;
    reg qa_63to71;
    reg qa_66to71;
    reg pwr_up_time;
    reg pup_cs_n;
    reg pup_ras_n;
    reg pup_cas_n;
    reg pup_we_n;
    reg pup_a10a;
    reg in_vid_wr_time;
    reg in_vid_wr_cs_n;
    reg in_vid_wr_ras_n;
    reg in_vid_wr_cas_n;
    reg in_vid_wr_we_n;
    reg in_vid_wr_a10a;
    reg [8:0] in_vid_wr_a_a;
    reg [29:0] in_vid_wr_dqa;
    reg in_vid_wr_dot;
    reg in_vid_rd_time;
    reg in_vid_rd_cs_n;
    reg in_vid_rd_ras_n;
    reg in_vid_rd_cas_n;
    reg in_vid_rd_a10a;
    reg [8:0] in_vid_rd_a_a;
    reg m4_cf_rd_time;
    reg m4_cf_rd_cs_n;
    reg m4_cf_rd_ras_n;
    reg m4_cf_rd_cas_n;
    reg [10:0] m4_cf_rd_a;
    reg out_vid_rd_time;
    reg out_vid_rd_cs_n;
    reg out_vid_rd_ras_n;
    reg out_vid_rd_cas_n;
    reg [10:0] out_vid_rd_a;
    reg auto_ref_time;
    reg auto_ref_cs_n;
    reg auto_ref_ras_n;
    reg auto_ref_cas_n;
    reg auto_ref_we_n;
    reg auto_ref_a10a;
    reg m4_cf_cmd_rd_time;
    reg m4_cf_cmd_rd_cs_n;
    reg m4_cf_cmd_rd_ras_n;
    reg m4_cf_cmd_rd_cas_n;
    reg [10:0] m4_cf_cmd_rd_a;
    reg m4_cf_cmd_wr_time;
    reg m4_cf_cmd_wr_cs_n;
    reg m4_cf_cmd_wr_ras_n;
    reg m4_cf_cmd_wr_cas_n;
    reg m4_cf_cmd_wr_we_n;
    reg [10:0] m4_cf_cmd_wr_a;
    reg [3:0] m4_cf_cmd_wr_dqm;
    reg [31:0] m4_cf_cmd_wr_dq;
    reg m4_cf_cmd_wr_dot;
    reg out_vid_wr_time;
    reg out_vid_wr_cs_n;
    reg out_vid_wr_ras_n;
    reg out_vid_wr_cas_n;
    reg out_vid_wr_we_n;
    reg [10:0] out_vid_wr_a;
    reg [31:0] out_vid_wr_dq;
    reg out_vid_wr_dot;
    reg cke_a;
    reg dot_a;

    wire ope_time;
    wire qc_end;
    wire qa_eq0, qa_eq2, qa_eq6, qa_eq7, qa_eq8;
    wire qa_eq10, qa_eq11, qa_eq12, qa_eq14, qa_eq18, qa_eq19;
    wire qa_eq20, qa_eq21, qa_eq23, qa_eq24;
    wire qa_eq30, qa_eq31, qa_eq32, qa_eq35, qa_eq36;
    wire qa_eq42, qa_eq43, qa_eq44, qa_eq47, qa_eq48;
    wire qa_eq51, qa_eq54, qa_eq59, qa_eq62, qa_eq63, qa_eq71;
    wire [1:0] pup_ba;
    wire [10:0] pup_a;
    wire [3:0] pup_dqm;
    wire [31:0] pup_dq;
    wire pup_dot;
    wire [1:0] in_vid_wr_ba;
    wire [10:0] in_vid_wr_a;
    wire [3:0] in_vid_wr_dqm;
    wire [31:0] in_vid_wr_dq;
    wire in_vid_rd_we_n;
    wire [1:0] in_vid_rd_ba;
    wire [10:0] in_vid_rd_a;
    wire [3:0] in_vid_rd_dqm;
    wire [31:0] in_vid_rd_dq;
    wire in_vid_rd_dot;
    wire m4_cf_rd_we_n;
    wire [1:0] m4_cf_rd_ba;
    wire [3:0] m4_cf_rd_dqm;
    wire [31:0] m4_cf_rd_dq;
    wire m4_cf_rd_dot;
    wire out_vid_rd_we_n;
    wire [1:0] out_vid_rd_ba;
    wire [3:0] out_vid_rd_dqm;
    wire [31:0] out_vid_rd_dq;
    wire out_vid_rd_dot;
    wire [1:0] auto_ref_ba;
    wire [10:0] auto_ref_a;
    wire [3:0] auto_ref_dqm;
    wire [31:0] auto_ref_dq;
    wire auto_ref_dot;
    wire m4_cf_cmd_rd_we_n;
    wire [1:0] m4_cf_cmd_rd_ba;
    wire [3:0] m4_cf_cmd_rd_dqm;
    wire [31:0] m4_cf_cmd_rd_dq;
    wire m4_cf_cmd_rd_dot;
    wire [1:0] m4_cf_cmd_wr_ba;
    wire [1:0] out_vid_wr_ba;
    wire [3:0] out_vid_wr_dqm;
    wire idle_cs_n;
    wire idle_ras_n;
    wire idle_cas_n;
    wire idle_we_n;
    wire [1:0] idle_ba;
    wire [10:0] idle_a;
    wire [3:0] idle_dqm;
    wire [31:0] idle_dq;
    wire idle_dot;


// タイミング作成

    // qa  7bitカウンタ (72クロックサイクル作成)
    always @(posedge clk) begin
      if(cycle_stp)
        qa <= 0;
      else
        qa <= qa + 1;
    end

    // cycle_stp, cycle_stp_adv
    always @(posedge clk) begin
      cycle_stp     <= (qa == 7'd70);
      cycle_stp_adv <= (qa == 7'd68);
    end

    // qb  2bitカウンタ (Power up timing 作成)
    always @(posedge clk) begin
      if(~c_done)
        qb <= 0;
      else if(cycle_stp & ~ope_time)
        qb <= qb + 1;
    end

    // pup_time, ope_time
    assign pup_time = qb[0];
    assign ope_time = qb[1];

    // qc  4bitカウンタ (auto_ref_cycle, m4_cmd_cycle 作成)
    always @(posedge clk) begin
      if(~ope_time | (cycle_stp_adv & qc_end))
        qc <= 0;
      else if(cycle_stp_adv)
        qc <= qc + 1;
    end

    // qc_end
    //assign qc_end = qc[3];  // 8;
    assign qc_end = qc[2];  // 4;		//Hasco Automatic 16ms-4096cylces

    // qc_eq0
    always @(posedge clk) begin
      qc_eq0 <= (qc == 4'd0);
    end

    // auto_ref_cycle, m4_cmd_cycle
    always @(posedge clk) begin
      auto_ref_cycle <=  qc_eq0 & ope_time;
      m4_cmd_cycle   <= ~qc_eq0 & ope_time;
    end

    // qa_eq0 -- qa_eq71
    assign qa_eq0  = (qa == 7'd0);
    assign qa_eq2  = (qa == 7'd2);
    assign qa_eq6  = (qa == 7'd6);
    assign qa_eq7  = (qa == 7'd7);
    assign qa_eq8  = (qa == 7'd8);
    assign qa_eq10 = (qa == 7'd10);
    assign qa_eq11 = (qa == 7'd11);
    assign qa_eq12 = (qa == 7'd12);
    assign qa_eq14 = (qa == 7'd14);
    assign qa_eq18 = (qa == 7'd18);
    assign qa_eq19 = (qa == 7'd19);
    assign qa_eq20 = (qa == 7'd20);
    assign qa_eq21 = (qa == 7'd21);
    assign qa_eq23 = (qa == 7'd23);
    assign qa_eq24 = (qa == 7'd24);
    assign qa_eq30 = (qa == 7'd30);
    assign qa_eq31 = (qa == 7'd31);
    assign qa_eq32 = (qa == 7'd32);
    assign qa_eq35 = (qa == 7'd35);
    assign qa_eq36 = (qa == 7'd36);
    assign qa_eq42 = (qa == 7'd42);
    assign qa_eq43 = (qa == 7'd43);
    assign qa_eq44 = (qa == 7'd44);
    assign qa_eq47 = (qa == 7'd47);
    assign qa_eq48 = (qa == 7'd48);
    assign qa_eq51 = (qa == 7'd51);
    assign qa_eq54 = (qa == 7'd54);
    assign qa_eq59 = (qa == 7'd59);
    assign qa_eq62 = (qa == 7'd62);
    assign qa_eq63 = (qa == 7'd63);
    assign qa_eq71 = (qa == 7'd71);

    // qa_0to20 -- qa_66to71
    always @(posedge clk) begin
      qa_0to20  <=  qa_eq71     | (qa < 7'd20);
      qa_3to18  <= (qa > 7'd1 ) & (qa < 7'd18);
      qa_8to11  <= (qa > 7'd6 ) & (qa < 7'd11);
      qa_0to7   <=  qa_eq71     | (qa < 7'd7);
      qa_3to7   <= (qa > 7'd1 ) & (qa < 7'd7);
      qa_20to23 <= (qa > 7'd18) & (qa < 7'd23);
      qa_12to19 <= (qa > 7'd10) & (qa < 7'd19);
      qa_15to19 <= (qa > 7'd13) & (qa < 7'd19);
      qa_32to35 <= (qa > 7'd30) & (qa < 7'd35);
      qa_44to47 <= (qa > 7'd42) & (qa < 7'd47);
      qa_24to31 <= (qa > 7'd22) & (qa < 7'd31);
      qa_36to43 <= (qa > 7'd34) & (qa < 7'd43);
      qa_27to31 <= (qa > 7'd25) & (qa < 7'd31);
      qa_39to43 <= (qa > 7'd37) & (qa < 7'd43);
      qa_21to47 <= (qa > 7'd19) & (qa < 7'd47);
      qa_24to47 <= (qa > 7'd22) & (qa < 7'd47);
      qa_48to62 <= (qa > 7'd46) & (qa < 7'd62);
      qa_48to58 <= (qa > 7'd46) & (qa < 7'd58);
      qa_59to62 <= (qa > 7'd57) & (qa < 7'd62);
      qa_63to71 <= (qa > 7'd61) & (qa < 7'd71);
      qa_66to71 <= (qa > 7'd64) & (qa < 7'd71);
    end


// Power up sequence

    // pwr_up_time
    always @(posedge clk) begin
      pwr_up_time <= pup_time;
    end

    // pup_cs_n
    always @(posedge clk) begin
      pup_cs_n <= ~(qa_eq2 | qa_eq6 | qa_eq10 | qa_eq14 | 
                    qa_eq18 | qa_eq30 | qa_eq42 | qa_eq54);
    end

    // pup_ras_n
    always @(posedge clk) begin
      pup_ras_n <= ~(qa_eq2 | qa_eq6 | qa_eq10 | qa_eq14 | 
                     qa_eq18 | qa_eq30 | qa_eq42 | qa_eq54);
    end

    // pup_cas_n
    always @(posedge clk) begin
      pup_cas_n <= ~(qa_eq10 | qa_eq14 | qa_eq18 | qa_eq30 | qa_eq42 | qa_eq54);
    end

    // pup_we_n
    always @(posedge clk) begin
      pup_we_n <= ~(qa_eq2 | qa_eq6 | qa_eq10 | qa_eq14);
    end

    // pup_ba  2bit
    assign pup_ba = 2'b00;

    // pup_a10a
    always @(posedge clk) begin
      pup_a10a <= (qa_eq2 | qa_eq6);
    end

    // pup_a  11bit
    assign pup_a[10]  = pup_a10a;
    assign pup_a[9:0] = 10'b0000110000;  // Burst Length=1, CASn Latency=3

    // pup_dqm  4bit
    assign pup_dqm = 4'b1111;

    // pup_dq  32bit
    assign pup_dq = 32'hffffffff;

    // pup_dot
    assign pup_dot = 1'b1;


// Input video write

    // in_vid_wr_time
    always @(posedge clk) begin
      in_vid_wr_time <= in_vid_wr_req & qa_0to20 & ope_time;
    end

    // in_vid_wr_cs_n, in_vid_wr_ras_n, in_vid_wr_cas_n, in_vid_wr_we_n
    always @(posedge clk) begin
      in_vid_wr_cs_n  <= ~(qa_eq0 | qa_3to18);
      in_vid_wr_ras_n <= ~qa_eq0;
      in_vid_wr_cas_n <= ~qa_3to18;
      in_vid_wr_we_n  <= ~qa_3to18;
    end

    // in_vid_wr_ba  2bit
    assign in_vid_wr_ba = 2'b00;

    // in_vid_wr_a10a
    always @(posedge clk) begin
      in_vid_wr_a10a <= qa_eq18;
    end

    // in_vid_wr_a_a  9bit
    always @(posedge clk) begin
      in_vid_wr_a_a <= qa_eq0 ? in_vid_wr_adrs[16:8]          // Row address
                              : {1'b0, in_vid_wr_adrs[7:0]};  // Column address
    end

    // in_vid_wr_a  11bit
    assign in_vid_wr_a[10]  = in_vid_wr_a10a;
    assign in_vid_wr_a[9]   = 1'b0;
    assign in_vid_wr_a[8:0] = in_vid_wr_a_a;

    // in_vid_wr_dqm  4bit
    assign in_vid_wr_dqm = 4'b0000;

    // in_vid_wr_dqa  30bit
    always @(posedge clk) begin
      in_vid_wr_dqa <= in_vid_wr_d;
    end

    // in_vid_wr_dq  32bit
    assign in_vid_wr_dq[29:0]  = in_vid_wr_dqa;
    assign in_vid_wr_dq[31:30] = 2'd0;

    // in_vid_wr_dot
    always @(posedge clk) begin
      in_vid_wr_dot <= ~qa_3to18;
    end


// Input video read

    // in_vid_rd_time
    always @(posedge clk) begin
      in_vid_rd_time <= in_vid_rd_req & ~in_vid_wr_req & ~out_vid_rd_req &
                        (qa_8to11 | qa_20to23 | qa_32to35 | qa_44to47) & ope_time;
    end

    // in_vid_rd_cs_n, in_vid_rd_ras_n, in_vid_rd_cas_n
    always @(posedge clk) begin
      in_vid_rd_cs_n  <= ~(qa_eq8 | qa_eq11 | qa_eq20 | qa_eq23 |
                           qa_eq32 | qa_eq35 | qa_eq44 | qa_eq47);
      in_vid_rd_ras_n <= ~(qa_eq8 | qa_eq20 | qa_eq32 | qa_eq44);
      in_vid_rd_cas_n <= ~(qa_eq11 | qa_eq23 | qa_eq35 | qa_eq47);
    end

    // in_vid_rd_we_n
    assign in_vid_rd_we_n = 1'b1;

    // in_vid_rd_ba  2bit
    assign in_vid_rd_ba = 2'b00;

    // in_vid_rd_a10a
    always @(posedge clk) begin
      in_vid_rd_a10a <= (qa_eq11 | qa_eq23 | qa_eq35 | qa_eq47);
    end

    // in_vid_rd_a_a  9bit
    always @(posedge clk) begin
      in_vid_rd_a_a <= (qa_eq8 | qa_eq20 | qa_eq32 | qa_eq44) ? 
                        in_vid_rd_adrs[16:8] :       // Row address
                       {1'b0, in_vid_rd_adrs[7:0]};  // Column address
    end

    // in_vid_rd_a  11bit
    assign in_vid_rd_a[10]  = in_vid_rd_a10a;
    assign in_vid_rd_a[9]   = 1'b0;
    assign in_vid_rd_a[8:0] = in_vid_rd_a_a;

    // in_vid_rd_dqm  4bit
    assign in_vid_rd_dqm = 4'b0000;

    // in_vid_rd_dq  32bit
    assign in_vid_rd_dq = 32'h00000000;

    // in_vid_rd_dot
    assign in_vid_rd_dot = 1'b1;


// M4 coefficient read

    // m4_cf_rd_time
    always @(posedge clk) begin
      m4_cf_rd_time <= in_vid_rd_req & ~in_vid_wr_req & ~out_vid_rd_req &
                       (qa_0to7 | qa_12to19 | qa_24to31 | qa_36to43) & ope_time;
    end

    // m4_cf_rd_cs_n, m4_cf_rd_ras_n, m4_cf_rd_cas_n
    always @(posedge clk) begin
      m4_cf_rd_cs_n  <= ~(qa_eq0 | qa_3to7 | qa_eq12 | qa_15to19 |
                          qa_eq24 | qa_27to31 | qa_eq36 | qa_39to43);
      m4_cf_rd_ras_n <= ~(qa_eq0 | qa_eq12 | qa_eq24 | qa_eq36);
      m4_cf_rd_cas_n <= ~(qa_3to7 | qa_15to19 | qa_27to31 | qa_39to43);
    end

    // m4_cf_rd_we_n
    assign m4_cf_rd_we_n = 1'b1;

    // m4_cf_rd_ba  2bit
    assign m4_cf_rd_ba = {1'b1, m4_bank1};

    // m4_cf_rd_a  11bit
    always @(posedge clk) begin
      m4_cf_rd_a[10]  <= ((qa_eq0 | qa_eq12 | qa_eq24 | qa_eq36) & m4_cf_rd_adrs[18]) |
                           qa_eq7 | qa_eq19 | qa_eq31 | qa_eq43;
      m4_cf_rd_a[9]   <=  (qa_eq0 | qa_eq12 | qa_eq24 | qa_eq36) & m4_cf_rd_adrs[17];
      m4_cf_rd_a[8:0] <=  (qa_eq0 | qa_eq12 | qa_eq24 | qa_eq36) ?
                           m4_cf_rd_adrs[16:8] :       // Row address
                          {1'b0, m4_cf_rd_adrs[7:0]};  // Column address
    end

    // m4_cf_rd_dqm  4bit
    assign m4_cf_rd_dqm = 4'b0000;

    // m4_cf_rd_dq  32bit
    assign m4_cf_rd_dq = 32'h00000000;

    // m4_cf_rd_dot
    assign m4_cf_rd_dot = 1'b1;


// Output video read

    // out_vid_rd_time
    always @(posedge clk) begin
      out_vid_rd_time <= out_vid_rd_req & qa_21to47 & ope_time;
    end

    // out_vid_rd_cs_n, out_vid_rd_ras_n, out_vid_rd_cas_n
    always @(posedge clk) begin
      out_vid_rd_cs_n  <= ~(qa_eq21 | qa_24to47);
      out_vid_rd_ras_n <= ~qa_eq21;
      out_vid_rd_cas_n <= ~qa_24to47;
    end

    // out_vid_rd_we_n
    assign out_vid_rd_we_n = 1'b1;

    // out_vid_rd_ba  2bit
    assign out_vid_rd_ba = 2'b01;

    // out_vid_rd_a  11bit
    always @(posedge clk) begin
      out_vid_rd_a[10]  <= (qa_eq21 & out_vid_rd_adrs[18]) | qa_eq47;
      out_vid_rd_a[9]   <= qa_eq21 & out_vid_rd_adrs[17];
      out_vid_rd_a[8:0] <= qa_eq21 ? out_vid_rd_adrs[16:8]          // Row address
                                   : {1'b0, out_vid_rd_adrs[7:0]};  // Column address
    end

    // out_vid_rd_dqm  4bit
    assign out_vid_rd_dqm = 4'b0000;

    // out_vid_rd_dq  32bit
    assign out_vid_rd_dq = 32'h00000000;

    // out_vid_rd_dot
    assign out_vid_rd_dot = 1'b1;


// Auto refresh read

    // auto_ref_time
    always @(posedge clk) begin
      auto_ref_time <= auto_ref_cycle & qa_48to62 & ope_time;
    end

    // auto_ref_cs_n, auto_ref_ras_n, auto_ref_cas_n, auto_ref_we_n
    always @(posedge clk) begin
      auto_ref_cs_n  <= ~(qa_eq48 | qa_eq51);
      auto_ref_ras_n <= ~(qa_eq48 | qa_eq51);
      auto_ref_cas_n <= ~qa_eq51;
      auto_ref_we_n  <= ~qa_eq48;
    end

    // auto_ref_ba  2bit
    assign auto_ref_ba = 2'b00;

    // auto_ref_a10a
    always @(posedge clk) begin
      auto_ref_a10a <= qa_eq48;
    end

    // auto_ref_a  11bit
    assign auto_ref_a[10]  = auto_ref_a10a;
    assign auto_ref_a[9:0] = 10'd0;

    // auto_ref_dqm  4bit
    assign auto_ref_dqm = 4'b0000;

    // auto_ref_dq  32bit
    assign auto_ref_dq = 32'h00000000;

    // auto_ref_dot
    assign auto_ref_dot = 1'b1;


// M4 coefficient command read

    // m4_cf_cmd_rd_time
    always @(posedge clk) begin
      m4_cf_cmd_rd_time <= m4_cf_cmd_rd_req & m4_cmd_cycle & qa_48to58 & ope_time;
    end

    // m4_cf_cmd_rd_cs_n, m4_cf_cmd_rd_ras_n, m4_cf_cmd_rd_cas_n
    always @(posedge clk) begin
      m4_cf_cmd_rd_cs_n  <= ~(qa_eq48 | qa_eq51);
      m4_cf_cmd_rd_ras_n <= ~qa_eq48;
      m4_cf_cmd_rd_cas_n <= ~qa_eq51;
    end

    // m4_cf_cmd_rd_we_n
    assign m4_cf_cmd_rd_we_n = 1'b1;

    // m4_cf_cmd_rd_ba  2bit
    assign m4_cf_cmd_rd_ba = {1'b1, m4_cf_cmd_rd_bank1};

    // m4_cf_cmd_rd_a  11bit
    always @(posedge clk) begin
      m4_cf_cmd_rd_a[10]  <= (qa_eq48 & m4_cf_cmd_rd_adrs[18]) | qa_eq51;
      m4_cf_cmd_rd_a[9]   <=  qa_eq48 & m4_cf_cmd_rd_adrs[17];
      m4_cf_cmd_rd_a[8:0] <=  qa_eq48 ? m4_cf_cmd_rd_adrs[16:8] :        // Row address
                                        {1'b0, m4_cf_cmd_rd_adrs[7:0]};  // Column address
    end

    // m4_cf_cmd_rd_dqm  4bit
    assign m4_cf_cmd_rd_dqm = 4'b0000;

    // m4_cf_cmd_rd_dq  32bit
    assign m4_cf_cmd_rd_dq = 32'h00000000;

    // m4_cf_cmd_rd_dot
    assign m4_cf_cmd_rd_dot = 1'b1;


// M4 coefficient command write

    // m4_cf_cmd_wr_time
    always @(posedge clk) begin
      m4_cf_cmd_wr_time <= m4_cf_cmd_wr_req & m4_cmd_cycle & qa_59to62 & ope_time;
    end

    // m4_cf_cmd_wr_cs_n, m4_cf_cmd_wr_ras_n, m4_cf_cmd_wr_cas_n, m4_cf_cmd_wr_we_n
    always @(posedge clk) begin
      m4_cf_cmd_wr_cs_n  <= ~(qa_eq59 | qa_eq62);
      m4_cf_cmd_wr_ras_n <= ~qa_eq59;
      m4_cf_cmd_wr_cas_n <= ~qa_eq62;
      m4_cf_cmd_wr_we_n  <= ~qa_eq62;
    end

    // m4_cf_cmd_wr_ba  2bit
    assign m4_cf_cmd_wr_ba = {1'b1, m4_cf_cmd_wr_bank1};

    // m4_cf_cmd_wr_a  11bit
    always @(posedge clk) begin
      m4_cf_cmd_wr_a[10]  <= (qa_eq59 & m4_cf_cmd_wr_adrs[18]) | qa_eq62;
      m4_cf_cmd_wr_a[9]   <=  qa_eq59 & m4_cf_cmd_wr_adrs[17];
      m4_cf_cmd_wr_a[8:0] <=  qa_eq59 ? m4_cf_cmd_wr_adrs[16:8] :        // Row address
                                        {1'b0, m4_cf_cmd_wr_adrs[7:0]};  // Column address
    end

    // m4_cf_cmd_wr_dqm  4bit
    always @(posedge clk) begin
      m4_cf_cmd_wr_dqm <= m4_cf_cmd_wr_byten;
    end

    // m4_cf_cmd_wr_dq  32bit
    always @(posedge clk) begin
      m4_cf_cmd_wr_dq <= m4_cf_cmd_wr_d;
    end

    // m4_cf_cmd_wr_dot
    always @(posedge clk) begin
      m4_cf_cmd_wr_dot <= ~qa_eq62;
    end


// Output video write

    // out_vid_wr_time
    always @(posedge clk) begin
      out_vid_wr_time <= out_vid_wr_req & qa_63to71 & ope_time;
    end

    // out_vid_wr_cs_n, out_vid_wr_ras_n, out_vid_wr_cas_n, out_vid_wr_we_n
    always @(posedge clk) begin
      out_vid_wr_cs_n  <= ~(qa_eq63 | qa_66to71);
      out_vid_wr_ras_n <= ~qa_eq63;
      out_vid_wr_cas_n <= ~qa_66to71;
      out_vid_wr_we_n  <= ~qa_66to71;
    end

    // out_vid_wr_ba  2bit
    assign out_vid_wr_ba = 2'b01;

    // out_vid_wr_a  11bit
    always @(posedge clk) begin
      out_vid_wr_a[10]  <= (qa_eq63 & out_vid_wr_adrs[18]) | qa_eq71;
      out_vid_wr_a[9]   <= qa_eq63 & out_vid_wr_adrs[17];
      out_vid_wr_a[8:0] <= qa_eq63 ? out_vid_wr_adrs[16:8] :        // Row address
                                     {1'b0, out_vid_wr_adrs[7:0]};  // Column address
    end

    // out_vid_wr_dqm  4bit
    assign out_vid_wr_dqm = 4'b0000;

    // out_vid_wr_dq  32bit
    always @(posedge clk) begin
      out_vid_wr_dq <= out_vid_wr_d;
    end

    // out_vid_wr_dot
    always @(posedge clk) begin
      out_vid_wr_dot <= ~qa_66to71;
    end


// Idle

    // idle_cs_n, idle_ras_n, idle_cas_n, idle_we_n
    assign idle_cs_n  = 1'b1;
    assign idle_ras_n = 1'b1;
    assign idle_cas_n = 1'b1;
    assign idle_we_n  = 1'b1;

    // idle_ba  2bit
    assign idle_ba = 2'b00;

    // idle_a  11bit
    assign idle_a = 11'd0;

    // idle_dqm  4bit
    assign idle_dqm = 4'b0000;

    // idle_dq  32bit
    assign idle_dq = 32'h00000000;

    // idle_dot
    assign idle_dot = 1'b1;


// 出力部

    // cke_a, cke
    always @(posedge clk) begin
      cke_a <= pup_time | ope_time;
      cke   <= cke_a;
    end

    // cs_n
    always @(posedge clk) begin
      if(pwr_up_time)
        cs_n <= pup_cs_n;
      else if(in_vid_wr_time)
        cs_n <= in_vid_wr_cs_n;
      else if(in_vid_rd_time)
        cs_n <= in_vid_rd_cs_n;
      else if(m4_cf_rd_time)
        cs_n <= m4_cf_rd_cs_n;
      else if(out_vid_rd_time)
        cs_n <= out_vid_rd_cs_n;
      else if(auto_ref_time)
        cs_n <= auto_ref_cs_n;
      else if(m4_cf_cmd_rd_time)
        cs_n <= m4_cf_cmd_rd_cs_n;
      else if(m4_cf_cmd_wr_time)
        cs_n <= m4_cf_cmd_wr_cs_n;
      else if(out_vid_wr_time)
        cs_n <= out_vid_wr_cs_n;
      else
        cs_n <= idle_cs_n;
    end

    // ras_n
    always @(posedge clk) begin
      if(pwr_up_time)
        ras_n <= pup_ras_n;
      else if(in_vid_wr_time)
        ras_n <= in_vid_wr_ras_n;
      else if(in_vid_rd_time)
        ras_n <= in_vid_rd_ras_n;
      else if(m4_cf_rd_time)
        ras_n <= m4_cf_rd_ras_n;
      else if(out_vid_rd_time)
        ras_n <= out_vid_rd_ras_n;
      else if(auto_ref_time)
        ras_n <= auto_ref_ras_n;
      else if(m4_cf_cmd_rd_time)
        ras_n <= m4_cf_cmd_rd_ras_n;
      else if(m4_cf_cmd_wr_time)
        ras_n <= m4_cf_cmd_wr_ras_n;
      else if(out_vid_wr_time)
        ras_n <= out_vid_wr_ras_n;
      else
        ras_n <= idle_ras_n;
    end

    // cas_n
    always @(posedge clk) begin
      if(pwr_up_time)
        cas_n <= pup_cas_n;
      else if(in_vid_wr_time)
        cas_n <= in_vid_wr_cas_n;
      else if(in_vid_rd_time)
        cas_n <= in_vid_rd_cas_n;
      else if(m4_cf_rd_time)
        cas_n <= m4_cf_rd_cas_n;
      else if(out_vid_rd_time)
        cas_n <= out_vid_rd_cas_n;
      else if(auto_ref_time)
        cas_n <= auto_ref_cas_n;
      else if(m4_cf_cmd_rd_time)
        cas_n <= m4_cf_cmd_rd_cas_n;
      else if(m4_cf_cmd_wr_time)
        cas_n <= m4_cf_cmd_wr_cas_n;
      else if(out_vid_wr_time)
        cas_n <= out_vid_wr_cas_n;
      else
        cas_n <= idle_cas_n;
    end

    // we_n
    always @(posedge clk) begin
      if(pwr_up_time)
        we_n <= pup_we_n;
      else if(in_vid_wr_time)
        we_n <= in_vid_wr_we_n;
      else if(in_vid_rd_time)
        we_n <= in_vid_rd_we_n;
      else if(m4_cf_rd_time)
        we_n <= m4_cf_rd_we_n;
      else if(out_vid_rd_time)
        we_n <= out_vid_rd_we_n;
      else if(auto_ref_time)
        we_n <= auto_ref_we_n;
      else if(m4_cf_cmd_rd_time)
        we_n <= m4_cf_cmd_rd_we_n;
      else if(m4_cf_cmd_wr_time)
        we_n <= m4_cf_cmd_wr_we_n;
      else if(out_vid_wr_time)
        we_n <= out_vid_wr_we_n;
      else
        we_n <= idle_we_n;
    end

    // ba  2bit
    always @(posedge clk) begin
      if(pwr_up_time)
        ba <= pup_ba;
      else if(in_vid_wr_time)
        ba <= in_vid_wr_ba;
      else if(in_vid_rd_time)
        ba <= in_vid_rd_ba;
      else if(m4_cf_rd_time)
        ba <= m4_cf_rd_ba;
      else if(out_vid_rd_time)
        ba <= out_vid_rd_ba;
      else if(auto_ref_time)
        ba <= auto_ref_ba;
      else if(m4_cf_cmd_rd_time)
        ba <= m4_cf_cmd_rd_ba;
      else if(m4_cf_cmd_wr_time)
        ba <= m4_cf_cmd_wr_ba;
      else if(out_vid_wr_time)
        ba <= out_vid_wr_ba;
      else
        ba <= idle_ba;
    end

    // adrs  11bit
    always @(posedge clk) begin
      if(pwr_up_time)
        adrs <= pup_a;
      else if(in_vid_wr_time)
        adrs <= in_vid_wr_a;
      else if(in_vid_rd_time)
        adrs <= in_vid_rd_a;
      else if(m4_cf_rd_time)
        adrs <= m4_cf_rd_a;
      else if(out_vid_rd_time)
        adrs <= out_vid_rd_a;
      else if(auto_ref_time)
        adrs <= auto_ref_a;
      else if(m4_cf_cmd_rd_time)
        adrs <= m4_cf_cmd_rd_a;
      else if(m4_cf_cmd_wr_time)
        adrs <= m4_cf_cmd_wr_a;
      else if(out_vid_wr_time)
        adrs <= out_vid_wr_a;
      else
        adrs <= idle_a;
    end

    // dqm  4bit
    always @(posedge clk) begin
      if(pwr_up_time)
        dqm <= pup_dqm;
      else if(in_vid_wr_time)
        dqm <= in_vid_wr_dqm;
      else if(in_vid_rd_time)
        dqm <= in_vid_rd_dqm;
      else if(m4_cf_rd_time)
        dqm <= m4_cf_rd_dqm;
      else if(out_vid_rd_time)
        dqm <= out_vid_rd_dqm;
      else if(auto_ref_time)
        dqm <= auto_ref_dqm;
      else if(m4_cf_cmd_rd_time)
        dqm <= m4_cf_cmd_rd_dqm;
      else if(m4_cf_cmd_wr_time)
        dqm <= m4_cf_cmd_wr_dqm;
      else if(out_vid_wr_time)
        dqm <= out_vid_wr_dqm;
      else
        dqm <= idle_dqm;
    end

    // dq  32bit
    always @(posedge clk) begin
      if(pwr_up_time)
        dq <= pup_dq;
      else if(in_vid_wr_time)
        dq <= in_vid_wr_dq;
      else if(in_vid_rd_time)
        dq <= in_vid_rd_dq;
      else if(m4_cf_rd_time)
        dq <= m4_cf_rd_dq;
      else if(out_vid_rd_time)
        dq <= out_vid_rd_dq;
      else if(auto_ref_time)
        dq <= auto_ref_dq;
      else if(m4_cf_cmd_rd_time)
        dq <= m4_cf_cmd_rd_dq;
      else if(m4_cf_cmd_wr_time)
        dq <= m4_cf_cmd_wr_dq;
      else if(out_vid_wr_time)
        dq <= out_vid_wr_dq;
      else
        dq <= idle_dq;
    end

    // dot_a
    always @(posedge clk) begin
      if(pwr_up_time)
        dot_a <= pup_dot;
      else if(in_vid_wr_time)
        dot_a <= in_vid_wr_dot;
      else if(in_vid_rd_time)
        dot_a <= in_vid_rd_dot;
      else if(m4_cf_rd_time)
        dot_a <= m4_cf_rd_dot;
      else if(out_vid_rd_time)
        dot_a <= out_vid_rd_dot;
      else if(auto_ref_time)
        dot_a <= auto_ref_dot;
      else if(m4_cf_cmd_rd_time)
        dot_a <= m4_cf_cmd_rd_dot;
      else if(m4_cf_cmd_wr_time)
        dot_a <= m4_cf_cmd_wr_dot;
      else if(out_vid_wr_time)
        dot_a <= out_vid_wr_dot;
      else
        dot_a <= idle_dot;
    end

    // dot
    always @(posedge clk) begin
      dot   <= dot_a;
    end

endmodule
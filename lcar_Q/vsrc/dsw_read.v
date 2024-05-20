module dsw_read(CLK, 
                C_DONE, 
                C_DONE_DLY, 
                DSW_TP);

    input CLK;
    input C_DONE;
   output C_DONE_DLY;
   output DSW_TP;
   
   
   dsw_rd  dsw_rd_0 (.clk(CLK), 
                    .c_done(C_DONE), 
                    .c_done_dly(C_DONE_DLY), 
                    .dsw_tp(DSW_TP));
endmodule

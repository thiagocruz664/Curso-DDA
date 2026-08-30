module count(i_sw, o_valid, i_reset, clock);
    output          o_valid;
    
    input   [2:0]   i_sw;
    input           i_reset;
    input           clock;

    wire    [1:0]   reset;
    wire    [1:0]   count;
    
    counter u_counter(
        .i_sw(i_sw[0]),
        .i_com_reset(reset[0]), 
        .o_count(count[0]), 
        .i_reset(i_reset), 
        .clock(clock)
    );
endmodule
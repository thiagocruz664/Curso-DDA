module count(i_sw, o_valid, i_reset, clock);
    output          o_valid;
    
    input   [2:0]   i_sw;
    input           i_reset;
    input           clock;

    wire    [1:0]   reset;
    wire    [1:0]   count;
    wire    [1:0]   compare;
    reg     o_valid;

    counter u_counter(
        .i_sw(i_sw[0]),
        .i_com_reset(reset[0]), 
        .o_count(count[0]), 
        .i_reset(i_reset), 
        .clock(clock)
    );

    rx_mux  u_rx_mux(
        .i_sw(i_sw[2:1]),
        .o_mux(compare[0])
    );

    always @(*) begin
        if (count[1] == compare[1]) begin
            o_valid <= 'b1;
        end else begin
            o_valid <= 'b0;
        end
    end
endmodule
module count(i_sw, o_valid, i_reset, clock);
    output  reg     o_valid;
    
    input   [2:0]   i_sw;
    input           i_reset;
    input           clock;

    wire            reset;
    wire    [31:0]  count;
    wire    [31:0]   compare;

    counter u_counter(
        .i_sw(i_sw[0]),
        .i_com_reset(reset), 
        .o_count(count), 
        .i_reset(i_reset), 
        .clock(clock)
    );

    rx_mux  u_rx_mux(
        .i_sw(i_sw[2:1]),
        .o_mux(compare)
    );

    always @(*) begin
        if (count == compare) begin
            o_valid <= 'b1;
        end else begin
            o_valid <= 'b0;
        end
    end
endmodule
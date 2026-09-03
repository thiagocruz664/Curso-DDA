module counter(i_sw, i_com_reset, o_count, i_reset, clock);
    input           i_sw;
    input           i_com_reset;
    input           i_reset;
    input           clock;

    output  reg [31:0]  o_count;
    
    wire    [31:0]  sum;

    rca u_rca(
        .i_a(o_count),
        .i_b(1),
        .i_carry('b0),
        .o_sum(sum)
    );

    always @(posedge clock) begin
        if (i_reset || i_com_reset) begin
            o_count <= 32'b0;
        end else begin
            o_count <= sum;
        end
    end
endmodule
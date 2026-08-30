module counter(i_sw, i_com_reset, o_count, i_reset, clock);
    input           i_sw;
    input           i_com_reset;
    input           i_reset;
    input           clock;

    output          o_count;

    reg     [31:0]  count;
    wire            sum;
    assign o_count = count;

    rca u_rca(
        .i_a(o_count),
        .i_b(1),
        .i_carry(0),
        .o_sum(sum),
        .*
    );

    always @(posedge clock) begin
        count <= sum;
    end
endmodule
module rca(i_a, i_b, i_carry, o_sum, o_carry);
    output  [2:0]   o_sum;
    output          o_carry;

    input   [2:0]   i_a;
    input   [2:0]   i_b;
    input           i_carry;

    wire    [1:0]   carry;

    fulladder
        u_fulladder_0(
            .i_a(i_a[0]),
            .i_b(i_b[0]),
            .i_carry(i_carry),

            .o_sum(o_sum[0]),
            .o_carry(carry[0])
        );
        u_fulladder_1(
            .i_a(i_a[1]),
            .i_b(i_b[1]),
            .i_carry(carry[1]),

            .o_sum(o_sum[1]),
            .o_carry(carry[0])
        );
        u_fulladder_2(
            .i_a(i_a[2]),
            .i_b(i_b[2]),
            .i_carry(carry[1]),

            .o_sum(o_sum[2]),
            .o_carry(o_carry)
        );
endmodule
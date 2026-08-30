module rca(i_a, i_b, i_carry, o_sum, o_carry);
    output  [31:0]   o_sum;
    output          o_carry;

    input   [31:0]   i_a;
    input   [31:0]   i_b;
    input           i_carry;

    wire    [32:0]   carry;
    assign  carry[0] = i_carry;
    assign  carry[32] = o_carry;

    genvar i;
    generate
        for (i=0; i<31; i=i+1) begin
            fulladder u_fa(
                .i_a(i_a[i]),
                .i_b(i_b[i]),
                .i_carry(carry[i]),
                .o_sum(o_sum[i]),
                .o_carry(carry[i+1])
            );
        end
    endgenerate
endmodule
module fulladder(i_carry, i_a, i_b, o_carry, o_sum);
    output  o_carry;
    output  o_sum;

    input   i_a;
    input   i_b;
    input   i_carry;

    assign  {o_carry, o_sum} = i_a + i_b + i_carry;
endmodule
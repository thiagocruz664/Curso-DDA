module sum_sat (i_exp_a, i_exp_b, o_exp_y);
parameter NB_EXPONENTES = 4;

input   [NB_EXPONENTES-1 : 0]   i_exp_a;
input   [NB_EXPONENTES-1 : 0]   i_exp_b;
output  [NB_EXPONENTES-1 : 0]   o_exp_y;

wire    [NB_EXPONENTES : 0]     w_sum;

assign w_sum = i_exp_a + i_exp_b;

assign o_exp_y = (w_sum < 7) ? 4'b0000 : (w_sum > 22) ? 4'b1111 : w_sum;

endmodule
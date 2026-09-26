module mul_trunc (i_man_a, i_man_b, o_man_y);
parameter NB_MANTIZA = 8;

input   [NB_MANTIZA-1 : 0]   i_man_a;
input   [NB_MANTIZA-1 : 0]   i_man_b;
output  [NB_MANTIZA-1 : 0]   o_man_y;

wire    [2*NB_MANTIZA-1 : 0]     w_mul;

assign w_mul = i_man_a * i_man_b;

assign o_man_y = w_mul[NB_MANTIZA-1 : 0];

endmodule
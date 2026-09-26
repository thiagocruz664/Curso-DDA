module top (i_a, i_b, o_y);
parameter NB_NUMERO = 13;
parameter NB_MANTIZA = 8;
parameter NB_EXPONENTES = 4;

input   [NB_NUMERO-1 : 0]   i_a;
input   [NB_NUMERO-1 : 0]   i_b;
output  [NB_NUMERO-1 : 0]   o_y;

m_xor u_sign(
    .i_a    (i_a[NB_NUMERO-1]),
    .i_b    (i_b[NB_NUMERO-1]),
    .o_y    (o_y[NB_NUMERO-1])
);

sum_sat #(
    .NB_EXPONENTES  (NB_EXPONENTES)
) u_exp (
    .i_exp_a    (i_a[NB_NUMERO-2 : NB_MANTIZA]),
    .i_exp_b    (i_b[NB_NUMERO-2 : NB_MANTIZA]),
    .o_exp_y    (o_y[NB_NUMERO-2 : NB_MANTIZA])
);

mul_trunc #(
    .NB_MANTIZA  (NB_MANTIZA)
) u_man (
    .i_man_a    (i_a[NB_MANTIZA-1 : 0]),
    .i_man_b    (i_b[NB_MANTIZA-1 : 0]),
    .o_man_y    (o_y[NB_MANTIZA-1 : 0])
);

endmodule
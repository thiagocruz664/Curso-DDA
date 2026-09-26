module m_xor (i_a, i_b, o_y);

input   i_a;
input   i_b;
output  o_y;
    
assign o_y = i_a ^ i_b;

endmodule
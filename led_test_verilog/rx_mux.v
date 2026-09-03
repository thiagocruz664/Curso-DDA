module rx_mux (i_sw, o_mux);
    input   [1:0]   i_sw;

    output  [31:0]  o_mux;

    reg     [31:0]  o_mux;
    reg     [31:0]  r0 = 'b1;
    reg     [31:0]  r1 = 'b1;
    reg     [31:0]  r2 = 'b1;
    reg     [31:0]  r3 = 'b1;

    always@(*) begin
        case (i_sw)
            2'b00: o_mux = r0;
            2'b01: o_mux = r1;
            2'b10: o_mux = r2;
            2'b11: o_mux = r3;
        endcase
    end
endmodule
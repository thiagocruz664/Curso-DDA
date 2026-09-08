module data_select(i_data1, i_data2, i_sel, o_data);
    parameter NB_DATA = 3;
    parameter NB_SELECT = 2;

    input   [NB_DATA-1 : 0]     i_data1;
    input   [NB_DATA-1 : 0]     i_data2;
    input   [NB_SELECT-1 : 0]   i_sel;

    output  [NB_DATA-1 : 0]     o_data;

    wire    [NB_DATA : 0]       w_sum;
    wire    [NB_DATA : 0]       w_carry     =   {NB_DATA+1{1'b0}};
    reg     [NB_DATA-1 : 0]     w_data;

    wire    mux_i0  =   {1'b0, i_data2};
    wire    mux_i1  =   w_sum;
    wire    mux_i2  =   {1'b0, i_data1};

    fulladder u_fa0(
        .i_a(i_data1[0]),
        .i_b(i_data2[0]),
        .i_carry(w_carry[0]),
        .o_sum(w_sum[0]),
        .o_carry(w_carry[1])
    );
    fulladder u_fa1(
        .i_a(i_data1[1]),
        .i_b(i_data2[1]),
        .i_carry(w_carry[1]),
        .o_sum(w_sum[1]),
        .o_carry(w_carry[2])
    );
    fulladder u_fa2(
        .i_a(i_data1[2]),
        .i_b(i_data2[2]),
        .i_carry(w_carry[2]),
        .o_sum(w_sum[2]),
        .o_carry(w_sum[3])
    );

    always @(*) begin
        case (i_sel)
            2'b00 : w_data <= mux_i0;
            2'b01 : w_data <= mux_i0;
            2'b10 : w_data <= mux_i0;
        endcase
    end

    assign o_data = w_data;
endmodule
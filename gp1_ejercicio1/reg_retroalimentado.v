module reg_retroalimentado(i_data, i_rst_n, o_data, o_overflow, clock);
    parameter NB_DATA = 6;

    input   [NB_DATA-1 : 0]     i_data;
    input                       clock;
    input                       i_rst_n;

    output  [NB_DATA-1 : 0]     o_data;
    output                      o_overflow;

    wire    [NB_DATA : 0]       w_sum;
    reg     [NB_DATA : 0]       r_sum;
    wire    [NB_DATA : 0]       w_carry     =   {NB_DATA+1{1'b0}};

    fulladder u_fa0(
        .i_a(i_data[0]),
        .i_b(r_sum[0]),
        .i_carry(w_carry[0]),
        .o_sum(w_sum[0]),
        .o_carry(w_carry[1])
    );
    fulladder u_fa1(
        .i_a(i_data[1]),
        .i_b(r_sum[1]),
        .i_carry(w_carry[1]),
        .o_sum(w_sum[1]),
        .o_carry(w_carry[2])
    );
    fulladder u_fa2(
        .i_a(i_data[2]),
        .i_b(r_sum[2]),
        .i_carry(w_carry[2]),
        .o_sum(w_sum[2]),
        .o_carry(w_carry[3])
    );
    fulladder u_fa3(
        .i_a(i_data[3]),
        .i_b(r_sum[3]),
        .i_carry(w_carry[3]),
        .o_sum(w_sum[3]),
        .o_carry(w_carry[4])
    );
    fulladder u_fa4(
        .i_a(i_data[4]),
        .i_b(r_sum[4]),
        .i_carry(w_carry[4]),
        .o_sum(w_sum[4]),
        .o_carry(w_carry[5])
    );
    fulladder u_fa5(
        .i_a(i_data[5]),
        .i_b(r_sum[5]),
        .i_carry(w_carry[5]),
        .o_sum(w_sum[5]),
        .o_carry(w_sum[6])
    );

    always @(posedge clock) begin
        if (i_rst_n) begin
            r_sum <= w_sum;
        end else begin
            r_sum <= 7'b0000000;
        end
    end

    assign o_data = r_sum[5:0];
    assign o_overflow = r_sum[0];
endmodule
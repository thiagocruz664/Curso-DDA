module top(i_data1, i_data2, i_sel, i_rst_n, o_data, o_overflow, clock);
    parameter NB_INPUTS = 3;
    parameter NB_OUTPUTS = 6;
    parameter NB_SELECT = 2;

    input   [NB_INPUTS-1 : 0]       i_data1;
    input   [NB_INPUTS-1 : 0]       i_data2;
    input   [NB_SELECT-1 : 0]       i_sel;
    input                           i_rst_n;
    input                           clock;

    output  [NB_OUTPUTS-1 : 0]      o_data;
    output                          o_overflow;

    wire    [NB_INPUTS : 0]         w_data_sel;

    data_select #(
        .NB_DATA    (NB_INPUTS),
        .NB_SELECT  (NB_SELECT)
    ) u_ds (
        .i_data1    (i_data1),
        .i_data2    (i_data2),
        .i_sel      (i_sel),
        .o_data     (w_data_sel)
    );

    reg_retroalimentado #(
        .NB_DATA        (NB_OUTPUTS)
    ) u_rr (
        .i_data         (w_data_sel),
        .i_rst_n        (i_rst_n),
        .clock          (clock),
        .o_data         (o_data),
        .o_overflow     (o_overflow)
    );
endmodule
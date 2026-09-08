module data_select(i_data1, i_data2, i_sel, o_data);
    parameter NB_DATA = 3;
    parameter NB_SELECT = 2;

    input   [NB_DATA-1 : 0]     i_data1;
    input   [NB_DATA-1 : 0]     i_data2;
    input   [NB_SELECT-1 : 0]   i_sel;

    output  [NB_DATA : 0]     o_data;

    reg     [NB_DATA : 0]     r_data;

    wire    [NB_DATA : 0]   mux_i0;
    wire    [NB_DATA : 0]   mux_i1;
    wire    [NB_DATA : 0]   mux_i2;
 
    assign  mux_i0  =   {1'b0, i_data2};
    assign  mux_i1  =   i_data1 + i_data2;
    assign  mux_i2  =   {1'b0, i_data1};

    always @(*) begin
        case (i_sel)
            2'b00 : r_data <= mux_i0;
            2'b01 : r_data <= mux_i1;
            2'b10 : r_data <= mux_i2;
            default: r_data = 4'b0000;
        endcase
    end

    assign o_data = r_data;
endmodule
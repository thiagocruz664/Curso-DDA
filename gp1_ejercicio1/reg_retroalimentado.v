module reg_retroalimentado(i_data, i_rst_n, o_data, o_overflow, clock);
    parameter NB_DATA = 6;
    parameter NB_INPUT = 4;

    input   [NB_INPUT-1 : 0]    i_data;
    input                       clock;
    input                       i_rst_n;

    output  [NB_DATA-1 : 0]     o_data;
    output                      o_overflow;

    reg     [NB_DATA : 0]       r_sum;
    
    wire    [NB_DATA : 0]       w_sum;

    assign w_sum = r_sum + {2'b00, i_data};

    always @(posedge clock) begin
        if (i_rst_n) begin
            r_sum <= w_sum;
        end else begin
            r_sum <= 7'b0000000;
        end
    end

    assign o_data = r_sum[5:0];
    assign o_overflow = r_sum[6];
endmodule
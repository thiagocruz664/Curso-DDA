`timescale 1ns / 1ps

module tb_top;
    parameter NB_INPUTS  = 3;
    parameter NB_OUTPUTS = 6;
    parameter NB_SELECT  = 2;

    reg [NB_INPUTS-1:0] i_data1;
    reg [NB_INPUTS-1:0] i_data2;
    reg [NB_SELECT-1:0] i_sel;
    reg                 i_rst_n;
    reg                 clock;

    wire [NB_OUTPUTS-1:0] o_data;
    wire                  o_overflow;

    top #(
        .NB_INPUTS  (NB_INPUTS),
        .NB_OUTPUTS (NB_OUTPUTS),
        .NB_SELECT  (NB_SELECT)
    ) dut (
        .i_data1    (i_data1),
        .i_data2    (i_data2),
        .i_sel      (i_sel),
        .i_rst_n    (i_rst_n),
        .clock      (clock),
        .o_data     (o_data),
        .o_overflow (o_overflow)
    );

    // Clock: período = 10 ns
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        // Estado inicial
        i_data1 = 3'b000;
        i_data2 = 3'b000;
        i_sel   = 2'b00;
        i_rst_n = 1'b0;

        // RESET INICIAL
        #20;
        i_rst_n = 1'b1;

        // Selecciona i_data2
        // Valor pequeño para comprobar funcionamiento básico
        i_sel   = 2'b00;
        i_data1 = 3'd1;
        i_data2 = 3'd2;

        #30;

        // RESET
        i_rst_n = 1'b0;

        #20;
        i_rst_n = 1'b1;

        // Selecciona i_data1 + i_data2
        // 7 + 7 = 14
        // 14 * 5 = 70 -> overflow
        i_sel   = 2'b01;
        i_data1 = 3'd7;
        i_data2 = 3'd7;

        #60;

        // RESET
        i_rst_n = 1'b0;

        #20;
        i_rst_n = 1'b1;

        // Selecciona i_data1
        // 7 * 10 = 70 -> overflow
        i_sel   = 2'b10;
        i_data1 = 3'd7;
        i_data2 = 3'd0;

        #110;
        $finish;
    end

endmodule
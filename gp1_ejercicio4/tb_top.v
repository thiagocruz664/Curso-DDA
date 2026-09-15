`timescale 1ns / 1ps

module tb_top;
    parameter NB_INPUT = 8;
    parameter NB_OUTPUT = 12;

    reg signed  [NB_INPUT-1 : 0]    i_x;
    reg                             clock;
    reg                             reset;

    wire signed [NB_OUTPUT-1 : 0]   o_y;

    top #(
        .NB_INPUT   (NB_INPUT),
        .NB_OUTPUT  (NB_OUTPUT)
    ) u_top (
        .i_x        (i_x),
        .o_y        (o_y),
        .clock      (clock),
        .reset      (reset)
    );

    // Clock: período = 10 ns
    initial begin
        clock = 1;
        forever #5 clock = ~clock;
    end

    initial begin
        i_x = 8'b00000000;
        reset = 1'b0;

        #20;

        reset = 1'b1;

        i_x = 8'b00010000;
        #10;

        i_x = 8'b00001000;
        #10;

        i_x = 8'b00000100;
        #10;

        i_x = 8'b00000010;
        #10;

        i_x = 8'b00000001;
        #10;
        
        i_x = 8'b00000000;
        #140;

        $finish;
    end
endmodule
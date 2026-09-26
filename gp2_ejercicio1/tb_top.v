`timescale 1ns/1ps

module tb_top;

parameter NB_NUMERO = 13;
parameter NB_MANTIZA = 8;
parameter NB_EXPONENTES = 4;

reg  [NB_NUMERO-1:0] i_a;
reg  [NB_NUMERO-1:0] i_b;
wire [NB_NUMERO-1:0] o_y;

top #(
    .NB_NUMERO      (NB_NUMERO),
    .NB_EXPONENTES  (NB_EXPONENTES),
    .NB_MANTIZA     (NB_MANTIZA)
)u_top (
    .i_a(i_a),
    .i_b(i_b),
    .o_y(o_y)
);

initial begin
    // Caso 1:
    // Signo: 0 ^ 0 = 0
    // Exponente: 8 + 8 - 7 = 9
    // Mantisa: 10 * 20 = 200 -> C8
    i_a = {1'b0, 4'd8, 8'd10};
    i_b = {1'b0, 4'd8, 8'd20};
    #10;

    // Caso 2:
    // Signo: 0 ^ 1 = 1
    // Exponente: 5 + 4 - 7 = 2
    // Mantisa: 15 * 10 = 150 -> 96
    i_a = {1'b0, 4'd5, 8'd15};
    i_b = {1'b1, 4'd4, 8'd10};
    #10;

    // Caso 3:
    // Saturación inferior:
    // 2 + 3 - 7 = -2 -> 0
    i_a = {1'b0, 4'd2, 8'd10};
    i_b = {1'b0, 4'd3, 8'd10};
    #10;

    // Caso 4:
    // Saturación superior:
    // 15 + 15 - 7 = 23 -> 15
    i_a = {1'b0, 4'd15, 8'd10};
    i_b = {1'b0, 4'd15, 8'd10};
    #10;

    // Caso 5:
    // Exponente exactamente 15:
    // 10 + 12 - 7 = 15
    i_a = {1'b0, 4'd10, 8'd100};
    i_b = {1'b0, 4'd12, 8'd2};
    #10;

    // Caso 6:
    // Exponente exactamente 0:
    // 3 + 4 - 7 = 0
    i_a = {1'b1, 4'd3, 8'd200};
    i_b = {1'b1, 4'd4, 8'd3};
    #10;

    // Caso 7:
    // Mantisa máxima:
    // 255 * 255 = 65025 = FE01
    // Se conservan los 8 bits inferiores: 01
    i_a = {1'b0, 4'd8, 8'd255};
    i_b = {1'b0, 4'd8, 8'd255};
    #10;

    $finish;
end

initial begin
    $monitor("t=%0t | A=%b | B=%b | Y=%b",
             $time, i_a, i_b, o_y);
end

endmodule
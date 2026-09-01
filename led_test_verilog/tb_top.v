`timescale 1ns/1ps

module tb_top;

    reg         clock;
    reg         i_reset;
    reg  [3:0]  i_sw;

    wire [3:0]  o_led;
    wire [3:0]  o_led_b;
    wire [3:0]  o_led_g;

    // DUT
    top uut (
        .o_led(o_led),
        .o_led_b(o_led_b),
        .o_led_g(o_led_g),
        .i_sw(i_sw),
        .i_reset(i_reset),
        .clock(clock)
    );

    // Clock: período de 10 ns
    initial begin
        clock = 1'b0;
        forever #5 clock = ~clock;
    end

    // Pruebas
    initial begin

        // Estado inicial
        i_reset = 1'b1;
        i_sw    = 4'b0000;

        #20;

        // Soltar reset
        i_reset = 1'b0;

        // =========================================
        // PRUEBA 1
        // i_sw[3] = 0 -> o_led_b y o_led_g siguen o_led
        // i_sw[2:0] = 000
        // =========================================
        i_sw = 4'b0000;
        #50;

        // =========================================
        // PRUEBA 2
        // Cambiar entrada del contador
        // =========================================
        i_sw = 4'b0001;
        #100;

        // =========================================
        // PRUEBA 3
        // Otra entrada
        // =========================================
        i_sw = 4'b0010;
        #100;

        // =========================================
        // PRUEBA 4
        // Otra entrada
        // =========================================
        i_sw = 4'b0101;
        #100;

        // =========================================
        // PRUEBA 5
        // i_sw[3] = 1
        // o_led_b y o_led_g deberían quedar en 0000
        // =========================================
        i_sw = 4'b1000;
        #50;

        // =========================================
        // PRUEBA 6
        // i_sw[3] = 1 + entrada al contador
        // =========================================
        i_sw = 4'b1011;
        #100;

        // =========================================
        // PRUEBA 7
        // Volver a i_sw[3] = 0
        // =========================================
        i_sw = 4'b0011;
        #100;

        // =========================================
        // PRUEBA 8
        // Volver a presionar RESET
        // =========================================
        i_reset = 1'b1;
        #30;

        // Soltar RESET
        i_reset = 1'b0;
        i_sw    = 4'b0111;
        #100;

        $finish;
    end

    // Mostrar cambios importantes
    initial begin
        $monitor(
            "Tiempo=%0t | RESET=%b | SW=%b | LED=%b | LED_B=%b | LED_G=%b",
            $time,
            i_reset,
            i_sw,
            o_led,
            o_led_b,
            o_led_g
        );
    end

endmodule
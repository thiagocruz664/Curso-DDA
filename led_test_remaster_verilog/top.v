module top(o_led, o_led_b, o_led_g, i_sw, i_reset, clock);
    parameter NB_LEDS = 4;
    parameter NB_SW = 4;
    parameter NB_COUNTER = 32;

    input   [NB_SW - 1 : 0]   i_sw;
    input           i_reset;
    input           clock;

    output  [NB_LEDS - 1 : 0]   o_led;
    output  [NB_LEDS - 1 : 0]   o_led_b;
    output  [NB_LEDS - 1 : 0]   o_led_g;

    wire    w_valid;
    wire    [NB_LEDS - 1 : 0]   w_leds;

    count #(
        .NB_COUNTER (NB_COUNTER),
        .NB_SW      (NB_SW - 1))
        u_count (
        .i_sw       (i_sw[NB_SW-2 : 0]),
        .i_reset    (~i_reset),
        .clock      (clock),

        .o_valid    (w_valid)
    );

    shiftreg u_shiftreg(
        .i_valid    (w_valid),
        .i_reset    (~i_reset),
        .clock      (clock),

        .o_led      (w_leds)
    );

    assign o_led = w_leds;
    assign o_led_b = (i_sw[NB_SW - 1]) ? w_leds : 4'b0000;
    assign o_led_g = (i_sw[NB_SW - 1]) ? 4'b0000 : w_leds;
endmodule
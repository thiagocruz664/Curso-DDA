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
    
    wire                        selMux;
    wire                        w_reset;
    wire                        w_vioReset;
    wire    [NB_LEDS - 1 : 0]   w_sw;
    wire    [NB_LEDS - 1 : 0]   w_vioSw;
    
    assign w_reset = (selMux)? w_vioReset : i_reset;
    assign w_sw = (selMux)? w_vioSw : i_sw;

    count #(
        .NB_COUNTER (NB_COUNTER),
        .NB_SW      (NB_SW - 1))
        u_count (
        .i_sw       (w_sw[NB_SW-2 : 0]),
        .i_reset    (~w_reset),
        .clock      (clock),

        .o_valid    (w_valid)
    );

    shiftreg u_shiftreg (
        .i_valid    (w_valid),
        .i_reset    (~w_reset),
        .clock      (clock),

        .o_led      (w_leds)
    );

    wire    [NB_LEDS - 1 : 0]   w_led;
    wire    [NB_LEDS - 1 : 0]   w_led_b;
    wire    [NB_LEDS - 1 : 0]   w_led_g;
    
    assign w_led = w_leds;
    assign w_led_b = (w_sw[NB_SW - 1]) ? w_leds : 4'b0000;
    assign w_led_g = (w_sw[NB_SW - 1]) ? 4'b0000 : w_leds;

    assign o_led = w_led;
    assign o_led_b = w_led_b;
    assign o_led_g = w_led_g;
    
    ila u_ila (
        .clk_0      (clock),
        .probe0_0   (w_led),
        .probe1_0   (w_led_b),
        .probe2_0   (w_led_g)
    );
    
    vio u_vio (
        .clk_0          (clock),
        .probe_in0_0    (w_led),
        .probe_in1_0    (w_led_b),
        .probe_in2_0    (w_led_g),
        .probe_out0_0   (selMux),
        .probe_out1_0   (w_vioReset),
        .probe_out2_0   (w_vioSw)
    );
endmodule
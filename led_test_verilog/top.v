module top(o_led, o_led_b, o_led_g, i_sw, i_reset, clock);
    output  wire    [3:0]   o_led;
    output  reg     [3:0]   o_led_b;
    output  reg     [3:0]   o_led_g;

    input   [3:0]   i_sw;
    input           i_reset;
    input           clock;

    wire            valid;

    count u_count(
        .o_valid(valid),
        .i_sw(i_sw[2:0]),
        .i_reset(i_reset),
        .clock(clock)
    );

    shiftreg u_shiftreg(
        .o_led(o_led),
        .i_valid(valid),
        .i_reset(i_reset),
        .clock(clock)
    );

    always @(posedge clock) begin
        if (i_sw[3] == 'b0) begin
            o_led_b <= o_led;
            o_led_g <= o_led;
        end else begin
            o_led_b <= 4'b0;
            o_led_g <= 4'b0;
        end
    end
endmodule
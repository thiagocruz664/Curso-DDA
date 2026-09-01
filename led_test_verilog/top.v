module top(o_led, o_led_b, o_led_g, i_sw, i_reset, clock);
    output  [3:0]   o_led;
    output  [3:0]   o_led_b;
    output  [3:0]   o_led_g;

    input   [3:0]   i_sw;
    input           i_reset;
    input           clock;

    wire    [1:0]   valid;
    reg     [3:0]   o_led_b;
    reg     [3:0]   o_led_g;

    count u_count(
        .o_valid(valid[0]),
        .i_sw(i_sw[2:0]),
        .i_reset(i_reset),
        .clock(clock)
    );

    shiftreg u_shiftreg(
        .o_led(o_led),
        .i_valid(valid[1]),
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
module shiftreg(i_valid, o_led, i_reset, clock);
    output  reg [3:0]   o_led;

    input           i_valid;
    input           i_reset;
    input           clock;

    integer         i;

    always @(posedge clock) begin
        if (i_reset) begin
            o_led <= 4'b0000;
        end else begin
            o_led[3] <= o_led[2];
            o_led[2] <= o_led[1];
            o_led[1] <= o_led[0];
            o_led[0] <= i_valid;
        end
    end
endmodule
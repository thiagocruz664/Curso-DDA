module shiftreg(i_valid, o_led, i_reset, clock);
    output  [3:0]   o_led;

    input           i_valid;
    input           i_reset;
    input           clock;

    reg     [3:0]   led;
    integer         i;

    always @(posedge clock) begin
        for (i=0; i<4; i=i+1) begin
            led[i+1] <= led[i];
        end
    end
endmodule
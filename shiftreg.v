module shiftreg(i_valid, o_led, i_reset, clock);
    parameter NB_LEDS = 4;

    input           i_valid;
    input           i_reset;
    input           clock;

    output  [NB_LEDS-1 : 0]     o_led;

    reg     [NB_LEDS-1 : 0]     shift_reg;

    always @(posedge clock) begin
        if (i_reset) begin
            shift_reg <= {{NB_LEDS - 1 {1'b0}} , 1'b1};
        end else if (i_valid) begin
            shift_reg[3] <= shift_reg[2];
            shift_reg[2] <= shift_reg[1];
            shift_reg[1] <= shift_reg[0];
            shift_reg[0] <= shift_reg[3];

            // Otra opcion mas sencilla es usar el shift logico
            //shift_reg <= shift_reg << 1;
            //shift_reg[0] <= shift_reg[3];
        end
    end

    assign o_led = shift_reg;
endmodule
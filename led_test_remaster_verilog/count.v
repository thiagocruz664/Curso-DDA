module count(i_sw, o_valid, i_reset, clock);
    parameter NB_SW = 3;    // Estos parametros se pueden modificar desde afuera
    parameter NB_COUNTER = 32;

    input   [NB_SW - 1 : 0]    i_sw;
    input                           i_reset;
    input                           clock;

    output                          o_valid;

    localparam R0 = (2**(NB_COUNTER/4))-1;
    localparam R1 = (2**(2*NB_COUNTER/4))-1;
    localparam R2 = (2**(3*NB_COUNTER/4))-1;
    localparam R3 = (2**(4*NB_COUNTER/4))-1;

    wire    [NB_COUNTER - 1 : 0]    limit_cmp;
    assign limit_cmp =  (i_sw[2:1]==2'b00) ? R0:
                        (i_sw[2:1]==2'b01) ? R1:
                        (i_sw[2:1]==2'b10) ? R2 : R3;

    reg     [NB_COUNTER - 1 : 0]    counter;
    reg                             valid;
    always @(posedge clock) begin
        if(i_reset) begin
            counter <= {NB_COUNTER{1'b0}}; // La doble llave asi repite en dato mas interno la cantidad de veces del dato externo
            valid <= 1'b0;
        end else if (i_sw[0]) begin
            if (counter >= limit_cmp) begin
                valid <= 1'b1;
                counter <= {NB_COUNTER{1'b0}};
            end else begin
                counter <= counter + 1'b1;
                valid <= 1'b0;
            end
        end else begin      // Este else es solo para posible errores
            counter <= counter;
            valid <= valid;
        end
    end

    assign o_valid = valid;
endmodule
`timescale 1ns/100ps

module tb_top ();
    parameter NB_LEDS = 4;
    parameter NB_SW = 4;
    parameter NB_COUNTER = 4;

    //Los input tienen que ser de tipo reg para los estimulos
    reg   [NB_SW - 1 : 0]   i_sw;
    reg           i_reset;
    reg           clock;

    //Los ouput de tipo wire ya que solo quiero observar su respuesta al estimulo
    wire  [NB_LEDS - 1 : 0]   o_led;
    wire  [NB_LEDS - 1 : 0]   o_led_b;
    wire  [NB_LEDS - 1 : 0]   o_led_g;
    
    initial begin   //Se definen los parametros de inicio
        i_sw = 4'b0000;
        i_reset = 1'b0;
        clock = 1'b0;

        #50;    //Esperamos 5 periodos, de onda
        @(posedge clock);   //Nos sincronizamos con un flanco de subida de reloij
        i_reset = 1'b1;     // y sacamos el reset

        #50;
        @(posedge clock);
        i_sw = 4'b0001;

        #1000;
        @(posedge clock);
        i_sw = 4'b0011;

        #1000;
        @(posedge clock);
        i_sw = 4'b0101;

        #1000;
        @(posedge clock);
        i_sw = 4'b0111;

        #1000;
        @(posedge clock);
        i_sw = 4'b1001;

        #1000;
        @(posedge clock);
        i_sw = 4'b1011;

        #1000;
        @(posedge clock);
        i_sw = 4'b1101;

        #1000;
        @(posedge clock);
        i_sw = 4'b1111;

        #1000;
        $finish;
    end

    always #5 clock = ~clock; //Establecemos la frecuencia con T=10ns

    top #(
        .NB_LEDS    (NB_LEDS),
        .NB_SW      (NB_SW),
        .NB_COUNTER (NB_COUNTER))
        u_top (
        .i_sw       (i_sw),
        .i_reset    (i_reset),
        .clock      (clock),

        .o_led      (o_led),
        .o_led_b    (o_led_b),
        .o_led_g    (o_led_g)
    );
endmodule
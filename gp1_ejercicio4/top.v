module top (i_x, o_y, clock, reset);
    parameter NB_INPUT = 8;
    parameter NB_OUTPUT = 12;

    input signed    [NB_INPUT-1 : 0]    i_x;
    input                               clock;
    input                               reset;

    output signed   [NB_OUTPUT-1 : 0]   o_y;

    wire signed [NB_INPUT-1:0] w_x;
    assign w_x = i_x;
    
    reg signed  [NB_INPUT-1:0] x_n1;
    reg signed  [NB_INPUT-1:0] x_n2;
    reg signed  [NB_INPUT-1:0] x_n3;

    reg signed  [NB_OUTPUT-1:0]      r_y;
    reg signed  [NB_OUTPUT-1 : 0]    y_n1;
    reg signed  [NB_OUTPUT-1 : 0]    y_n2;

    wire signed    [NB_INPUT : 0]    sum1;
    assign  sum1    =   w_x - x_n1;
    wire signed    [NB_INPUT+1 : 0]    sum2;
    assign  sum2    =   x_n2 + sum1;
    wire signed    [NB_INPUT+1 : 0]    sum3;
    assign  sum3    =   x_n3 + sum2;
    wire signed    [NB_OUTPUT-1 : 0]    sum4;
    assign  sum4    =   (y_n1 >>> 1) + (y_n2 >>> 2);

    wire signed    [NB_OUTPUT-1 : 0]    sum5;
    assign  sum5     =   sum3 + sum4;

    always @(posedge clock) begin
        $display("w_x=%b   x_n1=%b   x_n2=%b     x_n3=%b     r_y=%b    y_n1=%b     y_n2=%b ",w_x,x_n1,x_n2,x_n3,r_y,y_n1,y_n2);
        if (reset) begin
            x_n1 <= w_x;
            x_n2 <= x_n1;
            x_n3 <= x_n2;
            r_y <= sum5;
            y_n1 <= sum5;
            y_n2 <= y_n1;
        end else begin
            x_n1 <= {NB_INPUT{1'b0}};
            x_n2 <= {NB_INPUT{1'b0}};
            x_n3 <= {NB_INPUT{1'b0}};
            r_y <= {NB_OUTPUT{1'b0}};
            y_n1 <= {NB_OUTPUT{1'b0}};
            y_n2 <= {NB_OUTPUT{1'b0}};
        end
    end

    assign  o_y =   r_y;
endmodule
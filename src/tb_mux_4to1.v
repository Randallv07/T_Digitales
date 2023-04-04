`timescale 1ns / 1ps


module tb_mux_4to1;
    parameter ANCHO=8;
    reg [ANCHO-1:0] a;
    reg [ANCHO-1:0] b;
    reg [ANCHO-1:0] c;
    reg [ANCHO-1:0] d;
    wire [ANCHO-1:0] out;
    reg [1:0] sel;
    integer i, j;
    mux_4to1 #(.ANCHO(ANCHO)) U0(.a(a),
                .b(b),
                .c(c),
                .d(d),
                .sel(sel),
                .out(out));
    initial begin
    $monitor ("[%0t] sel=0x%0h a=0x%0h b=0x%0h c=0x%0h d=0x%0h out=0x%0h", $time, sel, a, b, c, d, out);    
    for (j=1; j < 15; j=j+1) begin
    sel <= 0;
    a <= $random;
    b <= $random;
    c <= $random;
    d <= $random;
    
    for (i=1; i < 4; i=i+1) begin
        #5 sel <= i;
    end
    end
    #5 $finish;
  end
endmodule
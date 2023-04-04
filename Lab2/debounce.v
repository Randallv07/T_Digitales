`timescale 1ns / 1ps


//Pensando el antirebotes como una caja negra con 2 entradas
// Pushbuttom y señal  CLK de entrada  y una salida: la señal sin rebote
module debounce(
input pb, clk_in, rst, 
output [7:0] conta
); //Enable es el clock con la frecuencia disminuida

wire pulsoEn; // Clock con frecuencia disminuida
wire DebouncePulse;
wire Q1, Q2, Q2_bar;
wire clk_out;
wire clk_1kHz;

 clk_wiz_0 clk_slow
   (
    // Clock out ports
    .clk_out1(clk_out),     // output clk_out1
   // Clock in ports
    .clk_in1(clk_in)); 

    ClockDivider Divisor_frecuencial
    (
    .CLK_6_25MHZ(clk_out), 
    .Reset(rst),
    .CLK_1kHz(clk_1kHz)
    );
/*
//Cambiar a asignaciones explicita
    divisor_frecuencial #(.frec_sal(1000))
    slow_clk
    (.clk_in(clk), 
    .clk_out(clk_out)
    );
*/
//FF 1 recibe como entradas el clk retrasado y el PushButtom y tiene salida Q1
D_FF d1(
    .clk_in(clk_in), 
    .pulsoEn(clk_1kHz), 
    .rst(rst), 
    .D(pb), 
    .Q(Q1),
    .Qbar()
    );

//FF 2 recibe como entradas el clk retrasado y  Q1 y tiene salida Q2
D_FF d2(
    .clk_in(clk_in),
    .pulsoEn(clk_1kHz), 
    .rst(rst), 
    .D(Q1), 
    .Q(Q2),
    .Qbar(Q2_bar)
    );

//Se asigna a Q2 negado el valor negado de Q2
//assign Q2_bar=~Q2;
assign DebouncePulse = Q1 & Q2_bar;

contadorPrueba U1(
    .clk_in(clk_in), 
    .rst(rst),
    .DebouncePulse(DebouncePulse),
    .conta(conta)
    );
  
endmodule

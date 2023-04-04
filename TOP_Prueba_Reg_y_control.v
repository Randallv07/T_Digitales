`timescale 1ns / 1ps

module TOP_Prueba_Reg_y_control (
    input clk,
    input rst,
    input WR, sel_mux, sel_dmux,
    input [1:0] i_extC,
    input [7:0] i_extD,
    input [3:0] SPI,
    output [15:0] led
);

wire [31:0] salida;

Prueba_Reg_y_control U1(
 .rst(rst), 
 .clk(clk),
 .WR(WR),
 .sel_mux(sel_mux),
 .sel_dmux(sel_dmux),
 .i_extC(i_extC), 
 .i_extD(i_extD),
 .SPI(SPI),
 .out(salida)
 );

assign led = salida [15:0];

endmodule
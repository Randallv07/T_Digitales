`timescale 1ns / 1ps

module TOP_prueba (
    input clk_in,
    input rst,
    
    //SPI JA
    output o_SPI_Clk,   //Conectar JA
    input i_SPI_MISO,  //Conectar JA
    output o_SPI_MOSI,   //Conecta JA
    
    input WR, sel_mux, sel_dmux,
    input [1:0] i_extC,
    input [7:0] i_extD,
    output [15:0] out
);

wire [31:0] salida;

    clk_wiz_0  clk_slow
 (
  // Clock out ports
    .clk_out1(clk_out),     // output clk_out1
   // Clock in ports
    .clk_in1(clk_in)
 );
 
 TOP Prueba(
    .clk_in(clk_out),
    .rst(rst),
    
    //SPI JA
    .o_SPI_Clk(o_SPI_Clk),   //Conectar JA
    .i_SPI_MISO(i_SPI_MISO),  //Conectar JA
    .o_SPI_MOSI(o_SPI_MOSI),   //Conecta JA
    
    .WR(WR), 
    .sel_mux(sel_mux), 
    .sel_dmux(sel_dmux),
    .i_extC(i_extC),
    .i_extD(i_extD),
    .out(salida)
);

assign out = salida [15:0];

endmodule
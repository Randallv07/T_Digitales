`timescale 1ns / 1ps

module TOP (
    input clk_in,
    input rst,
    
    //SPI JA
    output o_SPI_Clk,   //Conectar JA
    input i_SPI_MISO,  //Conectar JA
    output o_SPI_MOSI,   //Conecta JA
    
    input WR, sel_mux, sel_dmux,
    input [1:0] i_extC,
    input [7:0] i_extD,
    output [31:0] out
);

wire WR1, WR2, clear, send, WR1C, WR1D, e_SPI; //asignar boton en el control
wire [7:0] transaccion;
wire [7:0] SPI;
wire [31:0]out1, out2;
parameter CLKS_PER_HALF_BIT = 2;
parameter SPI_MODE = 0;
wire [7:0] i_TX_DV;

assign i_TX_DV = out1 [7:0]; 

SPImaster #(.SPI_MODE(SPI_MODE), .CLKS_PER_HALF_BIT(CLKS_PER_HALF_BIT)) DUT 
  (.i_Rst_L(rst),
   .i_Clk(clk_in),
   .i_TX_Byte(i_TX_DV),
   .i_TX_DV(e_SPI),
   .o_TX_Ready(),
   .o_RX_DV(), 
   .o_RX_Byte(SPI),
   
   .o_SPI_Clk(o_SPI_Clk),
   .i_SPI_MISO(i_SPI_MISO),
   .o_SPI_MOSI(o_SPI_MOSI)   
   );

Reg_datos U1(
 .rst(rst), 
 .clk(clk_in),
 .WR1D(WR1D),
 .WR2D(WR1),
 .i_ext(i_extD), 
 .i_int(SPI),
 .outD(out1)
 );

Reg_control U2(
 .rst(rst), 
 .clk(clk_in), 
 .WR1C(WR1C), 
 .WR2C(WR2),
 .i_ext(i_extC), 
 .i_clear(clear), 
 .i_send(send),
 .i_transac(transaccion),
 .outC(out2)
 );
 
 control U3(
 .rst(rst), 
 .clk(clk_in), 
 .i_data_control(out2),
 .o_send(send),
 .o_clear(clear), 
 .WR2C(WR2), 
 .WR2D(WR1), 
 .eneable_SPI(e_SPI),
 .transac(transaccion)
 );
    
 mux_2a1 U4(
 .a(out1), 
 .b(out2),
 .sel_mux(sel_mux),
 .out(out)
 );
 
 dmux1a2 U5(
 .sel_dmux(sel_dmux),
 .D(WR),
 .Out0(WR1C),
 .Out1(WR1D)
 );
 

endmodule
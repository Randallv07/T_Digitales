`timescale 1ns / 1ps

module TOP2 (
    //general
    input clk_in,
    input rst,
    input WR,
    input vp_in, vn_in, AD2N, AD2P,
    output [11:0] out
    );

wire [31:0] salida;
wire [11:0] XADC;

    clk_wiz_0 slow_clk
 (
  // Clock out ports
  .clk_out1(clk_out),
 // Clock in ports
  .clk_in1(clk_in)
 );
 
XADCprueba (
    .clk(clk_out),
    .vp_in(vp_in),
    .vn_in(vn_in),
    .AD2N(AD2N),
    .AD2P(AD2P),
    .o_XADC(XADC)
    );
    
Reg_datos (
    .rst(rst), 
    .clk(clk_out), 
    .WR2D(WR),
    .i_int(XADC),
    .outD(salida)
    );
    
assign out= salida[11:0];

endmodule
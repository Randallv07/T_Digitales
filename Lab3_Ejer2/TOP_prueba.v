`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2022 14:55:25
// Design Name: 
// Module Name: TOP_prueba
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP_prueba(
    input clk_in,
    input rst,
    input WR1C, sel_mux,
    input vp_in, vn_in, AD2N, AD2P,
    input [8:0] i_ext,
    output [15:0] out
    );
    
    wire [31:0] salida;
    
     clk_wiz_0 clk_slow
   (
    // Clock out ports
    .clk_out1(clk_out),     // output clk_out1
   // Clock in ports
    .clk_in1(clk_in)
    ); 
    
    TOP X(
    .clk_in(clk_out),
    .rst(rst),
    .WR1C(WR1C), 
    .sel_mux(sel_mux),
    .vp_in(vp_in), 
    .vn_in(vn_in), 
    .AD2N(AD2N), 
    .AD2P(AD2P),
    .i_ext(i_ext),
    .out(salida)
    );
    
    assign out = salida [15:0];
 
endmodule

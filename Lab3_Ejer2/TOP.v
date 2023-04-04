`timescale 1ns / 1ps

module TOP (
    //general
    input clk_in,
    input rst,
    input WR1C, sel_mux,
    input vp_in, vn_in, AD2N, AD2P,
    input [8:0] i_ext,
    output [31:0] out
    );

wire WR1;
wire WR2;
wire flag;
wire new;
wire [31:0]out1;
wire [31:0]out2;
wire [11:0] XADC;


XADC ADC(
    .clk(clk_in),
    .vp_in(vp_in),
    .vn_in(vn_in),
    .AD2N(AD2N),
    .AD2P(AD2P),
    .o_XADC(XADC)
    );

Reg_datos U1(
 .rst(rst), 
 .clk(clk_in), 
 .WR2D(WR1), 
 .i_int(XADC),
 .outD(out1)
 );

Reg_control U2(
 .rst(rst), 
 .clk(clk_in), 
 .WR1C(WR1C), 
 .WR2C(WR2),
 .i_ext(i_ext), 
 .i_flag(flag), 
 .i_new(new),
 .outC(out2)
 );
 
 control U3(
 .rst(rst), 
 .clk(clk_in), 
 .i_data_control(out2),
 .i_data_XADC(XADC),
 .o_new(new), 
 .o_flag(flag), 
 .WRD2(WR1), 
 .WRC2(WR2)
    );
    
 mux_2a1 U4(
 .a(out1), 
 .b(out2),
 .sel_mux(sel_mux),
 .out(out)
 );

endmodule
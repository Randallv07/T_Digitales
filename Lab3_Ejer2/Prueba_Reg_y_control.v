`timescale 1ns / 1ps

module Prueba_Reg_y_control (
    //general
    input clk,
    input rst,
    input WR1C, sel_mux,
    input [31:0] i_ext,
    input [11:0] XADC,
    output [31:0] out
);

wire WR1;
wire WR2;
wire flag;
wire new;
wire [31:0]out1;
wire [31:0]out2;

Reg_datos U1(
 .rst(rst), 
 .clk(clk), 
 .WR2D(WR1), 
 .i_int(XADC),
 .outD(out1)
 );

Reg_control U2(
 .rst(rst), 
 .clk(clk), 
 .WR1C(WR1C), 
 .WR2C(WR2),
 .i_ext(i_ext), 
 .i_flag(flag), 
 .i_new(new),
 .outC(out2)
 );
 
 control U3(
 .rst(rst), 
 .clk(clk), 
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
 
/*xadc_wiz_0 XLXI_7 (
  .di_in(0),              // input wire [15 : 0] di_in
  .daddr_in(8'h12),        // input wire [6 : 0] daddr_in
  .den_in(1),            // input wire den_in
  .dwe_in(0),            // input wire dwe_in
  .drdy_out(),        // output wire drdy_out
  .do_out(LED),            // output wire [15 : 0] do_out
  .dclk_in(clk),          // input wire dclk_in
  .reset_in(0),        // input wire reset_in
  .vp_in(vp_in),              // input wire vp_in
  .vn_in(vn_in),              // input wire vn_in
  .channel_out(),  // output wire [4 : 0] channel_out
  .eoc_out(1),          // output wire eoc_out
  .alarm_out(),      // output wire alarm_out
  .eos_out(),          // output wire eos_out
  .busy_out()        // output wire busy_out
);*/

endmodule
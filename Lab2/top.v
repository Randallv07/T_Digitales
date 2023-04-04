`timescale 1ns / 1ps

module top #(parameter numreg=5) (
    input rst, clk,
    output [numreg-1:0] RES
);

wire n_sel_mux;
wire [4:0] n_selread_1; 
wire [4:0] n_selread_2;
wire [4:0] n_selwr;
wire [2:0] n_sel_alu;
wire clk_out;

divisor_frecuencial #(.frec_sal(1))
    slow_clk
    (.clk_in(clk), 
    .clk_out(clk_out)
    );
datapath1 dp(
    .sel_mux(n_sel_mux), 	
    .rst(rst), 
    .clk(clk),
    .selread1(n_selread_1), 
    .selread2(n_selread_2), 
    .selwr(n_selwr),
    .sel_alu(n_sel_alu),
    .RES(RES)
    );

control ctl(
    .clk(clk), 
    .rst(rst),
    .sel_mux(n_sel_mux),
    .sel_alu(n_sel_alu),
    .selread1(n_selread_1), 
    .selread2(n_selread_2), 
    .selwr(n_selwr)
);

endmodule
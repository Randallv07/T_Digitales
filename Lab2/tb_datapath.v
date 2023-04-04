`timescale 1ns / 1ps

module tb_datapath;
parameter numreg = 5;
reg sel_mux, rst, clk;
reg [numreg-1:0] selread1, selread2, selwr;
reg [2:0] sel_alu;
wire RES;

datapath #(.numreg(numreg)) dp(
    .sel_mux(sel_mux), 
    .rst(rst), 
    .clk(clk),
    .selread1(selread1), 
    .selread2(selread2), 
    .selwr(selwr),
    .sel_alu(sel_alu),
    .RES(RES)
);

always begin
    #5 
    clk=~clk;
end

initial begin
    clk=0;
    rst=0;
    sel_mux=0;
    selwr=0;
    sel_alu=0;
    #5
    #5
    selwr=1;
    #5
    selwr=2;
    #5
    selread1=0;
    selread2=1;
    sel_alu=0;
    #40 $finish;
end
endmodule
    
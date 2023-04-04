`timescale 1ns / 1ps

module tb_control;
    parameter bitsel=5;
    reg clk, rst;
    wire sel_mux;
    wire [2:0] sel_alu;
    wire [bitsel-1:0] selread1, selread2, selwr;

control Prueba(
     .clk(clk), 
     .rst(rst),
     .sel_mux(sel_mux),
     .sel_alu(sel_alu),
     .selread1(selread1), 
     .selread2(selread2), 
     .selwr(selwr)
     );

initial begin
    clk=0;
end

always begin
    #5 clk=~clk;
end

initial begin
    rst=0;
    @(negedge clk)
    rst=1;
    #400
    rst=0;
    #5 $finish;
end

endmodule
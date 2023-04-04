`timescale 1ns / 1ps

module tb_program_counter;
    parameter ANCHO=4;
    reg clk, rst;
    reg [ANCHO-1:0] jumpdir;
    reg [1:0] sel;
    wire [ANCHO-1:0] PC_o, PC_inc;
    
    program_counter #(.ANCHO(ANCHO)) U0(
                        .clk(clk),
                        .rst(rst),
                        .jumpdir(jumpdir),
                        .sel(sel),
                        .PC_o(PC_o),
                        .PC_inc(PC_inc)
                        );
always begin
     #5 clk=~clk;
end
     
initial begin
    clk=0;
    rst=0;
    jumpdir=4'b0000;
    #10
    sel=2'b00;
    rst=1;
    #30 sel=2'b10;
    #30 jumpdir= 4'b0010;
    #10 sel=2'b11;
    #20 sel=2'b10;
    #20 sel=2'b01;
    #20 sel=2'b00;
    #20 sel=2'b10;
    #40 $finish;
end
endmodule
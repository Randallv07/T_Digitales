`timescale 1ns / 1ps

module tb_Reg_datos;
reg rst, clk, WR2D;
reg [11:0] i_int;
wire [31:0] outD;

Reg_datos prueba(
     .clk(clk), 
     .rst(rst),
     .WR2D(WR2D), 
     .i_int(i_int), 
     .outD(outD) 
);

initial begin
    clk=0;
end

always begin
    #5 clk=~clk;
end

initial begin
    rst=0;
    WR2D=0;
    @(negedge clk)
    rst=1;
    @(negedge clk)
    i_int = 11'b10010101101;
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    WR2D=1;
    @(negedge clk)
    WR2D=0;
    @(negedge clk)
    i_int = 11'b11111111111;
    @(negedge clk)
    WR2D=1;
    @(negedge clk)
    WR2D=0;
    @(negedge clk)
    @(negedge clk)
    #5 $finish;
end 
endmodule
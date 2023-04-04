`timescale 1ns / 1ps

module tb_Reg_datos;
reg rst, clk, WR1D, WR2D;
reg [7:0] i_int, i_ext;
wire [31:0] outD;

Reg_datos prueba(
     .clk(clk), 
     .rst(rst),
     .WR1D(WR1D),
     .WR2D(WR2D), 
     .i_int(i_int),
     .i_ext(i_ext),
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
    WR1D=0;
    WR2D=0;
    i_int=0;
    i_ext=0;
    @(negedge clk)
    rst=1;
    @(negedge clk)
    i_int = 5;
    i_ext = 8;
    @(negedge clk)
    WR2D=1;
    @(negedge clk)
    WR2D=0;
    @(negedge clk)
    WR1D=1;
    @(negedge clk)
    WR1D=0;
    @(negedge clk)
    WR1D=1;
    @(negedge clk)
    WR2D=1;
    @(negedge clk)
    WR1D=0;
    @(negedge clk)
    WR1D=1;
    @(negedge clk)
    @(negedge clk)
    #5 $finish;
end 
endmodule
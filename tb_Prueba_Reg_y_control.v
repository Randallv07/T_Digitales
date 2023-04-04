`timescale 1ns / 1ps

module tb_Prueba_Reg_y_control;
reg rst, clk;
reg WR, sel_mux, sel_dmux;
reg [1:0] i_extC;
reg [7:0] i_extD; 
reg [3:0] SPI;
wire [15:0] out;

TOP_Prueba_Reg_y_control prueba(
     .clk(clk), 
     .rst(rst),
     .WR(WR),
     .sel_mux(sel_mux),
     .sel_dmux(sel_dmux), 
     .i_extC(i_extC), 
     .i_extD(i_extD), 
     .SPI(SPI),
     .led(out) 
);

initial begin
    clk=0;
end

always begin
    #5 clk=~clk;
end

initial begin
    rst=1;
    i_extD=0;
    SPI=0;
    sel_mux = 1;
    i_extC=0;
    WR=0;
    sel_dmux=0;
    @(negedge clk)
    rst=0;
    i_extC = 1;
    i_extD = 1;
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    SPI=5;
    @(negedge clk)
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    SPI=3;
    @(negedge clk)
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    SPI=8;
    @(negedge clk)
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    SPI=14;
    @(negedge clk)
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    SPI=4;
    @(negedge clk)
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    SPI=9;
    @(negedge clk)
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    @(negedge clk)
    @(negedge clk)
    WR=1;
    SPI=1;
    @(negedge clk)
    WR=0;
    SPI=3;
    @(negedge clk) 
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;

    
  
    #5 $finish;
end 
endmodule
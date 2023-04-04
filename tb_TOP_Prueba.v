`timescale 1ns / 1ps

module tb_TOP_Prueba;
reg rst, clk;
reg WR, sel_mux, sel_dmux;
reg [1:0] i_extC;
reg [7:0] i_extD;
wire [15:0] out;
wire o_SPI_MOSI; 

TOP_prueba prueba(
     .clk_in(clk), 
     .rst(rst),
     .WR(WR),
     .sel_mux(sel_mux),
     .sel_dmux(sel_dmux), 
     .i_extC(i_extC), 
     .i_extD(i_extD), 
     .o_SPI_Clk(),
     .i_SPI_MISO(o_SPI_MOSI),
     .o_SPI_MOSI(o_SPI_MOSI),
     .out(out) 
);

initial begin
    clk=0;
end

always begin
    #5 clk=~clk;
end

initial begin
    rst=0;
    i_extD=0;
    sel_mux = 0;
    i_extC=0;
    WR=0;
    sel_dmux=1;
    i_extD=0;
    @(negedge clk)
    rst=1;
    //WR=1;
    @(negedge clk)
    sel_mux = 1;
    i_extC=2'b01;
    i_extD=0;
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    //i_extC=2'b01;
    @(negedge clk)
    i_extC=2'b01;
    sel_dmux=0;
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    @(negedge clk)
    i_extD=10;
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    @(negedge clk)
    sel_mux=1;
    @(negedge clk)
    i_extD=10;
    @(negedge clk)
    WR=1;
    @(negedge clk)
    WR=0;
    @(negedge clk)
    //i_extC=2'b01;
    @(negedge clk)
    
  
    #5 $finish;
end 
endmodule
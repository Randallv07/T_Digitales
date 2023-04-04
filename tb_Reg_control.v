`timescale 1ns / 1ps

module tb_Reg_control;
reg rst, clk, WR1C, WR2C;
reg [1:0] i_ext;
reg i_send, i_clear;
reg [7:0] i_transac;
wire [31:0] outC;

Reg_control prueba(
     .clk(clk), 
     .rst(rst),
     .WR1C(WR1C),
     .WR2C(WR2C),
     .i_ext(i_ext), 
     .i_send(i_send), 
     .i_clear(i_clear), 
     .i_transac(i_transac),
     .outC(outC) 
);

initial begin
    clk=0;
end

always begin
    #5 clk=~clk;
end

initial begin
    rst=1;
    WR2C=0;
    WR1C=0;
    i_ext=0;
    i_send=0;
    i_clear=0;
    i_transac=0;
    @(negedge clk)
    rst=0;
    @(negedge clk)
    @(negedge clk)
    i_transac=1;
    @(negedge clk)
    i_ext= {2'b01};
    i_send=0;
    @(negedge clk)
    WR1C=1;
    @(negedge clk)
    WR1C=0;
    WR2C=1;
    i_send=0;
    i_ext= {2'b01};
    i_transac=2;
    @(negedge clk)
    WR2C=0;
    WR1C=1;
    @(negedge clk)
    WR1C=0;
    @(negedge clk)
    WR2C=1;
    i_transac=3;
    i_send=0;
    @(negedge clk)
    WR2C=0;
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    #5 $finish;
end 
endmodule
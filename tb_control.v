`timescale 1ns / 1ps

module tb_control;

    reg clk, rst;
    reg [31:0] i_data_control;
    wire o_send, o_clear, WR2C, WR2D, eneable_SPI;
    wire [7:0] transac;


    control Prueba(
     .clk(clk), 
     .rst(rst),
     .i_data_control(i_data_control),
     .transac(transac),
     .o_send(o_send), 
     .o_clear(o_clear), 
     .eneable_SPI(eneable_SPI),
     .WR2D(WR2D),
     .WR2C(WR2C)
     );

initial begin
    clk=0;
end

always begin
    #5 clk=~clk;
end

initial begin
    rst=0;
    i_data_control=0;
    @(negedge clk)
    rst=1;
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    i_data_control={30'b0,1'b0,1'b1};
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    i_data_control={30'b0,1'b0,1'b0};
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    i_data_control={30'b0,1'b1,1'b1};
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    #5 $finish;
end

endmodule
`timescale 1ns / 1ps

module tb_control;

    reg clk, rst;
    reg [31:0] i_data_control;
    reg [11:0] i_data_XADC;
    wire o_new, o_flag, WRD2;


    control Prueba(
     .clk(clk), 
     .rst(rst),
     .i_data_control(i_data_control),
     .i_data_XADC(i_data_XADC),
     .o_new(o_new), 
     .o_flag(o_flag), 
     .WRD2(WRD2)
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
    i_data_XADC=11'b11111110101;
    @(negedge clk)
    rst=1;
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    i_data_control={16'b0,8'b00001001,6'b0,1'b0,1'b1};
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    i_data_control={16'b0,8'b00001001,6'b0,1'b0,1'b0};
    i_data_XADC=11'b00011110101;
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    i_data_control={16'b0,8'b10001001,6'b0,1'b0,1'b1};
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    #5 $finish;
end

endmodule
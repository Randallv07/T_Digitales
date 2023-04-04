`timescale 1ns / 1ps

module tb_Reg_control;
reg rst, clk, WR1C, WR2C;
reg [31:0] i_ext;
reg i_new, i_flag;
wire [31:0] outC;

Reg_control prueba(
     .clk(clk), 
     .rst(rst),
     .WR1C(WR1C),
     .WR2C(WR2C),
     .i_ext(i_ext), 
     .i_new(i_new), 
     .i_flag(i_flag), 
     .outC(outC) 
);

initial begin
    clk=0;
end

always begin
    #5 clk=~clk;
end

initial begin
    rst=0;
    WR2C=0;
    WR1C=0;
    @(negedge clk)
    rst=1;
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    i_ext= {16'b0, 8'b10011011, 6'b0, 1'b0, 1'b1};
    i_new = 0;
    i_flag = 1;
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    WR1C=1;
    @(negedge clk)
    WR1C=0;
    @(negedge clk)
    WR2C=1;
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    #5 $finish;
end 
endmodule
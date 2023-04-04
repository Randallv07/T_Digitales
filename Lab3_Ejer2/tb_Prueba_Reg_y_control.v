`timescale 1ns / 1ps

module tb_Prueba_Reg_y_control;
reg rst, clk;
reg WR1C, sel_mux;
reg [31:0] i_ext;
reg [11:0] XADC;
wire [31:0] out;

Prueba_Reg_y_control prueba(
     .clk(clk), 
     .rst(rst),
     .WR1C(WR1C),
     .sel_mux(sel_mux),
     .i_ext(i_ext), 
     .XADC(XADC), 
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
    WR1C=0;
    XADC=0;
    sel_mux = 0;
    @(negedge clk)
    rst=1;
    @(negedge clk)
    @(negedge clk)
    XADC=11'b11111110101;
    @(negedge clk)
    i_ext= {8'b10011011, 1'b1};
    @(negedge clk)
    WR1C=1;
    @(negedge clk)
    WR1C=0;
    @(negedge clk)
    XADC=11'b11010111101;
    @(negedge clk)
    sel_mux = 1;
    @(negedge clk)
    @(negedge clk)
    i_ext= {8'b00011011, 1'b1};
    @(negedge clk)
    sel_mux = 0;
    @(negedge clk)
    WR1C=1;
    @(negedge clk)
    WR1C=0;
    @(negedge clk)
    sel_mux = 1;
    @(negedge clk)
    i_ext= {8'b00001011, 1'b1};
    @(negedge clk)
    WR1C=1;
    @(negedge clk)
    WR1C=0;
    @(negedge clk)
    #5 $finish;
end 
endmodule
`timescale 1ns / 1ps
module tb_deco_7_segment;
reg [3:0] IN;
wire [6:0] OUT;
deco7segment U0(
.in(IN),
.out(OUT)
);
initial
begin
    IN= 4'b0000;
    #10 
    IN= 4'b0001;
    #10
    IN= 4'b0010;
    #10
    IN= 4'b0011;
    #10 
    IN= 4'b0100;
    #10
    IN= 4'b0101;
    #10
    IN= 4'b0110;
    #10 
    IN= 4'b0111;
    #10
    IN= 4'b1000;
    #10
    IN= 4'b1001;
    #10 
    $finish; 
end

endmodule
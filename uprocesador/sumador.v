`timescale 1ns / 1ps

module sumador(
    input [31:0] a, b,
    output [31:0] o_sum
);

assign o_sum = a + b;

endmodule
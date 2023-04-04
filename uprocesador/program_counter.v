`timescale 1ns / 1ps

module program_counter #(
        parameter reset = 2'd0, hold = 2'd1, inc = 2'd2, jump = 2'd3
    )(
	input clk, rst,
	input [31:0] jumpdir,
	input [1:0] sel,
	output reg [31:0] PC_o, PC_inc
	);
reg [31:0] next_PC_o;
//wire clk_out;

/*
    divisor_frecuencial #(.frec_sal(1))
    slow_clk
    (.clk_in(clk), 
    .clk_out(clk_out)
    );
 */
 
//Bloque de memoria (Es necesario bloque de memoria para state_inc?)
always @(posedge clk) begin
	if(!rst) PC_o <=0;
	else PC_o<=next_PC_o;
	PC_inc <= PC_o + 4; 
end

//logica de siguiente estado
always @(*) begin
    case (sel)
        reset:     next_PC_o = 0;

        hold:      next_PC_o = PC_o;

        inc:       next_PC_o = PC_o + 4;

        jump:      next_PC_o = jumpdir;
        
        default:   next_PC_o = 1'bx;
	endcase
end

endmodule
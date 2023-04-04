`timescale 1ns / 1ps

module program_counter #(parameter ANCHO=4) (
	input clk, rst,
	input [ANCHO-1:0] jumpdir,
	input [1:0] sel,
	output reg [ANCHO-1:0] PC_o, PC_inc
	);
reg [ANCHO-1:0] next_PC_o;
wire clk_out;

    divisor_frecuencial #(.frec_sal(1))
    slow_clk
    (.clk_in(clk), 
    .clk_out(clk_out)
    );
 
 /* slow_clk_4Hz modfrec
   (
    // Clock out ports
    .clk(clk_in),     // output clk_7MHz
    .clk_out(clk_out)
    );*/     // input clk_in1
/*
//DIVISOR DE FRECUENCIA
reg [ANCHO-1:0] next_PC_o;
reg [25:0] cont=0;
reg clk_60Hz;
    
    always @(posedge clk_7MHz)
     begin    
        cont <= cont+1;
        if (cont==58_333)
            begin             
                cont<=0;
                clk_60Hz=~clk_60Hz;
        end
    end
    */
//Bloque de memoria (Es necesario bloque de memoria para state_inc?)
always @(posedge clk_out) begin
	if(!rst) PC_o <=0;
	else PC_o<=next_PC_o;
	PC_inc <= PC_o + 4; 
end

//logica de siguiente estado
always @(*) begin
	if (sel == 2'b00) begin
	next_PC_o = 0;
	end
	else if (sel == 2'b01) begin
		next_PC_o = PC_o;
	end
	else if (sel == 2'b10) begin
	next_PC_o = PC_o + 4;
	end
	else  begin
	next_PC_o = jumpdir;
	end
end

endmodule
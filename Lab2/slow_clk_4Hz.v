`timescale 1ns / 1ps


module slow_clk_4Hz(

	input clk_in, //entrada de velocidad de reloj de la FPGA
	output reg  clk_out // salida del reloj reducida a 4 Hz
);

	reg [25:0] count =0; // 2^25 > 12 500 000 El 25 sale de la division de 100MHz entre  10kHz = 10000
	
	
	always @(posedge clk_in)
	begin
	count <= count+1;
	if(count ==100_000_000/2*10_000)//Cuando la cuenta llegue a 12 500 000 el CLK  pasara de estar en 1 a 0
		begin
			count <=1; //Contador se resetea
			clk_out = ~clk_out; // Se invierte el reloj
		end
	else 
	   clk_out = clk_out;
	end

endmodule
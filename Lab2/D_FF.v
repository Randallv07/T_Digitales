`timescale 1ns / 1ps


module D_FF(
	input clk_in, pulsoEn,rst, //Entrada del reloj retrasado
	input  D, // Almacena los datos generados por el Pushbotton
	output reg Q,
	output reg Qbar
);

always @(posedge clk_in)begin//Cada vez que el flanco de clk sea positivo
	if(rst)
	   if(pulsoEn==1)begin
		  Q <= D; // Asignar el valor de la entrada D a la salida Q 
		  Qbar <= !Q; // Asignar valor de salida negado Q a Q negada
	   end
	end
	
endmodule

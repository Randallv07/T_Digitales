`timescale 1ns / 1ps


module contadorPrueba(input clk_in, rst, DebouncePulse, output reg [7:0] conta);


//para detectar el flanco de la señal EN
reg [1:0]registroEN;

always@(posedge clk_in) begin
	registroEN <= {registroEN[0],DebouncePulse};
end

always@(posedge clk_in) begin
	if(!rst) conta<=0;
	else begin
	   //detectando sólo el flanco positivo de EN
		if(registroEN==2'b01) conta<=conta+8'd1;
	end
end

endmodule


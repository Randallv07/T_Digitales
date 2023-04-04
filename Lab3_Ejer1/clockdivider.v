`timescale 1ns / 1ps



module Clockdivider #(parameter select =2'b00)( //fc es la velocidad de cambio con que alternaran los valores de los registros 1 y 2
    input Frec_ent, Reset,
    output wire Frec_sal
    );
    
    reg [25:0] count1 = 0;
    reg [25:0] count2 = 0;
    reg [27:0] count3 = 0;
    reg clk_out1, clk_out2, clk_out3;


always @(posedge Frec_ent)begin
     count1 <= count1 + 1;
	if (count1==50000000)begin
		count1 <= 0;
		clk_out1 = ~clk_out1;
	end
end 


always @(posedge Frec_ent)begin
	count2 <= count2 + 1;
	if (count2==25000000)begin
		count2 <= 0;
		clk_out2 = ~clk_out2;
	end
end

always @(posedge Frec_ent)begin
	count3 <= count3 + 1;
	if (count3==100000000)begin
		count3 <= 0;
		clk_out3 = ~clk_out3;
	end
end 

    if (select == 2'b00)
	   assign Frec_sal = clk_out1;
	else if (select == 2'b01) 
	   assign Frec_sal = clk_out2;
	else if (select == 2'b10)
	   assign Frec_sal = clk_out3;
	
endmodule
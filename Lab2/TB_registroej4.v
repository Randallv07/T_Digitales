`timescale 1ns / 1ps

module TB_registroej4();

parameter Anchodatos = 8;

//Variables de entrada
reg [4:0] selread1 , selread2, selwr;
reg [31:0] wr_datos;
reg we, rst, clk;


//Variables de salida
wire [31:0] rd_datos1, rd_datos2;
integer k;



registro U1(.selread1(selread1), .selread2(selread2), .selwr(selwr), 
.wr_datos(wr_datos), .rd_datos1(rd_datos1), .rd_datos2(rd_datos1));


initial 
begin

we<=1;
rst<=0;
selwr<= 1;
wr_datos <= {Anchodatos{$random}};

#5 selread1 <= 1;
#5 selread2 <= 2;



end

endmodule
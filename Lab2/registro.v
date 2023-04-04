`timescale 1ns / 1ps

//bitsel son los N bits que se usarán para el selector de registro 1 y al selector de registro 2

module registro #(parameter Anchodatos = 5, parameter numreg =5)(

input rst,
input clk,
input we,

input [numreg-1:0] selread1,
input [numreg-1:0] selread2,
input [numreg-1:0] selwr, // Entrada de bits para seleccionar sobre que registro se va a escribir
input [Anchodatos-1:0] wr_datos, //Entrada para los bits que se van a escribir en el registro

output reg [Anchodatos-1:0] rd_datos1,
output reg [Anchodatos-1:0] rd_datos2 //Duda los registros de salida quedan de 16 posiciones, pero las posiciones del array que se asignan son de 8 posiciones
);


integer k;


//[Ancho de los datos:0] registro [0:Cantidad de registros]
reg [Anchodatos-1:0] array [0:numreg-1];



always @(posedge clk)begin
    if(rst==0)begin
        for(k=0; k<numreg; k=k+1)begin
            array[k] <={Anchodatos{1'b0}};
        end
    end
    else if(we==1)begin
        array[selwr] <= wr_datos;
    end
end


always @(*)begin
    rd_datos1 = array[selread1];
    rd_datos2 = array[selread2];
end
endmodule




//Primero se escribe en todos los regisrtros y luego de finalizar la escritura, dependiendo de la seleccion de sel1 y sel2 mostrar los valores de registros.
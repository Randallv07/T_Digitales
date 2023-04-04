`timescale 1ns / 1ps

module tb_registro;

parameter Anchodatos=5;
parameter SEL=5;


reg clk,rst;
reg [SEL-1:0] selread1,selread2,wr_datos;//selección
reg [Anchodatos-1:0] selwr;
wire [Anchodatos-1:0] rd_datos1,rd_datos2;
integer k;


registro #(.Anchodatos(SEL),.numreg(SEL)) U0(
 .rst(rst),
 .clk(clk),
 .we(1'b1),
.selread1(selread1),
.selread2(selread2),
.selwr(selwr), // Entrada de bits para seleccionar sobre que registro se va a escribir
.wr_datos(wr_datos), //Entrada para los bits que se van a escribir en el registro
.rd_datos1(rd_datos1),
.rd_datos2(rd_datos2) //Duda los registros de salida quedan de 16 posiciones, pero las posiciones del array que se asignan son de 8 posiciones
);

always begin
    #5 
    clk=~clk;
end


initial
begin
clk=0;
rst=0;
@(posedge clk);
@(posedge clk);
@(posedge clk);
#1;
rst = 1;

@(posedge clk);
selread1=0;
selread2=0;
wr_datos=0;//selección
selwr=0;
@(posedge clk);
selread1=0;
selread2=0;
wr_datos=10;//selección
selwr=1;
@(posedge clk);
selread1=0;
selread2=0;
wr_datos=15;//selección
selwr=2;
@(posedge clk);
selread1=2;
selread2=1;
wr_datos=7;//selección
selwr=3;

@(posedge clk);
selread1=3;
selread2=0;
wr_datos=4;//selección
selwr=4;

@(posedge clk);
selread1=4;
selread2=3;
wr_datos=11;//selección
selwr=5;

#120 $finish;
end



endmodule


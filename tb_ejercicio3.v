`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2022 13:42:11
// Design Name: 
// Module Name: tb_ejercicio3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ejercicio3(
    );
    
    reg clk=0,rst, WR, Reg_sel;
    reg [31:0] Entrada_t;
    wire [31:0] Salida;
    parameter clock=5;
    parameter medio_periodo=clock/2;
    parameter delay_val=1;
    initial begin
        forever begin
            #(medio_periodo) clk=~clk;
        end
    end
        
        task esperar(input integer num);
            repeat(num) begin
                @(posedge clk); #(delay_val);
            end
        endtask
        
   Ejercicio_3 tb3 (.clk(clk), 
                    .rst(rst), 
                    .WR(WR), 
                    .Reg_sel(Reg_sel), 
                    .Entrada(Entrada_t), 
                    .Salida(Salida));
                            
   initial begin
   rst=0;
   #30;
   rst=1;
   #30;
   Entrada_t=0000000000000000000000000000001;
   Reg_sel=0;
   WR=1;
   #20000;
   WR=0;
   Entrada_t=0000000000000000000000000000010;
   Reg_sel=0;
   WR=1;
   #2000;
   WR=0;
   end                 
                         
endmodule
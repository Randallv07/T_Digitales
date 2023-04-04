`timescale 1ns / 1ps

module deco7segment(

input clk,write,reset,
input [15:0] Datos,// Entradas binarias de los switches


input res,
input rstn,


output reg [7:0] anodo,
output a,
output b,
output c,
output d,
output e,
output f,
output g
    );
    
wire A,B,C,D;
reg [1:0] selreg;
reg clk_out;

reg [1:0] Out;
integer k,i;
wire Aneg, Bneg, Cneg, Dneg;
wire out1,out2,out3,out4,out5,out6, out7,out8,out9,out10,out11, out12, out13,out14,out15,out16;

// Generando 4 registros de 4 bits  los primeros parentesis indican el tamaño en bits de los registros
// los segundos parentesis indican el numero de registros que se crearan

reg [3:0] regfile [0:3];

//Reductor de frecuencia  CLK Wizard
 clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_7MHz(clk_7MHz),     // output clk_7MHz
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk));

parameter fre=8000000;
parameter fre_out=240;
parameter max_cont=fre/(2*fre_out);

reg [22:0] contador;    
initial begin
contador=0;
clk_out=0;
end

always @(posedge clk_7MHz)begin
        if(contador==(max_cont))begin
        clk_out=~clk_out;
        contador=0;
        end
        else begin
            contador=contador+1;
        end
end


assign {A,B,C,D} = regfile[selreg];


always @(posedge clk_out)begin
    if(write)begin
//El ciclo for itera seleccionando desde la posicion del registro 0 al registro 3
//Como los 4 registros son de 4 bits, se le asignan a cada bit del registro regfile una posicion del registro de 16 bits de la entrada
        for(k=0;k<4;k=k+1)begin
            regfile[k]<={Datos[k*4],Datos[k*4+1],Datos[k*4+2],Datos[k*4+3]};
            //regfile[0]<={sw[0*4],sw[0*4+1],sw[0*4+2],sw[0*4+3]};
            //regfile[1]<={sw[1*4],sw[1*4+1],sw[1*4+2],sw[1*4+3]};
            //regfile[2]<={sw[2*4],sw[2*4+1],sw[2*4+2],sw[2*4+3]};
            //regfile[3]<={sw[3*4],sw[3*4+1],sw[3*4+2],sw[3*4+3]};
        end
    end
    
    if(res)begin
        for (k=0;k<4;k=k+1)begin
            regfile[k]<=0;
        end
    end
    
end   

always @(posedge clk_out)begin
        case(Out)
        2'b00:anodo<=8'b01111111;
        2'b01:anodo<=8'b10111111;
        2'b10:anodo<=8'b11011111;
        2'b11:anodo<=8'b11101111;
    endcase

end

assign Aneg = ~A; 
assign Bneg = ~B;
assign Cneg = ~C;
assign Dneg = ~D;


// Tabla de Verdad de las 4 variables

assign out1=  Aneg &  Bneg & Cneg & Dneg;
assign out2=  Aneg &  Bneg & Cneg & D;
assign out3=  Aneg &  Bneg & C    & Dneg;
assign out4=  Aneg &  Bneg & C    & D;
assign out5=  Aneg&   B    & Cneg & Dneg;
assign out6=  Aneg &  B    & Cneg & D;
assign out7=  Aneg &  B    & C    & Dneg;
assign out8=  Aneg &  B    & C    & D;
assign out9=  A    &  Bneg & Cneg & Dneg;
assign out10= A    &  Bneg & Cneg & D;
assign out11= A    &  Bneg & C    & Dneg;
assign out12= A    &  Bneg & C    & D;
assign out13= A    &  B    & Cneg & Dneg;
assign out14= A    &  B    & Cneg & D;
assign out15= A    &  B    & C    & Dneg;
assign out16= A    &  B    & C    & D;

assign a=~(out1 | out3 | out4 | out6 | out7 | out8 | out9 | out10 | out11 | out15 |out16);
assign b=~(out1 | out2 | out3 | out4 | out5 | out8 | out9 | out10 | out11 | out14);
assign c=~(out1 | out2|  out4 | out5 | out6 | out7 | out8 | out9 | out10 | out11 | out12 | out14);
assign d=~(out1 | out3 | out4 | out6 | out7 | out9 | out10 | out12 | out13 | out14 |out15);
assign e=~(out1 | out3 | out7 | out9 | out11 | out12 | out13 | out14 | out15 | out16);
assign f=~(out1 | out5 | out6 | out7 | out9 | out10 | out11 | out12 |out15 |out16);
assign g=~(out3 | out4 | out5 | out6 | out7 | out9 | out10 | out11 | out12 | out13 | out14 | out15 | out16);

always @(posedge clk_out) begin
    if(rstn)
        Out <= 0;
    else 
        Out <= Out + 1;
                
 end

always @(posedge clk_out)begin
    case(Out)
        2'b00:selreg<=0;
        2'b01:selreg<=1;
        2'b10:selreg<=2;
        2'b11:selreg<=3;
        
    endcase
end


endmodule
`timescale 1ns / 1ps

module sieteseg(
    input clk,write,banksel,
    input [15:0] Datos,// Entradas binarias de los switches
    input res,
    input [1:0] muxfrec,

output reg [7:0] anodo,
output a,
output b,
output c,
output d,
output e,
output f,
output g,
output wire led1, led2
    );
    
wire A,B,C,D;
reg [1:0] selreg;
reg clk_out; //Enable

reg [1:0] Out;
integer k,i;
wire Aneg, Bneg, Cneg, Dneg;
wire out1,out2,out3,out4,out5,out6, out7,out8,out9,out10,out11, out12, out13,out14,out15,out16;

wire Frec_sal1, Frec_sal2, Frec_sal3;

reg frec;

// Generando 4 registros de 4 bits  los primeros parentesis indican el tamaño en bits de los registros
// los segundos parentesis indican el numero de registros que se crearan

reg [3:0] regfile1 [0:3];
reg [3:0] regfile2 [0:3];

  clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_10MHz(clk_10MHz),     // output clk_10MHz
    // Status and control signals
    .reset(1'b0), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk));      // input clk_in1

parameter fre=10000000;
parameter fre_out=1000;
parameter max_cont=(fre/(2*fre_out))-1;

reg [14:0] contador;    
initial begin
contador=0;
clk_out=0;
end

always @(posedge clk_10MHz)begin
        if(contador==(max_cont))begin
        clk_out=~clk_out;
        contador=0;
        end
        else begin
            contador=contador+1;
        end
end

Clockdivider  #(.select(2'b00)) U1(.Frec_ent(clk_10MHz), .Reset(res), .Frec_sal(Frec_sal1));

Clockdivider  #(.select(2'b01)) U2(.Frec_ent(clk_10MHz), .Reset(res), .Frec_sal(Frec_sal2));

Clockdivider  #(.select(2'b10)) U3(.Frec_ent(clk_10MHz), .Reset(res), .Frec_sal(Frec_sal3));

always @(posedge clk_10MHz)begin
    case(muxfrec)
        2'b00: frec <= Frec_sal1;
        2'b01: frec <= Frec_sal2;
        2'b10: frec <= Frec_sal3;
        2'b11: frec <= Frec_sal1;
    endcase
end

assign {A,B,C,D} = (frec==0)? regfile1[selreg]: regfile2[selreg];
assign led1 = (frec==0)? 1:0;
assign led2 = (frec==1)? 1:0;

always @(posedge clk_out)begin
    if(!banksel)begin
        if(write)
            for(k=0;k<4;k=k+1)begin
                regfile1[k]<={Datos[k*4],Datos[k*4+1],Datos[k*4+2],Datos[k*4+3]};
            end
        end
    else if (banksel)begin
           if(write)
               for(k=0;k<4;k=k+1)begin
                 regfile2[k]<={Datos[k*4],Datos[k*4+1],Datos[k*4+2],Datos[k*4+3]};
               end
           end      
   if(res)begin
            regfile1[0]<=4'b0;
            regfile1[1]<=4'b0;
            regfile1[2]<=4'b0;
            regfile1[3]<=4'b0;
            regfile2[0]<=4'b0;
            regfile2[1]<=4'b0;
            regfile2[2]<=4'b0;
            regfile2[3]<=4'b0;
        end 
    end

  

always @(posedge clk_out)begin
        case(Out)
        2'b00:anodo<=8'b11111110;
        2'b01:anodo<=8'b11111101;
        2'b10:anodo<=8'b11111011;
        2'b11:anodo<=8'b11110111;
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

assign a=~(out1 | out3 | out4| out6 | out7 | out8 | out9 | out10 |out11 | out15  | out16);
assign b=~(out1 | out2 | out3 | out4 | out5 | out8 | out9 | out10 | out11 | out14);
assign c=~(out1 | out2|  out4 | out5 | out6 | out7 | out8 | out9 | out10 | out11 | out12 | out14);
assign d=~(out1 | out3 | out4 | out6 | out7 | out9 | out10 | out12 | out13 | out14 |out15);
assign e=~(out1 | out3 | out7 | out9 | out11 | out12 | out13 | out14 | out15 | out16);
assign f=~(out1 | out5 | out6 | out7 | out9 | out10 | out11 | out12 |out15 |out16);
assign g=~(out3 | out4 | out5 | out6 | out7 | out9 | out10 | out11 | out12 | out13 | out14 | out15 | out16);

always @(posedge clk_out) begin
    if(res)
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
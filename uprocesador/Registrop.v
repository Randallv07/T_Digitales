`timescale 1ns / 1ps

module Registrop(

input clk,reset,write,
input [4:0] selread1,selread2,writesel,//selección
input [31:0] WData,
output reg [31:0] rdData1,rdData2
    );
integer k;

reg [31:0] regfile [2**5-1:0];

 

always @(posedge clk)begin
    if(!reset)begin
        for (k=0;k<2**5;k=k+1)begin
            regfile[k]<=0;
        end
    end

    else if (write==1)begin
        regfile[writesel]<=WData;
    end
end


always @(*) begin
    if (selread1==0)
         rdData1 = 31'b0;
    else 
        rdData1 = regfile[selread1];    
   if(selread2 ==0)
        rdData2 = 31'b0;
    else
        rdData2 = regfile[selread2];
end


endmodule
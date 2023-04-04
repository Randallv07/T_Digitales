`timescale 1ns / 1ps

module generador_datos_1(
    
    input clk,
    input rst,
    input we,
    output reg [15:0] data
    );
    
    //reg [1:0]Q;
    
    integer i;
    
    always @(posedge clk) begin
        if(!rst)begin
            data <= 0;
        end else begin
            for(i=0; i<15 ; i=i+1)begin
                data[i] <=$urandom%1;
                $display("Data: %d",data);
            end
        end
    end
endmodule

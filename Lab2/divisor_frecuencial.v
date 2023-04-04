`timescale 1ns / 1ps

module divisor_frecuencial #(parameter frec_sal=100, parameter frec_in=100_000_000)(input clk_in, output reg clk_out);
reg [25:0] contador=0;

always @(posedge clk_in) begin
    contador <= contador + 1; 
    if (contador==(frec_in/(2*frec_sal))) begin
        contador <= 1;
        clk_out <= ~clk_out;
    end
    else begin
        clk_out = clk_out;
    end
end
    
endmodule
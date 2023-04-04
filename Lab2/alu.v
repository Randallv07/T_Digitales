`timescale 1ns / 1ps

module alu #(parameter ANCHO=4) (
    input [ANCHO-1:0] A,B,
    input [2:0] sel_alu,
    output reg [ANCHO-1:0] RES
);

    always @(*)begin
        case (sel_alu)
            3'b000: RES = A + B;
            3'b001: RES = A - B;
            3'b010: RES = A & B;
            3'b011: RES = A | B;
            3'b100: RES = A ^ B;
            3'b101: RES = A << B;
            3'b110: RES = A >> B;
            3'b111: RES = A >>> B;
            default: RES = 1'bx;
        endcase
    end

    
endmodule
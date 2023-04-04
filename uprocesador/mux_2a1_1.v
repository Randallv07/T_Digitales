`timescale 1ns / 1ps

module mux_2a1_1 #(parameter D_ALU = 1'b0, D_RAM = 1'b1
                )(
                input [31:0] a, b,
                input sel_mux,
                output reg [31:0] out
                );
           
    always @(*) begin
        case (sel_mux)
            D_ALU : out <= a;
            D_RAM : out <= b;
        endcase
    end
endmodule
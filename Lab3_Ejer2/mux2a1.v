`timescale 1ns / 1ps

module mux_2a1 (input [31:0] a, b,
                input sel_mux,
                output reg [31:0] out
                );
           
    always @(*) begin
        case (sel_mux)
            1'b0 : out <= a;
            1'b1 : out <= b;
        endcase
    end
endmodule
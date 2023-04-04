`timescale 1ns / 1ps

module mux_2to1 #(parameter ANCHO=4)    (input [ANCHO-1:0] a, b,
                                         input sel_mux,
                                         output reg [ANCHO-1:0] out);

    always @(*) begin
        case (sel_mux)
            1'b0 : out <= a;
            1'b1 : out <= b;
        endcase
    end
endmodule
`timescale 1ns / 1ps

module mux_2a1_3 #(parameter RS2 = 2'd0, ext3 = 2'd1
                )(
                input [31:0] a, b,
                input sel_mux,
                output reg [31:0] out
                );
           
    always @(*) begin
        case (sel_mux)
            RS2 : out <= a;
            ext3 : out <= b;
        endcase
    end
endmodule
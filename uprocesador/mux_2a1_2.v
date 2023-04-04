`timescale 1ns / 1ps

module mux_2a1_2 #(parameter RS1_ext= 2'd0, ext2 = 2'd1
                )(
                input [31:0] a, b,
                input sel_mux,
                output reg [31:0] out
                );
           
    always @(*) begin
        case (sel_mux)
            RS1_ext : out <= a;
            ext2 : out <= b;
        endcase
    end
endmodule
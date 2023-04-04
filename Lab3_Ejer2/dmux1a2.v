`timescale 1ns / 1ps

module dmux1a2  (
input sel,
input  D,
output reg Out0, Out1
);

    always @(*) begin
        case(sel)
            0: Out0 = D;
            1: Out1 = D;        
        endcase
    end
endmodule
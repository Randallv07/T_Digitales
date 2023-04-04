`timescale 1ns / 1ps

module Reg_datos (
                    input rst, clk, WR2D,
                    input [11:0] i_int,
                    output [31:0] outD
                    );

reg [31:0] Reg_datos;

always @(posedge clk) begin
    if (!rst) Reg_datos <= 0;
    else begin
        if (WR2D) begin
            Reg_datos [11:0] <= i_int ;
        end
        else begin
            Reg_datos [11:0] <= Reg_datos [11:0];
        end
    end
end

assign outD = Reg_datos;

endmodule
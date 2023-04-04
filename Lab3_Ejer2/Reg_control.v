`timescale 1ns / 1ps

module Reg_control (
 input rst, clk, WR1C, WR2C,
 input [8:0] i_ext, 
 input i_flag, i_new,
 output [31:0] outC
 );

    reg [31:0] Reg_control;
        
    always @(posedge clk) begin
        if (!rst) Reg_control <= 0;
        else begin
            if (WR1C) begin
                Reg_control [0] <= i_ext [0];
                Reg_control [15:8] <= i_ext [8:1];
            end
            else begin
                Reg_control [0] <= Reg_control [0];
                Reg_control [15:8] <= Reg_control [15:8];
                if (WR2C) begin 
                Reg_control [1] <= i_flag;
                Reg_control [0] <= i_new;
                end
                else begin
                    Reg_control [1] <= Reg_control [1];
                end
            end
        end
    end

    assign outC = Reg_control;
endmodule
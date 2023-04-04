`timescale 1ns / 1ps

module Reg_addr (
 input rst, clk, we_AR,
 input [31:0] i_addr, 
 output [31:0] o_addr
 );

    reg [31:0] Reg_addr;
        
    always @(posedge clk) begin
        if (!rst) Reg_addr <= 0;
        else begin
            if (we_AR) begin
                Reg_addr  <= i_addr;
            end
            else begin
                Reg_addr <= Reg_addr;
            end
        end
    end

    assign o_addr = Reg_addr;
endmodule
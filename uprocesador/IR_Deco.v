`timescale 1ns / 1ps


module IR_Deco(
    input i_rst,
    input clk,
    input i_we,
    input [31:0] i_instr,
    output reg [6:0] opcode,
    output reg [2:0] funct3,
    output reg [6:0] funct7, 
    output reg [4:0] rd, 
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [11:0] o_imm_type_i, 
    output reg [4:0] o_imm_type_s1, 
    output reg [6:0] o_imm_type_s2, 
    output reg [4:0] o_imm_type_b1, 
    output reg [6:0] o_imm_type_b2, 
    output reg [19:0] o_imm_type_u, 
    output reg [19:0] o_imm_type_j 
    );

reg [31:0] Reg_inst;
        
    always @(posedge clk) begin
        if (!i_rst) Reg_inst <= 0;
        else begin
            if (i_we) begin
                Reg_inst  <= i_instr;
            end
            else begin
                Reg_inst <= Reg_inst;
            end
        end
    end

always @(*) begin
    opcode         = Reg_inst[6:0];
    funct3         = Reg_inst[14:12];
    funct7         = Reg_inst[31:25];
    rd             = Reg_inst[11:7];
    rs1            = Reg_inst[19:15];
    rs2            = Reg_inst[24:20];
    o_imm_type_i   = Reg_inst[31:20];
    o_imm_type_s1  = Reg_inst[11:7];
    o_imm_type_s2  = Reg_inst[31:25];
    o_imm_type_b1  = Reg_inst[11:7];
    o_imm_type_b2  = Reg_inst[31:25];
    o_imm_type_u   = Reg_inst[31:12];
    o_imm_type_j   = Reg_inst[31:12];
end


endmodule
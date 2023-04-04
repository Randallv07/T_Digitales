`timescale 1ns / 1ps

module tb_IR_Deco;
    reg i_rst;
    reg clk;
    reg i_we;
    reg [31:0] i_instr;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] o_imm_type_i;
    wire [4:0] o_imm_type_s1; 
    wire [6:0] o_imm_type_s2; 
    wire [4:0] o_imm_type_b1; 
    wire [6:0] o_imm_type_b2; 
    wire [19:0] o_imm_type_u; 
    wire [19:0] o_imm_type_j;

IR_Deco U0(
        .i_rst(i_rst),
        .clk(clk),
        .i_we(i_we),
        .i_instr(i_instr), 
        .opcode(opcode),
        .funct3(funct3), 
        .funct7(funct7),
        .rd(rd),  
        .rs1(rs1), 
        .rs2(rs2), 
        .o_imm_type_i(o_imm_type_i),
        .o_imm_type_s1(o_imm_type_s1),
        .o_imm_type_s2(o_imm_type_s2),
        .o_imm_type_b1(o_imm_type_b1),
        .o_imm_type_b2(o_imm_type_b2),
        .o_imm_type_u(o_imm_type_u),
        .o_imm_type_j(o_imm_type_j)
        );
        
        always begin
            #5 clk=~clk;
        end

        initial begin
            clk = 0;
            i_rst = 0;
            i_instr = 0;
            i_we = 0;
            #10
            i_rst = 1; 
            i_instr = {6'b111001,4'b0001,4'b1101,2'b01,4'b1111,6'b000001};
            #10
            i_we = 1;
            #30
            i_instr=569;
            #40 $finish;
        end


endmodule
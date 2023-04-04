`timescale 1ns / 1ps

module datapath #(
       //Comandos PC
       parameter reset = 2'd0, hold = 2'd1, inc = 2'd2, jump = 2'd3,
       //tipos de inmediatos
       parameter I = 3'd0, S = 3'd1, B = 3'd2, U = 3'd3, J = 3'd4,
       //Mux 2 a 1
       parameter D_ALU = 1'b0, D_RAM = 1'b1,
       //Mux 4 a 1
       parameter RS1_ext= 2'd0, ext2 = 2'd1,
       //Mux 4 a 1
       parameter RS2_i = 2'd0, ext3 = 2'd1
    )(
	input clk, rst,
	//entradas externas
	input [31:0] i_d_ROM, //Entrada de ROM
	input [31:0] i_d_RAM, //Entrada de RAM
	//salidas externas
	output [31:0] o_PC_o, //salida PC 
	output [31:0] o_d_up,  //salida de  microprocesador
	output [31:0] o_addr_RAM,  //dirección de la RAM
	output o_we_up,
	//entradas internas
	input i_we_up,
	input [2:0] i_im_type,
	input i_we_I, //write eneable registro de instrucciones
	input [1:0] i_C_pc, //control program counter
	input [2:0] i_op_ALU, // selección de  operaciÃ³n ALU
	input i_we_reg,  //write eneable registros
	input i_w_AR, //write eneable adress
	input i_sel_datos_rs1, //mux ALU o RAM hacia registro 
	input i_sel_datos_int, //mux ALU o RAM hacia registro 
	input i_sel_datos_rs2, //mux ALU o RAM hacia registro de registros
	//salidas internas
	output [6:0] o_opc, // opcode a FMS
	output [2:0] o_func3,
	output [6:0] o_func7,
	output o_zero
	);
    
    assign o_we_up = i_we_up;
    
    //Variables del PC
    wire [31:0] pc_jump;
    wire [31:0] pc_inc;
   
   //Inmediates
    wire [11:0] w_im_type_i;
    wire [4:0]  w_im_type_s1;
    wire [6:0]  w_im_type_s2;
    wire [4:0]  w_im_type_b1;
    wire [6:0]  w_im_type_b2;
    wire [19:0] w_im_type_u;
    wire [19:0] w_im_type_j;
    wire [31:0] w_im_extended;
   
   //Registros
    wire [4:0] w_RS1, w_RS2, w_RD;
    wire [31:0] w_dato_int, w_R1, w_R2;
    
   // ALU Y MUX
    wire [31:0] o_alu, mux_rs1, operand2, inst, s2, s1;
    
    program_counter PC(
	.clk(clk), 
	.rst(rst),
	.jumpdir(pc_jump[31:0]),
	.sel(i_C_pc[1:0]),
	.PC_o(o_PC_o[31:0]), 
	.PC_inc(pc_inc[31:0])
	);
    
    IR_Deco decoder(
    .i_rst(rst),
    .clk(clk),
    .i_we(i_we_I),
    .i_instr(i_d_ROM),
    .opcode(o_opc),
    .funct3(o_func3),
    .funct7(o_func7),
    .rd(w_RD), 
    .rs1(w_RS1),
    .rs2(w_RS2),
    .o_imm_type_i(w_im_type_i[11:0]), 
    .o_imm_type_s1(w_im_type_s1[4:0]), 
    .o_imm_type_s2(w_im_type_s2[6:0]), 
    .o_imm_type_b1(w_im_type_b1[4:0]), 
    .o_imm_type_b2(w_im_type_b2[6:0]), 
    .o_imm_type_u(w_im_type_u[19:0]), 
    .o_imm_type_j(w_im_type_j[19:0]) 
    );
    
    sign_extend extendet(
    .i_im_type(i_im_type[2:0]),
    .i_im_type_i(w_im_type_i[11:0]),
    .i_im_type_s1(w_im_type_s1[4:0]),
    .i_im_type_s2(w_im_type_s2[6:0]),
    .i_im_type_b1(w_im_type_b1[4:0]),
    .i_im_type_b2(w_im_type_b2[6:0]),
    .i_im_type_u(w_im_type_u[19:0]),
    .i_im_type_j(w_im_type_j[19:0]),
    .o_im_extended(w_im_extended[31:0])
    );
    
    
    Registrop registro(
        .clk(clk),
        .reset(rst),
        .write(i_we_reg),
        .selread1(w_RS1[4:0]),
        .selread2(w_RS2[4:0]),
        .writesel(w_RD[4:0]),
        .WData(w_dato_int[31:0]),
        .rdData1(w_R1[31:0]),
        .rdData2(w_R2[31:0])
    );
    
    mux_2a1_1 mux_datos(
        .a(o_alu[31:0]), 
        .b(i_d_RAM[31:0]),
        .sel_mux(i_sel_datos_int),
        .out(w_dato_int[31:0])
    );
    
    sumador sum2(
    .a(w_im_extended), 
    .b(w_R1),
    .o_sum(s2)
    );
    
     mux_2a1_2 mux__rs1(
        .a(s2[31:0]), 
        .b(w_im_extended[31:0]),
        .sel_mux(i_sel_datos_rs1),
        .out(mux_rs1[31:0])
    );
    
     mux_2a1_3 mux__rs2(
        .a(w_R2[31:0]), 
        .b(w_im_extended[31:0]),
        .sel_mux(i_sel_datos_rs2),
        .out(operand2[31:0])
    );
    
    alu ALU(
    .A(w_R1[31:0]),
    .B(operand2[31:0]),  // ALU 8-bit Inputs                 
    .ALU_Sel(i_op_ALU),// ALU Selection
    .ALU_Out(o_alu), // ALU 8-bit Output
    .CarryOut(), // Carry Out Flag
    .Zero(o_zero)
    );

    Reg_addr reg_direc(
    .rst(rst), 
    .clk(clk), 
    .we_AR(i_w_AR),
    .i_addr(s2), 
    .o_addr(o_addr_RAM)
    );
    
    assign o_d_up = w_R2;

endmodule

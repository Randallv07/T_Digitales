`timescale 1ns / 1ps

module tb_datapath; 
	
	reg clk, rst;
	//entradas externas
	reg [31:0] i_d_ROM; //Entrada de ROM
	reg [31:0] i_d_RAM; //Entrada de RAM
	//salidas externas
	wire [31:0] o_PC_o; //salida PC 
	wire [31:0] o_d_up;  //salida de  microprocesador
	wire [31:0] o_addr_RAM;  //dirección de la RAM
	wire we_up;
	//entradas internas
	reg [2:0] i_im_type;
	reg i_we_I; //write eneable registro de instrucciones
	reg [1:0] i_C_pc; //control program counter
	reg [2:0] i_op_ALU; // selección de  operaciÃ³n ALU
	reg i_we_reg;  //write eneable registros
	reg i_w_AR; //write eneable adress
	reg i_sel_datos_rs1; //mux ALU o RAM hacia registro 
	reg i_sel_datos_int; //mux ALU o RAM hacia registro 
	reg i_sel_datos_rs2; //mux ALU o RAM hacia registro de registros
	//salidas internas
	wire [6:0] opc; // opcode a FMS
	wire [2:0] func3;
	wire [6:0] func7;
	wire o_zero;
	
       parameter reset = 2'd0, inc = 2'd1, jump = 2'd1, hold = 2'd1;
       //tipos de inmediatos
       parameter I = 3'd0, S = 3'd1, B = 3'd2, U = 3'd3, J = 3'd4;
       //Mux 2 a 1
       parameter D_ALU = 1'b0, D_RAM = 1'b1;
       //Mux 4 a 1
       parameter RS1_ext= 2'd0, ext2 = 2'd1;
       //Mux 4 a 1
       parameter RS2_i = 2'd0, ext3 = 2'd1;


	datapath U0(
	.clk(clk), 
	.rst(rst),
	//entradas externas
	.i_d_ROM(i_d_ROM), //Entrada de ROM
	.i_d_RAM(i_d_RAM), //Entrada de RAM
	//salidas externas
	.o_PC_o(o_PC_o), //salida PC 
	.o_d_up(o_d_up),  //salida de  microprocesador
	.o_addr_RAM(o_addr_RAM),  //dirección de la RAM
	.we_up(we_up),
	//entradas internas
	.i_im_type(i_im_type),
	.i_we_I(i_we_I), //write eneable registro de instrucciones
	.i_C_pc(i_C_pc), //control program counter
	.i_op_ALU(i_op_ALU), // selección de  operaciÃ³n ALU
	.i_we_reg(i_we_reg),  //write eneable registros
	.i_w_AR(i_w_AR), //write eneable adress
	.i_sel_datos_rs1(i_sel_datos_rs1), //mux ALU o RAM hacia registro 
	.i_sel_datos_int(i_sel_datos_int), //mux ALU o RAM hacia registro 
	.i_sel_datos_rs2(i_sel_datos_rs2), //mux ALU o RAM hacia registro de registros
	//salidas internas
	.opc(opc), // opcode a FMS
	.func3(func3),
	.func7(func7),
	.o_zero(o_zero)
	);

   	always begin
           #5 clk=~clk;
	end

	initial begin
	clk = 0;
	rst = 0;
	i_d_ROM = 0;
	i_d_RAM = 0;
	i_im_type = 0;
	i_we_I = 0;
	i_C_pc = 0;
	i_op_ALU = 0;
	i_we_reg = 0;
	i_w_AR = 0;
	i_sel_datos_rs1 = 0;
	i_sel_datos_rs2 = 0;
	i_sel_datos_int = 0;
	@(negedge clk)
    @(negedge clk)
    i_d_RAM = 5;
    @(negedge clk)
    i_we_reg = 1;
    i_sel_datos_rs1 = 1;
    i_we_I = 1;
    i_sel_datos_int = 1;
    i_C_pc = 2;
    rst = 1;
    i_d_ROM = {7'b1011001,5'b00011,5'b00011,3'b101,5'b00011,7'b0000001};
    @(negedge clk)
	@(negedge clk)
	i_d_ROM = {7'b1011001,5'b00000,5'b00011,3'b101,5'b00001,7'b0000001};
    @(negedge clk)
    i_d_RAM = 4;
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
	#40 $finish;
	end


endmodule
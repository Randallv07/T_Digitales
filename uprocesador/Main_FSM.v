//Multicycle Control Main FSM
module Main_FSM(
                input clk, rst,
                input [6:0] i_opc, // entrada de opcode
                output reg o_we_upm, //we del uprocesador a la RAM
                output reg o_we_I, //habilita que se escriba las instruciones del ROM
                output reg [1:0] o_C_pc, //control de program counter
                output reg o_we_reg, //habilita escribir en registro
                output reg o_w_AR, //habilita escribir en el registro temporal addr
                output reg o_sel_datos_rs1,
                output reg o_sel_datos_rs2,
                output reg o_sel_datos_int,
                output reg [1:0] ALUOp
                );
                             


parameter
  Fetch          = 4'b0000, //0
  Decode         = 4'b0001, //1
  Mem_Read       = 4'b0010, //2
  Mem_Read_Load  = 4'b0011, //3
  Mem_Write      = 4'b0100, //4
  Mem_Write_Load = 4'b0101, //5
  ExecuteR       = 4'b0110, //6
  ALUWB          = 4'b0111, //7
  ExecuteI       = 4'b1000, //8
  JAL            = 4'b1001, //9
  JAL_2          = 4'b1010, //10
  BEQ            = 4'b1011; //11

reg [4:0] State, NextState;

// Updates state or reset on every positive clock edge

always @(posedge clk)
begin
if (rst)
  State <= Fetch;
else
  State <= NextState;
end

always @(State)
begin
case (State)
  Fetch: begin
        o_we_upm = 1'bx;
        o_we_I = 1'b1; //Se activan las instrucciones
        o_C_pc = 2'd2; //Se incrementa el pc 
        o_we_reg = 1'bx;
        o_w_AR = 1'bx;
        o_sel_datos_rs1 = 1'bx;
        o_sel_datos_rs2 = 1'bx;
        o_sel_datos_int = 1'bx;
        ALUOp = 2'b00; //estado inicial 
   end

  Decode: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bx;
        o_C_pc = 1'd1; //Mantiene el pc
        o_we_reg = 1'bx;
        o_w_AR = 1'bx;
        o_sel_datos_rs1 = 1'bx;
        o_sel_datos_rs2 = 1'b1; //Selecciona el extendet
        o_sel_datos_int = 1'bx;
        ALUOp = 2'b00; //estado inicial 
   end

  Mem_Read: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bx;
        o_C_pc = 2'd0;
        o_we_reg = 1'bx;
        o_w_AR = 1'b1;
        o_sel_datos_rs1 = 1'bx;
        o_sel_datos_rs2 = 1'b1;
        o_sel_datos_int = 1'b1;
        ALUOp = 2'b00;
   end

  Mem_Read_Load: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bx;
        o_C_pc = 2'd0;
        o_we_reg = 1'b1;
        o_w_AR = 1'b1;
        o_sel_datos_rs1 = 1'bx;
        o_sel_datos_rs2 = 1'b1;
        o_sel_datos_int = 1'b1;
        ALUOp = 2'b00;
   end

  Mem_Write: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bx;
        o_C_pc = 1'dx;
        o_we_reg = 1'bx;
        o_w_AR = 1'b1;
        o_sel_datos_rs1 = 1'bx;
        o_sel_datos_rs2 = 1'bx;
        o_sel_datos_int = 1'b1;
        ALUOp = 2'b00;
    end

  Mem_Write_Load: begin
        o_we_upm = 1'b1;
        o_we_I = 1'bx;
        o_C_pc = 1'dx;
        o_we_reg = 1'bx;
        o_w_AR = 1'b1;
        o_sel_datos_rs1 = 1'bx;
        o_sel_datos_rs2 = 1'bx;
        o_sel_datos_int = 1'bx;
        ALUOp = 2'b00;
    end

  ExecuteR: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bx;
        o_C_pc = 1'dx;
        o_we_reg = 1'bx;
        o_w_AR = 1'bx;
        o_sel_datos_rs1 = 1'bx;
        o_sel_datos_rs2 = 1'b0;
        o_sel_datos_int = 1'b0;
        ALUOp = 2'b00;
    end
    
  ALUWB: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bx;
        o_C_pc = 1'dx;
        o_we_reg = 1'b1;
        o_w_AR = 1'bx;
        o_sel_datos_rs1 = 1'bx;
        o_sel_datos_rs2 = 1'b0;
        o_sel_datos_int = 1'b0;
        ALUOp = 2'bxx;
    end
    
  ExecuteI: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bX;
        o_C_pc = 1'dx;
        o_we_reg = 1'bx;
        o_w_AR = 1'bx;
        o_sel_datos_rs1 = 1'bx;
        o_sel_datos_rs2 = 1'b1;
        o_sel_datos_int = 1'b0;
        ALUOp = 2'b10;
    end

  JAL: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bx;
        o_C_pc = 2'dx;
        o_we_reg = 1'bx;
        o_w_AR = 1'bx;
        o_sel_datos_rs1 = 1'b0;
        o_sel_datos_rs2 = 1'bx;
        o_sel_datos_int = 1'bx;
        ALUOp = 2'bxx;
    end

  JAL_2: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bx;
        o_C_pc = 2'd3;
        o_we_reg = 1'bx;
        o_w_AR = 1'bz;
        o_sel_datos_rs1 = 1'b0;
        o_sel_datos_rs2 = 1'bz;
        o_sel_datos_int = 1'bx;
        ALUOp = 2'bxx;
    end
    
  BEQ: begin
        o_we_upm = 1'bx;
        o_we_I = 1'bx;
        o_C_pc = 1'dx;
        o_we_reg = 1'bx;
        o_w_AR = 1'bx;
        o_sel_datos_rs1 = 1'b1;
        o_sel_datos_rs2 = 1'b0;
        o_sel_datos_int = 1'bx;
        ALUOp = 2'b01;
    end
endcase
end

//! fsm_extract
always @(*)
    begin
        case (State)
          Fetch: begin
            if (rst == 0)
              NextState = Decode;
            else
              NextState = Fetch;
            end
        
          Decode: begin
            if (i_opc == 0000011) //lw or sw
              NextState = Mem_Read;
              
            else if (i_opc == 0100011)
                NextState = Mem_Write;
                
            else if (i_opc == 0110011) //R-type
              NextState = ExecuteR;
              
            else if (i_opc == 0010011) //I-type ALU
              NextState = ExecuteI;
              
            else if (i_opc == 1101111)  //jal
              NextState = JAL;
              
            else if (i_opc == 1100011)  //beq
              NextState = BEQ;
            else 
              NextState = Fetch;
            end
        
          Mem_Read: begin
              NextState = Mem_Read_Load;
         end
        
          Mem_Read_Load: begin
            NextState = Fetch;
            end
        
          Mem_Write: begin
            NextState = Mem_Write_Load;
            end
        
          Mem_Write_Load: begin
            NextState = Fetch;
            end
        
          ExecuteR: begin
            NextState = ALUWB;
            end
        
          ALUWB: begin
            NextState = Fetch;
          end
            
          ExecuteI: begin
            NextState = ALUWB;
            end
            
          JAL: begin
            NextState = JAL_2;
            end
            
          JAL_2: begin
            NextState = Fetch;
            end
            
          BEQ: begin
            NextState = JAL_2;
            end
            
        endcase
    end
endmodule

module alu(
           input [31:0] A,B,  // ALU 8-bit Inputs                 
           input [2:0] ALU_Sel,// ALU Selection
           output [31:0] ALU_Out, // ALU 8-bit Output
           output CarryOut, // Carry Out Flag
           output  reg Zero // Zero flag
    );
    reg [31:0] ALU_Result;
    wire [32:0] tmp;
    assign ALU_Out = ALU_Result; // ALU out
    assign tmp = {1'b0,A} + {1'b0,B};
    assign CarryOut = tmp[32]; // Carryout flag
    always @(*)
    begin
        case(ALU_Sel)
            3'b000: // Addition
               ALU_Result = A + B ; 
            3'b001: // Subtraction
               ALU_Result = A - B ;
            3'b010: // Logical and
               ALU_Result = A & B;
            3'b011: // Logical or
               ALU_Result = A | B;
            3'b100: //  Logical xor 
               ALU_Result = A ^ B;
            3'b101: // Logical shift left
               ALU_Result = A<<1;
            3'b110: // Logical shift right
               ALU_Result = A>>1;
            3'b111: // Arithmetic shift right
               ALU_Result = A>>>1;
            default: ALU_Result = A + B ;            
        endcase
    end
 
 always @(*)
 begin
        if(ALU_Result == 0) begin
             Zero = 1;
        end
        else begin
            Zero = 0;
        end
 end

endmodule

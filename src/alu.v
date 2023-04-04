module alu(
           input [7:0] A,B,  // ALU 8-bit Inputs                 
           input [3:0] ALUControl,// ALU Selection
	   input [1:0] ALUFlagIn,// Carry In Flag
           output [7:0] ALU_Out, // ALU 8-bit Output
           output reg C // Carry Out Flag
    );
    reg [7:0] Y;
    wire [8:0] tmp;
    assign ALU_Out = Y; // ALU out
    assign tmp = {1'b0,A} + {1'b0,B};
    //assign C = tmp[8]; // Carryout flag
    always @(*)
    begin
        case(ALUControl)
	4'b0000: //  and 
           Y = A & B;
        4'b0001: //  or
           Y = A | B;
        4'b0010: // suma (en complemento a dos)
           Y = A + B ;
	4'b0011: // incrementar en uno el operando
	   if(ALUFlagIn == 0) begin
			Y = A>>1;
			end
		else if (ALUFlagIn == 1) begin
			Y = B>>1;
			end
		else begin
			Y = A>>1;
			end
	4'b0100: // decrementar en uno el operando
	    if(ALUFlagIn == 0) begin
			Y = A<<1;
			end
		else if (ALUFlagIn == 1) begin
			Y = B<<1;
			end
		else begin
			Y = A<<1;
			end           
	4'b0101: // not (sobre un operando)
		if(ALUFlagIn == 0) begin
			Y = ~(A) ;
			end
		else if (ALUFlagIn == 1) begin
			Y = ~(B) ;
			end
		else begin
			Y = ~(A) ;
			end
        4'b0110: // resta (en complemento a dos)
           Y = A - B ;
	4'b0111: //  xor 
           Y = A ^ B;
	4'b1000: // Corrimiento a la izquerda del operando A
           Y = {A[6:0],A[7]};
	4'b1001: // corrimiento a la derecha del operando A
           Y = {A[0],A[7:1]};
          default: Y = A + B ;
          
       endcase
       
	if(Y == 0)begin
	   C = 1 ;
	   end
	else begin
	   C = 0 ;
	   end 
        
    end

endmodule
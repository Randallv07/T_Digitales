`timescale 1ns / 1ps

module control #(parameter numreg=5) (
    input clk, rst,
    output reg sel_mux,
    output reg [2:0] sel_alu,
    output reg [numreg-1:0] selread1, selread2, 
    output reg [4:0] selwr
//Necesito write eneable?
);


//reg [4:0] cont1, next_cont1;
reg [2:0] next_sel_alu;
reg [numreg-1:0] next_selread1, next_selread2, next_selwr;

//MEMORIA - definición de estados
parameter N_BITS=1;
reg [N_BITS-1:0] state, next_state;

//ESTADOS
parameter Modo_capt = 1'b0;
parameter Modo_op = 1'b1;


//MEMORIA 
always @(posedge clk) begin
    if(!rst) begin
        state <= Modo_capt;
        //cont1 <= 0;
        selwr <= 0;
        selread1 <= 0;
        selread2 <= 1;
        sel_alu <= 0;
    end
    else begin 
        state <= next_state;
        //cont1 <= next_cont1;
        sel_alu <= next_sel_alu;
        selread1 <= next_selread1;
        selread2 <= next_selread2;
        selwr <= next_selwr; 
    end
end

//Maquina de estado Moore
//logica de siguiente estado
always @(*) begin //agregar default sel_mux=0
    case(state)
        Modo_capt: begin 
            if (selwr <=11) begin
                next_state = Modo_capt;
                sel_mux = 0;
                sel_alu = 0;
                selread1 = 0;
                selread2 = 0;
                //cont1 = cont1 + 1;
                next_selwr = selwr + 1;
            end
            else begin 
                next_state = Modo_op;
                next_sel_alu = 1;
                sel_mux = 1;
                sel_alu = 0;
                selread1 = 0;
                selread2 = 1;
                selwr = 20;
                next_selwr = 21;
                next_selread1 = 1;
                next_selread2 = 2;
                //next_cont1 = cont1 + 1;
                
            end
        end
        Modo_op: begin
        if (selread2 <= 8 ) begin
                   next_state = Modo_op;
                   //cont1 = cont1 + 1;
                   next_sel_alu = sel_alu + 1;
                   next_selread1 = selread1 + 1;
                   next_selread2 = selread2 + 1; 
                   next_selwr = selwr + 1;
               end
               else begin
                    next_state = Modo_capt;
                   sel_mux = 0;
                   next_sel_alu = 0;
                   next_selread1 = 0;
                   next_selread2 = 0;
                   sel_alu = 0;
                   selread1 = 0;
                   selread2 = 0;
                   selwr = 0;
                   next_selwr = 0;
               end
          /* if (cont1 == 13) begin
               next_state = Modo_op;
               next_cont1 = cont1+1;
               sel_mux = 1;
               sel_alu =1;
               selread1 = 1;
               selread2 = 2;
               selwr = 21;
           end
           else begin
               if (14<=cont1<=18) begin
                   next_state = Modo_op;
                   next_cont1 = cont1 + 1;
                   next_sel_alu = sel_alu + 1;
                   next_selread1 = selread1 + 1;
                   next_selread2 = selread2 + 1; 
                   next_selwr = selwr + 1;
               end
               else begin
                    next_state = Modo_capt;
                    sel_mux = 0;
                    sel_alu = 0;
                    selread1 = 0;
                    selread2 = 0;
                    cont1 = 0;
                    selwr = 0;
               end
           end*/
        end
        default:
            next_state = Modo_capt;
     
    endcase
end

//logica de salida
/*
always @(*) begin
    case (state)
        Modo_capt: begin
            if (cont1<=11) begin
                next_cont1 = cont1 + 1;
                sel_mux = 0;
                sel_alu = 0;
                selread1 = 0;
                selread2 = 0;
                next_selwr = selwr + 1;
            end
            else begin 
                sel_mux = 1;
                selwr = 20;
                selread1 = 0;
                selread2 = 1;
                next_cont1 = cont1 + 1;
            end
        end
        Modo_op: begin
            sel_mux = 1;
            next_cont1 = cont1 + 1;
            next_sel_alu = sel_alu + 1;
            next_selread1 = selread1 + 1;
            next_selread2 = selread2 + 1; 
            next_selwr = selwr + 1;
        end
     endcase
end
*/
endmodule
`timescale 1ns / 1ps

module control (
    input clk, rst,
    input [31:0] i_data_control,
    input [11:0] i_data_XADC,
    output reg o_new, o_flag, WRD2, WRC2
    );

    reg state, next_state;
    reg [11:0] Umb;
    
    //ESTADOS
    parameter OFF = 1'b0;
    parameter ON = 1'b1;


    //BLOQUED DE MEMORIA 
    always @(posedge clk) begin
        if(!rst) begin
            state <= OFF;
        end
        else begin 
            state <= next_state; 
        end
    end

    //logica de siguiente estado
    always @(*) begin //agregar default sel_mux=0
        Umb = {i_data_control [15:8],4'b0};
        case(state)
            OFF: begin 
                if (i_data_control [0] == 0) begin
                    next_state = OFF;
                    o_new = 0;
                    //o_flag = 0;
                    WRD2 = 0;
                    WRC2 = 0;
                end
                else begin 
                    next_state = ON;
                end
            end
            ON: begin
                    WRD2 = 1;
                    WRC2 = 1;
                    o_new = 0;
                    if (i_data_XADC >= Umb) o_flag = 1;
                    else o_flag = 0;
                    next_state = OFF;
      
            end
        endcase
    end

endmodule
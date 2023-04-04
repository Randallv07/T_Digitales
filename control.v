`timescale 1ns / 1ps

module control (
    input clk, rst,
    input [31:0] i_data_control,
    output reg o_send, o_clear, WR2C, WR2D, eneable_SPI,
    output reg [7:0] transac
    );

    integer Transac;
    
initial begin
    Transac = 0;
end

    reg state, next_state;
    
    //ESTADOS
    parameter OFF = 1'b0;
    parameter ON = 1'b1;
    

    //BLOQUED DE MEMORIA 
    always @(posedge clk) begin
        if(rst) begin
            state <= OFF;
        end
        else begin 
            state <= next_state; 
        end
    end

    //logica de siguiente estado
    always @(*) begin //agregar default sel_mux=0
    transac = Transac;
        case(state)
            OFF: begin 
                if (i_data_control [0] == 0) begin
                    next_state = OFF;
                    o_send = 0;
                    o_clear = 0;
                    WR2D = 0;
                    WR2C = 0;
		            eneable_SPI = 0;
		            Transac = Transac;
                end
                else begin 
                    next_state = ON;
                end
            end
            ON: begin
                    WR2D = 1;
                    WR2C = 1;
		    eneable_SPI = 1;
                    o_clear = 0;
                    o_send = 0;
                    if (i_data_control [1] == 1) Transac = 0;
                    else Transac = Transac + 1;
                    next_state = OFF;
      
            end
        endcase
    end
endmodule


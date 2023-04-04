`timescale 1ns / 1ps

module datapath #(parameter numreg=5) (
    input sel_mux, rst, clk,
    input [numreg-1:0] selread1, selread2, selwr,
    input [2:0] sel_alu,
    output [numreg-1:0] RES
);

wire [numreg-1:0] n0, n1, n2, n3, RES; 

LFSR_individual_test_top bloque0
         (.i_Clk(clk),
          .i_Rst(rst),
          .i_Enable(1'b1),
          .i_Seed_Data({5{1'b0}}), // Replication
          .o_LFSR_Data(n0),
          .o_LFSR_Done()
          );

mux_2to1 bloque1(.a(n0),
                .b(RES),
                .sel_mux(sel_mux),
                .out(n1)
                );

registro bloque2(.rst(rst),
                .clk(clk),
                .we(1'b1),
                .selread1(selread1),
                .selread2(selread2),
                .wr_datos(n1),
                .selwr(selwr),
                .rd_datos1(n2),
                .rd_datos2(n3)
                );

alu bloque3(.A(n2),
            .B(n3),
            .sel_alu(sel_alu),
            .RES(RES)
            );
            
endmodule
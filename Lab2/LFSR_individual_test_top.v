`timescale 1ns / 1ps


/// JUST to test using 5 bits 

module LFSR_individual_test_top(
        input i_Clk,
        input i_Rst,
        input i_Enable,
        
        // Optional Seed Value
        input [5-1:0] i_Seed_Data,
        
        output [5-1:0] o_LFSR_Data,
        output o_LFSR_Done
    );
    
    LFSR #(.NUM_BITS(5)) LFSR_inst
         (.i_Clk(i_Clk),
          .i_Rst(i_Rst),
          .i_Enable(i_Enable),
          .i_Seed_Data(i_Seed_Data), 
          .o_LFSR_Data(o_LFSR_Data),
          .o_LFSR_Done(o_LFSR_Done)
          );
          
endmodule

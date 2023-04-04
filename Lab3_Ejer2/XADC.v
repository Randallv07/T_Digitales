`timescale 1ns / 1ps

module XADC (
    input clk,
    input vp_in,
    input vn_in,
    input AD2N,
    input AD2P,
    output [11:0] o_XADC
    );
wire [15:0] LED;
wire eneable;

xadc_wiz_0 DUT
          (
          .daddr_in(7'h12),            // Address bus for the dynamic reconfiguration port
          .dclk_in(clk),             // Clock input for the dynamic reconfiguration port
          .den_in(eneable),              // Enable Signal for the dynamic reconfiguration port
          .di_in(0),               // Input data bus for the dynamic reconfiguration port
          .dwe_in(0),              // Write Enable for the dynamic reconfiguration port
          .vauxp2(AD2P),              // Auxiliary channel 2
          .vauxn2(AD2N),
          .busy_out(),            // ADC Busy signal
          .channel_out(),         // Channel Selection Outputs
          .do_out(LED),              // Output data bus for dynamic reconfiguration port
          .drdy_out(),            // Data ready signal for the dynamic reconfiguration port
          .eoc_out(eneable),             // End of Conversion Signal
          .eos_out(),             // End of Sequence Signal
          .alarm_out(),           // OR'ed output of all the Alarms    
          .vp_in(vp_in),               // Dedicated Analog Input Pair
          .vn_in(vn_in)
          );

assign o_XADC = LED [15:4];

endmodule
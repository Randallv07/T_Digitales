module tb_SPImaster;

   // Control/Data Signals,
   reg rst;     // FPGA Reset
   reg clk;       // FPGA Clock
   reg [7:0]  entrada;        // Byte to transmit on MOSI    Datos de entrada SW
   reg boton;          // Data Valid Pulse with i_TX_Byte     Boton
   wire o_TX_Ready;       // Transmit Ready for next byte  
   wire [7:0] salida;   // Byte received on MISO  LEDS
   wire o_SPI_MOSI;   //Conecta JA

parameter SPI_MODE = 0;
parameter CLKS_PER_HALF_BIT = 2;

SPImaster
  #(.SPI_MODE(SPI_MODE),
    .CLKS_PER_HALF_BIT(CLKS_PER_HALF_BIT))
  DUT(
   // Control/Data Signals,
   .i_Rst_L(rst),     // FPGA Reset
   .i_Clk(clk),       // FPGA Clock
   .i_TX_Byte(entrada),        // Byte to transmit on MOSI    Datos de entrada SW
   .i_TX_DV(boton),          // Data Valid Pulse with i_TX_Byte     Boton
   .o_TX_Ready(o_TX_Ready),       // Transmit Ready for next byte  
   .o_RX_DV(),     // Data Valid pulse (1 clock cycle)
   .o_RX_Byte(salida),   // Byte received on MISO  LEDS
   .o_SPI_Clk(),   //no se muestra
   .i_SPI_MISO(o_SPI_MOSI),  //Conectar JA
   .o_SPI_MOSI(o_SPI_MOSI)   //Conecta JA
   );

initial begin
    clk=0;
end

always begin
    #5 clk=~clk;
end

initial begin
    rst=0;
    boton=0;
    entrada = 0;
    @(negedge clk)
    rst=1;
    entrada=12;
    @(negedge clk)
    boton = 1;
    @(negedge clk)
    @(negedge clk)
    boton=0;
    @(negedge clk)
    entrada=15;
    @(negedge clk)
    @(negedge clk)
    boton = 1;
    @(negedge clk)
    boton=0;
    @(negedge clk)
    @(negedge clk)
    #5 $finish;
end 


endmodule // tb_SPI_Master
`timescale 1ns / 1ps

module Control_SPI(clk, rst, sal_c, sal_d, WR2_c, IN2_c, WR2_d, IN2_d,clks, miso, mosi);
    input clk, rst;
    input [31:0] sal_c, sal_d;
    output reg [31:0] IN2_c=0;
    output reg [31:0] IN2_d=0;
    output reg WR2_c=0;
    output reg WR2_d=0;
    
    reg [31:0] w_sal_c;
    wire w_final_spi, w_mosi;
    wire [7:0] w_dato_entr;
    wire w_rx_dv;
    reg inicio_spi, final_spi;
    output miso, mosi;
    output clks;
    reg [7:0] transacciones=0;
    reg [7:0] dato_sal, dato_entr;
            

    SPI_Master 
  #(.SPI_MODE(3),
    .CLKS_PER_HALF_BIT(12)) SPIU
  (
   // Control/Data Signals,
   .i_Rst_L(rst),     // FPGA Reset
   .i_Clk(clk),       // FPGA Clock
   
   // TX (MOSI) Signals
   .i_TX_Byte(dato_sal),        // Byte to transmit on MOSI
   .i_TX_DV(inicio_spi),          // Data Valid Pulse with i_TX_Byte
   .o_TX_Ready(w_final_spi),       // Transmit Ready for next byte
   
   // RX (MISO) Signals
   .o_RX_DV(w_rx_dv),     // Data Valid pulse (1 clock cycle)
   .o_RX_Byte(w_dato_entr),   // Byte received on MISO

   // SPI Interface
   .o_SPI_Clk(clks),
   .i_SPI_MISO(miso),
   .o_SPI_MOSI(mosi)
   );   
    
    //assign w_final_spi=final_spi;
    //assign w_dato_entr=dato_entr;
    //assign w_clks=clks;
   // assign w_mosi=mosi;
    reg [1:0] estado,sig_estado;
           
    
 parameter RESET=2'b00, ESTADO_INICIAL=2'b01, ESTADO_CARGA=2'b10,ESTADO_OPER=2'b11;
 //MEMORIA
 always@(posedge clk)begin
 if(sal_c[1]==1) begin
    estado<=RESET;
    //rst<=0;
    end
 else begin
    estado<=sig_estado;
    //rst<=1;
 end
 end
 
 //LOGICA DE ESTADO SIGUIENTE
 always @(posedge clk)begin
    case(estado)
        RESET: begin
            WR2_d<=1;
            WR2_c<=1;
            transacciones<=0;
            IN2_c[15:8]<=transacciones;
            IN2_c[1]<=0;
            sig_estado<=ESTADO_INICIAL;
        end
        
        ESTADO_INICIAL:begin
            WR2_d<=0;
            WR2_c<=0;
            /*if (IN2_c[1]==1)begin
               WR2_d<=1;
               WR2_c<=1;
               IN2_c[1]<=0;
               sig_estado<=ESTADO_CARGA; 
            end*/
            if(sal_c[0]==1) begin
               if(w_final_spi==1 & inicio_spi==1)begin
               transacciones<=transacciones+1'b1;
               end        
               inicio_spi<=1;
               dato_sal<=8'b11001100; 
               sig_estado<=ESTADO_CARGA;
               end
            
            else begin
               inicio_spi<=0;
               sig_estado<=ESTADO_INICIAL;
            end
        end
        
        ESTADO_CARGA: begin   
             inicio_spi<=0;
             if(w_final_spi==1)begin
                WR2_d<=1;
                WR2_c<=1;
                IN2_d[7:0]<=w_dato_entr;
                IN2_c[31:16]<=0;
                IN2_c[15:8]<=transacciones;
                IN2_c[7:2]<=0;
                IN2_c[0]<=0;
                IN2_d[31:8]<=0;
                sig_estado<=ESTADO_INICIAL;
             end
             else begin
                sig_estado<=ESTADO_CARGA;
             end
        end
        
        default: 
        sig_estado<=ESTADO_INICIAL;
    endcase
 end
 
 
//LÓGICA DE SALIDA
/*always @(*)begin
    case(estado)
    ESTADO_INICIAL:begin
            selc_estado=1'b0;
            we=1'b0;

                 
    end
    ESTADO_CARGA:begin
            selc_estado=1'b0;
            we=1'b1;
    end
    ESTADO_OPER:begin
        selc_estado=1'b1;
        we=1'b1;
    end
    
    default begin
    we=1'b1;
    selc_estado=1'b0;  
    end
    
    endcase
end*/

endmodule

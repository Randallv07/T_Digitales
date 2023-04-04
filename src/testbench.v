`timescale 1ns / 1ps

module testbench;

reg SW;
wire out;

modulo_uno DUT (.INTERRUPTOR(SW), .led(out));

initial begin
SW=0;
#10 SW=1;
#10 SW=0;
#10 SW=1;
#20 $finish;
end
endmodule
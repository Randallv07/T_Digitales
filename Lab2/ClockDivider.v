module ClockDivider(

    input CLK_6_25MHZ, Reset,
    output CLK_1Hz
    );
    
    reg [20:0]counter=0;
    
    always @(posedge CLK_6_25MHZ)
    begin
       if(Reset == 0) counter <= 0;
       else counter <= (counter>=6250000)?0:counter+1;
    end
    assign CLK_1Hz = (counter == 6250000)?1'b1:1'b0;
    
endmodule
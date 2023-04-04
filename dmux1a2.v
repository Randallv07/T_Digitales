`timescale 1ns / 1ps

module dmux1a2(

    input sel_dmux,

    input D,

    output Out0,

    output Out1

    );

not(sn,sel_dmux);

and(Out0,sn,D);

and(Out1,sel_dmux,D);

endmodule
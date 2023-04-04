`timescale 1ns / 1ps

module sign_extend #(
    parameter I = 3'd0,
    parameter S = 3'd1,
    parameter B = 3'd2,
    parameter U = 3'd3,
    parameter J = 3'd4 
    )(
    input [2:0]  i_im_type,
    input [11:0] i_im_type_i,
    input [4:0]  i_im_type_s1,
    input [6:0]  i_im_type_s2,
    input [4:0]  i_im_type_b1,
    input [6:0]  i_im_type_b2,
    input [19:0] i_im_type_u,
    input [19:0] i_im_type_j,
    output reg [31:0] o_im_extended
    );
    
     always @ (*)
        case(i_im_type)
            I: o_im_extended = {{20{i_im_type_i[11]}}, i_im_type_i};
            S: o_im_extended = {{20{i_im_type_s2[6]}}, i_im_type_s2, i_im_type_s1};
            B: o_im_extended = {{20{i_im_type_b2[6]}},
                                    i_im_type_b1[0],
                                    i_im_type_b2[5:0],
                                    i_im_type_b1[3:0],
                                    1'b0};
            U: o_im_extended = {i_im_type_u[19:0],
                                12'd0 };
            J: o_im_extended = {{12{i_im_type_j[19]}},
                                    i_im_type_j[7:0], 
                                    i_im_type_j[9], 
                                    i_im_type_j[18:9], 
                                    1'b0};
             default: o_im_extended = 32'd0;
        endcase
        
endmodule
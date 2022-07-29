`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 11:57:54
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [31:0] rD1_ex,
    input [31:0] alu_b_ex,
    input [3:0] alu_op_ex,
    output reg alu_branch,
    output reg [31:0] alu_c
    );
    
    reg [31:0] alu_c1;
    
    barrel_shifter u_bs(
        .alu_op_ex(alu_op_ex),
        .rD1_ex(rD1_ex),
        .alu_b_ex(alu_b_ex),
        .alu_c1(alu_c1)
    );    
    
    always @(*) begin
        case(alu_op_ex[1:0])
            2'b00:  
            begin
                case(alu_op_ex[3:2])                                       
                    2'b00: alu_c = rD1_ex + alu_b_ex;                       //add
                    2'b01: alu_c = (32'hffffffff-alu_b_ex) + 32'h00000001 + rD1_ex;//sub
                endcase
             end
             
            2'b01:
            begin
                case(alu_op_ex[3:2])
                    2'b00: alu_c = rD1_ex & alu_b_ex;//and
                    2'b01: alu_c = rD1_ex | alu_b_ex;//or
                    2'b10: alu_c = rD1_ex ^ alu_b_ex;//xor
                endcase
            end
            
            2'b10:  alu_c = alu_c1;//??¦Ë
                
            2'b11:
            begin
                alu_c = (32'hffffffff-alu_b_ex) + 32'h00000001 + rD1_ex;
                case(alu_op_ex[3:2])
                    2'b00: if(alu_c == 0) alu_branch = 1'b1;//beq
                           else alu_branch = 1'b0;
                    2'b01: if(alu_c == 0) alu_branch = 1'b0;//bne
                           else alu_branch = 1'b1;
                    2'b10: if(alu_c[31] == 0) alu_branch = 1'b1;//bge
                           else alu_branch = 1'b0;
                    2'b11: if(alu_c[31] == 1) alu_branch = 1'b1;//blt
                           else alu_branch = 1'b0;
                endcase
            end
        endcase
    end
    
    
endmodule


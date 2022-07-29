`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 12:00:55
// Design Name: 
// Module Name: EX
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


module EX(
    input [3:0] alu_op_ex,
    input [31:0] rD1_ex,
    input [31:0] alu_b_ex,
    output reg alu_branch,
    output reg [31:0] alu_c
    );
    
    
    ALU U_ALU(
        .rD1_ex(rD1_ex),
        .alu_b_ex(alu_b_ex),
        .alu_op_ex(alu_op_ex),
        .alu_branch(alu_branch),
        .alu_c(alu_c)
    );
    
endmodule

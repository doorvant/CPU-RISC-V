`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/03 09:57:43
// Design Name: 
// Module Name: execute
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


module execute(
    input alu_sel,
    input [3:0] alu_op,
    input [31:0] rD1,
    input [31:0] rD2,
    input [31:0] sext,
    output reg alu_branch,
    output reg [31:0] alu_c
    );
    
    reg [31:0] alu_b;
    
    ALU_MUX U_ALU_MUX(
        .rD2(rD2),
        .sext(sext),
        .alu_sel(alu_sel),
        .alu_b(alu_b)
    );
    
    ALU U_ALU(
        .rD1(rD1),
        .alu_b(alu_b),
        .alu_op(alu_op),
        .alu_branch(alu_branch),
        .alu_c(alu_c)
    );
    
endmodule









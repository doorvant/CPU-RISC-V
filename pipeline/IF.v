`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 11:25:45
// Design Name: 
// Module Name: IF
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


module IF(
    input clk,
    input rst_n,
    input stop,
    input jump_pc,
    input alu_branch,  
    input [1:0] pc_sel_ex, 
    input [31:0] sext_ex, 
    input [31:0] rD1_ex,
    output reg [31:0] pc
    );
    
    reg [31:0] npc;
    
    PC U_PC(
        .clk(clk),
        .rst_n(rst_n),
        .stop(stop),
        .jump_pc(jump_pc),
        .npc(npc),
        .pc(pc)
    ); 
    
    
    
    NPC U_NPC(
        .alu_branch(alu_branch),
        .pc_sel_ex(pc_sel_ex),
        .pc(pc),
        .sext_ex(sext_ex),
        .rD1_ex(rD1_ex),
        .npc(npc)
    );
    
endmodule

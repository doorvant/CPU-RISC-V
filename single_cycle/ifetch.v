`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/03 11:15:17
// Design Name: 
// Module Name: ifetch
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


module ifetch(
    input clk,
    input rst_n,
    input alu_branch,  
    input [1:0] pc_sel, 
    input [31:0] sext, 
    input [31:0] rD1,  
    output reg [31:0] pc
    );
    
    reg [31:0] npc;
    
    PC U_PC(
        .clk(clk),
        .rst_n(rst_n),
        .npc(npc),
        .pc(pc)
    ); 
    
    
    
    NPC U_NPC(
        .alu_branch(alu_branch),
        .pc_sel(pc_sel),
        .pc(pc),
        .sext(sext),
        .rD1(rD1),
        .npc(npc)
    );
    
endmodule





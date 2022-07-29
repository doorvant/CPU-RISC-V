`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/03 10:19:59
// Design Name: 
// Module Name: NPC
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


module NPC(
    input alu_branch,
    input [1:0] pc_sel,
    input [31:0] pc,
    input [31:0] sext,
    input [31:0] rD1,
    output reg [31:0] npc
    );
    
    
    always @(*) begin
        case(pc_sel)
            2'b00: //pc+4
                npc = pc + 32'h00000004;
            2'b01: //branch
                if(alu_branch)
                    npc = sext;
                else
                    npc = pc + 32'h00000004;
            2'b10: //jal
                npc = sext;
            2'b11: //jalr
                npc = (rD1+sext) & 32'hfffffffe;
        endcase
    end
    
endmodule










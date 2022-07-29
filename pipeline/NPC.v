`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 11:20:55
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
    input [1:0] pc_sel_ex,
    input [31:0] pc,
    input [31:0] sext_ex,
    input [31:0] rD1_ex,
    output reg [31:0] npc
    );
    
    
    always @(*) begin
        case(pc_sel_ex)
            2'b00: //pc+4
                npc = pc + 32'h00000004;
            2'b01: //branch
                if(alu_branch)
                    npc = sext_ex;
                else
                    npc = pc + 32'h00000004;
            2'b10: //jal
                npc = sext_ex;
            2'b11: //jalr
                npc = (rD1_ex+sext_ex) & 32'hfffffffe;
        endcase
    end
    
endmodule

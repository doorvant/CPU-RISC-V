`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/03 11:10:33
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input rst_n,
    input [31:0] npc,
    output reg [31:0] pc
    );
    
    always @(posedge clk or negedge rst_n) begin
        if(rst_n == 1'b0)
            pc <= 32'hfffffffc;
        else
            pc <= npc;
    end
    
    
endmodule

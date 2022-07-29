`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 10:09:16
// Design Name: 
// Module Name: ALU_MUX
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


module ALU_MUX(
    input [31:0] rD2,
    input [31:0] sext,
    input alu_sel,
    output reg [31:0] alu_b
    );
    
    always @(*) begin
        case(alu_sel)
            1'b0: alu_b = rD2;
            1'b1: alu_b = sext;
        endcase
    end
    
endmodule

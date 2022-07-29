`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 17:27:49
// Design Name: 
// Module Name: ID_MUX
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


module ID_MUX(
    input [31:0] sext,
    input [31:0] alu_c,
    input [31:0] pc,
    input [31:0] dram_rd,
    input [1:0] wd_sel,
    output reg [31:0] wD     
    );
    
    always @(*) begin
        case(wd_sel) 
            2'b00: wD = sext;
            2'b01: wD = alu_c;
            2'b10: wD = pc + 32'h00000004;
            2'b11: wD = dram_rd;
        endcase
    end
endmodule










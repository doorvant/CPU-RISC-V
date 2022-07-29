`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 22:21:11
// Design Name: 
// Module Name: dmem
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


module dmem(
    input clk,
    input dram_we,
    input [31:0] alu_c,
    input [31:0] rD2,
    output reg [31:0] dram_rd
    );
    
    data_mem u_dram(
        .clk(clk),
        .we(dram_we),
        .a(alu_c[13:0]),
        .d(rD2),
        .qspo(dram_rd)
    );
    
    
endmodule

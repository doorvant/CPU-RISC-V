`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 22:35:48
// Design Name: 
// Module Name: cpu_clk
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


module cpu_clk(
    input clk_i,
    output reg clk
    );
    
    cpuclk u_cpuclk(
        .clk_i(clk_i),
        .clk(clk)
    );
    
endmodule

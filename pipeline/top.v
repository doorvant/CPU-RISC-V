`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/14 11:14:28
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst_n,
    output debug_wb_have_inst,
    output [31:0]debug_wb_pc,
    output debug_wb_ena,
    output [4:0] debug_wb_reg,
    output [31:0] debug_wb_value
    );
    
    reg [31:0] pc;
    reg [31:0] inst_data;
    reg dram_we_mem;      
    reg [31:0] alu_c_mem;  
    reg [31:0] rD2_mem;    
    reg [31:0] dram_rd; 
    
    miniRV u_miniRV(
        .clk(clk),
        .rst_n(rst_n),
        .inst_data(inst_data),
        .dram_rd(dram_rd),
        .pc(pc),
        .dram_we_mem(dram_we_mem),
        .alu_c_mem(alu_c_mem),
        .rD2_mem(rD2_mem),
        .debug_wb_have_inst(debug_wb_have_inst),
        .debug_wb_pc(debug_wb_pc),
        .debug_wb_ena(debug_wb_ena),
        .debug_wb_reg(debug_wb_reg),
        .debug_wb_value(debug_wb_value)
    );
    
    inst_mem u_program(
//    prgrom u_program(
        .a(pc[15:2]),
        .spo(inst_data)
    );
    
    data_mem u_dram(
 //   dram u_dram(
        .clk(clk),
        .we(dram_we_mem),
        .a(alu_c_mem[15:2]),
        .d(rD2_mem),
        .spo(dram_rd)
    );
    
endmodule















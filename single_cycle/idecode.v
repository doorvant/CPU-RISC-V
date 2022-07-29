`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 21:09:47
// Design Name: 
// Module Name: idecode
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


module idecode(
    input clk,   
    input rst_n,                   
    input rf_we,                    //RF写信号，0读1写
    input [1:0] wd_sel,             //写入数选择信号
    input [2:0] sext_op,            //立即数操作信号
    input [4:0] rR1,                //寄存器1
    input [4:0] rR2,                //寄存器2
    input [4:0] wR,                 //目的寄存器
    input [31:0] inst_imm,          //指令立即数部分
    input [31:0] alu_c,             //ALU计算结果
    input [31:0] pc,           
    input [31:0] dram_rd,           //数据存储器读出数据
    output reg [31:0] wD,           //写入RF的数据
    output reg [31:0] rD1,          //寄存器1数据
    output reg [31:0] rD2,          //寄存器2数据
    output reg [31:0] sext          //立即数扩展结果
    );
    
    IMM U_IMM(
        .inst_imm(inst_imm),
        .sext_op(sext_op),
        .pc(pc),
        .sext(sext)
    );
    
    ID_MUX U_ID_MUX(
        .sext(sext),
        .alu_c(alu_c),
        .pc(pc),
        .dram_rd(dram_rd),
        .wd_sel(wd_sel),
        .wD(wD)
    );
    
    RF U_RF(
        .clk(clk),
        .rst_n(rst_n),
        .rR1(rR1),
        .rR2(rR2),
        .wR(wR),
        .rf_we(rf_we),
        .wD(wD),
        .rD1(rD1),
        .rD2(rD2)
    );
endmodule






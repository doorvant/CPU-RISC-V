`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 11:43:25
// Design Name: 
// Module Name: ID_and_WB
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


module ID_and_WB(
    input clk,   
    input rst_n,                   
    input rf_we_wb, 
    input alu_sel,                   //RF��????0??1��
    input [1:0] wd_sel_wb,             //��??????????
    input [2:0] sext_op,            //?????????????
    input [4:0] rR1,                //?????1
    input [4:0] rR2,                //?????2
    input [4:0] wR_wb,                 //???????
    input [31:0] inst_imm,          //?????????????
    input [31:0] alu_c_wb,             //ALU??????
    input [31:0] pc_id,  
    input [31:0] pc_wb,         
    input [31:0] dram_rd_wb,
    input [31:0] sext_wb,           //????��??????????
    output reg [31:0] wD,           //��??RF??????
    output reg [31:0] rD1,          //?????1????
    output reg [31:0] rD2,          //?????2????
    output reg [31:0] sext, 
    output reg [31:0] alu_b         //????????????
    );
    
    IMM U_IMM(
        .inst_imm(inst_imm),
        .sext_op(sext_op),
        .pc_id(pc_id),
        .sext(sext)
    );
    
    WB_MUX U_WB_MUX(
        .sext_wb(sext_wb),
        .alu_c_wb(alu_c_wb),
        .pc_wb(pc_wb),
        .dram_rd_wb(dram_rd_wb),
        .wd_sel_wb(wd_sel_wb),
        .wD(wD)
    );
    
    ALU_MUX U_ALU_MUX(
        .rD2(rD2),
        .sext(sext),
        .alu_sel(alu_sel),
        .alu_b(alu_b)
    );
    
    RF U_RF(
        .clk(clk),
        .rst_n(rst_n),
        .rR1(rR1),
        .rR2(rR2),
        .wR_wb(wR_wb),
        .rf_we_wb(rf_we_wb),
        .wD(wD),
        .rD1(rD1),
        .rD2(rD2)
    );
endmodule


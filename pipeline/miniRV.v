`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 12:05:59
// Design Name: 
// Module Name: miniRV
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


module miniRV(
    input clk,
    input rst_n,
    input [31:0] inst_data,
    input [31:0] dram_rd,
    output reg [31:0] pc,
    output reg dram_we_mem,
    output reg [31:0] alu_c_mem,
    output reg [31:0] rD2_mem,
    output wire debug_wb_have_inst,
    output wire [31:0]debug_wb_pc,
    output wire debug_wb_ena,
    output wire [4:0] debug_wb_reg,
    output wire [31:0] debug_wb_value   
    );
    
    reg stop;
    reg jump_pc;
    reg jump_id;
    
    reg [2:0] funct3;
    reg [6:0] funct7;
    reg [6:0] opcode;
    reg rf_we;
    reg dram_we;
    reg alu_sel;
    reg [1:0] pc_sel;
    reg [1:0] wd_sel;
    reg [2:0] sext_op;
    reg [3:0] alu_op;
    
    reg alu_branch;
    reg [1:0] pc_sel_ex;
    reg [31:0] sext_ex;
    reg [31:0] rD1_ex;
    reg [31:0] pc_ex;
    
    reg rf_we_wb;
    reg [1:0] wd_sel_wb;
    reg [4:0] rR1;
    reg [4:0] rR2;
    reg [4:0] wR_wb;
    reg [31:0] inst_imm;
    reg [31:0] alu_c_wb;
    reg [31:0] pc_id;
    reg [31:0] pc_wb;
    reg [31:0] dram_rd_wb;
    reg [31:0] sext_wb;
    reg [31:0] wD;
    reg [31:0] rD1;
    reg [31:0] rD2;
    reg [31:0] sext;
    reg [31:0] alu_b;
    
    reg [3:0] alu_op_ex;
    reg [31:0] alu_b_ex;
    reg [31:0] alu_c;
    
    reg [4:0] wR;
    
    reg rf_we_ex;
    reg dram_we_ex;
    reg alu_sel_ex;
    reg [1:0] wd_sel_ex;
    reg [4:0] wR_ex;
    reg [31:0] rD2_ex;
    
    reg rf_we_mem;
    reg [1:0] wd_sel_mem;
    reg [4:0] wR_mem;
    reg [31:0] sext_mem;
    reg [31:0] pc_mem;
    
    reg valid;
    reg valid_ex;
    reg valid_mem;
    reg valid_wb;
    
    control u_control(
        .funct3(funct3),
        .funct7(funct7),
        .opcode(opcode),
        .rf_we(rf_we),
        .dram_we(dram_we),
        .alu_sel(alu_sel),
        .pc_sel(pc_sel),
        .wd_sel(wd_sel),
        .sext_op(sext_op),
        .alu_op(alu_op)
    );
    
    IF U_IF(
        .clk(clk),
        .rst_n(rst_n),
        .stop(stop),
        .jump_pc(jump_pc),
        .alu_branch(alu_branch),
        .pc_sel_ex(pc_sel_ex),
        .sext_ex(sext_ex),
        .rD1_ex(rD1_ex),
        .pc(pc)
    );
    
    ID_and_WB U_ID_and_WB(
        .clk(clk),
        .rst_n(rst_n),
        .rf_we_wb(rf_we_wb),
        .alu_sel(alu_sel),
        .wd_sel_wb(wd_sel_wb),
        .sext_op(sext_op),
        .rR1(rR1),
        .rR2(rR2),
        .wR_wb(wR_wb),
        .inst_imm(inst_imm),
        .alu_c_wb(alu_c_wb),
        .pc_id(pc_id),
        .pc_wb(pc_wb),
        .dram_rd_wb(dram_rd_wb),
        .sext_wb(sext_wb),
        .wD(wD),
        .rD1(rD1),
        .rD2(rD2),
        .sext(sext),
        .alu_b(alu_b)
    );
    
    EX U_EX(
        .alu_op_ex(alu_op_ex),
        .rD1_ex(rD1_ex),
        .alu_b_ex(alu_b_ex),
        .alu_branch(alu_branch),
        .alu_c(alu_c)
    );
    
    IF_ID_reg U_IF_ID_reg(
        .clk(clk),
        .rst_n(rst_n),
        .jump_id(jump_id),
        .stop(stop),
        .pc(pc),
        .inst_data(inst_data),
        .funct3(funct3),
        .rR1(rR1),
        .rR2(rR2),
        .wR(wR),
        .funct7(funct7),
        .opcode(opcode),
        .inst_imm(inst_imm),
        .pc_id(pc_id),
        .valid(valid)
    );
    
    ID_EX_reg U_ID_EX_reg(
        .clk(clk),
        .rst_n(rst_n),
        .stop(stop),
        .rf_we(rf_we),
        .dram_we(dram_we),
        .pc_sel(pc_sel),
        .wd_sel(wd_sel),
        .alu_op(alu_op),
        .wR(wR),
        .pc_id(pc_id),
        .sext(sext),
        .rD1(rD1),
        .rD2(rD2),
        .alu_b(alu_b),
        .rf_we_ex(rf_we_ex),
        .dram_we_ex(dram_we_ex),
        .alu_sel_ex(alu_sel_ex),
        .pc_sel_ex(pc_sel_ex),
        .wd_sel_ex(wd_sel_ex),
        .alu_op_ex(alu_op_ex),
        .wR_ex(wR_ex),
        .pc_ex(pc_ex),
        .sext_ex(sext_ex),
        .rD1_ex(rD1_ex),
        .rD2_ex(rD2_ex),
        .alu_b_ex(alu_b_ex),
        .valid(valid),
        .valid_ex(valid_ex)
    );
    
    EX_MEM_reg U_EX_MEM_reg(
        .clk(clk),
        .rst_n(rst_n),
        .rf_we_ex(rf_we_ex),
        .dram_we_ex(dram_we_ex),
        .wd_sel_ex(wd_sel_ex),
        .wR_ex(wR_ex),
        .sext_ex(sext_ex),
        .pc_ex(pc_ex),
        .alu_c(alu_c),
        .rD2_ex(rD2_ex),
        .rf_we_mem(rf_we_mem),
        .dram_we_mem(dram_we_mem),
        .wd_sel_mem(wd_sel_mem),
        .wR_mem(wR_mem),
        .sext_mem(sext_mem),
        .pc_mem(pc_mem),
        .alu_c_mem(alu_c_mem),
        .rD2_mem(rD2_mem),
        .valid_ex(valid_ex),
        .valid_mem(valid_mem)
    ); 
    
    MEM_WB_reg U_MEM_WB_reg(
        .clk(clk),
        .rst_n(rst_n),
        .rf_we_mem(rf_we_mem),
        .wd_sel_mem(wd_sel_mem),
        .wR_mem(wR_mem),
        .sext_mem(sext_mem),
        .alu_c_mem(alu_c_mem),
        .pc_mem(pc_mem),
        .dram_rd(dram_rd),
        .rf_we_wb(rf_we_wb),
        .wd_sel_wb(wd_sel_wb),
        .wR_wb(wR_wb),
        .sext_wb(sext_wb),
        .alu_c_wb(alu_c_wb),
        .pc_wb(pc_wb),
        .dram_rd_wb(dram_rd_wb),
        .valid_mem(valid_mem),
        .valid_wb(valid_wb)
    );
    
    hazard_test u_hazard_test(
        .clk(clk),
        .alu_sel(alu_sel),
        .alu_branch(alu_branch),
        .rR1(rR1),
        .rR2(rR2),
        .wR_ex(wR_ex),
        .wR_mem(wR_mem),
        .wR_wb(wR_wb),
        .inst_data(inst_data),
        .stop(stop),
        .jump_id(jump_id),
        .jump_pc(jump_pc),
        .pc(pc),
        .dram_we(dram_we)
    );
    
    assign debug_wb_have_inst = valid_wb;
    assign debug_wb_pc = pc_wb;
    assign debug_wb_ena = rf_we_wb;
    assign debug_wb_reg = wR_wb;
    assign debug_wb_value = wD;
    
endmodule









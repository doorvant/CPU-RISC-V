`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 11:31:08
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
    //input clk_i,
    input clk,
    input rst_n,
    input [31:0] inst_data,
    input [31:0] dram_rd,
    output reg [31:0] pc,
    output reg dram_we,
    output reg [31:0] alu_c,
    output reg [31:0] rD2,
    output reg debug_wb_have_inst,
    output reg [31:0]debug_wb_pc,
    output reg debug_wb_ena,
    output reg [4:0] debug_wb_reg,
    output reg [31:0] debug_wb_value
    );
    
    //reg clk;
    reg [2:0] funct3;
    reg [6:0] funct7;  
    reg [6:0] opcode;  
    reg rf_we;
    //reg dram_we;
    reg alu_sel;
    reg [1:0] pc_sel;
    reg [1:0] wd_sel;
    reg [2:0] sext_op;
    reg [3:0] alu_op; 
    //reg [31:0] pc;
    reg [4:0] rR1;
    reg [4:0] rR2;
    reg [4:0] wR;
    reg [31:0] inst_imm; 
    //reg [31:0] alu_c;
    //reg [31:0] rD2;
    //reg [31:0] dram_rd;
    reg alu_branch;
    reg [31:0] sext;
    reg [31:0] rD1;
    reg [31:0] wD;
    
//    cpu_clk u_cpu_clk(
//        .clk_i(clk_i),
//        .clk(clk)
//    );
    
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
    
    prgrom u_prgrom(
        //.pc(pc),
        .inst_data(inst_data),
        .funct3(funct3), 
        .rR1(rR1),     
        .rR2(rR2),     
        .wR(wR),      
        .funct7(funct7),  
        .opcode(opcode),  
        .inst_imm(inst_imm)
    );
    
//    dmem u_dmem(
//        .clk(clk),
//        .dram_we(dram_we),
//        .alu_c(alu_c),
//        .rD2(rD2),
//        .dram_rd(dram_rd)
//    );
    
    ifetch u_ifetch(
        .clk(clk),           
        .rst_n(rst_n),         
        .alu_branch(alu_branch),    
        .pc_sel(pc_sel),  
        .sext(sext),   
        .rD1(rD1),    
        .pc(pc) 
    );
    
    execute u_execute(
        .alu_sel(alu_sel),
        .alu_op(alu_op),
        .rD1(rD1),
        .rD2(rD2),
        .sext(sext),
        .alu_branch(alu_branch),
        .alu_c(alu_c)
    );
    
    idecode u_idecode(
        .clk(clk),
        .rst_n(rst_n),
        .rf_we(rf_we),
        .wd_sel(wd_sel),
        .sext_op(sext_op),
        .rR1(rR1),
        .rR2(rR2),
        .wR(wR),
        .inst_imm(inst_imm),
        .alu_c(alu_c),
        .pc(pc),
        .dram_rd(dram_rd),
        .wD(wD),
        .rD1(rD1),
        .rD2(rD2),
        .sext(sext)
    );
    
    always @(*) begin
        debug_wb_have_inst = 1'b1;
        debug_wb_pc = pc;
        debug_wb_ena = rf_we;
        debug_wb_reg = wR;
        debug_wb_value = wD;
    end
    
endmodule



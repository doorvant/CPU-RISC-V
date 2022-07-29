`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 10:50:16
// Design Name: 
// Module Name: MEM_WB_reg
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


module MEM_WB_reg(
    input clk,
    input rst_n,
    input rf_we_mem,
    input [1:0] wd_sel_mem,
    input [4:0] wR_mem,
    input [31:0] sext_mem,
    input [31:0] alu_c_mem,
    input [31:0] pc_mem,
    input [31:0] dram_rd,
    input valid_mem,
    output reg rf_we_wb,
    output reg [1:0] wd_sel_wb,
    output reg [4:0] wR_wb,
    output reg [31:0] sext_wb,
    output reg [31:0] alu_c_wb,
    output reg [31:0] pc_wb,
    output reg [31:0] dram_rd_wb,
    output reg valid_wb
    );
    
    always @ (posedge clk or negedge rst_n) begin    
        if(~rst_n) rf_we_wb <= 1'b0;    
        else       rf_we_wb <= rf_we_mem;    
    end      
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) wd_sel_wb <= 2'b00;
        else       wd_sel_wb <= wd_sel_mem;
    end      
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) wR_wb <= 5'b00000;
        else       wR_wb <= wR_mem;
    end      
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) sext_wb <= 32'h00000000;
        else       sext_wb <= sext_mem;
    end      
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) alu_c_wb <= 32'h00000000;
        else       alu_c_wb <= alu_c_mem;
    end      
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) pc_wb <= 32'h0;
        else       pc_wb <= pc_mem;
    end      
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) dram_rd_wb <= 32'h00000000;
        else       dram_rd_wb <= dram_rd;
    end      
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)  valid_wb <= 1'b0;
        else       valid_wb <= valid_mem;
    end
    
endmodule

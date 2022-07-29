`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 10:14:06
// Design Name: 
// Module Name: EX_MEM_reg
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


module EX_MEM_reg(
    input clk,
    input rst_n,
    input rf_we_ex,
    input dram_we_ex,
    input valid_ex,
    input [1:0] wd_sel_ex,
    input [4:0] wR_ex,
    input [31:0] sext_ex,
    input [31:0] pc_ex,
    input [31:0] alu_c,
    input [31:0] rD2_ex,
    output reg rf_we_mem,
    output reg dram_we_mem,
    output reg [1:0] wd_sel_mem,
    output reg valid_mem,
    output reg [4:0] wR_mem,
    output reg [31:0] sext_mem,
    output reg [31:0] pc_mem,
    output reg [31:0] alu_c_mem,
    output reg [31:0] rD2_mem
    );
    
    always @ (posedge clk or negedge rst_n) begin    
        if(~rst_n) rf_we_mem <= 1'b0;    
        else       rf_we_mem <= rf_we_ex;    
    end      
    
    always @ (posedge clk or negedge rst_n) begin    
        if(~rst_n) wR_mem <= 5'b00000;    
        else       wR_mem <= wR_ex;    
    end      
    
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) dram_we_mem <= 1'b0;
        else       dram_we_mem <= dram_we_ex;
    end
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) wd_sel_mem <= 2'b00;
        else       wd_sel_mem <= wd_sel_ex;
    end    
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) sext_mem <= 32'h00000000;
        else       sext_mem <= sext_ex;
    end   
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) pc_mem <= 32'h0;
        else       pc_mem <= pc_ex;
    end     
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) alu_c_mem <= 32'h00000000;
        else       alu_c_mem <= alu_c;
    end   
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) rD2_mem <= 32'h00000000;
        else       rD2_mem <= rD2_ex;
    end     
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) valid_mem <= 1'b0;
        else      valid_mem <= valid_ex;
    end
    
endmodule






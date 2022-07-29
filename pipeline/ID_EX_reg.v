`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 09:32:39
// Design Name: 
// Module Name: ID_EX_reg
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


module ID_EX_reg(
    input clk,
    input rst_n,
    input stop,
    input rf_we,
    input dram_we,
    input valid,
    input [1:0] pc_sel,
    input [1:0] wd_sel,
    input [3:0] alu_op,
    input [4:0] wR,
    input [31:0] pc_id,
    input [31:0] sext,
    input [31:0] rD1,
    input [31:0] rD2,
    input [31:0] alu_b,
    output reg rf_we_ex,
    output reg dram_we_ex,
    output reg alu_sel_ex,       
    output reg [1:0] pc_sel_ex,  
    output reg [1:0] wd_sel_ex,  
    output reg [3:0] alu_op_ex,
    output reg [4:0] wR_ex,  
    output reg [31:0] pc_ex,
    output reg [31:0] sext_ex,
    output reg [31:0] rD1_ex,
    output reg [31:0] rD2_ex,
    output reg [31:0] alu_b_ex, 
    output reg valid_ex
    );
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)              wR_ex <= 5'b00000;
        else if(stop)          wR_ex <= 5'b00000;
        else                   wR_ex <= wR;
    end     
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n | stop) rf_we_ex <= 1'b0;
        else       rf_we_ex <= rf_we;
    end   
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n | stop) dram_we_ex <= 1'b0;
        else       dram_we_ex <= dram_we;
    end
    
    always @ (posedge clk or negedge rst_n) begin 
        if(~rst_n | stop) pc_sel_ex <= 2'b00;             
        else       pc_sel_ex <= pc_sel;          
    end                                           
    
    always @ (posedge clk or negedge rst_n) begin 
        if(~rst_n | stop) wd_sel_ex <= 2'b00;             
        else       wd_sel_ex <= wd_sel;          
    end          
                                                                        
    
    always @ (posedge clk or negedge rst_n) begin 
        if(~rst_n | stop) alu_op_ex <= 4'b0000;             
        else       alu_op_ex <= alu_op;          
    end                                           
    
    always @ (posedge clk or negedge rst_n) begin 
        if(~rst_n) pc_ex <= 32'h0;             
        else       pc_ex <= pc_id;          
    end                                           
    
    always @ (posedge clk or negedge rst_n) begin 
        if(~rst_n | stop) sext_ex <= 32'h00000000;             
        else       sext_ex <= sext;          
    end                                           
    
    always @ (posedge clk or negedge rst_n) begin 
        if(~rst_n | stop) rD1_ex <= 32'h00000000;             
        else       rD1_ex <= rD1;          
    end                                           
    
    always @ (posedge clk or negedge rst_n) begin 
        if(~rst_n | stop) rD2_ex <= 32'h00000000;             
        else       rD2_ex <= rD2;          
    end                                           
    
    always @ (posedge clk or negedge rst_n) begin 
        if(~rst_n | stop) alu_b_ex <= 32'h00000000;             
        else       alu_b_ex <= alu_b;          
    end                                           
        
    always @ (posedge clk or negedge rst_n) begin 
        if(~rst_n) alu_b_ex <= 32'h00000000;             
        else       alu_b_ex <= alu_b;          
    end      
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) valid_ex <= 1'b0;
        else if(stop) valid_ex <= 1'b0;
        else valid_ex <= valid;
    end
        
endmodule















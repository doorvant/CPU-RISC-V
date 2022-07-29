`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 09:09:01
// Design Name: 
// Module Name: IF_ID_reg
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


module IF_ID_reg(
    input clk,
    input rst_n,
    input jump_id,
    input stop,
    input [31:0] pc,
    input [31:0] inst_data,
    output reg [2:0] funct3,
    output reg [4:0] rR1,
    output reg [4:0] rR2,
    output reg [4:0] wR,
    output reg [6:0] funct7,
    output reg [6:0] opcode,
    output reg [31:0] inst_imm,
    output reg [31:0] pc_id,
    output reg valid
    );
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)                  rR1 <= 5'b00000;
        else if(stop)               rR1 <= rR1;
        else if(jump_id)            rR1 <= 5'b00000;
        else                        rR1 <= inst_data[19:15];
    end
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)                  rR2 <= 5'b00000;
        else if(stop)               rR2 <= rR2;
        else if(jump_id)            rR2 <= 5'b00000;
        else                        rR2 <= inst_data[24:20];
    end    
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)              wR <= 5'b00000;
        else if(stop)           wR <= wR;
        else if(jump_id)        wR <= 5'b00000;
        else                    wR <= inst_data[11:7];
    end    
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)     inst_imm <= 32'h00000000;
        else if(stop)            inst_imm <= inst_imm;
        else if(jump_id)         inst_imm <= 32'h00000000;
        else                     inst_imm <= inst_data;
    end
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)          funct3 <= 3'b000;
        else if(stop)       funct3 <= funct3;
        else if(jump_id)    funct3 <= 3'b000;
        else                funct3 <= inst_data[14:12];
    end
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)          funct7 <= 7'b0000000;
        else if(stop)       funct7 <= funct7;
        else if(jump_id)    funct7 <= 7'b0000000;
        else                funct7 <= inst_data[31:25];
    end

    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)          opcode <= 7'b0000000;
        else if(stop)       opcode <= opcode; 
        else if(jump_id)    opcode <= 7'b0000000;
        else                opcode <= inst_data[6:0];
    end
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)         pc_id <= 32'h0;
        else if(stop)       pc_id<= pc_id;
        else if(jump_id)    pc_id <= 32'h0;
        else                pc_id <= pc;
    end    
    
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n)          valid <= 1'b0;
        else if(stop)      valid <= 1'b1;
        else if(jump_id)   valid <= 1'b0;
        else                valid <= 1'b1;
    end    
    
endmodule

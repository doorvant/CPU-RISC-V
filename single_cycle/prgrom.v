`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/03 11:33:15
// Design Name: 
// Module Name: prgrom
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


module prgrom(
    //input [31:0] pc,
    input [31:0] inst_data,
    output reg [2:0] funct3,
    output reg [4:0] rR1,
    output reg [4:0] rR2,
    output reg [4:0] wR,
    output reg [6:0] funct7,
    output reg [6:0] opcode,
    output reg [31:0] inst_imm
    );
    
    //reg [31:0] inst_data;
    
//    inst_mem u_program(
//        .a(pc[15:2]),
//        .spo(inst_data)
//    );
    
    always @(inst_data) begin
        rR1 = inst_data[19:15];  
    end
    
    always @(inst_data) begin
        rR2 = inst_data[24:20];
    end
    
    always @(inst_data) begin
        wR = inst_data[11:7];  
    end    
    
    always @(inst_data) begin
        inst_imm = inst_data;  
    end        
 
     always @(inst_data) begin
        funct3 = inst_data[14:12];  
    end      
    
     always @(inst_data) begin
        funct7 = inst_data[31:25]; 
    end          
    
     always @(inst_data) begin
        opcode = inst_data[6:0]; 
    end       
    
endmodule






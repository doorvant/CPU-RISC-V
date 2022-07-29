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
    input rf_we,                    //RFд�źţ�0��1д
    input [1:0] wd_sel,             //д����ѡ���ź�
    input [2:0] sext_op,            //�����������ź�
    input [4:0] rR1,                //�Ĵ���1
    input [4:0] rR2,                //�Ĵ���2
    input [4:0] wR,                 //Ŀ�ļĴ���
    input [31:0] inst_imm,          //ָ������������
    input [31:0] alu_c,             //ALU������
    input [31:0] pc,           
    input [31:0] dram_rd,           //���ݴ洢����������
    output reg [31:0] wD,           //д��RF������
    output reg [31:0] rD1,          //�Ĵ���1����
    output reg [31:0] rD2,          //�Ĵ���2����
    output reg [31:0] sext          //��������չ���
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






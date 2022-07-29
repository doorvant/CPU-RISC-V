`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/14 14:40:52
// Design Name: 
// Module Name: hazard_test
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


module hazard_test(
    input clk,
    input alu_sel,
    input alu_branch,
    input [4:0] rR1,
    input [4:0] rR2,
    input [4:0] wR_ex,
    input [4:0] wR_mem,
    input [4:0] wR_wb,
    input [31:0] inst_data,
    input [31:0] pc,
    input dram_we,
    output stop,   
    output jump_id,
    output jump_pc 
);
    reg [2:0] cnt = 3'b000;
    reg j_reg = 1'b0;
    reg pc_reg = 1'b0;

    
    wire hazard_a1 = (rR1!=0) & (wR_ex!=0) & (rR1 == wR_ex);
    wire hazard_a2 =(~alu_sel | dram_we) & (rR2!=0) & (wR_ex!=0) & (rR2 == wR_ex);
    wire hazard_b1 = (rR1!=0) & (wR_mem!=0) & (rR1 == wR_mem);
    wire hazard_b2 =(~alu_sel | dram_we) & (rR2!=0) & (wR_mem!=0) & (rR2 == wR_mem);
    wire hazard_c1 = (rR1!=0) & (wR_wb!=0) & (rR1 == wR_wb);
    wire hazard_c2 =(~alu_sel | dram_we) & (rR2!=0) & (wR_wb!=0) & (rR2 == wR_wb);
    
  
   wire con_hazard = (inst_data[6:0] == 7'b1100111) | (inst_data[6:0] == 7'b1100011) | (inst_data[6:0] == 7'b1101111);//1100011

   
   always @ (posedge clk) begin
       if(stop) begin
            cnt <= cnt;
            j_reg <= j_reg;
            pc_reg <= pc_reg;
       end 
       else if(con_hazard & (cnt==3'b000)) begin
            cnt <= 3'b100;
            j_reg <= 1'b1;
            pc_reg <= 1'b1;
        end
        else if(cnt == 3'b100) begin
            cnt <= cnt - 3'b001;
            pc_reg <= 1'b0;
        end
        else if(cnt == 3'b011) begin
            cnt <= cnt - 3'b001;
            j_reg <= 1'b0;
        end
        else if(cnt > 3'b000) begin
            if(con_hazard & (pc != 32'b0)) begin
                cnt <= 3'b100;
                j_reg <= 1'b1;
                pc_reg <= 1'b1;
            end
            else
                cnt <= cnt - 3'b001;
        end       
        else
            cnt <= cnt;  
   end
   
    assign jump_id = j_reg;
    assign jump_pc = pc_reg;
    assign stop = hazard_a1 | hazard_a2 | hazard_b1 | hazard_b2 | hazard_c1 | hazard_c2; 
endmodule















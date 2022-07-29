`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 11:34:53
// Design Name: 
// Module Name: WB_MUX
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


module WB_MUX(
    input [31:0] sext_wb,
    input [31:0] alu_c_wb,
    input [31:0] pc_wb,
    input [31:0] dram_rd_wb,
    input [1:0] wd_sel_wb,
    output reg [31:0] wD     
    );
    
    always @(*) begin
        case(wd_sel_wb) 
            2'b00: wD = sext_wb;
            2'b01: wD = alu_c_wb;
            2'b10: wD = pc_wb + 32'h00000004;
            2'b11: wD = dram_rd_wb;
        endcase
    end
endmodule

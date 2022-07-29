`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 11:29:52
// Design Name: 
// Module Name: IMM
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


module IMM(
    input [2:0] sext_op,
    input [31:0] inst_imm,         
    input [31:0] pc_id,
    output reg [31:0] sext
    );
    
    always @(*) begin
        case(sext_op)
            3'b000: begin       //R??????I?????,??¦Ë?????????¦Ë??????????????
                        if(inst_imm[31] == 1'b1)
                            sext[31:0] = {20'hfffff,inst_imm[31:20]};
                        else
                            sext[31:0] = {20'h00000,inst_imm[31:20]};
                    end
            3'b001: begin       //S?????
                        if(inst_imm[31] == 1'b1)
                            sext[31:0] = {20'hfffff,inst_imm[31:25],inst_imm[11:7]};
                        else 
                            sext[31:0] = {20'h00000,inst_imm[31:25],inst_imm[11:7]};
                    end
            3'b010: begin       //B?????
                        if(inst_imm[31] == 1'b1)
                            sext[31:0] = pc_id + {16'hffff,3'b111,inst_imm[31],inst_imm[7],inst_imm[30:25],inst_imm[11:8],1'b0};
                        else
                            sext[31:0] = pc_id + {16'h0000,3'b000,inst_imm[31],inst_imm[7],inst_imm[30:25],inst_imm[11:8],1'b0};
                    end
            3'b011: begin       //jal
                        if(inst_imm[31] == 1'b1)
                            sext[31:0] = pc_id + {16'hffff,3'b111,inst_imm[31],inst_imm[19:12],inst_imm[20],inst_imm[30:21],1'b0};
                        else 
                            sext[31:0] = pc_id + {16'h0000,3'b000,inst_imm[31],inst_imm[19:12],inst_imm[20],inst_imm[30:21],1'b0};
                    end
            3'b100: begin       //lui
                        sext[31:0] = {inst_imm[31:12],12'h000};
                    end
        endcase
    end
endmodule


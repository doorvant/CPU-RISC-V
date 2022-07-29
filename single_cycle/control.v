`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 22:00:04
// Design Name: 
// Module Name: control
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


module control(
    input [2:0] funct3,
    input [6:0] funct7,  
    input [6:0] opcode,  
    output reg rf_we,
    output reg dram_we,
    output reg alu_sel,
    output reg [1:0] pc_sel,
    output reg [1:0] wd_sel,
    output reg [2:0] sext_op,
    output reg [3:0] alu_op
    );
    
    always @(*) begin //rf_we
        case(opcode)
            7'b0110011:  //R
                rf_we = 1'b1;
            7'b0010011: //I
                rf_we = 1'b1;
            7'b0000011: //lw
                rf_we = 1'b1;
            7'b1100111: //jalr
                rf_we = 1'b1;
            7'b0100011: //sw
                rf_we = 1'b0;
            7'b1100011: //B
                rf_we = 1'b0;
            7'b0110111: //lui
                rf_we = 1'b1;
            7'b1101111: //jal
                rf_we = 1'b1;
        endcase
    end
    
    always @(*) begin //dram_we
        case(opcode)
            7'b0110011:  //R
                dram_we = 1'b0;
            7'b0010011: //I
                dram_we = 1'b0;
            7'b0000011: //lw
                dram_we = 1'b0;
            7'b1100111: //jalr
                dram_we = 1'b0;
            7'b0100011: //sw
                dram_we = 1'b1;
            7'b1100011: //B
                dram_we = 1'b0;
            7'b0110111: //lui
                dram_we = 1'b0;
            7'b1101111: //jal
                dram_we = 1'b0;
        endcase
    end
    
    always @(*) begin //alu_sel
        case(opcode)
            7'b0110011:  //R
                alu_sel = 1'b0;
            7'b0010011: //I
                alu_sel = 1'b1;
            7'b0000011: //lw
                alu_sel = 1'b1;
            7'b1100111: //jalr
                alu_sel = 1'b1; //X
            7'b0100011: //sw
                alu_sel = 1'b1;
            7'b1100011: //B
                alu_sel = 1'b0;
            7'b0110111: //lui
                alu_sel = 1'b1; //X
            7'b1101111: //jal
                alu_sel = 1'b1; //X
        endcase
    end
    
    always @(*) begin //pc_sel
        case(opcode)
            7'b0110011:  //R
                pc_sel = 2'b00;
            7'b0010011: //I
                pc_sel = 2'b00;
            7'b0000011: //lw
                pc_sel = 2'b00;
            7'b1100111: //jalr
                pc_sel = 2'b11;
            7'b0100011: //sw
                pc_sel = 2'b00;
            7'b1100011: //B
                pc_sel = 2'b01;
            7'b0110111: //lui
                pc_sel = 2'b00;
            7'b1101111: //jal
                pc_sel = 2'b10;
            default: 
                pc_sel = 2'b00;
        endcase
    end
    
    always @(*) begin //wd_sel
        case(opcode)
            7'b0110011:  //R
                wd_sel = 2'b01;
            7'b0010011: //I
                wd_sel = 2'b01;
            7'b0000011: //lw
                wd_sel = 2'b11;
            7'b1100111: //jalr
                wd_sel = 2'b10;
            7'b0100011: //sw
                wd_sel =2'b01; //X
            7'b1100011: //B
                wd_sel = 2'b01; //X
            7'b0110111: //lui
                wd_sel = 2'b00;
            7'b1101111: //jal
                wd_sel = 2'b10;
        endcase
    end
    
    always @(*) begin //sext_op
        case(opcode)
            7'b0110011:  //R
                sext_op = 3'b000;
            7'b0010011: //I
                sext_op = 3'b000;
            7'b0000011: //lw
                sext_op = 3'b000;
            7'b1100111: //jalr
                sext_op = 3'b000;
            7'b0100011: //sw
                sext_op = 3'b001;
            7'b1100011: //B
                sext_op = 3'b010;
            7'b0110111: //lui
                sext_op = 3'b100;
            7'b1101111: //jal
                sext_op = 3'b011;
        endcase
    end
    
    always @(*) begin //alu_op
        case(opcode)
            7'b0110011:  //R
                case(funct3)
                    3'b000:
                        if(funct7 == 7'b0000000)
                            alu_op = 4'b0000;//add
                        else
                            alu_op = 4'b0100;//sub
                    3'b111: alu_op = 4'b0001;//and
                    3'b110: alu_op = 4'b0101;//or
                    3'b100: alu_op = 4'b1001;//xor
                    3'b001: alu_op = 4'b0010;//sll slli
                    3'b101: 
                        if(funct7 == 7'b0000000)
                            alu_op = 4'b1010;//srl
                        else
                            alu_op = 4'b1110;//sra                          
                endcase
            7'b0010011: //I
                case(funct3)
                    3'b000: alu_op = 4'b0000;
                    3'b111: alu_op = 4'b0001;
                    3'b110: alu_op = 4'b0101;
                    3'b100: alu_op = 4'b1001;
                    3'b001: alu_op = 4'b0010;
                    3'b101: alu_op = 4'b0110;
                endcase
            7'b0000011: //lw
                alu_op = 4'b0000;    
            7'b1100111: //jalr
                alu_op = 4'b0000; //X
            7'b0100011: //sw
                alu_op = 4'b0000; //X
            7'b1100011: //B
                case(funct3)
                    3'b000: alu_op = 4'b0011;
                    3'b001: alu_op = 4'b0111;
                    3'b100: alu_op = 4'b1111;
                    3'b101: alu_op = 4'b1011;
                endcase
            7'b0110111: //lui
                alu_op = 4'b0000; //X
            7'b1101111: //jal
                alu_op = 4'b0000; //X
        endcase
    end

    
endmodule

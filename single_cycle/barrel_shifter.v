`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 11:25:07
// Design Name: 
// Module Name: barrel_shifter
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


module barrel_shifter(
    input [4:0] alu_op,
    input [31:0] rD1,
    input [31:0] alu_b,
    output reg [31:0] alu_c1
    );
    
    reg [31:0] c;
    reg [31:0] alu_b1;
    
    always @(*) begin
        case(alu_op[3:2])
            2'b00: begin //sll slli
//                if(alu_b[31] == 1'b0) begin
                     c = alu_b[0] ? {rD1[30:0],1'b0} : rD1;
                     c = alu_b[1] ? {c[29:0],2'b0} : c;
                     c = alu_b[2] ? {c[27:0],4'b0} : c;
                     c = alu_b[3] ? {c[23:0],8'b0} : c;
                     c = alu_b[4] ? {c[15:0],16'b0} : c;
//                     if(alu_b[31:5] > 0) c = 32'b0;
                 end
//                 else begin
//                    alu_b1 = (32'hffffffff-alu_b) + 1;
//                    c = alu_b1[0] ? {rD1[0],rD1[31:1]} : rD1;
//                    c = alu_b1[1] ? {c[1:0],c[31:2]} : c;
//                    c = alu_b1[2] ? {c[3:0],c[31:4]} : c;
//                    c = alu_b1[3] ? {c[7:0],c[31:8]} : c;
//                    c = alu_b1[4] ? {c[15:0],c[31:16]} : c;
//                 end
//            end  
            2'b01: begin //srli srai
                if(alu_b[10] == 0) begin //srli 
                    c = alu_b[0] ? {1'b0,rD1[31:1]} : rD1;
                    c = alu_b[1] ? {2'b0,c[31:2]} : c;
                    c = alu_b[2] ? {4'b0,c[31:4]} : c;
                    c = alu_b[3] ? {8'b0,c[31:8]} : c;
                    c = alu_b[4] ? {16'b0,c[31:16]} : c;
                end
                else begin //srai
                    c = alu_b[0] ? {{rD1[31]},rD1[31:1]} : rD1;
                    c = alu_b[1] ? {{2{c[31]}},c[31:2]} : c;
                    c = alu_b[2] ? {{4{c[31]}},c[31:4]} : c;
                    c = alu_b[3] ? {{8{c[31]}},c[31:8]} : c;
                    c = alu_b[4] ? {{16{c[31]}},c[31:16]} : c; 
                end
            end
            2'b10: begin //srl
//                if(alu_b[31] == 1'b0)
                    c = alu_b[0] ? {1'b0,rD1[31:1]} : rD1;
                    c = alu_b[1] ? {2'b0,c[31:2]} : c;
                    c = alu_b[2] ? {4'b0,c[31:4]} : c;
                    c = alu_b[3] ? {8'b0,c[31:8]} : c;
                    c = alu_b[4] ? {16'b0,c[31:16]} : c;
//                    if(alu_b[31:5] > 0) c = 32'b0; 
//                 else begin
//                    alu_b1 = (32'hffffffff-alu_b) + 1;
//                    c = alu_b1[0] ? {rD1[30:0],rD1[31]} : rD1;
//                    c = alu_b1[1] ? {c[29:0],c[31:30]} : c;
//                    c = alu_b1[2] ? {c[27:0],c[31:28]} : c;
//                    c = alu_b1[3] ? {c[23:0],c[31:24]} : c;
//                    c = alu_b1[4] ? {c[15:0],c[31:16]} : c;
//                  end             
            end  
            2'b11: begin //sra
//                if(alu_b[31] == 1'b0)
                    c = alu_b[0] ? {{rD1[31]},rD1[31:1]} : rD1;
                    c = alu_b[1] ? {{2{c[31]}},c[31:2]} : c;
                    c = alu_b[2] ? {{4{c[31]}},c[31:4]} : c;
                    c = alu_b[3] ? {{8{c[31]}},c[31:8]} : c;
                    c = alu_b[4] ? {{16{c[31]}},c[31:16]} : c; 
//                    if(alu_b[31:5] > 0) c = {32{c[31]}};
//                else begin
//                    alu_b1 = (32'hffffffff-alu_b) + 1;
//                    c = alu_b1[0] ? {rD1[30:0],rD1[31]} : rD1;
//                    c = alu_b1[1] ? {c[29:0],c[31:30]} : c;
//                    c = alu_b1[2] ? {c[27:0],c[31:28]} : c;
//                    c = alu_b1[3] ? {c[23:0],c[31:24]} : c;
//                    c = alu_b1[4] ? {c[15:0],c[31:16]} : c;
//                end
            end            
        endcase    
        alu_c1 = c;
    end
    
endmodule






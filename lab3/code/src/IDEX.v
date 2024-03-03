module IDEX(
    clk,
    reset,
    flush_i,
    regwrite_d,
    memtoreg_d,
    memread_d,
    memwrite_d,
    aluop_d,
    alusrc_d,
    branch_d,
    branch_predict_d,
    rs1_d,
    rs2_d,
    imm32_d,
    func_d,
    instr_rs1_d,
    instr_rs2_d,
    instr_rd_d,
    pc_notchosen_d,
    regwrite_e,
    memtoreg_e,
    memread_e,
    memwrite_e,
    aluop_e,
    alusrc_e,
    Branch_o,
    branch_predict_e,
    rs1_e,
    rs2_e,
    imm32_e,
    func_e,
    instr_rs1_e,
    instr_rs2_e,
    instr_rd_e,
    pc_notchosen_e
);

input clk;
input reset;
input flush_i;
input regwrite_d;
input memtoreg_d;
input memread_d;
input memwrite_d;
input [1:0] aluop_d;
input alusrc_d;
input branch_d;
input branch_predict_d;
input signed [31:0] rs1_d;
input signed [31:0] rs2_d;
input signed [31:0] imm32_d;
input [9:0] func_d;
input [4:0] instr_rs1_d;
input [4:0] instr_rs2_d;
input [4:0] instr_rd_d;
input [31:0] pc_notchosen_d;
output regwrite_e;
output memtoreg_e;
output memread_e;
output memwrite_e;
output [1:0] aluop_e;
output alusrc_e;
output Branch_o;
output branch_predict_e;
output signed [31:0] rs1_e;
output signed[31:0] rs2_e;
output signed[31:0] imm32_e;
output [9:0] func_e;
output [4:0] instr_rs1_e;
output [4:0] instr_rs2_e;
output [4:0] instr_rd_e;
output [31:0] pc_notchosen_e;

reg regwrite_e;
reg memtoreg_e;
reg memread_e;
reg memwrite_e;
reg [1:0] aluop_e;
reg alusrc_e;
reg Branch_o;
reg branch_predict_e;
reg signed[31:0] rs1_e;
reg signed[31:0] rs2_e;
reg signed [31:0] imm32_e;
reg [9:0] func_e;
reg [4:0] instr_rs1_e;
reg [4:0] instr_rs2_e;
reg [4:0] instr_rd_e;
reg [31:0] pc_notchosen_e;

always @(posedge clk or negedge reset) begin
    if(~reset)
        begin
            regwrite_e <= 1'b0;
            memtoreg_e <= 1'b0;
            memread_e <= 1'b0;
            memwrite_e <= 1'b0;
            aluop_e <= 2'd0;
            alusrc_e <= 1'b0;
            Branch_o <= 1'b0;
            branch_predict_e <= 1'b0;
            rs1_e <= 32'd0;
            rs2_e <= 32'd0;
            imm32_e <= 32'd0;
            func_e <= 10'd0;
            instr_rs1_e <= 5'd0;
            instr_rs2_e <= 5'd0;
            instr_rd_e <= 5'd0;
            pc_notchosen_e <= 32'd0;
        end
    else if(flush_i)
        begin
            regwrite_e <= 1'b0;
            memtoreg_e <= 1'b0;
            memread_e <= 1'b0;
            memwrite_e <= 1'b0;
            aluop_e <= 2'd0;
            alusrc_e <= 1'b0;
            Branch_o <= 1'b0;
            branch_predict_e <= 1'b0;
            rs1_e <= 32'd0;
            rs2_e <= 32'd0;
            imm32_e <= 32'd0;
            func_e <= 10'd0;
            instr_rs1_e <= 5'd0;
            instr_rs2_e <= 5'd0;
            instr_rd_e <= 5'd0;
            pc_notchosen_e <= 32'd0;
        end
    else
        begin
            regwrite_e <= regwrite_d;
            memtoreg_e <= memtoreg_d;
            memread_e <= memread_d;
            memwrite_e <= memwrite_d;
            aluop_e <= aluop_d;
            alusrc_e <= alusrc_d;
            Branch_o <= branch_d;
            branch_predict_e <= branch_predict_d;
            rs1_e <= rs1_d;
            rs2_e <= rs2_d;
            imm32_e <= imm32_d;
            func_e <= func_d;
            instr_rs1_e <= instr_rs1_d;
            instr_rs2_e <= instr_rs2_d;
            instr_rd_e <= instr_rd_d;
            pc_notchosen_e <= pc_notchosen_d;
        end
end

endmodule
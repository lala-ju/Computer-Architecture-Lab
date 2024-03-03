module IFID(
    clk,
    reset,
    instr_f,
    pc_f,
    pc_add_f,
    stall,
    flush_i,
    instr_d,
    pc_d,
    pc_add_d
);

input clk;
input reset;
input [31:0] instr_f;
input [31:0] pc_f;
input [31:0] pc_add_f;
input stall;
input flush_i;
output [31:0] instr_d;
output [31:0] pc_d;
output [31:0] pc_add_d;

reg [31:0] instr_d;
reg [31:0] pc_d;
reg [31:0] pc_add_d;

always @(posedge clk or negedge reset) begin
    if(~reset)begin
            pc_d <= 32'd0;
            instr_d <= 32'd0;
            pc_add_d <= 32'd0;
    end
    else if(stall) begin
            pc_d <= pc_d;
            instr_d <= instr_d;
            pc_add_d <= pc_add_d;
    end
    else if(flush_i) begin
            pc_d <= 32'd0;
            instr_d <= 32'd0;
            pc_add_d <= 32'd0;
    end
    else begin
            pc_d <= pc_f;
            instr_d <= instr_f;
            pc_add_d <= pc_add_f;
    end
end
endmodule
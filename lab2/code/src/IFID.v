module IFID(
    clk,
    reset,
    instr_f,
    pc_f,
    stall,
    flush,
    instr_d,
    pc_d
);

input clk;
input reset;
input [31:0] instr_f;
input [31:0] pc_f;
input stall;
input flush;
output [31:0] instr_d;
output [31:0] pc_d;

reg [31:0] instr_d;
reg [31:0] pc_d;

always @(posedge clk or negedge reset) begin
    if(~reset)begin
            pc_d <= 32'd0;
            instr_d <= 32'd0;
    end
    else if(stall) begin
            pc_d <= pc_d;
            instr_d <= instr_d;
    end
    else if(flush) begin
            pc_d <= 32'd0;
            instr_d <= 32'd0;
    end
    else begin
            pc_d <= pc_f;
            instr_d <= instr_f;
    end
end
endmodule
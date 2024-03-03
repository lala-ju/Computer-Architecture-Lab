module MEMWB(
    clk,
    reset,
    regwrite_m,
    memtoreg_m,
    alurs_m,
    rd_m,
    instr_rd_m,
    regwrite_w,
    memtoreg_w,
    alurs_w,
    rd_w,
    instr_rd_w
);

input clk;
input reset;
input regwrite_m;
input memtoreg_m;
input signed [31:0] alurs_m;
input signed [31:0] rd_m;
input [4:0] instr_rd_m;
output regwrite_w;
output memtoreg_w;
output signed [31:0] alurs_w;
output signed [31:0] rd_w;
output [4:0] instr_rd_w;

reg regwrite_w = 1'b0;
reg memtoreg_w = 1'b0;
reg signed [31:0] alurs_w = 32'd0;
reg signed [31:0] rd_w = 32'd0;
reg [4:0] instr_rd_w = 5'd0;

always @(posedge clk or negedge reset) begin
    if(~reset)
        begin
            regwrite_w <= 1'd0;
            memtoreg_w <= 1'd0;
            alurs_w <= 32'd0;
            rd_w <= 32'd0;
            instr_rd_w <= 5'd0;
        end
    else
        begin
            regwrite_w <= regwrite_m;
            memtoreg_w <= memtoreg_m;
            alurs_w <= alurs_m;
            rd_w <= rd_m;
            instr_rd_w <= instr_rd_m;
        end
end

endmodule
module EXMEM(
    clk,
    reset,
    regwrite_e,
    memtoreg_e,
    memread_e,
    memwrite_e,
    alurs_e,
    muxrs2_e,
    instr_rd_e,
    regwrite_m,
    memtoreg_m,
    memread_m,
    memwrite_m,
    alurs_m,
    muxrs2_m,
    instr_rd_m
);

input clk;
input reset;
input regwrite_e;
input memtoreg_e;
input memread_e;
input memwrite_e;
input [31:0] alurs_e;
input signed [31:0] muxrs2_e;
input [4:0] instr_rd_e;
output regwrite_m;
output memtoreg_m;
output memread_m;
output memwrite_m;
output [31:0] alurs_m;
output signed [31:0] muxrs2_m;
output [4:0] instr_rd_m;

reg regwrite_m = 1'd0;
reg memtoreg_m = 1'd0;
reg memread_m = 1'd0;
reg memwrite_m = 1'd0;
reg [31:0] alurs_m = 32'd0;
reg signed [31:0] muxrs2_m = 32'd0;
reg [4:0] instr_rd_m = 5'd0;

always @(posedge clk or negedge reset) begin
    if(~reset)
        begin
            regwrite_m <= 1'b0;
            memtoreg_m <= 1'b0;
            memread_m <= 1'b0;
            memwrite_m <= 1'b0;
            alurs_m <= 32'd0;
            muxrs2_m <= 32'd0;
            instr_rd_m <= 5'd0;
        end
    else
        begin
            regwrite_m <= regwrite_e;
            memtoreg_m <= memtoreg_e;
            memread_m <= memread_e;
            memwrite_m <= memwrite_e;
            alurs_m <= alurs_e;
            muxrs2_m <= muxrs2_e;
            instr_rd_m <= instr_rd_e;
        end
end

endmodule
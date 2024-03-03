module ImmGen(
    instr32,
    imm32
);

input [31:0] instr32;
output signed [31:0] imm32;

reg signed [31:0] imm32;

always @* begin
    imm32 = 32'd0;
    if(instr32[6:0] == 7'b0110011)
        begin
            imm32[11:0] = 12'd0;
        end
    else if(instr32[6:0] == 7'b0010011 || instr32[6:0] == 7'b0000011)
        begin
            imm32[11:0] = instr32[31:20];
            if(imm32[11] == 1'b1)begin
                imm32[31:12] = 20'b11111111111111111111;
            end
        end
    else if(instr32[6:0] == 7'b0100011)
        begin
            imm32[11:5] = instr32[31:25];
            imm32[4:0] = instr32[11:7];
            if(imm32[11] == 1'b1)begin
                imm32[31:12] = 20'b11111111111111111111;
            end
        end
    else if(instr32[6:0] == 7'b1100011)
        begin
            imm32[12] = instr32[31];
            imm32[10:5] = instr32[30:25];
            imm32[4:1] = instr32[11:8];
            imm32[11] = instr32[7];
            if(imm32[12] == 1'b1)begin
                imm32[31:13] = 19'b1111111111111111111;
            end
        end
end

endmodule
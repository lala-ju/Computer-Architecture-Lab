module ALU(
    src1, 
    src2, 
    ctrl, 
    result
);

input signed [31:0] src1;
input [31:0] src2;
input [2:0] ctrl;
output signed [31:0] result;

reg signed [31:0] result;
reg [4:0] shift;

//    ctrl
//and  000
//xor  001
//sll  010
//add  011
//sub  100
//mul  101
//addi 110
//srai 111
always @* begin
    if(ctrl == 3'b000) //and
        begin
            result = src1 & src2;
        end
    else if(ctrl == 3'b001) //xor
        begin
            result = src1 ^ src2;
        end
    else if(ctrl == 3'b010) //sll
        begin
            result = src1 << src2;
        end
    else if(ctrl == 3'b011) //add
        begin
            result = src1 + src2;
        end
    else if(ctrl == 3'b100) //sub
        begin
            result = src1 - src2;
        end
    else if(ctrl == 3'b101) // mul
        begin
            result = src1 * src2;
        end
    else if(ctrl == 3'b110) //addi
        begin
            result[31:0] = src1[31:0] + src2[31:0];
        end
    else if(ctrl == 3'b111) //srai
        begin
            //only take imm[4:0] as shift position
            shift[4:0] = src2[4:0];
            result = src1 >>> shift;
        end
end
endmodule
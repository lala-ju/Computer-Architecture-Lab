module ALU(
    src1, 
    src2, 
    ctrl, 
    data_o
);

input signed [31:0] src1;
input signed [31:0] src2;
input [2:0] ctrl;
output [31:0] data_o;

reg [31:0] data_o = 32'd0;
reg [4:0] shift = 5'd0;

//    ctrl
//and  000
//xor  001
//sll  100
//add  010
//sub  110
//mul  011
//addi 010
//srai 101
//lw   010
//sw   010
//beq  110
always @* begin
    data_o = 32'd0;
    shift = 5'd0;

    if(ctrl == 3'b000) //and
        begin
            data_o = src1 & src2;
        end
    else if(ctrl == 3'b001) //xor
        begin
            data_o = src1 ^ src2;
        end
    else if(ctrl == 3'b100) //sll
        begin
            data_o = src1 << src2;
        end
    else if(ctrl == 3'b010) //add //addi //lw //sw
        begin
            data_o = src1 + src2;
        end
    else if(ctrl == 3'b110) //sub //beq
        begin
            data_o = src1 - src2;
        end
    else if(ctrl == 3'b011) // mul
        begin
            data_o = src1 * src2;
        end
    else if(ctrl == 3'b101) //srai
        begin
            //only take imm[4:0] as shift position
            shift[4:0] = src2[4:0];
            data_o = src1 >>> shift;
        end
end
endmodule
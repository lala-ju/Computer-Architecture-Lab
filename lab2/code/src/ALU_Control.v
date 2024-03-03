module ALU_Control(
    op, 
    func, 
    ctrl_o
);

input [1:0] op;
input [9:0] func;
output [2:0] ctrl_o;

reg [2:0] ctrl_o;

//     op   funct     out
//and  10 0000000111->000
//xor  10 0000000100->001
//sll  10 0000000001->100
//add  10 0000000000->010
//sub  10 0100000000->110
//mul  10 0000001000->011
//addi 10 ???????000->010
//srai 10 0100000101->101
//lw   00 ???????010->010
//sw   00 ???????010->010
//beq  01 ???????000->110
always @* begin
ctrl_o = 3'd0;
if (op == 2'b01)
    begin
        ctrl_o = 3'b110; //beq
    end
else if (op == 2'b00)
    begin
        ctrl_o = 3'b010; //lw //sw
    end
else if (func[2:0] == 3'b101)
    begin
        ctrl_o = 3'b101; //srai
    end
else if (func[2:0] == 3'b111)
    begin
        ctrl_o = 3'b000; //and
    end
else if (func[2:0] == 3'b100)
    begin
        ctrl_o = 3'b001; //xor
    end
else if (func[2:0] == 3'b001)
    begin
        ctrl_o = 3'b100; //sll
    end
else if (func == 10'b0000001000)
    begin
        ctrl_o = 3'b011; //mul
    end
else if (func == 10'b0100000000)
    begin
        ctrl_o = 3'b110; //sub
    end
else
    begin
        ctrl_o = 3'b010; //add //addi
    end
end

endmodule
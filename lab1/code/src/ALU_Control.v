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
//sll  10 0000000001->010
//add  10 0000000000->011
//sub  10 0100000000->100
//mul  10 0000001000->101
//addi 11 ???????000->110
//srai 11 0100000101->111
always @* begin
if (op == 2'b11 && func[2:0] == 3'b000)
    begin
        ctrl_o = 3'b110; //addi
    end
else if (op == 2'b11 && func[2:0] == 3'b101)
    begin
        ctrl_o = 3'b111; //srai
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
        ctrl_o = 3'b010; //sll
    end
else if (func == 10'b0000000000)
    begin
        ctrl_o = 3'b011; //add
    end
else if (func == 10'b0100000000)
    begin
        ctrl_o = 3'b100; //sub
    end
else
    begin
        ctrl_o = 3'b101; //mul
    end
end

endmodule
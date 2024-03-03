module Control(
    inCtrl, 
    aluop, 
    alusrc, 
    regwrite
);

input [6:0] inCtrl;
output [1:0] aluop;
output alusrc;
output regwrite;

wire [1:0] aluop;
wire alusrc;
wire regwrite;

//addi and srai need to choose imm
assign alusrc = (inCtrl == 7'b0010011)? 1'b1: 1'b0;
//every instruction in this lab needs to write to the register
assign regwrite = 1'b1; 
//operations are all R type
//but I add a different one for the instruction that use imm
assign aluop = (inCtrl == 7'b0010011)? 2'b11:2'b10;

endmodule
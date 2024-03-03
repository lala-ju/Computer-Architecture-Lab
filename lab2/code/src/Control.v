module Control(
    inCtrl, 
    noop,
    regwrite,
    memreg,
    memread,
    memwrite,
    aluop,
    alusrc,
    Branch_o
);

input [6:0] inCtrl;
input noop;
output regwrite;
output memreg;
output memread;
output memwrite;
output [1:0] aluop;
output alusrc;
output Branch_o;

reg regwrite = 1'b0;
reg memreg = 1'b0;
reg memread = 1'b0;
reg memwrite = 1'b0;
reg [1:0] aluop = 2'b00;
reg alusrc = 1'b0;
reg Branch_o = 1'b0;

always @* begin
    regwrite = 1'b0;
    memreg = 1'b0;
    memread = 1'b0;
    memwrite = 1'b0;
    aluop = 2'b00;
    alusrc = 1'b0;
    Branch_o = 1'b0;
    if(noop == 1'b1)
         begin
            regwrite = 1'b0;
            memreg = 1'b0;
            memread = 1'b0;
            memwrite = 1'b0;
            aluop[1:0] = 2'b00;
            alusrc = 1'b0;
            Branch_o = 1'b0;
         end
    else
        begin
            //sw, beq : 0 //other: 1
            regwrite = (inCtrl == 7'b0110011 || inCtrl == 7'b0010011 || inCtrl == 7'b0000011)? 1'b1: 1'b0;
            //other : 0 //lw: 1
            memreg = (inCtrl == 7'b0000011)? 1'b1: 1'b0;
            //other : 0 //lw: 1
            memread = (inCtrl == 7'b0000011)? 1'b1: 1'b0;
            //other : 0 //sw: 1
            memwrite = (inCtrl == 7'b0100011)? 1'b1: 1'b0;
            //other: 0 // beq, lw, sw:1
            aluop[1] = (inCtrl == 7'b0010011 || inCtrl == 7'b0110011)? 1'b1: 1'b0;
            //other: 0 // beq :1
            aluop[0] = (inCtrl == 7'b1100011)? 1'b1: 1'b0;
            //imm : 1 // other : 0
            alusrc = (inCtrl == 7'b0010011 || inCtrl == 7'b0000011 || inCtrl == 7'b0100011)? 1'b1: 1'b0;
            //beq : 1 // other : 0
            Branch_o = (inCtrl == 7'b1100011)? 1'b1: 1'b0;
        end
end
endmodule
module CPU
(
    clk_i, 
    rst_i,
);

// Ports
input               clk_i;
input               rst_i;

wire [31:0] pcCur;
wire [31:0] pcSrc;
wire [31:0] instr;
wire [1:0] aluOp;
wire aluSrc;
wire regWrite;
wire [31:0] rs1;
wire [31:0] rs2;
wire [31:0] ext;
wire [31:0] alurs2;
wire [2:0] aluCtrl;
wire [31:0] aluResult;


PC PC(
    .clk_i(clk_i), 
    .rst_i(rst_i), 
    .pc_i(pcSrc),
    .pc_o(pcCur)
);

Adder Add_PC(
    .in1(pcCur),
    .in2(32'd4),
    .sum(pcSrc)
);

Instruction_Memory Instruction_Memory(
    .addr_i(pcCur),
    .instr_o(instr)
);

Registers Registers(
    .rst_i(rst_i),
    .clk_i(clk_i),
    .RS1addr_i(instr[19:15]),
    .RS2addr_i(instr[24:20]),
    .RDaddr_i(instr[11:7]), 
    .RDdata_i(aluResult),
    .RegWrite_i(regWrite), 
    .RS1data_o(rs1), 
    .RS2data_o(rs2)
);

Control Control(
    .inCtrl(instr[6:0]), 
    .aluop(aluOp), 
    .alusrc(aluSrc), 
    .regwrite(regWrite)
);

Sign_Extend Sign_Extend(
    .imm_in(instr[31:20]), 
    .ext_out(ext)
);

MUX32 MUX_ALUSrc(
    .choice0(rs2), 
    .choice1(ext), 
    .select(aluSrc), 
    .res(alurs2)
);

wire [9:0] functionCode;
assign functionCode[9:3] = instr[31:25];
assign functionCode[2:0] = instr[14:12];

ALU_Control ALU_Control(
    .op(aluOp),
    .func(functionCode), 
    .ctrl_o(aluCtrl)
);
  
ALU ALU(
    .src1(rs1), 
    .src2(alurs2), 
    .ctrl(aluCtrl), 
    .result(aluResult)
);

endmodule


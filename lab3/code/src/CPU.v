module CPU(
    clk_i, 
    rst_i,
);

input clk_i;
input rst_i;

//IF Stage
//mux before pc
wire [31:0] pc_src;
wire [31:0] pc_cur;
wire [31:0] pc_add;
wire [31:0] pc_ori;
wire [31:0] pc_real;
wire [31:0] instruction_f;

//ID
wire [31:0] pc_cur_d;
wire [31:0] pc_add_d;
wire [31:0] instruction_d;
wire [6:0] opcode;
wire [4:0] rs1_d;
wire [4:0] rs2_d;
wire [4:0] rd_d;
wire [9:0] funct_d;
wire [31:0] pc_notchosen_d;

wire signed [31:0] data1_d;
wire signed [31:0] data2_d;
wire signed [31:0] imm_d;
wire regwrite_d;
wire memtoreg_d;
wire memread_d;
wire memwrite_d;
wire alusrc_d;
wire branch_d;
wire [1:0] aluop_d;


wire predict_bit;
wire branch_predict;
wire Flush;
wire stall;
wire pcwrite;
wire noop;
wire [31:0] pc_branch;

//EX
wire regwrite_e;
wire memtoreg_e;
wire memread_e;
wire memwrite_e;
wire alusrc_e;
wire branch_e;
wire branch_predict_e;
wire [1:0] aluop_e;
wire signed [31:0] data1_e;
wire signed [31:0] data2_e;
wire signed [31:0] imm_e;
wire [9:0] funct_e;
wire [4:0] rs1_e;
wire [4:0] rs2_e;
wire [4:0] rd_e;
wire [31:0] pc_notchosen_e;

wire signed [31:0] data1_mux;
wire signed [31:0] data2_mux;
wire signed [31:0] data2_imm_mux;
wire [31:0] alures_e;
wire [2:0] aluctrl;

wire [1:0] forwarda, forwardb;
wire data_equal_zero;
wire branch_real;

//MEM
wire regwrite_m;
wire memtoreg_m;
wire memread_m;
wire memwrite_m;
wire [31:0] alures_m;
wire signed [31:0] data2_mux_m;
wire [4:0] rd_m;
wire signed [31:0] read_data_m;

//WB
wire regwrite_w;
wire memtoreg_w;
wire [31:0] alures_w;
wire signed [31:0] read_data_w;
wire [4:0] rd_w;
wire signed [31:0] final_data;

//////////////////////////
MUX PCCHOICE(
    .choice0(pc_add), 
    .choice1(pc_branch), 
    .select(branch_predict), 
    .res(pc_src)
);

MUX REALPC(
    .choice0(pc_src), 
    .choice1(pc_notchosen_e), 
    .select(Flush), 
    .res(pc_real)
);

PC PC(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .PCWrite_i(pcwrite),
    .pc_i(pc_real),
    .pc_o(pc_cur)
);

Adder PCADD(
    .in1(pc_cur), 
    .in2(32'd4), 
    .sum(pc_add)
);

Instruction_Memory Instruction_Memory(
    .addr_i(pc_cur),
    .instr_o(instruction_f)
);

IFID IF_ID(
    .clk(clk_i),
    .reset(rst_i),
    .instr_f(instruction_f),
    .pc_f(pc_cur),
    .pc_add_f(pc_add),
    .stall(stall),
    .flush_i(branch_predict || Flush),
    .instr_d(instruction_d),
    .pc_d(pc_cur_d),
    .pc_add_d(pc_add_d)
);

assign opcode[6:0] = instruction_d[6:0];
assign rs1_d[4:0] = instruction_d[19:15];
assign rs2_d[4:0] = instruction_d[24:20];
assign funct_d[9:3] = instruction_d[31:25];
assign funct_d[2:0] = instruction_d[14:12];
assign rd_d[4:0] = instruction_d[11:7];

Hazard Hazard_Detection(
    .rs1(rs1_d),
    .rs2(rs2_d),
    .memread(memread_e),
    .exrd(rd_e),
    .Stall_o(stall),
    .pcwrite(pcwrite),
    .noop(noop)
);

Control Control(
    .inCtrl(opcode), 
    .noop(noop),
    .regwrite(regwrite_d),
    .memreg(memtoreg_d),
    .memread(memread_d),
    .memwrite(memwrite_d),
    .aluop(aluop_d),
    .alusrc(alusrc_d),
    .Branch_o(branch_d)
);

Branch_Predictor branch_predictor(
    .clk(clk_i),
    .reset(rst_i),
    .branch_i(branch_e),
    .equal(Flush),
    .predict_o(predict_bit)
);

assign branch_predict = (branch_d & predict_bit);

Registers Registers(
    .rst_i(rst_i),
    .clk_i(clk_i),
    .RS1addr_i(rs1_d),
    .RS2addr_i(rs2_d),
    .RDaddr_i(rd_w), 
    .RDdata_i(final_data),
    .RegWrite_i(regwrite_w), 
    .RS1data_o(data1_d), 
    .RS2data_o(data2_d) 
);

ImmGen immExt(
    .instr32(instruction_d),
    .imm32(imm_d)
);

Adder PCADD_BR(
    .in1(pc_cur_d), 
    .in2(imm_d), 
    .sum(pc_branch)
);

MUX PCNOTCHOSEN(
    .choice0(pc_branch), 
    .choice1(pc_add_d), 
    .select(branch_predict), 
    .res(pc_notchosen_d)
);

IDEX ID_EX(
    .clk(clk_i),
    .reset(rst_i),
    .flush_i(Flush),
    .regwrite_d(regwrite_d),
    .memtoreg_d(memtoreg_d),
    .memread_d(memread_d),
    .memwrite_d(memwrite_d),
    .aluop_d(aluop_d),
    .alusrc_d(alusrc_d),
    .branch_d(branch_d),
    .branch_predict_d(branch_predict),
    .rs1_d(data1_d),
    .rs2_d(data2_d),
    .imm32_d(imm_d),
    .func_d(funct_d),
    .instr_rs1_d(rs1_d),
    .instr_rs2_d(rs2_d),
    .instr_rd_d(rd_d),
    .pc_notchosen_d(pc_notchosen_d),
    .regwrite_e(regwrite_e),
    .memtoreg_e(memtoreg_e),
    .memread_e(memread_e),
    .memwrite_e(memwrite_e),
    .aluop_e(aluop_e),
    .alusrc_e(alusrc_e),
    .Branch_o(branch_e),
    .branch_predict_e(branch_predict_e),
    .rs1_e(data1_e),
    .rs2_e(data2_e),
    .imm32_e(imm_e),
    .func_e(funct_e),
    .instr_rs1_e(rs1_e),
    .instr_rs2_e(rs2_e),
    .instr_rd_e(rd_e),
    .pc_notchosen_e(pc_notchosen_e)
);

Forward fowardunit(
    .rs1(rs1_e),
    .rs2(rs2_e),
    .memregwrite(regwrite_m),
    .memrd(rd_m),
    .wbregwrite(regwrite_w),
    .wbrd(rd_w),
    .forward1(forwarda),
    .forward2(forwardb)
);

MUX4 data1_mux3(
    .choice00(data1_e), 
    .choice01(final_data), 
    .choice02(alures_m),
    .select0(forwarda), 
    .res0(data1_mux)
);

MUX4 data2_mux3(
    .choice00(data2_e), 
    .choice01(final_data), 
    .choice02(alures_m),
    .select0(forwardb), 
    .res0(data2_mux)
);

MUX data2_imm_mux2(
    .choice0(data2_mux), 
    .choice1(imm_e),
    .select(alusrc_e), 
    .res(data2_imm_mux)
);

ALU_Control alu_ctrl(
    .op(aluop_e), 
    .func(funct_e), 
    .ctrl_o(aluctrl)
);

ALU ALU(
    .src1(data1_mux), 
    .src2(data2_imm_mux), 
    .ctrl(aluctrl), 
    .data_o(alures_e)
);

assign data_equal_zero = (alures_e == 32'd0);
assign branch_real = (branch_e & data_equal_zero);
assign Flush = (branch_real ^ branch_predict_e);

EXMEM regEXMEM(
    .clk(clk_i),
    .reset(rst_i),
    .regwrite_e(regwrite_e),
    .memtoreg_e(memtoreg_e),
    .memread_e(memread_e),
    .memwrite_e(memwrite_e),
    .alurs_e(alures_e),
    .muxrs2_e(data2_mux),
    .instr_rd_e(rd_e),
    .regwrite_m(regwrite_m),
    .memtoreg_m(memtoreg_m),
    .memread_m(memread_m),
    .memwrite_m(memwrite_m),
    .alurs_m(alures_m),
    .muxrs2_m(data2_mux_m),
    .instr_rd_m(rd_m)
);

Data_Memory Data_Memory(
    .clk_i(clk_i), 
    .addr_i(alures_m), 
    .MemRead_i(memread_m),
    .MemWrite_i(memwrite_m),
    .data_i(data2_mux_m),
    .data_o(read_data_m)
);

MEMWB regMEMWB(
    .clk(clk_i),
    .reset(rst_i),
    .regwrite_m(regwrite_m),
    .memtoreg_m(memtoreg_m),
    .alurs_m(alures_m),
    .rd_m(read_data_m),
    .instr_rd_m(rd_m),
    .regwrite_w(regwrite_w),
    .memtoreg_w(memtoreg_w),
    .alurs_w(alures_w),
    .rd_w(read_data_w),
    .instr_rd_w(rd_w)
);

MUX wbMUX(
    .choice0(alures_w), 
    .choice1(read_data_w), 
    .select(memtoreg_w), 
    .res(final_data)
);

endmodule
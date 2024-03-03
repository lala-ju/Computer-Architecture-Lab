module Sign_Extend(
    imm_in, 
    ext_out
);

input [11:0] imm_in;
output [31:0] ext_out;

wire [31:0] ext_out;

assign ext_out[11:0] = imm_in;
assign ext_out[31:12] =  (imm_in[11] == 1'b1)? 20'b11111111111111111111:20'b0;

endmodule
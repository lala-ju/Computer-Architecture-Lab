module Adder(in1, in2, sum);

input [31:0] in1;
input [31:0] in2;
output [31:0] sum;

wire [31:0] sum;
assign sum = in1 + in2;

endmodule
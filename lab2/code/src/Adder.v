module Adder
(
    in1, 
    in2, 
    sum
);

input signed [31:0] in1;
input signed [31:0] in2;
output signed [31:0] sum;

wire signed [31:0] sum;
assign sum = in1 + in2;

endmodule
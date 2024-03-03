module MUX32(
    choice0, 
    choice1, 
    select, 
    res
);

input [31:0] choice0;
input [31:0] choice1;
input select;
output [31:0] res;

wire [31:0] res;
assign res = (select)? choice1:choice0;

endmodule
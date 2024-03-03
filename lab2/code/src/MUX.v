module MUX(
    choice0, 
    choice1, 
    select, 
    res
);

input signed [31:0] choice0;
input signed [31:0] choice1;
input select;
output signed [31:0] res;

reg signed [31:0] res;

always @(*) begin
    if (select == 1'b0) begin
        res <= choice0;
    end
    else begin
        res <= choice1;
    end
end
endmodule
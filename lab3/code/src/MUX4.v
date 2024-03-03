module MUX4(
    choice00, 
    choice01, 
    choice02,
    select0, 
    res0
);

input signed [31:0] choice00;
input signed [31:0] choice01;
input signed [31:0] choice02;
input [1:0] select0;
output signed [31:0] res0;

reg signed [31:0] res0;
always @* begin
    res0 = 32'd0;
    if(select0 == 2'b00)
        begin
            res0 = choice00;
        end
    else if(select0 == 2'b01)
        begin
            res0 = choice01;
        end
    else if(select0 == 2'b10)
        begin
            res0 = choice02;
        end
end
endmodule
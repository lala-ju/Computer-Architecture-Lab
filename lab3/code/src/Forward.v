module Forward(
    rs1,
    rs2,
    memregwrite,
    memrd,
    wbregwrite,
    wbrd,
    forward1,
    forward2
);

input [4:0] rs1;
input [4:0] rs2;
input memregwrite;
input [4:0] memrd;
input wbregwrite;
input [4:0] wbrd;
output [1:0] forward1;
output [1:0] forward2;

reg [1:0] forward1;
reg [1:0] forward2;

always @* begin
    forward1 = 2'b00;
    forward2 = 2'b00;
    if (memregwrite && memrd != 1'b0 && memrd == rs1)
        begin
            forward1[1:0] = 2'b10;
        end
    if (memregwrite && memrd != 1'b0 && memrd == rs2)
        begin
            forward2[1:0] = 2'b10;
        end
    if (wbregwrite && wbrd != 1'b0 && !(memregwrite && memrd != 1'b0 && memrd == rs1) && wbrd == rs1)
        begin
            forward1[1:0] = 2'b01;
        end
    if (wbregwrite && wbrd != 1'b0 && !(memregwrite && memrd != 1'b0 && memrd == rs2) && wbrd == rs2)
        begin
            forward2[1:0] = 2'b01;
        end
end

endmodule
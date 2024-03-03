module Hazard(
    rs1,
    rs2,
    memread,
    exrd,
    Stall_o,
    pcwrite,
    noop,
);

input [4:0] rs1;
input [4:0] rs2;
input [4:0] exrd;
input memread;
output pcwrite;
output Stall_o;
output noop;

reg pcwrite;
reg Stall_o;
reg noop;

always @* begin
    pcwrite = 1'b1;
    Stall_o = 1'b0;
    noop = 1'b0;
    if(memread == 1'b1)
        begin
            if(exrd != 5'd0 && (exrd == rs1 || exrd == rs2))
                begin
                    pcwrite = 1'b0;
                    Stall_o = 1'b1;
                    noop = 1'b1;
                end
        end
end

endmodule
module Branch_Predictor(
    clk,
    reset,
    branch_i,
    equal,
    predict_o
);

input clk;
input reset;
input branch_i;
input equal;
reg [1:0] state;
output predict_o;
reg predict_o;

always @(posedge clk or negedge reset) begin
    if(~reset) begin
        state <= 2'b00;
        predict_o <= 1'b1;
    end
    else begin 
        if(branch_i == 1'b1) begin
            if(equal == 1'b1) begin
                if(state[1:0] == 2'b00)begin
                    state[1:0] = 2'b01;
                end
                else if(state[1:0] == 2'b01)begin
                    state[1:0] = 2'b10;
                end
                else if(state[1:0] == 2'b10)begin
                    state[1:0] = 2'b01;
                end
                else if(state[1:0] == 2'b11)begin
                    state[1:0] = 2'b10;
                end
            end
            else if(equal == 1'b0) begin
                if(state[1:0] == 2'b00)begin
                    state[1:0] = 2'b00;
                end
                else if(state[1:0] == 2'b01)begin
                    state[1:0] = 2'b00;
                end
                else if(state[1:0] == 2'b10)begin
                    state[1:0] = 2'b11;
                end
                else if(state[1:0] == 2'b11)begin
                    state[1:0] = 2'b11;
                end
            end
        end
    
        if(state == 2'b00 || state == 2'b01) begin
            predict_o <= 1'b1;
        end
        else if(state == 2'b10 || state == 2'b11)  begin
            predict_o <= 1'b0;
        end
    end
end

endmodule
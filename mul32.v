`timescale 1ns/10ps

module mul32 (
    input wire signed [31:0] M, Q,
    output reg signed [63:0] P     
);
    reg signed [32:0] adjusted_M;  
    reg signed [63:0] shifted_value;

    wire signed [31:0] neg_M;  

    assign neg_M = -M;  

    integer i, j; 
    reg [2:0] booth_group [15:0];  

    always @(*) begin
        P = 0;  
      
        for (i = 0; i < 16; i = i + 1) begin
            if (i == 0) begin
                booth_group[i] = {Q[i+1], Q[i], 1'b0}; 
            end else begin
                booth_group[i] = {Q[(i*2)+1], Q[(i*2)], Q[(i*2)-1]};  
            end
        end

        for (j = 0; j < 16; j = j + 1) begin
            case (booth_group[j])
                3'b001, 3'b010: adjusted_M = {M[31], M}; 
                3'b011: adjusted_M = {M, 1'b0};          
                3'b100: adjusted_M = {neg_M, 1'b0};      
                3'b101, 3'b110: adjusted_M = {neg_M[31], neg_M}; 
                3'b111, 3'b000: adjusted_M = 0;     
                default: adjusted_M = 0;
            endcase

            shifted_value = adjusted_M << (j * 2);  

            if (shifted_value[63] == 1)  
                P = P + {shifted_value[63], shifted_value}; 
            else
                P = P + shifted_value;
        end

        if (M == -32'h80000000 && Q == -1) begin
            P = 32'h7FFFFFFF; 
        end
    end

endmodule

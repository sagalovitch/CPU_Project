`timescale 1ns/10ps

module mul32 (
    input wire signed [31:0] M, Q,  
    output reg signed [63:0] P     
);

    reg signed [32:0] cA;   
    reg signed [63:0] sCA;

    wire signed [31:0] nM; 

    assign nM = -M;  

    integer i, j;
    reg [2:0] bG [15:0]; 

    always @(*) begin
        P = 0; 
      
        for (i = 0; i < 16; i = i + 1) begin
            if (i == 0) begin
                bG[i] = {Q[i+1], Q[i], 1'b0}; 
            end else begin
                bG[i] = {Q[(i*2)+1], Q[(i*2)], Q[(i*2)-1]}; 
            end
        end

  
        for (j = 0; j < 16; j = j + 1) begin
            case (bG[j])
                3'b001, 3'b010: cA = {M[31], M};  
                3'b011: cA = {M, 1'b0}; 
                3'b100: cA = {nM, 1'b0};  
                3'b101, 3'b110: cA = {nM[31], nM};  
                3'b111, 3'b000: cA = 0;  
                default: cA = 0;
            endcase

            sCA = cA << (j * 2); 

            if (sCA[63] == 1)  
                P = P + {sCA[63], sCA}; 
            else
                P = P + sCA;
        end
    end

endmodule

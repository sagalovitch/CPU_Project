`timescale 1ns/10ps

module mul32 (
    input wire [31:0] M, Q, 
    output reg [63:0] P   
);

 
    reg [2:0] bG [15:0];
    
    reg signed [32:0] cA;    
    reg signed [63:0] sCA;   

    wire [31:0] nM; 
   
    assign nM = ~M + 1; 

    integer i, j;

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
                3'b001, 3'b010: cA = {M[31], M[31:0]}; 
                3'b011: cA = {M[31:0], 1'b0};  
                3'b100: cA = {nM[31:0], 1'b0}; 
                3'b101, 3'b110: cA = {nM[31], nM[31:0]};  
                3'b111, 3'b000: cA = 0;  
                default: cA = 0;
            endcase

            sCA = cA << (j * 2);  
            P = P + sCA;  
        end
    end

endmodule

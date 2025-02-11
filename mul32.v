`timescale 1ns/10ps

module mul32 (
    input wire [31:0] M, Q,  // M = Multiplicand, Q = Multiplier
    output reg [63:0] P      // 64-bit product
);

    // Booth encoding groups (storing 3-bit values)
    reg [2:0] bG [15:0];

    // Temporary variables
    reg signed [32:0] cA;    // Stores the adjusted M or -M
    reg signed [63:0] sCA;   // Stores the shifted value of cA

    wire [31:0] nM;  // Two’s complement of M (negative M)

    // Inline neg_32 function - computes two's complement of M
    assign nM = ~M + 1;  // Negating M using bitwise NOT and +1

    integer i, j;

    always @(*) begin
        P = 0;  // Initialize product to 0
        
        // Booth Encoding: Break multiplier Q into 3-bit groups
        for (i = 0; i < 16; i = i + 1) begin
            if (i == 0) begin
                bG[i] = {Q[i+1], Q[i], 1'b0};  // First group (assume Q[-1] = 0)
            end else begin
                bG[i] = {Q[(i*2)+1], Q[(i*2)], Q[(i*2)-1]};  // Extract 3-bit pairs
            end
        end

        // Process each Booth encoded group
        for (j = 0; j < 16; j = j + 1) begin
            case (bG[j])
                3'b001, 3'b010: cA = {M[31], M[31:0]};  // +M
                3'b011: cA = {M[31:0], 1'b0};  // +2M (shift left)
                3'b100: cA = {nM[31:0], 1'b0};  // -2M (shift left)
                3'b101, 3'b110: cA = {nM[31], nM[31:0]};  // -M
                3'b111, 3'b000: cA = 0;  // No operation
                default: cA = 0;
            endcase

            sCA = cA << (j * 2);  // Shift left based on position
            P = P + sCA;  // Accumulate partial results
        end
    end

endmodule

`timescale 1ns/10ps

module div32 (
    input wire [31:0] A,   // Dividend (Numerator)
    input wire [31:0] M,   // Divisor (Denominator)
    output reg [31:0] Q,   // Quotient (Result of division)
    output reg [31:0] R    // Remainder (What's left after division)
);

    reg [63:0] temp;  // 64-bit remainder register (HI:LO)
    integer i;  // Loop counter

    always @(*) begin
        // Initialize quotient and remainder
        Q = 0;
        temp = {32'b0, A};  // HI:LO setup

        // Handle division by zero case
        if (M == 0) begin
            Q = 32'hFFFFFFFF;  // Error value
            R = 32'hFFFFFFFF;
        end else begin
            // Perform Restoring Division
            for (i = 0; i < 32; i = i + 1) begin
                // Shift remainder left by 1 bit (bringing down next bit of A)
                temp = temp << 1;

                // Try subtracting divisor from HI part
                temp[63:32] = temp[63:32] - M;

                if (temp[63] == 1) begin
                    // If subtraction is negative, restore and append 0 to quotient
                    temp[63:32] = temp[63:32] + M;
                    Q = Q << 1;  // Shift quotient left, append 0
                end else begin
                    Q = (Q << 1) | 1;  // Shift quotient left, append 1
                end
            end

            // Store final remainder from HI part
            R = temp[63:32];
        end
    end

endmodule

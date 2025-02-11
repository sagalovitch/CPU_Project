`timescale 1ns/10ps  // Defines the time scale for simulation

module sub32 (
    input wire [31:0] A, B,  // 32-bit input operands (A - B)
    input wire Cin,          // Carry-in (should be 1 for two’s complement)
    output wire [31:0] Diff, // 32-bit subtraction result
    output wire Cout         // Carry-out (not typically used in subtraction)
);

    wire [31:0] B_complement; // Stores two's complement of B

    // Compute two's complement of B: B_complement = ~B + 1
    assign B_complement = ~B;  // Bitwise NOT operation

    // Instantiate the existing 32-bit CLA adder (from add32.v)
    add32 cla_adder (
        .A(A),
        .B(B_complement),
        .Cin(1'b1),  // Cin = 1 to complete two’s complement
        .Sum(Diff),
        .Cout(Cout)  // Carry-out (optional, typically ignored)
    );

endmodule

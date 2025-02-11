`timescale 1ns/10ps  // Defines the time scale for simulation

// 4-bit Carry Lookahead Adder (Base Module)
module cla_4bit_adder (
    input wire [3:0] A, B,  // 4-bit input operands
    input wire Cin,         // Carry-in
    output wire [3:0] Sum,  // 4-bit sum output
    output wire Cout        // Carry-out
);
    wire [3:0] G, P, C;  // Generate, Propagate, and Carry signals

    // Generate (G) - When both A and B are 1, we force a carry
    assign G = A & B;

    // Propagate (P) - When either A or B is 1, the sum propagates a carry
    assign P = A ^ B;

    // Carry Calculation - Determines how carries move forward
    assign C[0] = Cin;  
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);

    // Final carry-out calculation
    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);

    // Sum calculation (XORing the propagate with carry)
    assign Sum = P ^ C;

endmodule

// 16-bit Adder Using 4-bit Modules
module cla_16bit_adder (
    input wire [15:0] A, B,  // 16-bit input operands
    input wire Cin,          // Carry-in
    output wire [15:0] Sum,  // 16-bit sum output
    output wire Cout         // Carry-out
);
    wire C4, C8, C12;  // Intermediate carry signals

    // Instantiating 4-bit adders to build a 16-bit adder
    cla_4bit_adder adder0(A[3:0], B[3:0], Cin, Sum[3:0], C4);
    cla_4bit_adder adder1(A[7:4], B[7:4], C4, Sum[7:4], C8);
    cla_4bit_adder adder2(A[11:8], B[11:8], C8, Sum[11:8], C12);
    cla_4bit_adder adder3(A[15:12], B[15:12], C12, Sum[15:12], Cout);

endmodule

// 32-bit Adder Using Two 16-bit Adders
module add32 (
    input wire [31:0] A, B,  // 32-bit input operands
    input wire Cin,          // Carry-in
    output wire [31:0] Sum,  // 32-bit sum output
    output wire Cout         // Carry-out
);
    wire C16;  // Carry-out from lower 16-bit adder

    // Instantiating two 16-bit adders to create a 32-bit adder
    cla_16bit_adder adder_low(A[15:0], B[15:0], Cin, Sum[15:0], C16);
    cla_16bit_adder adder_high(A[31:16], B[31:16], C16, Sum[31:16], Cout);

endmodule

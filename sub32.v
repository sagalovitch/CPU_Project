`timescale 1ns/10ps  

module sub32 (
    input wire [31:0] A, B, 
    output wire [31:0] Diff,
    output wire Cout,   
    output wire Overflow   
);

    wire [31:0] B_complement; 
    wire Cout_internal; 
    
    assign B_complement = ~B;

    add32 cla_adder (
        .A(A),
        .B(B_complement),
        .Cin(1'b1),  
        .Sum(Diff),
        .Cout(Cout_internal)  
    );

    assign Cout = ~Cout_internal; 
    assign Overflow = (A[31] ^ B[31]) & (A[31] ^ Diff[31]); 

endmodule


`timescale 1ns/10ps 

module sub32 (
    input wire [31:0] A, B,  
    input wire Cin,          
    output wire [31:0] Diff, 
    output wire Cout         
);

    wire [31:0] B_complement; 

    
    assign B_complement = ~B; 

    add32 cla_adder (
        .A(A),
        .B(B_complement),
        .Cin(1'b1), 
        .Sum(Diff),
        .Cout(Cout)  
    );

endmodule

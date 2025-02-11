`timescale 1ns/10ps  


module cla_4bit_adder (
    input wire [3:0] A, B,  
    input wire Cin,         
    output wire [3:0] Sum,  
    output wire Cout        
);
    wire [3:0] G, P, C;

    assign G = A & B;
    assign P = A ^ B;

    assign C[0] = Cin;  
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);

  
    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);

    assign Sum = P ^ C;

endmodule

module cla_16bit_adder (
    input wire [15:0] A, B,  
    input wire Cin,          
    output wire [15:0] Sum,  
    output wire Cout         
);
    wire C4, C8, C12;  

  
    cla_4bit_adder adder0(A[3:0], B[3:0], Cin, Sum[3:0], C4);
    cla_4bit_adder adder1(A[7:4], B[7:4], C4, Sum[7:4], C8);
    cla_4bit_adder adder2(A[11:8], B[11:8], C8, Sum[11:8], C12);
    cla_4bit_adder adder3(A[15:12], B[15:12], C12, Sum[15:12], Cout);

endmodule


module add32 (
    input wire [31:0] A, B, 
    input wire Cin,         
    output wire [31:0] Sum, 
    output wire Cout        
);
    wire C16;  

    cla_16bit_adder adder_low(A[15:0], B[15:0], Cin, Sum[15:0], C16);
    cla_16bit_adder adder_high(A[31:16], B[31:16], C16, Sum[31:16], Cout);

endmodule

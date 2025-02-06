// Carry-Lookahead adder

// 4 bit carry-lookahead module
module CLA4 ( input [3:0] x, y, output [3:0] sum, input Cin, output Cout);
	wire [3:0] G, P, C;
	
	assign G = x & y;
	assign P = x ^ y; // xor according to the B-cell, could be or but does not matter
	
	assign C[0] = Cin;
	assign C[1] = G[0] | (P[0] & C[0]);
	assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
	assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
	assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);
	
	assign sum = P ^ C;
	
endmodule

// 16 bit carry-lookahead module
module CLA16( input [15:0] x, y, output [16:0] sum, input Cin, output Cout);
	wire Cout1, Cout2, Cout3;
	
	CLA4 CLA_1(.x(x[3:0]), .y(y[3:0]), .sum(sum[3:0]), .Cin(Cin), .Cout(Cout1));
	CLA4 CLA_2(.x(x[7:4]), .y(y[7:4]), .sum(sum[7:4]), .Cin(Cout1), .Cout(Cout2));
	CLA4 CLA_3(.x(x[11:8]), .y(y[11:8]), .sum(sum[11:8]), .Cin(Cout2), .Cout(Cout3));
	CLA4 CLA_4(.x(x[15:12]), .y(y[15:12]), .sum(sum[15:12]), .Cin(Cout3), .Cout(Cout));

endmodule

// 32 bit carry-lookahead module

module add32( input [31:0] A, B, output [31:0] sum, input Cin, output Cout);
	wire Cout1;
	
	CLA16 CLA1(.x(A[15:0]), .y(B[15:0]), .sum(sum[15:0]), .Cin(Cin), .Cout(Cout1));
	CLA16 CLA2(.x(A[31:16]), .y(B[31:16]), .sum(sum[31:16]), .Cin(Cout1), .Cout(Cout));
	
endmodule
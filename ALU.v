// ALU module 
// In this case, input A is always going to be the Y register (this will be setup in the DataPath
module ALU (input [31:0] A, B, 
			output reg [63:0] C, 
			input [4:0] opcode);

parameter Add = 5'b00011, Sub = 5'b00100, AND = 5'b00101, OR = 5'b00110, RotateRight = 5'b00111, 
RotateLeft = 5'b01000, ShiftRight = 5'b01001, ShiftRightArithmetic = 5'b01010, ShiftLeft = 5'b01011,
AddImmediate = 5'b01100, ANDImmediate = 5'b01101, ORImmediate = 5'b01110, Divide = 5'b01111, Multiply = 5'b10000, Negate = 5'b10001,
NOT = 5'b10010;

// instatiate alu modules here with corresponding outputs then have C take value of those inputs 
wire [63:0] mul_out;
wire add_cout, sub_cout;
wire [31:0] add_out, sub_out, and_out, or_out, ror_out, rol_out, shr_out, shra_out, shl_out, 
ori_out, IncPC_out, neg_out, not_out, div_out, div_remainder;

// alu operation module instantiations
add32 add_32(.A(A), .B(B), .Cin(1'd0), .Sum(add_out), .Cout(add_cout));
sub32 sub_32(.A(A), .B(B), .Overflow(), .Diff(sub_out), .Cout(sub_cout));
mul32 mul_32(.M(A), .Q(B), .P(mul_out));
div32 div_32(.dividend(A), .divisor(B), .quotient(div_out), .remainder(div_remainder));
and32 and_32(.Ra(A), .Rb(B), .Rz(and_out));
or32 or_32(.Ra(A), .Rb(B), .Rz(or_out));
ror32 ror_32(.Ra(A), .shift_amt(B), .result(ror_out));
rol32 rol_32(.Ra(A), .shift_amt(B), .result(rol_out));
shr32 shr_32(.Ra(A), .shift_amt(B), .result(shr_out));
shra32 shra_32(.Ra(A), .shift_amt(B), .result(shra_out));
shl32 shl_32(.Ra(A), .shift_amt(B), .result(shl_out));
neg neg_32(.a(A), .b(neg_out));
not32 not_32(.Ra(A), .Rb(not_out));

always @(*) begin
	case (opcode)
		Add: begin
			C[31:0] <= add_out;
			C[63:32] <= 32'd0;
		end
		Sub: begin
			C[31:0] <= sub_out;
			C[63:32] <= 32'd0;
		end
		AND: begin
			C[31:0] <= and_out;
			C[63:32] <= 32'd0;
		end
		OR: begin
			C[31:0] <= or_out;
			C[63:32] <= 32'd0;
		end
		RotateRight: begin
			C[31:0] <= ror_out;
			C[63:32] <= 32'd0;
		end
		RotateLeft: begin
			C[31:0] <= rol_out;
			C[63:32] <= 32'd0;
		end
		ShiftRight: begin
			C[31:0] <= shr_out;
			C[63:32] <= 32'd0;
		end
		ShiftRightArithmetic: begin
			C[31:0] <= shra_out;
			C[63:32] <= 32'd0;
		end
		ShiftLeft: begin
			C[31:0] <= shl_out;
			C[63:32] <= 32'd0;
		end
		AddImmediate: begin
			C[31:0] <= add_out;
			C[63:32] <= 32'd0;
		end
		ANDImmediate:begin
			C[31:0] <= and_out;
			C[63:32] <= 32'd0;
		end
		ORImmediate: begin
			C[31:0] <= or_out;
			C[63:32] <= 32'd0;
		end
		Divide: begin
			C[63:32] <= div_out;
			C[31:0] <= div_remainder;
		end
		Multiply: begin
			C[63:0] <= mul_out;
		end
		Negate: begin
			C[31:0] <= neg_out;
			C[63:32] <= 32'd0;
		end
		NOT: begin
			C[31:0] <= not_out;
			C[63:32] <= 32'd0;
		end
	endcase
end

endmodule
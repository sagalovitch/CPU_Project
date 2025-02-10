// ALU module 
// In this case, input A is always going to be the Y register (this will be setup in the DataPath
module ALU ( input [31:0] A, B, output [63:0] C, input [4:0] opcode);

parameter Add = 5'b00011, Sub = 5'b00100, AND = 5'b00101, OR = 5'b00110, RotateRight = 5'b00111, 
RotateLeft = 5'b01000, ShiftRight = 01001, ShiftRightArithmetic = 5'b01010, ShiftLeft = 5'b01011,
AddImmediate = 5'b01100, ANDImmediate = 5'b01101, ORImmediate = 5'b01110, Divide = 5'b01111, Multiply = 5'b10000, Negate = 5'b10001,
NOT = 5'b10010;

// instatiate alu modules here with corresponding outputs then have C take value of those inputs 
wire [63:0] multi_out, div_out;
wire [31:0] add_out, sub_out, and_out, or_out, ror_out, rol_out, shr_out, shra_out, shl_out, addi_out, andi_out, ori_out, IncPC_out, neg_out, not_out;

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
		ShiftRightArtithmetic: begin
			C[31:0] <= shra_out;
			C[63:32] <= 32'd0;
		end
		ShiftLeft: begin
			C[31:0] <= shl_out;
			C[63:32] <= 32'd0;
		end
		AddImmediate: begin
			C[31:0] <= addi_out;
			C[63:32] <= 32'd0;
		end
		ANDImmediate:begin
			C[31:0] <= andi_out;
			C[63:32] <= 32'd0;
		end
		ORImmediate: begin
			C[31:0] <= or_out;
			C[63:32] <= 32'd0;
		end
		Divide: begin
			C[63:0] <= div_out;
		end
		Multiply: begin
			C[63:0] <= multi_out;
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
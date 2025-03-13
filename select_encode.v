// Select and Encode Logic 
module select_encode( 
	input Gra, Grb, Grc, Rin, Rout, BAout,
	output R0in, R1in, R2in, R3in, R4in, R5in, 
	R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
	output R0out, R1out, R2out, R3out, R4out, R5out, 
	R6out, R7out, R8out, R9out, R10out, R11out, R12out, 
	R13out, R14out, R15out,
	input [31:0] instruction,
	output [31:0] C_sign_extended
);




wire [3:0] Ra, Rb, Rc, binary_in;
assign Ra = instruction[26:23];
assign Rb = instruction[22:19];
assign Rc = instruction[18:15];


assign binary_in = (Ra & Gra) | (Rb & Grb) | (Rc & Grc);

// 4 to 16 encoder
// If Ra = 0000 Then it means Ra is R0, Rb = 0001 then Rb is R1 ....
/* parameter R0 = 16'b0000000000000001, R1 = 16'b0000000000000010, 
R2 = 16'b0000000000000100, R3 = 16'b0000000000001000, R4 = 16'b0000000000010000,
R5 = 16'b0000000000100000, R6 = 16'b0000000001000000, R7 = 16'b0000000010000000,
R8 = 16'b0000000100000000, R9 = 16'b0000001000000000, R10 = 16'b0000010000000000,
R11 = 16'b0000100000000000, R12 = 16'b0001000000000000, R13 = 16'b0010000000000000,
R14 = 16'b0100000000000000, R15 = 16'b1000000000000000; */

reg R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;
always @ (Gra, Grb, Grc, Rin, Rout, BAout) begin
// Should probably make this work on the clock edge but ....
// I'll keep it as is for now
	case (binary_in)
		4'h0: R0 <= 1;
		4'h1: R1 <= 1;
		4'h2: R2 <= 1;
		4'h3: R3 <= 1;
		4'h4:	R4 <= 1;
		4'h5: R5 <= 1;
		4'h6: R6 <= 1;
		4'h7: R7 <= 1;
		4'h8: R8 <= 1;
		4'h9: R9 <= 1;
		4'hA: R10 <= 1;
		4'hB: R11 <= 1;
		4'hC: R12 <= 1;
		4'hD: R13 <= 1;
		4'hE: R14 <= 1;
		4'hF: R15 <= 1;
		default: {R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15} <= 0;
	endcase

end
	
	assign R0in = R0 & Rin;
	assign R1in = R1 & Rin;
	assign R2in = R2 & Rin;
	assign R3in = R3 & Rin;
	assign R4in = R4 & Rin;
	assign R5in = R5 & Rin;
	assign R6in = R6 & Rin;
	assign R7in = R7 & Rin;
	assign R8in = R8 & Rin;
	assign R9in = R9 & Rin;
	assign R10in = R10 & Rin;
	assign R11in = R11 & Rin;
	assign R12in = R12 & Rin;
	assign R13in = R13 & Rin;
	assign R14in = R14 & Rin;
	assign R15in = R15 & Rin;
	
	assign R0out = R0 & (Rout | BAout);
	assign R1out = R1 & (Rout | BAout);
	assign R2out = R2 & (Rout | BAout);
	assign R3out = R3 & (Rout | BAout);
	assign R4out = R4 & (Rout | BAout);
	assign R5out = R5 & (Rout | BAout);
	assign R6out = R6 & (Rout | BAout);
	assign R7out = R7 & (Rout | BAout);
	assign R8out = R8 & (Rout | BAout);
	assign R9out = R9 & (Rout | BAout);
	assign R10out = R10 & (Rout | BAout);
	assign R11out = R11 & (Rout | BAout);
	assign R12out = R12 & (Rout | BAout);
	assign R13out = R13 & (Rout | BAout);
	assign R14out = R14 & (Rout | BAout);
	assign R15out = R15 & (Rout | BAout);
	
	// Push out C_sign_extended, use shift right arithmetic to extend the
	// 19 bit C_sign_extended to 32 bits, 
	assign C_sign_extended[31:0] = 32'b0;
	assign C_sign_extended[31:13] = instruction[18:0];
	assign C_sign_extended[31:0] = C_sign_extended >>> 13;

endmodule
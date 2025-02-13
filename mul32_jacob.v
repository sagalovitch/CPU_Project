// 32-bit multiply module
// Use Booth's Algorithm

// Q multiplier, M multiplicand
module mul32_jacob(input [31:0] Q, M, output [64:0] product);

// loop through Q (shift 3 bits each time to determine bit-pair)
// why would we need an always block? If our goal is to just multiply this, similar to a function. Is this for just when something gets passed
// as an input it will do the below steps?
reg [63:0] C = 64'b0;
assign M_neg = ~M + 1;
integer i;


// Apparently could also just do - A instead of two's complement since verilog auto handles negatives as two's complement.
always @ (*) begin
	
	// Cycle through Q three bits at a time
	for (i = 0; i < 30; i = i + 2) begin
        case ({Q[i+1], Q[i], (i == 0) ? 1'b0 : Q[i-1]})  // 3-bit slice
           //3'b000, 3'b111: C = C; 
            3'b001, 3'b010: C = C + (M << i);  // +1 × M
            3'b011: C = C + (M << (i+1));  // +2 × M
            3'b100: C = C + (M_neg << (i+1));  // -2 × M
            3'b101, 3'b110: C = C + (M_neg << i);  // -1 × M
            default: C = C;  
        endcase
	end	
	
end
assign product = C;
endmodule
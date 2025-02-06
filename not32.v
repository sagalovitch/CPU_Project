// not32 module
module not32 (
	input [31:0] Ra,
	output [31:0] Rb
);

assign Rb = ~Ra;

endmodule
// 32-bit and module
module and32 (
	input [31:0] Ra, Rb,
	output [31:0] Rz
);
					
assign Rz = Ra & Rb;

endmodule

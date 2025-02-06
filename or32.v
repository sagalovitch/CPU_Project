// Or module
module or32 (
	input [31:0] Ra, Rb,
	output [31:0] Rz
);

assign Rz = Ra | Rb;

endmodule
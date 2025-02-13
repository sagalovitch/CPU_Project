// And module
module and (input [31:0] Ra, Rb,
				output [31:0] Rz 
				);
assign Rz = Ra & Rb;

endmodule
module DataPath(
	input wire clock, clear,
	input wire [7:0] A, 
	input wire [7:0] RegisterAImmediate,
	input wire RZout, RAout, RBout,
	input wire RAin, RBin, RZin
);

wire [7:0] BusMuxOut, BusMuxInRZ, BusMuxInRA, BusMuxInRB; 

wire [7:0] Zregin;

//Devices
register RA(clear, clock, RAin, RegisterAImmediate, BusMuxInRA);
register RB(clear, clock, RBin, BusMuxOut, BusMuxInRB);

// adder
adder add(A, BusMuxOut, Zregin);
register RZ(clear, clock, RZin, Zregin, BusMuxInRZ);

//Bus
Bus bus(BusMuxInRZ, BusMuxInRA, BusMuxInRB, RZout, RAout, RBout, BusMuxOut);

endmodule

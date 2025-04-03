`timescale 1ns/10ps

module DataPath_tb; 
reg Clock, Clear, Stop;
wire [31:0] Outport_Out, Inport_In;

	DataPath DUT (
		.clock(Clock),
		.clear(Clear),
		.stop(Stop),
		.Outport_Out(Outport_Out),
		.Inport_In(Inport_In)
	);

	// Clock generation
	initial begin
		Clock = 0;
		forever #10 Clock = ~Clock;
	end

		// Simulation time
	initial begin
		#7000 $finish;
	end
	
endmodule

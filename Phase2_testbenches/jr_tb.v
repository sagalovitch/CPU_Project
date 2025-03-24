`timescale 1ns/10ps

module DataPath_tb; 
  	reg Clock, Clear, Read, Write,
			Gra, Grb, Grc, Rin, Rout, BAout,
			HIout, HIin,
			LOout, LOin,
			Zhighout, Zlowout, Zin, Yin,
			MDRout, MDRin, MARin,
			PCout, PCin, IRin, IncPC, Cout;
	// reg [31:0] Mdatain;
	reg AND;
	reg [4:0] opcode;

  // State parameters
  parameter Default = 4'd0, 
            T0 = 4'd1, 
            T1 = 4'd2,
            T2 = 4'd3,
            T3 = 4'd4, 
            T4 = 4'd5,
            T5 = 4'd6,
				T6 = 4'd7,
				T7 = 4'd8;

  reg [3:0] Present_state = Default;

  // Device Under Test instantiation using named port connections
  DataPath DUT (
	.clock(Clock),
	.clear(Clear),
	.read(Read), .write(Write),
	.Gra(Gra), .Grb(Grb), .Grc(Grc), 
	.BAout(BAout), .Rin(Rin), .Rout(Rout),
	.HIout(HIout), .HIin(HIin),
	.LOout(LOout), .LOin(LOin),
	.Zhighout(Zhighout), .Zlowout(Zlowout),
	.Zin(Zin), .Yin(Yin),
	.MDRout(MDRout), .MDRin(MDRin),
	.PCout(PCout), .PCin(PCin), .IRin(IRin),
	.MARin(MARin), .IncPC(IncPC), .opcode(opcode), .Cout(Cout)
  );

  // Clock generation - unchanged
  initial 
  begin
    Clock = 0;
    forever #10 Clock = ~ Clock;
  end
  


  // State machine - unchanged
always @(posedge Clock)
  begin
    case (Present_state)
      Default      : Present_state = T0;
      T0           : Present_state = T1;
      T1           : Present_state = T2;
      T2           : Present_state = T3;
      T3           : Present_state = T4;
    endcase
end
 // st C, Ra 
 // st C(Rb), Ra
always @(Present_state) // do the required job in each state
  begin
  case (Present_state) // assert the required signals in each clock cycle
		Default: begin
			PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
			 MARin <= 0; Zin <= 0; 
			PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0; 
			IncPC <= 0; Read <= 0; Write <= 0;
			Clear <= 0;
			HIin <= 0; LOin <= 0; Cout <= 0; 
			Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0;
			opcode <= 5'bzzzzz;
		end
		T0: begin // Instruction Fetch
			PCout <= 1;  MARin <= 1; IncPC <= 1;  Zin <= 1; 
			#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0; Read <= 1;
			// Get Setup for Read signal
		end
		T1: begin // Instruction Fetch
			Zlowout <= 1; PCin <= 1; MDRin <= 1;
			#15 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
		end
		T2: begin // Instruction Fetch
			MDRout <= 1; IRin <= 1; 
			#15 MDRout <= 0; IRin <= 0;
		end
		T3: begin 
			Gra <= 1; Rout <= 1; PCin <= 1;
		end
  endcase
end

 // Monitor signals
// initial begin
//	  $monitor("Time=%0d State=%b BusMuxOut=%h, BusMuxIn_MDR=%h MDRMuxOut=%h",
//				  $time, Present_state, DUT.BusMuxOut, DUT.BusMuxIn_MDR, DUT.MDRMuxOut);
// end

// Test run length
initial
	begin
		#500 $finish;
	end

endmodule

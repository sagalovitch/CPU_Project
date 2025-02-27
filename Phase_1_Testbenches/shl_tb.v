`timescale 1ns/10ps

module DataPath_tb; 
  	reg Clock, Clear, Read;
	reg		R0out, R0in,
			R1out, R1in,
			R2out, R2in,
			R3out, R3in,
			R4out, R4in,
			R5out, R5in,
			R6out, R6in,
			R7out, R7in,
	// R8 is return address register (RA)
			R8out, R8in,
	// R9 is Stack Pointer (SP)
			R9out, R9in,
	// R10-13 are argument registers
			R10out, R10in,
			R11out, R11in,
			R12out, R12in,
			R13out, R13in,
	// R14-15 are return value registers
			R14out, R14in,
			R15out, R15in,
			HIout, HIin,
			LOout, LOin,
			Zhighout, Zlowout, Zin, Yin,
			MDRout, MDRin, MARin,
			PCout, PCin, IRin, IncPC;
	reg [31:0] Mdatain;
	reg AND;
	reg [4:0] opcode;

  // State parameters
  parameter Default = 4'b0000, 
            Reg_load1a = 4'b0001, 
            Reg_load1b = 4'b0010,
            Reg_load2a = 4'b0011,
            Reg_load2b = 4'b0100, 
            Reg_load3a = 4'b0101,
            Reg_load3b = 4'b0110,
            T0 = 4'b0111,
            T1 = 4'b1000,
            T2 = 4'b1001,
            T3 = 4'b1010,
            T4 = 4'b1011,
            T5 = 4'b1100,
				T6 = 4'b1101;

  reg [3:0] Present_state = Default;

  // Device Under Test instantiation using named port connections
  DataPath DUT (
	.clock(Clock),
	.clear(Clear),
	.read(Read),
	.R0out(R0out), .R0in(R0in),
	.R1out(R1out), .R1in(R1in),
	.R2out(R2out), .R2in(R2in),
	.R3out(R3out), .R3in(R3in),
	.R4out(R4out), .R4in(R4in),
	.R5out(R5out), .R5in(R5in),
	.R6out(R6out), .R6in(R6in),
	.R7out(R7out), .R7in(R7in),
	.R8out(R8out), .R8in(R8in),
	.R9out(R9out), .R9in(R9in),
	.R10out(R10out), .R10in(R10in),
	.R11out(R11out), .R11in(R11in),
	.R12out(R12out), .R12in(R12in),
	.R13out(R13out), .R13in(R13in),
	.R14out(R14out), .R14in(R14in),
	.R15out(R15out), .R15in(R15in),
	.HIout(HIout), .HIin(HIin),
	.LOout(LOout), .LOin(LOin),
	.Zhighout(Zhighout), .Zlowout(Zlowout),
	.Zin(Zin), .Yin(Yin),
	.MDRout(MDRout), .MDRin(MDRin),
	.PCout(PCout), .PCin(PCin), .IRin(IRin),
	.Mdatain(Mdatain),
	.MARin(MARin), .IncPC(IncPC),
	.opcode(opcode)
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
      Default      : Present_state = Reg_load1a;
      Reg_load1a   : Present_state = Reg_load1b;
      Reg_load1b   : Present_state = Reg_load2a;
      Reg_load2a   : Present_state = Reg_load2b;
      Reg_load2b   : Present_state = Reg_load3a;
      Reg_load3a   : Present_state = Reg_load3b;
      Reg_load3b   : Present_state = T0;
      T0           : Present_state = T1;
      T1           : Present_state = T2;
      T2           : Present_state = T3;
      T3           : Present_state = T4;
      T4           : Present_state = T5;
    endcase
end
 
always @(Present_state) // do the required job in each state
  begin
  case (Present_state) // assert the required signals in each clock cycle
		Default: begin
			PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
			R2out <= 0; R6out <= 0; MARin <= 0; Zin <= 0; 
			PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0; 
			IncPC <= 0; Read <= 0; AND <= 0;
			R2in <= 0; R6in <= 0; R7in <= 0; Mdatain <= 32'h00000000; Clear <= 0;
			HIin <= 0; LOin <= 0;
			opcode <= 5'bzzzzz;
		end
		Reg_load1a: begin 
			Mdatain <= 32'hFFFFFFFF;
			// Read = 0; MDRin = 0; // the first zero is there for completeness
			Read <= 1; 
			MDRin <= 1; // Took out #10 for '1', as it may not be needed
			#15 Read <= 0; MDRin <= 0; // for your current implementation
		end
		Reg_load1b: begin
		  MDRout <= 1; R3in <= 1; 
		  #15 MDRout <= 0; R3in <= 0; 
		end
		Reg_load2a: begin 
			Mdatain <= 32'h2; // Load this value into MDR to then be loaded into 
			Read <= 1; MDRin <= 1; 
			#15 Read <= 0; MDRin <= 0; 
		end
		Reg_load2b: begin
		  MDRout <= 1; R7in <= 1; 
		  #15 MDRout <= 0; R7in <= 0; 
		end
		Reg_load3a: begin 
		//	Mdatain <= 32'hFF543211; // -ABCDEF 
		//	Read <= 1; MDRin <= 1; 
		//	#15 Read <= 0; MDRin <= 0;
		end
		Reg_load3b: begin
		//  MDRout <= 1; R2in <= 1; 
		//  #15 MDRout <= 0; R2in <= 0; 
		end
		T0: begin // see if you need to de-assert these signals
			PCout <= 1;  MARin <= 1; IncPC <= 1;  Zin <= 1;
			#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
		end
		T1: begin
			Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
			Mdatain <= 32'h2A2B8000; // opcode for “and R4, R3, R7” // ignoring for now
			#15 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
		end
		T2: begin
			MDRout <= 1; IRin <= 1; 
			#15 MDRout <= 0; IRin <= 0;
		end
		T3: begin
			R3out <= 1; Yin <= 1; 	// R# goes into Y, then A, A >> B
			#15 Yin <= 0; R2out <= 0; 
		end
		T4: begin
			R7out <= 1; opcode <= 5'b01011; Zin <= 1; // opcode for shift left
			#15 opcode <= 5'bzzzzz; Zin <= 0; R7out <= 0;
		end
		T5: begin
			Zlowout <= 1; R4in <= 1; 
			#15 Zlowout <= 0; R4in <= 0;
		end

  endcase
end


// Test run length
initial
	begin
		#500 $finish;
	end

endmodule
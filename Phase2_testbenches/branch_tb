`timescale 1ns/10ps

module DataPath_tb; 
  	reg Clock, Clear, Read, IncPC, conIn;
	reg		R0out, R0in,
			R1out, R1in,
			R2out, R2in,
			R3out, R3in,
			R4out, R4in,
			R5out, R5in,
			R6out, R6in,
			R7out, R7in,
			R8out, R8in,  // R8 is return address register (RA)
			R9out, R9in,  // R9 is Stack Pointer (SP)
			R10out, R10in, R11out, R11in, R12out, R12in, R13out, R13in, // R10-13 are argument registers
			R14out, R14in, R15out, R15in,  // R14-15 are return value registers
			HIout, HIin, LOout, LOin, 
			Zhighout, Zlowout, Zin, Yin,
			MDRout, MDRin, MARin,
			PCout, PCin, IRin;
	reg [31:0] Mdatain;
	reg [4:0] opcode;
	reg Cout;  // Declaring Cout as a reg
	reg ANDSignal;  // FIXED: Renaming AND to ANDSignal and declaring it properly

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

  // Device Under Test instantiation
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
	.opcode(opcode),
	.conIn(conIn),
	.conOut(conOut)
  );
  
  //------------------------------

  // Clock generation
  initial begin
    Clock = 0;
    forever #10 Clock = ~Clock;
  end

  //------------------------------
  
  // State machine
  always @(posedge Clock) begin
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
      T5           : Present_state = T6;
    endcase
  end
 
 
 //used for manually testing all branch instructions
 
// conds from CPU specs : 
//--00: branch if zero brzr Ra, C
//--01: branch if nonzero brnz Ra, C
//--10: branch if positive brpl Ra, C
//--11: branch if negative brmi Ra, C 
 reg [1:0] c2; 
 
 
 
  always @(Present_state) begin
    case (Present_state)
		Default: begin
			PCout = 0; Zlowout = 0; MDRout = 0; // Initialize signals
			R2out = 0; R6out = 0; MARin = 0; Zin = 0; 
			PCin = 0; MDRin = 0; IRin = 0; Yin = 0; 
			IncPC = 0; Read = 0; ANDSignal = 0;  // FIXED: Using ANDSignal instead of AND
			R2in = 0; R6in = 0; R7in = 0; Mdatain = 32'h00000000; Clear = 0;
			HIin = 0; LOin = 0;
			opcode = 5'bzzzzz;
		end

		T0: begin
			Zin = 1; 
			PCout = 1;
			IncPC = 1;
			MARin = 1;
			#15 
			Zin = 0; 
			PCout = 0;
			IncPC = 0;
			MARin = 0;
		end
		
		T1: begin
			Zlowout = 1; 
			PCin = 1;
			Read = 1;
			MDRin = 1;
			#15
			Zlowout = 0; 
			PCin = 0;
			Read = 0;
			MDRin = 0;
		end

		T2: begin
			MDRout = 1; IRin = 1; 
			#15 MDRout = 0; IRin = 0;
		end
		
		T3: begin
			R1out = 1; 
			conIn = 1; // manually enabling for now
			c2 = 2'b00; // set to test brzr
			
			#15 
			conIn = 0; R1out = 0; 
		end
		
		T4: begin
			PCout = 1; Yin = 1;
			#15
			PCout = 0; Yin = 0;
		end
		
		T5: begin
			Cout = 1; 
			opcode = 5'b00011; // Opcode for ADD
			Zin = 1; // here we have calculated PC + 1 + C
			#15
			Cout = 0; 
			opcode = 5'bzzzzz; 
			Zin = 0;
		end

		T6: begin
			Zlowout = 1; 
			if (conOut)  // if the condition is satisfied
				PCin = 1; // branch taken
			#15 
			Zlowout = 0;
			PCin = 0; // De-assert after the delay    

		end
    endcase
  end

  // Monitor signals
  initial begin
	  $monitor("Time=%0d State=%b BusMuxOut=%h, BusMuxIn_MDR=%h MDRMuxOut=%h",
				  $time, Present_state, DUT.BusMuxOut, DUT.BusMuxIn_MDR, DUT.MDRMuxOut);
  end

  // Test run length
  initial begin
    #500 $finish;
  end

endmodule

module DataPath(
	input clock, clear, read, RAMwrite,
	// Temp control unit signals before Contorl Unit is created in Phase 3
			Gra, Grb, Grc, Rin, Rout, BAout,
			HIout, HIin,
			LOout, LOin,
			Zhighout, Zlowout, Zin, Yin,
			MDRout, MDRin, MARin,
			PCout, PCin, IRin, IncPC, Cout,
	output [31:0] Outport_Out, 
	input Out_portIn,
	input [31: 0] Inport_In,
	input [4:0] opcode,
	input Strobe
);


// Wires for the bus
wire [31:0]	BusMuxOut, 
			BusMuxIn_R0, 
			BusMuxIn_R1, 
			BusMuxIn_R2, 
			BusMuxIn_R3, 
			BusMuxIn_R4, 
			BusMuxIn_R5, 
			BusMuxIn_R6, 
			BusMuxIn_R7,
			BusMuxIn_R8, 
			BusMuxIn_R9, 
			BusMuxIn_R10,
			BusMuxIn_R11,
			BusMuxIn_R12,
			BusMuxIn_R13,
			BusMuxIn_R14, 
			BusMuxIn_R15, 
			BusMuxIn_MDR, 
			BusMuxIn_HI,
			BusMuxIn_LO,
			BusMuxIn_Zhigh, 
			BusMuxIn_Zlow, 
			C_sign_extended, 
			BusMuxIn_PC,
			MDRMuxOut, 
			Yout,
			IRout,
			BusMuxIn_InPort;
			
		// 16 32-bit registers control (out is to put it into the bus, in is to write to the register)
	// R0-7 General-purpose registers
wire 		R0out, R0in,
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
			R15out, R15in;
			
// Output of RAM, into MDRmux
wire [31:0] Mdatain;

// Select Encode Logic that reads instruction and outputs correct Register Out and In signal
select_encode selectEncode(.Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout), .instruction(IRout), 
		.R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in), .R8in(R8in), .R9in(R9in),
		.R10in(R10in), .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), .R15in(R15in),
		.R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out), .R8out(R8out), 
		.R9out(R9out), .R10out(R10out), .R11out(R11out), .R12out(R12out), .R13out(R13out), .R14out(R14out), .R15out(R15out), .C_sign_extended(C_signextended));


// Registers
register_R0 R0(clear, clock, R0in, BusMuxOut, BusMuxIn_R0);
register R1(clear, clock, R1in, BusMuxOut, BusMuxIn_R1);
register R2(clear, clock, R2in, BusMuxOut, BusMuxIn_R2);
register R3(clear, clock, R3in, BusMuxOut, BusMuxIn_R3);
register R4(clear, clock, R4in, BusMuxOut, BusMuxIn_R4);
register R5(clear, clock, R5in, BusMuxOut, BusMuxIn_R5);
register R6(clear, clock, R6in, BusMuxOut, BusMuxIn_R6);
register R7(clear, clock, R7in, BusMuxOut, BusMuxIn_R7);
register R8(clear, clock, R8in, BusMuxOut, BusMuxIn_R8);
register R9(clear, clock, R9in, BusMuxOut, BusMuxIn_R9);
register R10(clear, clock, R10in, BusMuxOut, BusMuxIn_R10);
register R11(clear, clock, R11in, BusMuxOut, BusMuxIn_R11);
register R12(clear, clock, R12in, BusMuxOut, BusMuxIn_R12);
register R13(clear, clock, R13in, BusMuxOut, BusMuxIn_R13);
register R14(clear, clock, R14in, BusMuxOut, BusMuxIn_R14);
register R15(clear, clock, R15in, BusMuxOut, BusMuxIn_R15);
register HI(clear, clock, HIin, BusMuxOut, BusMuxIn_HI);
register LO(clear, clock, LOin, BusMuxOut, BusMuxIn_LO);
register Y(clear, clock, Yin, BusMuxOut, Yout);

register Out_Port(clear, clock, Out_portIn, BusMuxOut, Outport_Out);
InPort In_port(clear, clock, Strobe, Inport_In, BusMuxIn_InPort);

// Memory Registers
mux2to1 MDR_Mux(read, Mdatain, BusMuxOut, MDRMuxOut);
register MDR(clear, clock, MDRin, MDRMuxOut, BusMuxIn_MDR);
register MAR(clear, clock, MARin, BusMuxOut, MARoutput);
// Use RAM from Library
RAM ram(.clock(clock), .memRead(read), .memWrite(RAMwrite), .address(MARoutput), .dataIn(MDRMuxOut), .dataOut(Mdatain));

register PC(clear, clock, PCin, BusMuxOut, BusMuxIn_PC);
register IR(clear, clock, IRin, BusMuxOut, IRout);

wire [63:0] Z_64;

// ALU alu(.A(Yout), .B(BusMuxOut), .C(Z_64),.opcode(Mdatain[31:27])); // Trying to decode Mdatain, ignore for now
ALU alu(.A(Yout), .B(BusMuxOut), .C(Z_64),.opcode(opcode));
register Zhi(clear, clock, Zin, Z_64[63:32], BusMuxIn_Zhigh);
register Zlo(clear, clock, Zin, Z_64[31:0], BusMuxIn_Zlow);

// Bus
Bus bus(
    // Register data inputs (32-bit)
    .BusMuxInR0(BusMuxIn_R0),
    .BusMuxInR1(BusMuxIn_R1),
    .BusMuxInR2(BusMuxIn_R2),
    .BusMuxInR3(BusMuxIn_R3),
    .BusMuxInR4(BusMuxIn_R4),
    .BusMuxInR5(BusMuxIn_R5),
    .BusMuxInR6(BusMuxIn_R6),
    .BusMuxInR7(BusMuxIn_R7),
    .BusMuxInR8(BusMuxIn_R8),
    .BusMuxInR9(BusMuxIn_R9),
    .BusMuxInR10(BusMuxIn_R10),
    .BusMuxInR11(BusMuxIn_R11),
    .BusMuxInR12(BusMuxIn_R12),
    .BusMuxInR13(BusMuxIn_R13),
    .BusMuxInR14(BusMuxIn_R14),
    .BusMuxInR15(BusMuxIn_R15),
    
    // Special register data inputs
    .BusMuxInMDR(BusMuxIn_MDR),
    .BusMuxInPC(BusMuxIn_PC),
    .BusMuxInZhigh(BusMuxIn_Zhigh),
    .BusMuxInZlow(BusMuxIn_Zlow),
    .BusMuxInHI(BusMuxIn_HI),
    .BusMuxInLO(BusMuxIn_LO),
    .BusMuxIn_InPort(BusMuxIn_InPort),
    .C_sign_extended(C_sign_extended),
    
    // Register output enable signals
    .R0out(R0out),
    .R1out(R1out),
    .R2out(R2out),
    .R3out(R3out),
    .R4out(R4out),
    .R5out(R5out),
    .R6out(R6out),
    .R7out(R7out),
    .R8out(R8out),
    .R9out(R9out),
    .R10out(R10out),
    .R11out(R11out),
    .R12out(R12out),
    .R13out(R13out),
    .R14out(R14out),
    .R15out(R15out),
    
    // Special register output enable signals
    .MDRout(MDRout),
    .HIout(HIout),
    .LOout(LOout),
    .Zhighout(Zhighout),
    .Zlowout(Zlowout),
    .PCout(PCout),
    .InPortout(InPortout),
    .Cout(Cout),
    
    // Output bus
    .BusMuxOut(BusMuxOut)
);


//con_ff logic
wire [1:0] c2 = IRout[20:19];
wire conOut; // The latched result
wire conIn;   // Will come from testbench or control

con_ff myConFF (
    .busIn(BusMuxOut),
    .c2(c2),
    .conIn(conIn),
    .clock(clock),
    .conOut(conOut)
);

endmodule
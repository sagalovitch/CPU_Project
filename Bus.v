module Bus (
	//Encoder
	input	R0out, 
			R1out,
			R2out,
			R3out,
			R4out,
			R5out,
			R6out,
			R7out,
			R8out,
			R9out,
			R10out,
			R11out,
			R12out,
			R13out,
			R14out,
			R15out, 
			MDRout,
			HIout,
			LOout,
			Zhighout,
			Zlowout,
			PCout,
			InPortout,
			Cout,
	//Mux
	input [31:0]	BusMuxInR0, 
					BusMuxInR1,
					BusMuxInR2,
					BusMuxInR3,
					BusMuxInR4,
					BusMuxInR5, 
					BusMuxInR6,
					BusMuxInR7,
					BusMuxInR8,
					BusMuxInR9,
					BusMuxInR10,
					BusMuxInR11,
					BusMuxInR12,
					BusMuxInR13,
					BusMuxInR14,
					BusMuxInR15,
					BusMuxInMDR,
					BusMuxIn_InPort, 
					C_sign_extended,
					BusMuxInZhigh,
					BusMuxInZlow,
					BusMuxInPC,
					BusMuxInHI,
					BusMuxInLO,
					
	output wire [31:0] BusMuxOut
);

reg [31:0] q;
 
always @(*) begin
	// Default case to prevent latches
  //q = 32'h00000000; 
  
  // Priority encoder structure
	if (R0out)   q = BusMuxInR0;
	if (R1out)   q = BusMuxInR1;
	if (R2out)   q = BusMuxInR2;
	if (R3out)   q = BusMuxInR3;
	if (R4out)   q = BusMuxInR4;
	if (R5out)   q = BusMuxInR5;
	if (R6out)   q = BusMuxInR6;
	if (R7out)   q = BusMuxInR7;
	if (R8out)   q = BusMuxInR8;
	if (R9out)   q = BusMuxInR9;
	if (R10out)  q = BusMuxInR10;
	if (R11out)  q = BusMuxInR11;
	if (R12out)  q = BusMuxInR12;
	if (R13out)  q = BusMuxInR13;
	if (R14out)  q = BusMuxInR14;
	if (R15out)  q = BusMuxInR15;
	if (MDRout)  q = BusMuxInMDR;
	if (HIout)   q = BusMuxInHI;
	if (LOout)   q = BusMuxInLO;
	if (Zhighout) q = BusMuxInZhigh;
	if (Zlowout) q = BusMuxInZlow;
	if (PCout)   q = BusMuxInPC;
	if (InPortout) q = BusMuxIn_InPort;
	if (Cout)    q = C_sign_extended;
end
 
assign BusMuxOut = q;
endmodule
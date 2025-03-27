//`timescale 1ns/10ps
//
//module DataPath_tb; 
//  	reg Clock, Clear, Read,
//			Gra, Grb, Grc, Rin, Rout, BAout,
//			HIout, HIin,
//			LOout, LOin,
//			Zhighout, Zlowout, Zin, Yin,
//			MDRout, MDRin, MARin,
//			PCout, PCin, IRin, IncPC, Cout;
//	reg [4:0] opcode;
//
//	parameter Default = 4'd0, 
//			  T0 = 4'd1, 
//			  T1 = 4'd2,
//			  T2 = 4'd3,
//			  T3 = 4'd4, 
//			  T4 = 4'd5,
//			  T5 = 4'd6;
//
//	reg [3:0] Present_state = Default;
//
//	DataPath DUT (
//		.clock(Clock),
//		.clear(Clear),
//		.read(Read),
//		.Gra(Gra), .Grb(Grb), .Grc(Grc), 
//		.BAout(BAout), .Rin(Rin), .Rout(Rout),
//		.HIout(HIout), .HIin(HIin),
//		.LOout(LOout), .LOin(LOin),
//		.Zhighout(Zhighout), .Zlowout(Zlowout),
//		.Zin(Zin), .Yin(Yin),
//		.MDRout(MDRout), .MDRin(MDRin),
//		.PCout(PCout), .PCin(PCin), .IRin(IRin),
//		.MARin(MARin), .IncPC(IncPC), .opcode(opcode), .Cout(Cout)
//
//	);
//
//	// Clock generation
//	initial begin
//		Clock = 0;
//		forever #10 Clock = ~Clock;
//	end
//
//	// State transitions
//	always @(posedge Clock) begin
//		case (Present_state)
//			Default:  Present_state = T0;
//			T0:       Present_state = T1;
//			T1:       Present_state = T2;
//			T2:       Present_state = T3;
//			T3:       Present_state = T4;
//			T4:       Present_state = T5;
//		endcase
//	end
//
//	// Control signals per state
//	always @(Present_state) begin
//		case (Present_state)
//			Default: begin
//				PCout <= 0; Zlowout <= 0; MDRout <= 0;
//				MARin <= 0; Zin <= 0; PCin <= 0; MDRin <= 0; IRin <= 0;
//				Yin <= 0; IncPC <= 0; Read <= 0; Clear <= 0; 
//				HIin <= 0; LOin <= 0; Cout <= 0;
//				Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0;
//				opcode <= 5'bzzzzz;
//			end
//
//			// Instruction Fetch
//			T0: begin
//				PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
//				#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0; Read <= 1;
//			end
//
//			T1: begin
//				Zlowout <= 1; PCin <= 1; MDRin <= 1;
//				#15 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
//			end
//
//			T2: begin
//				MDRout <= 1; IRin <= 1;
//				#15 MDRout <= 0; IRin <= 0;
//			end
//
//			// ADDI Instruction Execution
//			T3: begin
//				Grb <= 1; Rout <= 1; Yin <= 1;
//				#15 Grb <= 0; Rout <= 0; Yin <= 0;
//			end
//
//			T4: begin
//				Cout <= 1; Zin <= 1; opcode <= 5'b00011;  // ADD
//				#15 Cout <= 0; Zin <= 0; opcode <= 5'bzzzzz;
//			end
//
//			T5: begin
//				Zlowout <= 1; Gra <= 1; Rin <= 1;  // Store to R5
//				#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
//			end
//		endcase
//	end
//
//	// Simulation time
//	initial begin
//		#500 $finish;
//	end
//
//endmodule

module control_unit (
	output reg Gra, Grb, Grc, Rin, Rout, BAout,
	HIout, HIin, LOout, LOin, Zhighout, Zlowout, 
	Zin, Yin, MDRout, MDRin, MARin, PCout, CONin, 
	PCin, IRin, Out_portIn, conIn, Read, Write, Run, Clear,
	input [31:0] IR,
	input Clock, Reset, Stop, conOut
);

parameter reset_state = 8'h0, fetch0 = 8'h1, fetch1 = 8'h2, fetch2 = 8'h3, 
			add3 = 8'h4, add4 = 8'h5, add5 = 8'h6, sub3 = 8'h7, sub4 = 8'h8, sub5 = 8'h9,
			mul3 = 8'hA, mul4 = 8'hB, mul5 = 8'hC, mul6 = 8'hD, div3 = 8'hE, div4 = 8'hF,
			div5 = 8'h10, div6 = 8'h11, or3 = 8'h12, or4 = 8'h13, or5 = 8'h14, and3 = 8'h15, 
			and4 = 8'h16, and5 = 8'h17, shl3 = 8'h18, shl4 = 8'h19, shl5 = 8'h1A, shr3 = 8'h1B,
			shr4 = 8'h1C, shr5 = 8'h1D, rol3 = 8'h1E, rol4 = 8'h1F, rol5 = 8'h20, ror3 = 8'h21,
			ror4 = 8'h22, ror5 = 8'h23, neg3 = 8'h24, neg4 = 8'h25, neg5 = 8'h26, not3 = 8'h27,
			not4 = 8'h28, not5 = 8'h29, ld3 = 8'h2A, ld4 = 8'h2B, ld5 = 8'h2C, ld6 = 8'h2D, 
			ld7 = 8'h2E, ldi3 = 8'h2F, ldi4 = 8'h30, ldi5 = 8'h31, st3 = 8'h32, st4 = 8'h33,
			st5 = 8'h34, st6 = 8'h35, st7 = 8'h36, addi3 = 8'h37, addi4 = 8'h38, addi5 = 8'h39,
			andi3 = 8'h3A, andi4 = 8'h3B, andi5 = 8'h3C, ori3 = 8'h3D, ori4 = 8'h3E, ori5 = 8'h3F,
			br3 = 8'h40, br4 = 8'h41, br5 = 8'h42, br6 = 8'h43, jr3 = 8'h44, jal3 = 8'h45, 
			jal4 = 8'h46, mfhi3 = 8'h47, mflo3 = 8'h48, in3 = 8'h49, out3 = 8'h4A, nop3 = 8'h4B, 
			halt3 = 8'h4C, shra3 = 8'h4D, shra4 = 8'h4E, shra5 = 8'h4F;

reg [7:0] present_state = reset_sate;

always @ (posedge Clock, posedge Reset, posedge Stop) 
	begin
		if(Reset == 1'b1) present_state = reset_state;
		if(stop == 1) present_state = halt3;
		else 
			case (present_state) 
				reset_state: present_state = fetch0;
				fetch0: present_state = fetch1;
				fetch1: present_state = fetch2;
				fetch2: begin
					case (IR[31:27]) // inst. decoding bvased on opcode (also found in ALU.v) to set next state
						5'b00011: present_state = add3;
						5'b00100: present_state = sub3;
						5'b00101: present_state = and3;
						5'b00110: present_state = or3;
						5'b00111: present_state = ror3;
						5'b01000: present_state = rol3;
						5'b01001: present_state = shr3;
						5'b01010: present_state = shra3;
						5'b01011: present_state = shl3;
						5'b01100: present_state = addi3;
						5'b01101: present_state = andi3;
						5'b01110: present_state = ori3;
						5'b01111: present_state = div3;
						5'b10000: present_state = mul3;
						5'b10001: present_state = neg3;
						5'b10010: present_state = not3;
					endcase
				end
				
				// Go to reset state after each instruction is completed to de-assert all relevant signals
				// Memory Ops
				ld3: present_state = ld4;
				ld4: present_state = ld5;
				ld5: present_state = ld6;
				ld6: present_state = ld7;
				ld7: present_state = reset_state;
				
				ldi3: present_state = ldi4;
				ldi4: present_state = ldi5;
				ldi5: present_state = reset_state;
				
				st3: present_state = st4;
				st4: present_state = st5;
				st5: present_state = st6;
				st6: present_state = st7;
				st7: present_state = reset_state;
				
				br3: present_state = br4;
				br4: present_state = br5; 
				br5: present_state = br6;
				br6: present_state = reset_state;
				
				jal3: present_state = jal4;
				jal4: present_state = reset_state;
			
				jr3: present_state = reset_state;
				
				out3: present_state = reset_state;
			
				in3: present_state = reset_state;
				
				mflo3: present_state = reset_state;
				
				mfhi3: present_state = reset_state;

				nop3:  present_state = reset_state;
				
				// ALu
				
				add3: present_state = add4;
				add4: present_state = add5;
				add5: present_state = reset_state;
				
				addi3: present_state = addi4;
				addi4: present_state = addi5;
				addi5: present_state = reset_state;
				
				sub3: present_state = sub4;
				sub4: present_state = sub5;
				sub5: present_state = reset_state;
				
				mul3: present_state = mul4;
				mul4: present_state = mul5;
				mul5: present_state = mul6;
				mul6: present_state = reset_state; 
				
				div3: present_state = div4;
				div4: present_state = div5;
				div5: present_state = div6;
				div6: present_state = reset_state;
				
				or3: #resent_state = or4;
				or4: #resent_state = or5;
				or5: #resent_state = reset_state;
				
				and3: present_state = and4;
				and4: present_state = and5;
				and5: present_state = reset_state;
				
				shl3: present_state = shl4;
				shl4: present_state = shl5;
				shl5: present_state = reset_state;
				
				shr3: present_state = shr4;
				shr4: present_state = shr5;
				shr5: present_state = reset_state;
				
				rol3: present_state = rol4;
				rol4: present_state = rol5;
				rol5: present_state = reset_state;
				
				ror3: present_state = ror4;
				ror4: present_state = ror5;
				ror5: present_state = reset_state;
				
				neg3: present_state = neg4;
				neg4: present_state = reset_state;
				
				not3: present_state = not4;
				not4: present_state = reset_state;

				andi3: present_state = andi4;
				andi4: present_state = andi5;
				andi5: present_state = reset_state;
				
				ori3: present_state = ori4;
				ori4: present_state = ori5;
				ori5: present_state = reset_state;
			endcase
	end

	
// Insert testbenches that we created here
always @ (present_state) // do task for each state
begin 
	case (present_state)
		reset_state: begin
			Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0;
			HIout <= 0; HIin <= 0; LOout <= 0; LOin <= 0; Zhighout <= 0; Zlowout <= 0; 
			Zin <= 0; Yin <= 0; MDRout <= 0; MDRin <= 0; MARin <= 0; PCout <= 0; CONin <= 0;
			PCin <= 0; IRin <= 0; Out_portIn <= 0; conIn <= 0; Read <= 0; Write <= 0; Run <= 0; Clear <= 0;
		end
		fetch0: begin
			PCout <= 1;  MARin <= 1; IncPC <= 1;  Zin <= 1; 
			#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0; Read <= 1;
		end
		fetch1: begin
			Zlowout <= 1; PCin <= 1; MDRin <= 1;
			#15 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;\
		end
		fetch2: begin
			MDRout <= 1; IRin <= 1; 
			#15 MDRout <= 0; IRin <= 0;
		end
		//-------------------------------------------
		and3: begin
	
		end
		and4: begin
		
		end
		and5: begin
		
		end
		//-------------------------------------------
	endcase
end
endmodule
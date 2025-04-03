`timescale 1ns/10ps
module control_unit (
	output reg Gra, Grb, Grc, Rin, Rout, BAout,
	HIout, HIin, LOout, LOin, Zhighout, Zlowout, 
	Zin, Yin, MDRout, MDRin, MARin, PCout, 
	PCin, IRin, Out_portIn, InPortout, conIn, Read, Write, Run, R8_RAin, IncPC, Cout,
	input [31:0] IR,
	input Clock, Stop, conOut, Clear
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

reg [7:0] present_state = reset_state;

always @ (posedge Clock, posedge Clear, posedge Stop) 
	begin
		if(Clear == 1'b1) present_state = reset_state;
		if(Stop == 1) present_state = halt3;
		else 
			case (present_state) 
				reset_state: present_state = fetch0;
				fetch0: present_state = fetch1;
				fetch1: present_state = fetch2;
				fetch2: begin
					case (IR[31:27]) // inst. decoding bvased on opcode (also found in ALU.v) to set next state
						5'b00000: present_state = ld3;
						5'b00001: present_state = ldi3;
						5'b00010: present_state = st3;
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
						5'b10011: present_state = br3;
						5'b10100: present_state = jal3;
						5'b10101: present_state = jr3;
						5'b10110: present_state = in3;
						5'b10111: present_state = out3;
						5'b11000: present_state = mflo3;
						5'b11001: present_state = mfhi3;
						5'b11010: present_state = nop3;
						5'b11011: present_state = halt3;
						
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
				
				or3: present_state = or4;
				or4: present_state = or5;
				or5: present_state = reset_state;
				
				and3: present_state = and4;
				and4: present_state = and5;
				and5: present_state = reset_state;
				
				shl3: present_state = shl4;
				shl4: present_state = shl5;
				shl5: present_state = reset_state;
				
				shr3: present_state = shr4;
				shr4: present_state = shr5;
				shr5: present_state = reset_state;
				
				shra3: present_state = shra4;
				shra4: present_state = shra5;
				shra5: present_state = reset_state;
				
				rol3: present_state = rol4;
				rol4: present_state = rol5;
				rol5: present_state = reset_state;
				
				ror3: present_state = ror4;
				ror4: present_state = ror5;
				ror5: present_state = reset_state;
				
				neg3: present_state = neg4;
				neg4: present_state = neg5;
				neg5: present_state = reset_state;
				
				not3: present_state = not4;
				not4: present_state = not5;
				not5: present_state = reset_state;

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
			Zin <= 0; Yin <= 0; MDRout <= 0; MDRin <= 0; MARin <= 0; PCout <= 0; conIn <= 0;
			PCin <= 0; IRin <= 0; Out_portIn <= 0; conIn <= 0; Read <= 0; Write <= 0;
		end
		fetch0: begin
			PCout <= 1;  MARin <= 1; IncPC <= 1;  Zin <= 1; 
			#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0; Read <= 1;
		end
		fetch1: begin
			MDRin <= 1; // PCin <= 1;
			#15 Read <= 0; MDRin <= 0; // PCin <= 0;
		end
		fetch2: begin
			MDRout <= 1; IRin <= 1; 
			#15 MDRout <= 0; IRin <= 0;
		end
		
		// changes below here 
		
		// below are the testbenches for all modules implemented in phase 1
		
		add3, sub3: begin
			 Grb <= 1;  // replaced direct register with grb
			 Rout <= 1;Yin <= 1;
			 #15 Grb <= 0;Rout <= 0;Yin <= 0;
		end

		add4, sub4: begin
			 Grc <= 1;  
			 Rout <= 1;
			 Zin <= 1;
			 #15
			 Zin <= 0; Grc <= 0;Rout <= 0;
		end

		add5, sub5: begin
			 Zlowout <= 1; Gra <= 1;Rin <= 1;
			 #15
			 Zlowout <= 0; Gra <= 0;Rin <= 0;			 
		end
		
		//--------------------------------------------
		
		mul3, div3: begin
			 Gra <= 1;Rout <= 1;Yin <= 1;
			 #15
			 Gra <= 0;Rout <= 0;Yin <= 0;
		end

		mul4, div4: begin
			 Grb <= 1;  
			 Rout <= 1;
			 Zin <= 1;
			 #15
			 Grb <= 0;Rout <= 0;Zin <= 0; 
		end

		mul5, div5: begin
			 Zlowout <= 1;
			 LOin <= 1;  
			 #15 Zlowout <= 0; LOin <= 0;
		end

		mul6, div6: begin
			 Zhighout <= 1;
			 HIin <= 1;
			 #15 Zhighout <= 0; HIin <= 0;

		end
		//--------------------------------------------
		
		and3, or3, rol3, ror3, shl3, shr3, shra3: begin
			Grb <= 1; Rout <= 1; Yin <= 1;
			#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end
		
		and4, or4, rol4, ror4, shl4, shr4, shra4: begin
			Grc <= 1; Rout <= 1; Zin <= 1;
			#15 Grc <= 0; Rout <= 0; Zin <= 0;
		end
		
		and5, or5, rol5, ror5, shl5, shr5, shra5: begin
			Zlowout <= 1; Gra <= 1; Rin <= 1;
			#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
		//-------------------------------------------
		
		neg3, not3: begin
			Grb <= 1; Rout <= 1; Yin <= 1;
			#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end

		neg4, not4: begin
			Zin <= 1;
			#15 Zin <= 0;
		end

		neg5, not5: begin
			Zlowout <= 1; Gra <= 1; Rin <= 1;
			#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
		
		//-------------------------------------------
		
		
		// below are the testbenches for all modules implemented in phase 2
		
		
		//-------------------------------------------
		addi3: begin
			Grb <= 1; Rout <= 1; Yin <= 1;
			#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end

		addi4: begin
			Cout <= 1; Zin <= 1; 
			#15 Cout <= 0; Zin <= 0;
		end

		addi5: begin
			Zlowout <= 1; Gra <= 1; Rin <= 1;
			#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
		//-------------------------------------------
		
		
		andi3: begin
			Grb <= 1; Rout <= 1; Yin <= 1;
			#15 Grb <= 0; Rout <= 0; Yin <= 0;
		end

		andi4: begin
			Cout <= 1; Zin <= 1;
			#15 Cout <= 0; Zin <= 0; 
		end

		andi5: begin
			Zlowout <= 1; Gra <= 1; Rin <= 1;
			#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
		//-------------------------------------------
		
		br3: begin  
			Gra   <= 1;
			Rout  <= 1;
			conIn <= 1;
			#15 Gra <= 0; Rout <= 0;
		end

		br4: begin 
			//conIn <= 0;
			PCout <= 1;
			Yin   <= 1;
			#15 PCout <= 0; Yin <= 0;
		end

		br5: begin 
			Cout   <= 1;
			Zin    <= 1;
			#15 Cout <= 0; Zin <= 0;
		end

		br6: begin  
			Zlowout <= 1;
			if (conOut)
				PCin <= 1;
			else
				PCin <= 0;
			#15 Zlowout <= 0; PCin <= 0; conIn <= 0;
		end
		//-------------------------------------------

		
		//what's R8_RAin? It's the return address register signal
		
		  jal3: begin
            PCout   <= 1; 
            R8_RAin <= 1;        
            #15;
            PCout   <= 0;
            R8_RAin <= 0;
        end

        jal4: begin
            Gra   <= 1;
            Rout  <= 1;
            PCin  <= 1;         
            #15;
            Gra   <= 0;
            Rout  <= 0;
            PCin  <= 0;
        end
		
		//-------------------------------------------
		
		jr3: begin
			Gra   <= 1;
			Rout  <= 1;
			PCin  <= 1;
			#15;
			Gra   <= 0;
			Rout  <= 0;
			PCin  <= 0;
		end

		//-------------------------------------------
		ld3: begin
			Grb   <= 1;
			Rout 	<= 1;
			Yin   <= 1;
			#15;
			Grb   <= 0;
			Rout <= 0;
			Yin   <= 0;
		end

		ld4: begin 
			Cout   <= 1;
			Zin    <= 1;
			#15;
			Cout   <= 0;
			Zin    <= 0;
		end

		ld5: begin 
			Zlowout <= 1;
			MARin   <= 1;
			#15;
			Zlowout <= 0;
			MARin   <= 0;
			Read    <= 1;
		end

		ld6: begin
			MDRin <= 1;
			#15;
			Read  <= 0;
			MDRin <= 0;
		end

		ld7: begin 
			MDRout <= 1;
			Gra    <= 1;
			Rin    <= 1;
			#15;
			MDRout <= 0;
			Gra    <= 0;
			Rin    <= 0;
		end

		//--------------------------------------------

		ldi3: begin
			Grb <= 1; BAout <= 1; Yin <= 1;
			#15 Grb <= 0; BAout <= 0; Yin <= 0;
		end

		ldi4: begin
			Cout <= 1; Zin <= 1; 
			#15 Cout <= 0; Zin <= 0; 
		end

		ldi5: begin
			Zlowout <= 1; Gra <= 1; Rin <= 1;
			#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end
		
		
		//--------------------------------------------
		mfhi3: begin
		  HIout <= 1; Gra <= 1; Rin <= 1;
		  #15 HIout <= 0; Gra <= 0; Rin <= 0;
		end

		//--------------------------------------------

		mflo3: begin
		  LOout <= 1; Gra <= 1; Rin <= 1;
		  #15 LOout <= 0; Gra <= 0; Rin <= 0;
		end

		
		//--------------------------------------------

		ori3: begin
			Gra <= 0; Grb <= 1; Grc <= 0;
			Rout <= 1; Yin <= 1;
			#15 Rout <= 0; Yin <= 0; Grb <= 0;
		end

		ori4: begin
			Cout <= 1; Zin <= 1; 
			#15 Cout <= 0; Zin <= 0;
		end

		ori5: begin
			Zlowout <= 1; Gra <= 1; Rin <= 1;
			#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
		end

		
		//--------------------------------------------
		
		st3: begin 
			Gra <= 0; Grb <= 1; Grc <= 0;
			BAout <= 1; Yin <= 1;
			#15 BAout <= 0; Yin <= 0;
		end

		st4: begin
			Cout <= 1; Zin <= 1;
			#15 Cout <= 0; Zin <= 0;
		end

		st5: begin
			Zlowout <= 1; MARin <= 1;
			#15 Zlowout <= 0; MARin <= 0;
		end

		st6: begin
			Gra <= 1; Rout <= 1; MDRin <= 1;
			#15 Gra <= 0; Rout <= 0; MDRin <= 0; Write <= 1;
		end

		st7: begin
			MDRout <= 1;
			#15 MDRout <= 0; Write <= 0;
		end

		//--------------------------------------------
		
		in3: begin
		  Gra <= 1;  // Select R3 as indicated by the instruction field in IR.
        Rin <= 1;  // Load the bus data into R3.
		  InPortout <= 1;
		  #15 Gra <= 0; Rin <= 0; InPortout <= 0;  
		end
		
		//--------------------------------------------
		
		out3: begin
			Gra <= 1; Rout <= 1; Out_portIn <= 1;		
			#15 Gra <= 0; Rout <= 0; Out_portIn <= 0;
		end
		
		//--------------------------------------------
		
		nop3: begin
			// Do nothing
		end
		
		//--------------------------------------------
		
		halt3: begin
			Run <= 0;
		end
		
		//--------------------------------------------
		
		default: begin
			// Do nothing
		end
		
	endcase
end
endmodule

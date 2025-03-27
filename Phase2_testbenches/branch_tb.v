`timescale 1ns/10ps

module DataPath_tb; 
   reg  Clock, Clear, Read,
        Gra, Grb, Grc, Rin, Rout, BAout,
        HIout, HIin,
        LOout, LOin,
        Zhighout, Zlowout, Zin, Yin,
        MDRout, MDRin, MARin,
        PCout, PCin, IRin, IncPC, Cout,
        conIn;         
   wire conOut;        
   reg [4:0] opcode;   


   parameter Default = 4'd0, 
             T0 = 4'd1,
             T1 = 4'd2,
             T2 = 4'd3,
             T3 = 4'd4,
             T4 = 4'd5,
             T5 = 4'd6,
             T6 = 4'd7;

   reg [3:0] Present_state = Default;


   DataPath DUT (
       .clock(Clock),
       .clear(Clear),
       .read(Read),
       // Register‐select signals
       .Gra(Gra), .Grb(Grb), .Grc(Grc), 
       .BAout(BAout), .Rin(Rin), .Rout(Rout),
       // Special registers 
       .HIout(HIout), .HIin(HIin),
       .LOout(LOout), .LOin(LOin),
       .Zhighout(Zhighout), .Zlowout(Zlowout),
       .Zin(Zin), .Yin(Yin),
       .MDRout(MDRout), .MDRin(MDRin),
       .PCout(PCout), .PCin(PCin), .IRin(IRin),
       .MARin(MARin), .IncPC(IncPC),
       .opcode(opcode),
       .Cout(Cout),

       // Branch/CON signals
       .conIn(conIn),
       .conOut(conOut)
   );

   initial begin
      Clock = 0;
      forever #10 Clock = ~Clock;
   end


   always @(posedge Clock) begin
      case (Present_state)
         Default :  Present_state = T0;
         T0      :  Present_state = T1;
         T1      :  Present_state = T2;
         T2      :  Present_state = T3;
         T3      :  Present_state = T4;
         T4      :  Present_state = T5;
         T5      :  Present_state = T6;
      endcase
   end


   always @(Present_state) begin
      case (Present_state)


         Default: begin
            PCout    <= 0;   Zlowout <= 0;  MDRout  <= 0;
            MARin    <= 0;   Zin     <= 0;  
            PCin     <= 0;   MDRin   <= 0;  IRin    <= 0;    Yin <= 0; 
            IncPC    <= 0;   Read    <= 0;  Clear   <= 0;
            HIin     <= 0;   LOin    <= 0;
            opcode   <= 5'bzzzzz; 
            Gra      <= 0;   Grb     <= 0;  Grc     <= 0;
            BAout    <= 0;   Rin     <= 0;  Rout    <= 0;
            Cout     <= 0;
            conIn    <= 0;   // disable condition-latch
         end

         T0: begin
            PCout  <= 1;
            MARin  <= 1;
            IncPC  <= 1;
            Zin    <= 1;
            #15; 
            // De‐assert
            PCout  <= 0;
            MARin  <= 0;
            IncPC  <= 0;
            Zin    <= 0;
				Read <= 1;
         end

         T1: begin
            Zlowout <= 1;
            PCin    <= 1;
            MDRin   <= 1;
            #15;
            Zlowout <= 0;
            PCin    <= 0;
            Read    <= 0; 
            MDRin   <= 0;
         end
   
         T2: begin
            MDRout <= 1;
            IRin   <= 1;
            #15;
            MDRout <= 0;
            IRin   <= 0;
         end

         // T3: (Condition Check step) ---> brzr R1, #C
         T3: begin
            Gra   <= 1;  
            Rout  <= 1;   
            conIn <= 1;   
            #15;
            Gra   <= 0;   
            Rout  <= 0;               
         end

         T4: begin
				conIn <= 0;  
            PCout <= 1;
            Yin   <= 1;
            #15;
            PCout <= 0;
            Yin   <= 0;
         end

         // T5: add sign‐extended C to PC + 1 => Z
         T5: begin
            Cout   <= 1;         
            opcode <= 5'b00011;  // Add opcode
            Zin    <= 1;
            #15;
            Cout   <= 0;
            opcode <= 5'bzzzzz; 
            Zin    <= 0;
         end

         T6: begin
            Zlowout <= 1;
				if (conOut == 1'b1)
					PCin <= 1;
				else
					PCin <= 0;       
            #15;
            Zlowout <= 0;
            PCin    <= 0;       
         end

      endcase
   end


   initial begin
      #500 $finish;
   end

endmodule

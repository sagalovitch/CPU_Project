`timescale 1ns/10ps

module Bus_tb;
    // Test signals
    reg clock, clear, read;
    reg R3out, R4in, R7out, R2in, R7in, MDRout, R3in; 
    reg [31:0] Mdatain;
    reg [31:0] out;
    
    // Test data
    reg [31:0] test_data_1 = 32'hAAAAAAAA;
    reg [31:0] test_data_2 = 32'h55555555;
    
    // Test states
    parameter DEFAULT = 4'b0000,
              LOAD_R3 = 4'b0001,
              TRANSFER_R3_TO_R4 = 4'b0010,
              LOAD_R7 = 4'b0011,
              TRANSFER_R7_TO_R2 = 4'b0100;
              
    reg [3:0] Present_state = DEFAULT;
    
    // Initialize DUT
    DataPath DUT(
        // Clock signal
        .clock(clock),
        .clear(clear),
        
        
        // Register output controls (Input to Mux to select output)
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

        // Register input controls (What enables to register to be written to)
        .R0in(R0in),
        .R1in(R1in),
        .R2in(R2in),
        .R3in(R3in),
        .R4in(R4in),
        .R5in(R5in),
        .R6in(R6in),
        .R7in(R7in),
        .R8in(R8in),
        .R9in(R9in),
        .R10in(R10in),
        .R11in(R11in),
        .R12in(R12in),
        .R13in(R13in),
        .R14in(R14in),
        .R15in(R15in),

        // Special Registers controls (Memory Data Register, High Register, Low Register, etc.)
        .MDRout(MDRout),
        .MDRin(MDRin),
        .Zhighout(Zhighout),
        .Zlowout(Zlowout),
        .PCout(PCout),
        .Zin(Zin),
        .PCin(PCin),

        // Read is for MDR Mux
        .Read(read),

        // Output to test

    );
    
 // Clock generation
 initial begin
	  clock = 0;
	  forever #10 clock = ~clock;
 end
 
	
 // Test sequence
 always @ (posedge clock) begin
	  case (Present_state)
		DEFAULT			    : Present_state = LOAD_R3;
		LOAD_R3			    : Present_state = TRANSFER_R3_TO_R4;
		TRANSFER_R3_TO_R4   : Present_state = LOAD_R7;
		LOAD_R7			    : Present_state = TRANSFER_R7_TO_R2;
	 endcase
 end
 
 always @ (Present_state) begin
	case (Present_state)
	    DEFAULT: begin
            clear = 1;
            {R3out, R4in, R7out, R2in, R3in, R7in, R2in, MDRout} <= 0;
            // Load contents into Mdatain and push into MDR Mux
            Mdatain <= test_data_1; read <= 1; 
            #5 clear <= 0; read <= 0;

        end
        LOAD_R3: begin
            // Use MDR to load data
            MDRout <= 1;
            #1 R3in <= 1;
            #5 MDRout <= 0; R3in <= 0;
        end
        TRANSFER_R3_TO_R4: begin
            // Transfer R3 to R4
            R3out <= 1; R4in <= 1;
            #5 R3out <= 0; R4in <= 0;
        end
        LOAD_R7: begin
            // Load test_data_2 into R7
            Mdatain <= test_data_2; read <= 1; MDRout <= 1; R7in <= 1;
            #5 read <= 0;  MDRout <= 0; R7in <= 0;
        end
        TRANSFER_R7_TO_R2: begin
            // Transfer R7 to R2
            R7out <= 1; R2in <= 1;
            #5 R7out <= 0; R2in <= 0;
        end
    endcase
	
		
 
 end
 
 // Monitor signals
 initial begin
	  $monitor("Time=%0d State=%b R3out=%b R4in=%b BusMuxOut=%h, ",
				  $time, Present_state, R3out, R4in, DUT.BusMuxOut);
 end

	// Test run length
  initial
  begin
    #500 $finish;
  end
    
endmodule
`timescale 1ns/10ps

module not32_tb;
    reg [31:0] Ra;
    wire [31:0] Rb;

    
    not32 DUT (
        .Ra(Ra),
        .Rb(Rb)
    );

    initial begin
        $display("Time (ns)\tRa (Hex) \t\t Rb (Hex)");
        
        // Test Case 1: All zeros should invert to all ones.
        Ra = 32'h00000000; #10;
        $display("%0dns:\t %h \t %h", $time, Ra, Rb);
        
        // Test Case 2: All ones should invert to all zeros.
        Ra = 32'hFFFFFFFF; #10;
        $display("%0dns:\t %h \t %h", $time, Ra, Rb);
        
        // Test Case 3: Alternating bits (0xAAAAAAAA) should invert to 0x55555555.
        Ra = 32'hAAAAAAAA; #10;
        $display("%0dns:\t %h \t %h", $time, Ra, Rb);
        
        // Test Case 4: Alternating bits (0x55555555) should invert to 0xAAAAAAAA.
        Ra = 32'h55555555; #10;
        $display("%0dns:\t %h \t %h", $time, Ra, Rb);
        
        $finish;
    end
endmodule

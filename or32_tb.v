`timescale 1ns/10ps

module or32_tb;
    reg [31:0] Ra, Rb;
    wire [31:0] Rz;
	 
    or32 DUT (
        .Ra(Ra),
        .Rb(Rb),
        .Rz(Rz)
    );

    initial begin
        $display("Time(ns) \t Ra \t\t\t Rb \t\t\t Rz (OR result)");
        
        // Test 1: Both Zero
        Ra = 32'h00000000; Rb = 32'h00000000; #10;
        $display("%0dns:\t %h \t %h \t %h", $time, Ra, Rb, Rz);
        
        // Test 2: One Zero, One Nonzero
        Ra = 32'hFFFFFFFF; Rb = 32'h00000000; #10;
        $display("%0dns:\t %h \t %h \t %h", $time, Ra, Rb, Rz);
        
        // Test 3: Both All Ones
        Ra = 32'hFFFFFFFF; Rb = 32'hFFFFFFFF; #10;
        $display("%0dns:\t %h \t %h \t %h", $time, Ra, Rb, Rz);
        
        // Test 4: Alternating Bits
        Ra = 32'hAAAAAAAA; Rb = 32'h55555555; #10;
        $display("%0dns:\t %h \t %h \t %h", $time, Ra, Rb, Rz);
        
        // Test 5: Random Pattern
        Ra = 32'h12345678; Rb = 32'h87654321; #10;
        $display("%0dns:\t %h \t %h \t %h", $time, Ra, Rb, Rz);
        
        $finish;
    end
endmodule

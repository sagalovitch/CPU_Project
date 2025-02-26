`timescale 1ns/10ps

module neg_tb;
    reg signed [31:0] A;
    wire signed [31:0] Neg;
	 
    neg DUT (
        .a(A),
        .b(Neg)
    );

    initial begin
        $display("Time (ns)\tA (Hex/Dec)\tNeg (Hex/Dec)");
        
        // Test Case 1: Zero
        A = 32'd0;
        #10;
        $display("%0dns:\t%h (%0d) \t%h (%0d)", $time, A, A, Neg, Neg);

        // Test Case 2: Small Positive Number
        A = 32'd5;
        #10;
        $display("%0dns:\t%h (%0d) \t%h (%0d)", $time, A, A, Neg, Neg);

        // Test Case 3: Small Negative Number
        A = -32'd5;
        #10;
        $display("%0dns:\t%h (%0d) \t%h (%0d)", $time, A, A, Neg, Neg);

        // Test Case 4: Maximum Positive Value (2147483647)
        A = 32'h7FFFFFFF;
        #10;
        $display("%0dns:\t%h (%0d) \t%h (%0d)", $time, A, A, Neg, Neg);

        // Test Case 5: Minimum Negative Value (-2147483648)
        A = 32'h80000000;
        #10;
        $display("%0dns:\t%h (%0d) \t%h (%0d)", $time, A, A, Neg, Neg);

        // Test Case 6: Random Value
        A = 32'h12345678;
        #10;
        $display("%0dns:\t%h (%0d) \t%h (%0d)", $time, A, A, Neg, Neg);

        $finish;
    end

endmodule

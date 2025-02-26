`timescale 1ns/10ps

module shr32_tb;
    reg [31:0] in;
    reg [4:0] shamt;
    wire [31:0] out;

	shr32 DUT (
		 .Ra(in),
		 .shift_amt(shamt),
		 .result(out)
	);


    initial begin
        $display("Time (ns)\tin\t\tshamt\tout");
        // Case 1: Shift 0 bits on zero
        in = 32'h00000000; shamt = 5'd0; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 2: Shift 0 bits on nonzero value
        in = 32'hF0F0F0F0; shamt = 5'd0; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 3: Shift 4 bits
        in = 32'hF0F0F0F0; shamt = 5'd4; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 4: Shift maximum (31 bits)
        in = 32'hAAAAAAAA; shamt = 5'd31; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 5: Boundary test
        in = 32'h80000001; shamt = 5'd1; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        $finish;
    end
endmodule

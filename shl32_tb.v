`timescale 1ns/10ps

module shl32_tb;
    reg [31:0] in;
    reg [4:0] shamt;
    wire [31:0] out;

	shl32 DUT (
		 .Ra(in),
		 .shift_amt(shamt),
		 .result(out)
	);


    initial begin
        $display("Time (ns)\tin\t\tshamt\tout");
        // Case 1: Shift 0 bits
        in = 32'h00000001; shamt = 5'd0; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 2: Shift 4 bits
        in = 32'h00000001; shamt = 5'd4; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 3: Shift 8 bits on a random pattern
        in = 32'h12345678; shamt = 5'd8; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 4: Shift maximum (31 bits) on all ones
        in = 32'hFFFFFFFF; shamt = 5'd31; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        $finish;
    end
endmodule

`timescale 1ns/10ps

module rol32_tb;
    reg [31:0] in;
    reg [4:0] shamt;
    wire [31:0] out;

	 rol32 DUT (
 		 .Ra(in),
 		 .shift_amt(shamt),
		 .result(out)
		);


    initial begin
        $display("Time (ns)\tin\t\tshamt\tout");
        // Case 1: Rotate 0 bits
        in = 32'hF0F0F0F0; shamt = 5'd0; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 2: Rotate 4 bits
        in = 32'hF0F0F0F0; shamt = 5'd4; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 3: Rotate 16 bits
        in = 32'h12345678; shamt = 5'd16; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 4: Rotate by 31 bits
        in = 32'hAAAAAAAA; shamt = 5'd31; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        $finish;
    end
endmodule

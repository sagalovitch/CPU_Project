`timescale 1ns/10ps

module shra32_tb;
    reg signed [31:0] in;
    reg [4:0] shamt;
    wire signed [31:0] out;

    shra32 DUT (
         .Ra(in),
         .shift_amt(shamt),
         .result(out)
    );

    initial begin
        $display("Time (ns)\tin\t\tshamt\tout");
        // Case 1: Positive value, no shift
        in = 32'h7FFFFFFF; shamt = 5'd0; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 2: Positive value, shift 4 bits
        in = 32'h7FFFFFFF; shamt = 5'd4; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 3: Negative value, no shift
        in = -32'd10; shamt = 5'd0; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 4: Negative value, shift 4 bits
        in = -32'd10; shamt = 5'd4; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        // Case 5: Negative value, shift maximum (31)
        in = -32'd1; shamt = 5'd31; #10;
        $display("%0dns:\t%h\t%d\t%h", $time, in, shamt, out);
        $finish;
    end
endmodule

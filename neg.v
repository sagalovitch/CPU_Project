// neg module
module neg (input [31:0] a, output [31:0] b);

assign b = ~a + 1;

endmodule
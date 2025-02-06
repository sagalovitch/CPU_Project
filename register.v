module register #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
	input clear, clock, enable, 
	input [DATA_WIDTH_IN-1:0] RegisterInput,
	output wire [DATA_WIDTH_OUT-1:0] RegisterOutput
);

reg [DATA_WIDTH_IN-1:0]q;
initial q = INIT;
always @ (negedge clock)
		begin 
			if (clear) begin
				q <= {DATA_WIDTH_IN{1'b0}};
			end
			else if (enable) begin
				q <= RegisterInput;
			end
		end
	assign RegisterOutput = q[DATA_WIDTH_OUT-1:0];
endmodule

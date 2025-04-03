module register_R0 #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
	input clear, clock, enable, 
	input [DATA_WIDTH_IN-1:0] RegisterInput,
	output wire [DATA_WIDTH_OUT-1:0] RegisterOutput,
	input BAout
);

reg [DATA_WIDTH_IN-1:0]q;
initial q = INIT;
always @ (negedge clock)
		begin 
			if (clear) begin
				q <= {DATA_WIDTH_IN{1'b0}};
			end
			else if (enable) begin
				if (BAout == 0) q <= RegisterInput;
				if (BAout == 1) q <= 32'b0;
			end
		end
	assign RegisterOutput = q[DATA_WIDTH_OUT-1:0];
endmodule
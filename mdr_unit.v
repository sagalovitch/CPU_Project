module mdr_unit #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
	input clear, clock, enable, read,
	input [DATA_WIDTH_IN-1:0]BusMuxOut, input [DATA_WIDTH_IN-1:0] Mdatain,
	output wire [DATA_WIDTH_OUT-1:0]BusMuxIn
);


reg [DATA_WIDTH_IN-1:0]q;
initial q = INIT;
initial j = INIT;
wire [DATA_WIDTH_IN-1:0] MDRMux;

always @ (read) begin
	if (read) begin
		j <= BusMuxOut;
	end
	else if (!read) begin
		j <= Mdatain;
	end
end
assign MDRMux = j[DATA_WIDTH_OUT-1:0];

always @ (posedge clock) begin 
			if (clear) begin
				q <= {DATA_WIDTH_IN{1'b0}};
			end
			else if (enable) begin
				q <= MDRMux;
			end
end

		assign BusMuxIn = q[DATA_WIDTH_OUT-1:0];
		
endmodule
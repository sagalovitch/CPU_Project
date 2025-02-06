// 2 to 1 Mux 
module mux2to1 (input select, input [31:0] Input1, input [31:0] Input0, output wire [31:0] MuxOut);

reg [31:0]q;

initial q = 32'd0;

always @ (*) begin
	if (select == 1) 
		q <= Input1;
	else
		q <= Input0;
end

assign MuxOut = q;

endmodule

module InPort(
    input clear, clock,
    input Strobe,
    input [31: 0] Inport_In,
    output [31: 0] Inport_out
);
	reg [31:0] q;

	always @ (posedge clock) begin
	  if (clear) begin
			q <= 32'b0;
	  end
	  else if (Strobe) begin 
			q <= Inport_In;
	  end
	end
	assign Inport_out = q;
endmodule

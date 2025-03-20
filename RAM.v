module RAM(
    input clock,
    input memRead, memWrite,
    input [8:0] address,
    input [31:0] dataIn,
    output reg [31:0] dataOut
);


    // "memory" is a 512 x 32-bit array
    reg [31:0] memory [0:511];
			 
	 initial begin
		$readmemh("load.hex", memory);
		//memory[0] = 00000065;
	 end
    always @(posedge clock) begin
        if (memWrite)
            // Write dataIn into memory at this address
            memory[address] <= dataIn;

        if (memRead)
            // Read the memory contents to dataOut
            dataOut <= memory[address];
    end

endmodule

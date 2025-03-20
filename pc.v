module pc #(parameter INIT_VAL) (output reg [31:0] PC_data_out, input clock, input IncPC, input PC_enable, input [31:0] BusMuxOut, input conOut);
// add muxout as a final parameter for jump instructions

initial begin
	PC_data_out = INIT_VAL;
end

always@(posedge clock)
    begin
        if(IncPC === 1 && PC_enable === 1)
			PC_data_out = PC_data_out + 1;
		else if (PC_enable == 1 && conOut == 1)
			PC_data_out <= BusMuxOut;
    end

endmodule
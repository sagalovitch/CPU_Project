module con_ff(
    input wire [31:0] busIn, // 32 bit input with value we are testing 
    input wire [1:0]  c2,      // IR<20,19> 
    input wire        conIn,   // Latch enable hardcoded for now 
    input wire        clock,
    output reg        conOut   // Condition bit
);
	
	// condition checks we will apply on c2 bits 
    wire isZero = (busIn == 32'b0);
    wire isNeg  = busIn[31];
    wire isPos  = ~busIn[31] && !isZero;

    reg nextVal;
    always @(*) begin
        case (c2)
            2'b00: nextVal = isZero;  // brzr
            2'b01: nextVal = !isZero; // brnz
            2'b10: nextVal = isPos;   // brpl
            2'b11: nextVal = isNeg;   // brmi
        endcase
    end

    always @(posedge clock) begin
        if (conIn) // only latch when conIn=1
            conOut <= nextVal;
    end
endmodule


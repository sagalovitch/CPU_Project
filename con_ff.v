module con_ff#(parameter INIT_VAL = 1'b0)(
    input wire [31:0] busIn,   // value to check
    input wire [1:0]  c2,      // IR[20:19] field
    input wire        conIn,   // latch enable
    input wire        clock,
    output reg        conOut   // output condition result
);

    initial conOut = 1'b0;

    reg [3:0] decoder_out = 4'b0000;
    wire isZero = ~|busIn;
    wire isNeg = busIn[31];
    wire isPos = ~busIn[31] & ~isZero;

    always @(*) begin
        case(c2)
            2'b00: decoder_out = 4'b0001; // brzr
            2'b01: decoder_out = 4'b0010; // brnz
            2'b10: decoder_out = 4'b0100; // brpl
            2'b11: decoder_out = 4'b1000; // brmi
            default: decoder_out = 4'b0000;
        endcase
    end

    always @(posedge clock) begin
			
        if (conIn) begin
            conOut <= (decoder_out[0] & isZero) |(decoder_out[1] & ~isZero) |(decoder_out[2] & isPos) |(decoder_out[3] & isNeg);
        end
    end

endmodule


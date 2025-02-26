`timescale 1ns/10ps

module div32 (
    input wire signed [31:0] dividend,  
    input wire signed [31:0] divisor,    
    output reg signed [31:0] quotient,  
    output reg signed [31:0] remainder  
);

    reg [63:0] remainder_register;  
    reg [31:0] abs_dividend, abs_divisor;  
    reg quotient_sign, remainder_sign; 
    integer bit_position;

    always @(*) begin
        if (divisor == 0) begin
            quotient = 32'hFFFFFFFF;  
            remainder = 32'hFFFFFFFF;
        end 
        else if (dividend == -32'h80000000 && divisor == -1) begin
            quotient = 32'h7FFFFFFF;  
            remainder = 0;
        end 
        else begin
            quotient_sign = dividend[31] ^ divisor[31]; 
            remainder_sign = dividend[31];  

            abs_dividend = (dividend[31]) ? (~dividend + 1) : dividend;  
            abs_divisor = (divisor[31]) ? (~divisor + 1) : divisor;  

            quotient = 0;
            remainder_register = {32'b0, abs_dividend}; 

            for (bit_position = 0; bit_position < 32; bit_position = bit_position + 1) begin
                remainder_register = remainder_register << 1;

                remainder_register[63:32] = remainder_register[63:32] - abs_divisor;

                if (remainder_register[63] == 1) begin
                    remainder_register[63:32] = remainder_register[63:32] + abs_divisor;
                    quotient = quotient << 1;
                end else begin
                    quotient = (quotient << 1) | 1;
                end
            end

            remainder = remainder_register[63:32];

            if (quotient_sign)
                quotient = -quotient;

            if (remainder_sign)
                remainder = -remainder;
        end
    end

endmodule

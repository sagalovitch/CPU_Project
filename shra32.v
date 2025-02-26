module shra32 (
    input signed [31:0] Ra,       
    input [4:0] shift_amt, 
    output signed [31:0] result   
);
    assign result = Ra >>> shift_amt; 
endmodule

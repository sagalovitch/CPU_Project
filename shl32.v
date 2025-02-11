module shl32 (
    input [31:0] Ra,      
  input [4:0] shift_amt, 
    output [31:0] result   
);
    assign result = Ra << shift_amt; 
endmodule

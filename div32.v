`timescale 1ns/10ps

module div32 (
    input wire signed [31:0] A,   // Dividend 
    input wire signed [31:0] M,   // Divisor 
    output reg signed [31:0] Q,   // Quotient 
    output reg signed [31:0] R    // Remainder
);

    reg [63:0] temp; 
    reg [31:0] absA, absM;  
    reg signQ, signR;  
    integer i; 

    always @(*) begin
     
        if (M == 0) begin
            Q = 32'hFFFFFFFF;  
            R = 32'hFFFFFFFF;
        end 
        else if (A == 32'h80000000 && M == -1) begin
            Q = 32'h80000000;  
            R = 0;  
        end 
        else begin
            
            signQ = A[31] ^ M[31]; 
            signR = A[31];         

            absA = (A[31]) ? (~A + 1) : A; 
            absM = (M[31]) ? (~M + 1) : M; 

            Q = 0;
            temp = {32'b0, absA}; 

            for (i = 0; i < 32; i = i + 1) begin
                temp = temp << 1;

      
                temp[63:32] = temp[63:32] - absM;

                if (temp[63] == 1) begin
                    temp[63:32] = temp[63:32] + absM;
                    Q = Q << 1;  
                end else begin
                    Q = (Q << 1) | 1;  
                end
            end
       
            R = temp[63:32];

       
            if (signQ)
                Q = ~Q + 1;  

            if (signR)
                R = ~R + 1;  
        end
    end

endmodule

module InPort(
    input clear, clock,
    input Strobe,
    input [31: 0] Inport_In,
    output [31: 0] Inport_out
);

    always @ (posedge clock) begin
        if (clear) begin
            Inport_out <= 32'b0;
        end
        else if (strobe) begin 
            Inport_out <= Inport_In;
        end
    end
endmodule

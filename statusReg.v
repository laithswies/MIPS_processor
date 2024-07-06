module Reg (
    input [7:0] in,
    output reg [7:0] out,
    input write,
    input clk
);
    reg [7:0] Register;
    initial 
        Register = 0; 
    always @(posedge clk) begin
        if(write)
            Register <= in;
    end
    always @(*)
    out <= Register;
endmodule
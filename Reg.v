module Reg (
    input [23:0] in,
    output reg [23:0] out,
    input write,
    input clk
);
    reg [23:0] Register;
    initial 
        Register = 0; 
    always @(posedge clk) begin
        if(write)
        Register <= in;   
    end
    always @(*)
    out <= Register;
endmodule
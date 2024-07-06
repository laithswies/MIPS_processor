module Adder#(parameter bits = 23) (
    A,
    B,
    out
);
input [bits:0] A;
input [23:0] B;
output [23:0] out;
assign out = A+B;
endmodule
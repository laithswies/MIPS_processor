module SignExtend#(parameter bits = 17)(
    input [bits-1:0] in,
    input ExtOp,
    output reg [23:0] out
);
    always @(*) begin
        out[bits-1:0] <= in[bits-1:0];
        out[23:bits] <= (ExtOp&in[bits-1])*(2**(24-bits));
    end
endmodule
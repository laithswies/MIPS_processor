module Mux2x1 (
    input sel,
    input [23:0] a,
    input[23:0] b,
    output reg [23:0] out
);
  always @(*) begin
    if (sel)
      out <= b;
    else 
      out <= a;
  end 
endmodule
module Mux4x1 (
    input [1:0] sel,
    input [23:0] a,
    input[23:0] b,
    input[23:0] c,
    input [23:0] d,
    output reg [23:0] out
);
  always @(*) begin
    case (sel)
      2'b00:out<=a;
      2'b01:out<=b;
      2'b10:out<=c;
      2'b11:out<=d;
    endcase
  end
endmodule
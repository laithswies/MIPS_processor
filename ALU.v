module ALU (
    input [23:0] A,B,
    input [4:0] OP,
    output reg zeroFlag,
    output reg [23:0] Result
);
    initial Result = 0;
    reg [23:0] temp;
    always @(OP or A or B) begin
        case(OP)
        5'b00000, 5'b00111:
        temp = A&B;
        5'b00001:
        begin
            if (A > B) begin
            temp = A;
        end
        else begin
            temp = B;
        end
        end
        5'b00011, 5'b00010,5'b01000, 5'b01001, 5'b01010,5'b01001:
            temp = A + B;
        5'b00100, 5'b01011 ,5'b01011:
            temp = A-B;
        5'b00101:
            temp = A >= B;
        5'b01111:
        begin

        end

        endcase
        Result <= temp;
        zeroFlag <= temp == 0;
    end
endmodule
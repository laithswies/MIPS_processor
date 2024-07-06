module RegisterFile (
    input [2:0] Rdata1,
    input [2:0] Rdata2,
    input [2:0] WriteReg,
    input [23:0] Wdata,
    output reg [23:0] Outdata1,
    output reg [23:0] Outdata2,
    input RegWrite,
    input clk
);
    reg[23:0] RegFile[8];
    integer i;
    initial begin
        for( i=0;i<8;i++)
            begin
                RegFile[i] = 0; 
                end
    end
    always @(posedge clk) begin
        if(RegWrite & WriteReg != 0)
            RegFile[WriteReg] <= Wdata;
    end
    always @(*) begin
     Outdata1 <= RegFile[Rdata1];
    end
    always @(*) begin
        Outdata2 <= RegFile[Rdata2];
    end
endmodule

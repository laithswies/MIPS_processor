module Memory (
    input [23:0] Address,
    input [23:0] DataIn,
    output [23:0] DataOut,
    input MemW,
    input MemR,
    input clk
);
reg[23:0] Mem[2**24];
    integer i;
    initial begin
        for( i=0;i<2**24;i++)
            begin
                Mem[i] = 0; 
                end
    end
    always @(posedge clk) begin
        if(MemW)
            Mem[Address] <= DataIn;
    end
    assign DataOut = MemR?Mem[Address]:0;  
endmodule
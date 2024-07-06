module writeControl (
    input [4:0] Op,
    input zeroFlag,
    output reg RegWrite,
    output reg MemWrite,
    output reg PCWriteCond,
    input clk
);
    
    always @(posedge clk) begin
            #1
            if (Op == 5'b01001 || Op ==5'b00010)
            begin
                repeat (3)@(posedge clk);
                PCWriteCond <= 1;
                @(posedge clk);
                PCWriteCond <= 0;
            end
            else if (Op == 5'b01010)
            begin //SW
                repeat (2)@(posedge clk);
                PCWriteCond <= 1;
                @(posedge clk);
                PCWriteCond <= 0;
            end
            else if (Op ==5'b01011)//BEQ
            begin
                @(posedge clk);
                PCWriteCond <= 1;
                @(posedge clk);
                PCWriteCond <= 0;
            end
            else if (Op ==5'b00110)
            begin // JR
                @(posedge clk);
                PCWriteCond <=1;
                @(posedge clk);
                PCWriteCond <= 0;
            end
            else if (Op ==5'b00000 || Op ==5'b00001  || Op ==5'b00011 || Op ==5'b00100 || Op ==5'b00101 || Op ==5'b01000 || Op ==5'b00111)
            begin
                repeat (2)@(posedge clk);
                PCWriteCond <= 1;
                @(posedge clk);
                PCWriteCond <= 0;
            end
            else if (Op ==5'b01101)
                begin // JAL
                @(posedge clk);
                PCWriteCond <= 1;
                @(posedge clk);
                PCWriteCond <= 0;
                end
            else if (Op ==5'b01110)
            begin // LUI
                @(posedge clk);
                PCWriteCond <= 1;
                @(posedge clk);
                PCWriteCond <= 0;
            end
            else if (Op ==5'b00101)
            begin // CMP
                @(posedge clk);
                PCWriteCond <= 1;
                @(posedge clk);
                PCWriteCond <= 0;
            end
            // else if (Op ==5'b11111)
            // begin 
            //     repeat (2)@(posedge clk);
            //     PCWriteCond <= 1;
            //     @(posedge clk);
            //     PCWriteCond <= 0;
            // end
            else if (Op == 5'b01100)
            begin
                @(posedge clk);
                PCWriteCond <= 1;
                @(posedge clk);
                PCWriteCond <= 0;
            end
            else if (Op == 5'b01111) begin
                @(posedge clk);
                PCWriteCond <=1;
                @(posedge clk);
                PCWriteCond <= 0;
            end
        
    end
    always @(posedge clk) begin  
    case(Op)  
    5'b01001:
    begin  //LW
        repeat(2)@(posedge clk);
        RegWrite <=1;
        @(posedge clk);
        RegWrite <= 0;
        @(posedge clk);
    end
 5'b01010:
    begin //SW
        //@(posedge clk);
        MemWrite <= 1;
        @(posedge clk);
        MemWrite <= 0;
        @(posedge clk);
    end
 5'b00000,5'b00001,5'b00011,5'b00100: //Rtype
    begin
        @(posedge clk);
        RegWrite <=1;
        @(posedge clk);
        RegWrite <= 0;
        @(posedge clk);
        @(posedge clk);
    end
   5'b00010: //LWS
   begin
        repeat(2)@(posedge clk);
        RegWrite <=1;
        @(posedge clk);
        RegWrite <= 0;
        @(posedge clk);
   end
 5'b01101:
    begin // JAL
        RegWrite <=1;
        @(posedge clk);
        RegWrite <= 0;
    end
    5'b00111,5'b01000:
    begin // ANDI & ADDI
        @(posedge clk);
        RegWrite <=1;
        @(posedge clk);
        RegWrite <= 0;
        @(posedge clk);
    end
    5'b01111: //NOP
    begin
        RegWrite <= 0;
        MemWrite <= 0;
        @(posedge clk);
    end
    5'b01110: //LUI
    begin
        RegWrite <=1;
        @(posedge clk);
        RegWrite <= 0;
        @(posedge clk);
    end
 endcase
        end
    
endmodule
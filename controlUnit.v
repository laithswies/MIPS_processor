module controlUnit (
    input [4:0] Op,
    input [1:0] cond,
    input zeroFlag,
    input branchZero,
    input sf,
    output reg reg2sel,
    output reg[1:0] Mem2Reg,
    output reg MemRead,ALUSrc,
    output reg [1:0] RegDst,
    output [1:0] PCSource,
    output reg [4:0] ALUOp,
    output reg SeSel,
    output reg zeroFlagWrite
);
reg [4:0] temp =0 ;
assign zeroFlagWrite = sf || Op == 5'b00101;
assign PCSource[0] = Op==5'b01100 || Op == 5'b01101 || (Op==5'b01011 & branchZero);
assign PCSource[1] = Op==5'b00110;
always @(*)
    begin
 if(cond == 0 || cond == 1 & zeroFlag == 1 || cond == 2 & zeroFlag == 0) begin
   temp = Op;
 end
 else temp = 5'b01111;
   ALUOp <= temp;
 case(temp)  
5'b01001:
    begin  //LW
    RegDst <=2'b01;
    ALUSrc <= 1;
    MemRead <=1;
    Mem2Reg <=1;
    SeSel <= 1;
    end
 5'b01100:
    begin // J
    MemRead <=0;
    Mem2Reg <=0;
    SeSel <= 0;
    end
 5'b01010:
    begin //SW
    ALUSrc <= 1;
    MemRead <=0;
    reg2sel<=1;
    SeSel <= 1;
    end
  5'b01011: //BEQ
    begin
    ALUSrc <= 0;
    MemRead <=0;
    Mem2Reg <=0;
    SeSel <= 1;
    reg2sel<=1;
    end
 5'b00110:
    begin // JR
    MemRead <=0;
    end
 5'b00000,5'b00001,5'b00011,5'b00100: //Rtype
    begin
    RegDst <=2'b00;
    ALUSrc <= 0;
    MemRead <=0;
    Mem2Reg <=0;
    reg2sel<=0;
    end
   
   5'b00010: begin //LWS
    RegDst <=2'b00;
    ALUSrc <= 0;
    MemRead <=1;
    Mem2Reg <= 1;
    reg2sel<=0;
   end
 5'b01101:
    begin // JAL
    RegDst <=2'b11;
    MemRead <=0;
    Mem2Reg <= 2;
    end
 5'b01110:
    begin // LUI
    RegDst <=2'b10;
    MemRead <=0;
    Mem2Reg <= 3;
    SeSel <= 0;
    end
 5'b00101:
    begin // CMP
    ALUSrc <= 0;
    MemRead <=0;
    Mem2Reg <=0;
    reg2sel<=0;
    end
    5'b00111,5'b01000:
    begin // ANDI & ADDI
    RegDst <=2'b00;
    ALUSrc <= 1;
    MemRead <=0;
    Mem2Reg <=0;
    SeSel <= 1;
    end
    default:
    begin
      ALUOp <= 5'b01111;
      MemRead <= 0;
    end
    
 endcase
        end
    
endmodule
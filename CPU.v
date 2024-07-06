module CPU (
    input clk
);
    wire [23:0] PCin,PCout,ALUOut,PCMuxOut, instruction,Data,instructionBuff,writeData,A,B,ABuff,BBuff,nextPC,nextPCBuff,PCJump,PCJumpBuff,ALUIn,DataOut,SEOut,dataBuff,Result,SEOut1,SEOut2;
    wire [1:0] cond=instructionBuff[1:0];
    wire [4:0] Op= instructionBuff[6:2];
    wire sf,zeroFlag,MemRead,MemWrite,ALUSrc,RegWrite,PCWriteCond,SeSel;
    wire [1:0] Mem2Reg;
    assign sf =instructionBuff[7];
    wire [2:0] Rd,Rs,Rt,writeReg,reg2;
    wire [4:0] ALUOp;
    assign Rd=instructionBuff[10:8];
    assign Rs=instructionBuff[13:11];
    assign Rt=instructionBuff[16:14];
    wire [1:0] RegDst,PCSource;
    controlUnit cu(Op,cond,zero,zeroFlag,sf,reg2sel,Mem2Reg,MemRead,ALUSrc,RegDst,PCSource,ALUOp,SeSel,zeroFlagWrite);
    writeControl WControl(ALUOp,zero,RegWrite,MemWrite,PCWriteCond,clk);
    Adder PCAdd(PCout,24'b1,nextPC);
    Adder PCJumpadd(PCout,SEOut,PCJump);
    Reg PCAddBuffer(nextPC,nextPCBuff,1'b1,clk);
    Reg PCJumpBuffer(PCJump,PCJumpBuff,1'b1,clk);
    Reg PC(PCin,PCout,PCWriteCond,clk);
    Memory instructionMem(PCout,24'bz,instruction,1'b0,1'b1,clk);
    Memory dataMem(ALUOut,BBuff,DataOut,MemWrite,MemRead,clk);
    Reg instructionBuffer(instruction,instructionBuff,1'b1,clk);
    Reg memBuffer(DataOut,dataBuff,1'b1,clk);
    Reg ABuffer(A,ABuff,1'b1,clk);
    Reg BBuffer(B,BBuff,1'b1,clk);
    Mux4x1 wRegMux(RegDst,Rd,Rt,3'b001,3'b111,writeReg);
    Mux4x1 writeDataMux(Mem2Reg,ALUOut,dataBuff,nextPC,SEOut << 7,writeData);
    RegisterFile RegFile(Rs,reg2,writeReg,writeData,A,B,RegWrite,clk);
    Mux2x1 readReg2(reg2sel, Rt, Rd, reg2);

    //Sign Extend
    SignExtend#(17) SE_17Bit(instructionBuff[23:8],1'b1,SEOut1);
    SignExtend#(10) SE_10Bit(instructionBuff[23:14],1'b1,SEOut2);
    Mux2x1 SE(SeSel, SEOut1, SEOut2, SEOut);

    Mux2x1 ALUMux(ALUSrc,BBuff,SEOut,ALUIn);
    ALU alu(ABuff,ALUIn,ALUOp,zeroFlag,Result);
    Reg aluReg(Result,ALUOut,1'b1,clk);
    Mux4x1 nextPCMux(PCSource,nextPCBuff,PCJumpBuff,ABuff,0,PCin);
    Reg statusReg(zeroFlag,zero,zeroFlagWrite,clk);
   
endmodule
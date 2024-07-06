`timescale 1ns/1ns
`include "Adder.v"
`include "ALU.v"
`include "Memory.v"
`include "Mux.v"
`include "Reg.v"
`include "RegFile.v"
`include "SignExtend.v"
`include "controlUnit.v"
`include "CPU.v"
`include "writeControl.v"
module testbench (
);
    reg PCWriteCond,PCWrite,MemRead,MemWrite,Mem2Reg,IRWrite,PCSource;
    reg[4:0] ALUOp;
    reg ALUSrc,RegWrite,RegDst,clk;

    CPU cpu(clk);
    initial begin
        clk =0;
    forever begin
        #5 clk = ~clk;
    end
    end
    initial begin
        
        /*
        *int arr[6];
        for (int i=0;i<6;i++) arr[6] = i;
        */
              
        cpu.instructionMem.Mem[0] = 0;
        cpu.instructionMem.Mem[1] = 24'b00000001001011000_01110_00;// LUI R1 = decimal(600) << 7
        cpu.instructionMem.Mem[2] = 24'b0000000110_000_100_0_01000_00; //ADDI R4 = R0 + 6
        cpu.instructionMem.Mem[3] = 24'b0000000000_000_010_0_01000_00; // ADDI R2 = R0 + 0
        //loop1: 
        cpu.instructionMem.Mem[4] = 24'b0000000_010_001_011_0_00011_00;// ADD R3 = R1 + R2
        cpu.instructionMem.Mem[5] = 24'b0000000000_011_010_0_01010_00; // Sw Mem(R3+0) = Reg(R2)
        cpu.instructionMem.Mem[6] = 24'b0000000001_010_010_0_01000_00;// ADDI R2 = R2 + 1
        cpu.instructionMem.Mem[7] = 24'b0000000011_010_100_0_01011_00;// BEQ if (R2 == R4) Jump to A meanning R2 == 6
        cpu.instructionMem.Mem[8] = 24'b0000000100_000_111_0_01000_00;// ADDI R7 = R0 + 4
        cpu.instructionMem.Mem[9] = 24'b0000000_000_111_000_0_00110_00;// JR PC = Reg(R7)
        ////////////////////////////////////////////////////////////////////////////////////////////////////

        ////////////////////////////////////////////////////////////////////////////////////////////////////
        // for (int i=0;i<6;i++) j = arr[i];
        //loop2
        cpu.instructionMem.Mem[10] = 24'b0000000000_000_010_0_01000_00;//ADDI R2 = R0 + 0
        cpu.instructionMem.Mem[11] = 24'b0000000_010_001_101_0_00010_00;// LWS R5 = Mem(Reg(R2)+Reg(R1))
        cpu.instructionMem.Mem[12] = 24'b0000000001_010_010_0_01000_00;// ADDI R2 = R2 + 1
        cpu.instructionMem.Mem[13] = 24'b0000000011_010_100_0_01011_00;//BEQ if (R2 == R4) Jump to A meanning R2 == 6
        cpu.instructionMem.Mem[14] = 24'b0000001011_000_111_0_01000_00;// ADDI R7 = R0 + 11
        cpu.instructionMem.Mem[15] = 24'b0000000_000_111_000_0_00110_00;// JR PC = Reg(R7)
        // cpu.instructionMem.Mem[1] = 24'b0000000_000_001_010_1_00100_00;
        // cpu.instructionMem.Mem[2] = 24'b0000000_000_001_010_1_00011_10;
        // cpu.instructionMem.Mem[1] = 24'b0000000001_000_001_0_01000_00;
        // cpu.instructionMem.Mem[2] = 24'b0000000_001_000_010_0_00011_00;
    end
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        #10000
        $finish;
    end

endmodule
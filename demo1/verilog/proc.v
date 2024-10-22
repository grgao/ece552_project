/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
`default_nettype none
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input wire clk;
   input wire rst;

   output reg err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here -- should include instantiations of fetch, decode, execute, mem and wb modules */
   wire [15:0] instruction;
   wire [15:0] pc_in; // current PC
   wire [15:0] pc_out; // next PC
   wire [15:0] writeback;
   wire [15:0] opA;
   wire [15:0] opB;
   wire [15:0] sign_extended_11bit;
   wire [15:0] out8bit;
   wire invb;
   wire inva;
   wire memwrt;
   wire alujmp;
   wire immsrc;
   wire [3:0] branch;
   wire [1:0] regsrc;
   wire [3:0] aluop;
   wire [15:0] aluout;
   wire setrd;
   wire brchCnd;
   wire [15:0] PCaddersrc;
   wire mem_enable;
   wire createdump;
   wire [15:0] mem_data_out;
   wire [15:0] read2Data;  

   fetch fetch0(.instruction(instruction), .pc_in(pc_in), .pc_out(pc_out), .clk(clk), .rst(rst));
   decode decode0(.instruction(instruction), .writeback(writeback), .opA(opA), .opB(opB), .out8bit(out8bit), .sign_extended_11bit(sign_extended_11bit), .invb(invb), .inva(inva), .memwrt(memwrt), .immsrc(immsrc), .branch(branch), .regsrc(regsrc), .aluop(aluop), .clk(clk), .rst(rst), .mem_enable(mem_enable), .alujmp(alujmp), .memdmp(createdump), .read2Data(read2Data));
   execute execute0(.opA(opA), .opB(opB), .imm8bit(out8bit), .imm11bit(sign_extended_11bit), .aluop(aluop), .invb(invb), .inva(inva), .immsrc(immsrc), .branch(branch), .aluout(aluout), .setrd(setrd), .brchCnd(brchCnd), .PCaddersrc(PCaddersrc), .instruction2bits(instruction[1:0]));
   memory memory0(.halt(createdump), .data_in(read2Data), .addr(aluout), .adderSrc(PCaddersrc), .inPC(pc_out), .brchCnd(brchCnd), .alujmp(alujmp), .enable(mem_enable), .wr(memwrt), .clk(clk), .rst(rst), .data_out(mem_data_out), .outPC(pc_in));
   wb wb0(.regSrc(regsrc), .inPC(pc_out), .readData(mem_data_out), .aluout(aluout), .setRd(setrd), .wbData(writeback));
   
endmodule // proc
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :0:

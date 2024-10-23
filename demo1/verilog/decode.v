/*
   CS/ECE 552 Spring '22
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
`default_nettype none
module decode (instruction, writeback, opA, opB, out8bit, sign_extended_11bit, invb, inva, memwrt, immsrc, branch, regsrc, aluop, clk, rst, alujmp, memdmp, mem_enable, read2Data, sign, halt);
   input wire [15:0] instruction;
   input wire [15:0] writeback;
   input wire clk;
   input wire rst;
   output wire [15:0] opA;
   output wire [15:0] opB;
   output wire [15:0] sign_extended_11bit;
   output wire [15:0] out8bit;
   output wire invb;
   output wire inva;
   output wire memwrt;
   output wire immsrc;
   output wire [3:0] branch;
   output wire [1:0] regsrc;
   output wire [3:0] aluop;
   output wire alujmp;
   output wire memdmp;
   output wire mem_enable;
   output wire [15:0] read2Data;
   output wire sign;
   output wire halt;

   wire [15:0] sign_extended_5bit;
   wire [15:0] sign_extended_8bit;
   wire [15:0] zero_extended_5bit;
   wire [15:0] zero_extended_8bit;
   wire [15:0] out5bit;
   wire [15:0] rd2, rd1;
   wire sel0ext;
   

   // instruction decoder module
   wire [1:0]regdst;
   wire regwrt;
   wire [1:0] bsource;
   wire asource;
   instruction_decoder decoder(.instruction(instruction[15:11]), .regdst(regdst), .sel0ext(sel0ext), .regwrt(regwrt), .bsource(bsource), .branch(branch), .aluop(aluop), .alujmp(alujmp), .invb(invb), .inva(inva), .memwrt(memwrt), .immsrc(immsrc), .asource(asource), .regsrc(regsrc), .dmp(memdmp), .mem_enable(mem_enable), .sign(sign), .halt(halt));

   // register file bypass module
   wire [2:0] writeReg;
   mux4_1 #(.WIDTH(3)) writeReg_mux(.in0(instruction[7:5]), .in1(instruction[10:8]), .in2(instruction[4:2]), .in3(3'b111), .sel(regdst), .out(writeReg));
   regFile_bypass regFile0(.read1Data(rd1), .read2Data(rd2), .err(), .clk(clk), .rst(rst), .read1RegSel(instruction[10:8]), .read2RegSel(instruction[7:5]), .writeRegSel(writeReg), .writeData(writeback), .writeEn(regwrt));

   // other muxes
   assign sign_extended_5bit = {{11{instruction[4]}}, instruction[4:0]};
   assign sign_extended_8bit = {{8{instruction[7]}}, instruction[7:0]};
   assign sign_extended_11bit = {{5{instruction[10]}}, instruction[10:0]};
   assign zero_extended_5bit = {11'b0, instruction[4:0]};
   assign zero_extended_8bit = {8'b0, instruction[7:0]};

   mux2_1 out5bit_mux(.in0(sign_extended_5bit), .in1(zero_extended_5bit), .sel(sel0ext), .out(out5bit));
   mux2_1 out8bit_mux(.in0(sign_extended_8bit), .in1(zero_extended_8bit), .sel(sel0ext), .out(out8bit));

   mux4_1 bsource_mux(.in0(rd2), .in1(out5bit), .in2(out8bit), .in3(sign_extended_11bit), .sel(bsource), .out(opB));
   mux2_1 asource_mux(.in0(rd1), .in1({rd1[7:0], 8'h00}), .sel(asource), .out(opA));

   assign read2Data = rd2;



   
endmodule
`default_nettype wire

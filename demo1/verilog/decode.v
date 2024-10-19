/*
   CS/ECE 552 Spring '22
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
`default_nettype none
module decode (instruction, writeback, opA, opB, 8bit, sign_extended_11bit, invb, inva, memwrt, immsrc, branch, regsrc, aluop, clk, rst);
   input [15:0] instruction;
   input [15:0] writeback;
   output [15:0] opA;
   output [15:0] opB;
   output [15:0] sign_extended_11bit;
   output [15:0] 8bit;
   output invb;
   output inva;
   output memwrt;
   output immsrc;
   output [2:0] branch;
   output regsrc;
   output [3:0] aluop;

   wire [15:0] sign_extended_5bit;
   wire [15:0] sign_extended_8bit;
   wire [15:0] zero_extended_5bit;
   wire [15:0] zero_extended_8bit;
   wire [15:0] 5bit;
   wire [15:0] rd2, rd1;
   wire 0ext;

   // instruction decoder module
   wire [1:0]regdst;
   wire 0ext;
   wire regwrt;
   wire [1:0] bsource;
   wire alujmp;
   wire asource;
   instruction_decoder decoder(.instruction(instruction[15:11]), .regdst(regdst), .0ext(0ext), .regwrt(regwrt), .bsource(bsource), .branch(branch), .aluop(aluop), .alujmp(alujmp), .invb(invb), .inva(inva), .memwrt(memwrt), .immsrc(immsrc), .asource(asource), .regsrc(regsrc));

   // register file bypass module
   wire [15:0] writeReg;
   mux4_1 #(parameter WIDTH = 3) writeReg_mux(.in0(instruction[7:5]), .in1(instruction[10:8]), .in2(instruction[4:2]), .in3(3'b111), .sel(regdst), .out(writeReg));
   regFile_bypass rf(.read1Data(rd1), .read2Data(rd2), .err(), .clk(clk), .rst(rst), .read1RegSel(instruction[10:8]), .read2RegSel(instruction[7:5]), .writeRegSel(writeReg), .writeData(writeback), .writeEn(regwrt))

   // other muxes
   assign sign_extended_5bit = {{11{instruction[4]}}, instruction[4:0]};
   assign sign_extended_8bit = {{8{instruction[7]}}, instruction[7:0]};
   assign sign_extended_11bit = {{5{instruction[10]}}, instruction[10:0]};
   assign zero_extended_5bit = {11'b0, instruction[4:0]};
   assign zero_extended_8bit = {8'b0, instruction[7:0]};

   mux2_1 5bit_mux(.in0(sign_extended_5bit), .in1(zero_extended_5bit), .sel(0ext), .out(5bit));
   mux2_1 8bit_mux(.in0(sign_extended_8bit), .in1(zero_extended_8bit), .sel(0ext), .out(8bit));

   mux4_1 bsource_mux(.in0(rd2), .in1(5bit), .in2(8bit), .in3(sign_extended_11bit), .sel(bsource), .out(opB));
   mux2_1 asource_mux(.in0(rd1), .in1({rd1[7:0], 8'h00}), .sel(asource), .out(opA));



   
endmodule
`default_nettype wire

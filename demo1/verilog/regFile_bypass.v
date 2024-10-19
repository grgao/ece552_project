/*
   CS/ECE 552, Fall '22
   Homework #3, Problem #2
  
   This module creates a wrapper around the 8x16b register file, to do
   do the bypassing logic for RF bypassing.
*/
module regFile_bypass (
                       // Outputs
                       read1Data, read2Data, err,
                       // Inputs
                       clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
                       );
   input        clk, rst;
   input [2:0]  read1RegSel;
   input [2:0]  read2RegSel;
   input [2:0]  writeRegSel;
   input [15:0] writeData;
   input        writeEn;

   output [15:0] read1Data;
   output [15:0] read2Data;
   output        err;

   wire [15:0] regRead1Data, regRead2Data;
   wire regErr;

   /* YOUR CODE HERE */
   regFile rf (.clk(clk), .rst(rst), .read1RegSel(read1RegSel), .read2RegSel(read2RegSel), .writeRegSel(writeRegSel), .writeData(writeData), .writeEn(writeEn), .read1Data(regRead1Data), .read2Data(regRead2Data), .err(regErr));

   assign read1Data = (writeRegSel == read1RegSel) & writeEn ? writeData : regRead1Data;
   assign read2Data = (writeRegSel == read2RegSel) & writeEn ? writeData : regRead2Data;

   assign err = ((^({clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn, regRead1Data, regRead2Data}))===1'bx) | regErr;
endmodule

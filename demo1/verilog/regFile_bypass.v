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

   /* YOUR CODE HERE */
   wire [15:0] read1DataIn, read2DataIn, writeDataff;
   wire writeEnff;
   wire [2:0] writeRegSelff, read1RegSelff, read2RegSelff;
   assign read1Data = (((writeEn ^ writeEnff) == 1'b1) && (writeRegSelff == read1RegSelff)) ? writeDataff : read1DataIn;
   assign read2Data = (((writeEn ^ writeEnff) == 1'b1) && (writeRegSelff == read2RegSelff)) ? writeDataff : read2DataIn;
   register register(.in(writeData), .out(writeDataff), .clk(clk), .rst(rst));
   register #(.WIDTH(1)) register1(.in(writeEn), .out(writeEnff), .clk(clk), .rst(rst));
   register #(.WIDTH(3)) register2(.in(writeRegSel), .out(writeRegSelff), .clk(clk), .rst(rst));
   register #(.WIDTH(3)) register3(.in(read1RegSel), .out(read1RegSelff), .clk(clk), .rst(rst));
   register #(.WIDTH(3)) register4(.in(read2RegSel), .out(read2RegSelff), .clk(clk), .rst(rst));
   regFile regfile(.read1Data(read1DataIn), .read2Data(read2DataIn), .err(err), .clk(clk), .rst(rst), .read1RegSel(read1RegSel), .read2RegSel(read2RegSel), .writeRegSel(writeRegSel), .writeData(writeData), .writeEn(writeEn));

endmodule

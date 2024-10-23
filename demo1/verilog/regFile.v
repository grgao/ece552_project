/*
   CS/ECE 552, Fall '22
   Homework #3, Problem #1
  
   This module creates a 16-bit register.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
module regFile (
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
   wire [15:0] input1, output1;
   wire [15:0] input2, output2;
   wire [15:0] input3, output3;
   wire [15:0] input4, output4;
   wire [15:0] input5, output5;
   wire [15:0] input6, output6;
   wire [15:0] input7, output7;
   wire [15:0] input8, output8;
   
   assign input1 = ((writeRegSel === 3'b000) & (writeEn === 1'b1)) ? writeData : output1;
   assign input2 = ((writeRegSel === 3'b001) & (writeEn === 1'b1)) ? writeData : output2;
   assign input3 = ((writeRegSel === 3'b010) & (writeEn === 1'b1)) ? writeData : output3;
   assign input4 = ((writeRegSel === 3'b011) & (writeEn === 1'b1)) ? writeData : output4;
   assign input5 = ((writeRegSel === 3'b100) & (writeEn === 1'b1)) ? writeData : output5;
   assign input6 = ((writeRegSel === 3'b101) & (writeEn === 1'b1)) ? writeData : output6;
   assign input7 = ((writeRegSel === 3'b110) & (writeEn === 1'b1)) ? writeData : output7;
   assign input8 = ((writeRegSel === 3'b111) & (writeEn === 1'b1)) ? writeData : output8;
   
   assign read1Data = read1RegSel[0] ? read1RegSel[1] ? read1RegSel[2] ? output8 : output4 : read1RegSel[2] ? output6 : output2 : read1RegSel[1] ? read1RegSel[2] ? output7 : output3 : read1RegSel[2] ? output5 : output1;
   assign read2Data = read2RegSel[0] ? read2RegSel[1] ? read2RegSel[2] ? output8 : output4 : read2RegSel[2] ? output6 : output2 : read2RegSel[1] ? read2RegSel[2] ? output7 : output3 : read2RegSel[2] ? output5 : output1;
   assign err = (^({input1, input2, input3, input4, input5, input6, input7, input8, clk, rst, writeEn, read1RegSel, read2RegSel, writeData, writeRegSel}) === 1'bx);
   register reg1 (.out(output1), .in(input1), .clk(clk), .rst(rst));
   register reg2 (.out(output2), .in(input2), .clk(clk), .rst(rst));
   register reg3 (.out(output3), .in(input3), .clk(clk), .rst(rst));
   register reg4 (.out(output4), .in(input4), .clk(clk), .rst(rst));
   register reg5 (.out(output5), .in(input5), .clk(clk), .rst(rst));
   register reg6 (.out(output6), .in(input6), .clk(clk), .rst(rst));
   register reg7 (.out(output7), .in(input7), .clk(clk), .rst(rst));
   register reg8 (.out(output8), .in(input8), .clk(clk), .rst(rst));

endmodule

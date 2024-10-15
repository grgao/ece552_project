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
   parameter WIDTH = 16;

   input        clk, rst;
   input [2:0]  read1RegSel;
   input [2:0]  read2RegSel;
   input [2:0]  writeRegSel;
   input [WIDTH-1:0] writeData;
   input        writeEn;

   output [WIDTH-1:0] read1Data;
   output [WIDTH-1:0] read2Data;
   output        err;

   wire [7:0] write;
   wire [7:0] regwrite;
   wire [15:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;
   wire err0, err1, err2, err3, err4, err5, err6, err7;
   wire errMux0, errMux1, errMux2;

   mux8_1 mux0 (.out(write), .in0(16'b0000000000000001), .in1(16'b0000000000000010), .in2(16'b0000000000000100), .in3(16'b0000000000001000), .in4(16'b0000000000010000), .in5(16'b0000000000100000), .in6(16'b0000000001000000), .in7(16'b0000000010000000), .sel(writeRegSel), .err(errMux0));

   assign regwrite = write & {8{writeEn}};

   register register0 (.in(writeData), .clk(clk), .out(reg0), .rst(rst), .writeEn(regwrite[0]), .err(err0));
   register register1 (.in(writeData), .clk(clk), .out(reg1), .rst(rst), .writeEn(regwrite[1]), .err(err1));
   register register2 (.in(writeData), .clk(clk), .out(reg2), .rst(rst), .writeEn(regwrite[2]), .err(err2));
   register register3 (.in(writeData), .clk(clk), .out(reg3), .rst(rst), .writeEn(regwrite[3]), .err(err3));
   register register4 (.in(writeData), .clk(clk), .out(reg4), .rst(rst), .writeEn(regwrite[4]), .err(err4));
   register register5 (.in(writeData), .clk(clk), .out(reg5), .rst(rst), .writeEn(regwrite[5]), .err(err5));
   register register6 (.in(writeData), .clk(clk), .out(reg6), .rst(rst), .writeEn(regwrite[6]), .err(err6));
   register register7 (.in(writeData), .clk(clk), .out(reg7), .rst(rst), .writeEn(regwrite[7]), .err(err7));  

   mux8_1 mux1 (.out(read1Data), .in0(reg0), .in1(reg1), .in2(reg2), .in3(reg3), .in4(reg4), .in5(reg5), .in6(reg6), .in7(reg7), .sel(read1RegSel), .err(errMux1));
   mux8_1 mux2 (.out(read2Data), .in0(reg0), .in1(reg1), .in2(reg2), .in3(reg3), .in4(reg4), .in5(reg5), .in6(reg6), .in7(reg7), .sel(read2RegSel), .err(errMux2)); 

   assign err = ((^({clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn}))===1'bx) | errMux0 | errMux1 | errMux2 | err0 | err1 | err2 | err3 | err4 | err5 | err6 | err7;
endmodule

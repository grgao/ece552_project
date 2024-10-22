/*
   CS/ECE 552 Spring '22
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
`default_nettype none
module wb (regSrc, inPC, readData, aluout, setRd, wbData);

   // TODO: Your code here
   input wire [1:0] regSrc;
   input wire [15:0] inPC;
   input wire [15:0] readData;
   input wire [15:0] aluout;
   input wire setRd;
   output wire [15:0] wbData;
   mux4_1 mux(.in0(inPC), .in1(readData), .in2(aluout), .in3({15'h0000, setRd}), .sel(regSrc), .out(wbData));
   
endmodule
`default_nettype wire

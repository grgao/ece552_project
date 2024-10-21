/*
   CS/ECE 552 Spring '22
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
`default_nettype none
module decode (instruction, nextPC, asource, bsource, sign_extended_11bit, 8bit, aluOP,
               regsrc, immsrc, memwrt, inva, invb, alujmp, aluopr, branch);
   input [15:0] instruction;
   input [15:0] nextPC;
   output [15:0] asource;
   output [15:0] bsource;
   output [15:0] sign_extended_11bit;
   output [15:0] 8bit;

   // Instruction Decoder

   wire [15:0] sign_extended_5bit;
   wire [15:0] sign_extended_8bit;
   wire [15:0] zero_extended_5bit;
   wire [15:0] zero_extended_8bit;
   wire [15:0] 5bit;
   wire [15:0] rd2;
   wire 0ext;

   regFile_bypass rf(.read1Data(), .read2Data(), .err(), .clk(), .rst(), .read1RegSel(instruction[10:8]), .read2RegSel(instruction[7:5]), .writeRegSel(), .writeData(), .writeEn())

   assign sign_extended_5bit = {{11{instruction[4]}}, instruction[4:0]};
   assign sign_extended_8bit = {{8{instruction[7]}}, instruction[7:0]};
   assign sign_extended_11bit = {{5{instruction[10]}}, instruction[10:0]};
   assign zero_extended_5bit = {11'b0, instruction[4:0]};
   assign zero_extended_8bit = {8'b0, instruction[7:0]};

   mux2_1 5bit_mux(.in0(sign_extended_5bit), .in1(zero_extended_5bit), .sel(0ext), .out(5bit));
   mux2_1 8bit_mux(.in0(sign_extended_8bit), .in1(zero_extended_8bit), .sel(0ext), .out(8bit));

   mux4_1 bsource_mux(.in0(rd2), .in1(5bit), .in2(8bit), .in3(sign_extended_11bit), .sel(bsource_sel), .out(bsource));



   
endmodule
`default_nettype wire

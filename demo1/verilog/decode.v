/*
   CS/ECE 552 Spring '22
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
`default_nettype none
module decode (clk, rst, err, PC_in, instruction, wb_data, next_PC_in, PC_out, next_PC_out, srca, srcb, eightBits, elevenBits, instruct,
               regsrc, immsrc, memwrt, inva, invb, branch, alujmp, aluopr, dmp, memread);
   input wire clk;
   input wire rst;
   output wire err;
   // input - wires
   input wire [15:0]PC_in;
   input wire [15:0]instruction;
   input wire [15:0]wb_data;
   input wire [15:0]next_PC_in;

   // output -wires
   output wire [15:0] PC_out;
   output wire [15:0] next_PC_out;
   output wire [15:0]srca;
   output wire [15:0]srcb;
   output wire [15:0]eightBits;
   output wire [15:0]elevenBits;
   output wire [1:0]instruct;

   // output - decode
   output wire [1:0]regsrc;
   output wire immsrc;
   output wire memwrt;
   output wire inva;
   output wire invb;
   output wire [3:0]branch;
   output wire alujmp;
   output wire [3:0]aluopr;
   output wire dmp;
   output wire memread;
   wire [1:0]regdst, bsource;
   wire ext, regwrt, asource;
   instruction_decoder instrucDecode(.instruction(instruction[15:11]), .regdst(regdst), .ext(ext), 
                                    .regwrt(regwrt), .bsource(bsource), .branch(branch), .aluop(aluopr), 
                                    .alujmp(alujmp), .invb(invb), .inva(inva), .memwrt(memwrt), .immsrc(immsrc),
                                    .asource(asource), .regsrc(regsrc), .dmp(dmp), .memread(memread));
   
   wire [2:0]wrtreg;
   mux4_1 #(3) muxWriteRegister(.in0(instruction[7:5]), .in1(instruction[10:8]), .in2(instruction[4:2]), 
                                 .in3(3'b111), .sel(regdst), .out(wrtreg));

   wire[15:0]src1, src2;
   regFile_bypass registerFile(.read1Data(src1), .read2Data(src2), .err(err), .clk(clk), 
                              .rst(rst), .read1RegSel(instruction[10:8]), .read2RegSel(instruction[7:5]),
                              .writeRegSel(wrtreg), .writeData(wb_data), .writeEn(regwrt));
                     
   wire [15:0] SE_5bits, ZE_5bits, SE_8bits, ZE_8bits, fiveBits;
   assign SE_5bits = {{11{instruction[4]}}, instruction[4:0]};
   assign ZE_5bits = {{11'b0}, instruction[4:0]};
   assign SE_8bits = {{8{instruction[7]}}, instruction[7:0]};
   assign ZE_8bits = {{8'b0}, instruction[7:0]};
   assign elevenBits = {{5{instruction[10]}}, instruction[10:0]};

   mux2_1 mux5bit(.in0(SE_5bits), .in1(ZE_5bits), .sel(ext), .out(fiveBits));
   mux2_1 mux8bit(.in0(SE_8bits), .in1(ZE_8bits), .sel(ext), .out(eightBits));
   wire [15:0]shftSrcA;
   assign shftSrcA = src1 << 8;
   mux4_1 bsourceMux(.in0(src2), .in1(fiveBits), .in2(eightBits), .in3(elevenBits), .sel(bsource), .out(srcb));
   mux2_1 asourceMux(.in0(src1), .in1(shftSrcA), .sel(asource), .out(srca));
   assign instruct = instruction[1:0];
   assign PC_out = PC_in;
   assign next_PC_out = next_PC_in;
endmodule
`default_nettype wire

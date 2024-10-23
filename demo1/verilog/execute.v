/*
   CS/ECE 552 Spring '22
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
`default_nettype none
module execute (PC_in, eightBits, elevenBits, asrc, bsrc, next_PC_in, instruct, wb_in, 
regsrc, immsrc, memwrt, inva, invb, branch, alujmp, aluopr, PC_out, jmpSource, 
alu_out, srcb_out, next_PC_out, wb_out, setrd, regsrc_out, alujmp_out, brchcnd, memwrt_out, dmp, dmp_out, memread, memread_out);
   
   //////////// INPUTS /////////////
   // wires
   input wire [15:0]PC_in;
   input wire [15:0]eightBits;
   input wire [15:0]elevenBits;
   input wire [15:0]asrc;
   input wire [15:0]bsrc;
   input wire [15:0]next_PC_in;
   input wire [1:0]instruct;
   input wire [15:0]wb_in;

   // decoder
   input wire [1:0]regsrc;
   input wire immsrc;
   input wire memwrt;
   input wire inva;
   input wire invb;
   input wire [2:0]branch;
   input wire alujmp;
   input wire [3:0]aluopr;
   input wire dmp;
   input wire memread;

   ///////////  OUTPUTS /////////////
   // wires
   output wire [15:0]PC_out;
   output wire [15:0]jmpSource;
   output wire [15:0]alu_out;
   output wire [15:0]srcb_out;
   output wire [15:0]next_PC_out;
   output wire [15:0]wb_out;
   output wire setrd;

   // decode
   output wire [1:0]regsrc_out;
   output wire alujmp_out;
   output wire brchcnd;
   output wire memwrt_out;
   output wire dmp_out;
   output wire memread_out;

   wire SF, ZF, OF, CF;

   alu alu1(.InA(asrc), .InB(bsrc), .Cin(inva | invb), .Oper(aluopr), .invA(inva), .invB(invb), 
            .sign(1'b1), .Out(alu_out), .instruct(instruct), .ZF(ZF), .OF(OF), .SF(SF), .CF(CF));

   branchCondition bc1(.branch(branch), .SF(SF), .ZF(ZF), .OF(OF), .CF(CF), .brchcnd(brchcnd), .setrd(setrd));

   mux2_1 mux1(.in0(eightBits), .in1(elevenBits), .sel(immsrc), .out(jmpSource));

   assign PC_out = PC_in;
   assign srcb_out = bsrc;
   assign next_PC_out = next_PC_in;
   assign wb_out = wb_in;
   assign regsrc_out = regsrc;
   assign alujmp_out = alujmp;
   assign memwrt_out = memwrt;
   assign memread_out = memread;
   assign dmp_out = dmp;

endmodule
`default_nettype wire

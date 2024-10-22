/*
   CS/ECE 552 Spring '22
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
`default_nettype none
module execute (PC_in, 8bits, 10bits, asrc, bsrc, next_PC_in, instruct, wb_in, 
regsrc, immsrc, memwrt, inva, invb, branch, alujmp, aluopr, PC_out, jmpSource, 
alu_out, srcb_out, next_PC_out, wb_out, setrd, regsrc_out, alujmp_out, brchcnd, memwrt_out);
   
   //////////// INPUTS /////////////
   // wires
   input [15:0]PC_in;
   input [7:0]8bits;
   input [8:0]10bits;
   input [15:0]asrc;
   input [15:0]bsrc;
   input [15:0]next_PC_in;
   input [1:0]instruct;
   input [15:0]wb_in;

   // decoder
   input regsrc;
   input immsrc;
   input memwrt;
   input inva;
   input invb;
   input [2:0]branch;
   input alujmp;
   input [3:0]aluopr;

   ///////////  OUTPUTS /////////////
   // wires
   output [15:0]PC_out;
   output [15:0]jmpSource;
   output [15:0]alu_out;
   output [15:0]srcb_out;
   output [15:0]next_PC_out;
   output [15:0]wb_out;
   output setrd;

   // decode
   output regsrc_out;
   output alujmp_out;
   output brchcnd;
   output memwrt_out;

   wire SF, ZF, OF, CF;

   alu alu1(.InA(asrc), .InB(bsrc), .Cin(inva | invb), .Oper(aluopr), .invA(inva), .invB(invb), 
            .sign(1'b1), .Out(alu_out), .instruct(instruct), .ZF(ZF), .OF(OF), .SF(SF), .CF(CF));

   branchCondition bc1(.branch(branch), .SF(SF), .ZF(ZF), .OF(OF), .CF(CF), .brchcnd(brchcnd), .setrd(setrd));

   mux2_1 mux1(.in0(8bits), .in1(10bits), .sel(immsrc), .out(jmpSource));

   assign PC_out = PC_in;
   assign srcb_out = bsrc;
   assign next_PC_out = next_PC_in;
   assign wb_out = wb_in;
   assign regsrc_out = regsrc;
   assign alujmp_out = alujmp;
   assign memwrt_out = memwrt;

endmodule
`default_nettype wire

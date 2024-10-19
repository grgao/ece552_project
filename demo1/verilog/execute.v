/*
   CS/ECE 552 Spring '22
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
`default_nettype none
module execute (opA, opB, aluop, invb, inva, immsrc, branch, aluout, setrd, brchCnd, PCaddersrc, instruction2bits);

   // TODO: Your code here
   input wire [15:0] opA;
   input wire [15:0] opB;
   input wire [3:0] aluop;
   input wire invb;
   input wire inva;
   input wire immsrc;
   input wire [2:0] branch;
   input wire [2:0] instruction2bits;
   output wire [15:0] aluout;
   output wire setrd;
   output wire brchCnd;
   output wire PCaddersrc;
   
   wire [2:0] Oper; // final operation code generated for ALU
   wire invA, invB; // might need to invert A and B for Sub and ANDN instructions when instruction is determined
   wire SF, ZF, OF, CF; // flags generated by ALU
   ALUOperation ALUOperation(.ALUOpr(aluop), .instruction2bits(instruction2bits), .ALUOp(Oper), .invA(invA), .invB(invB));
   alu ALU(.InA(opA), .InB(opB), .Cin(1'b0), .Oper(Oper), .invA(invA | inva), .invB(invB | invb), .sign(SF), .Out(aluout), .Zero(ZF), .Ofl(OF));






   
endmodule
`default_nettype wire

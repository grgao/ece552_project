/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 3

    A multi-bit ALU module (defaults to 16-bit). It is designed to choose
    the correct operation to perform on 2 multi-bit numbers from rotate
    left, shift left, shift right arithmetic, shift right logical, add,
    or, xor, & and.  Upon doing this, it should output the multi-bit result
    of the operation, as well as drive the output signals Zero and Overflow
    (OFL).
*/
module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, instruct, ZF, OF, SF, CF);
    `include "opcodes.v"  
    parameter OPERAND_WIDTH = 16;    
    parameter NUM_OPERATIONS = 4;
       
    input  [OPERAND_WIDTH -1:0] InA ; // Input operand A
    input  [OPERAND_WIDTH -1:0] InB ; // Input operand B
    input                       Cin ; // Carry in
    input  [NUM_OPERATIONS-1:0] Oper; // Operation type
    input                       invA; // Signal to invert A
    input                       invB; // Signal to invert B
    input                       sign; // Signal for signed operation
    input  [1:0]                instruct; // opcode for r-type instructions
    output [OPERAND_WIDTH -1:0] Out ; // Result of computation
    output                      OF ; // Signal if overflow occured
    output                      ZF; // Signal if Out is 0
    output                      SF; // Sign Flag
    output                      CF; //carry out flag

    wire [OPERAND_WIDTH -1:0] actA;
    wire [OPERAND_WIDTH -1:0] actB; //actual inputs after inversion if needed
    wire [OPERAND_WIDTH -1:0] out_shft;
    wire [OPERAND_WIDTH -1:0]out_add;
    wire [NUM_OPERATIONS - 1 : 0]actualOp;
    assign actualOp = (Oper === `OP) ? {2'b01, instruct} : (Oper === `OPSHFT) ? {2'b00 ,instruct} : Oper;
    //invert A if needed
    assign actA = (invA | (actualOp === `SUB)) ? ~InA : InA;
    //invert B if needed
    assign actB = (invB | (actualOp === `ANDN))? ~InB : InB;
    
    shifter shift(.In(actA), .ShAmt(actB[3:0]), .Oper(actualOp[1:0]), .Out(out_shft));

    add add(.a(actA), .b(actB), .cin(Cin | (actualOp === `SUB)), .out(out_add), .sign(sign), .overflow(OF), .cout(CF));

    assign Out = actualOp[3] ? (actualOp[2] ? actA:(actualOp[0] ? actB : {actA[0], actA[1], actA[2], actA[3], actA[4], actA[5], actA[6], actA[7], actA[8], actA[9], actA[10], actA[11], actA[12], actA[13], actA[14], actA[15]})) : 
            (actualOp[2] ? (actualOp[1] ? (actualOp[0] ? actA&actB : actA^actB) : (out_add)): out_shft);

    assign ZF = (Out == 0);
    assign SF = (Out[OPERAND_WIDTH - 1]);

endmodule

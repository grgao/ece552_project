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
`include "opcodes.v"
module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, SF, ZF, OF, CF);
    parameter OPERAND_WIDTH = 16;    
    parameter NUM_OPERATIONS = 4;
       
    input  [OPERAND_WIDTH -1:0] InA ; // Input operand A
    input  [OPERAND_WIDTH -1:0] InB ; // Input operand B
    input                       Cin ; // Carry in
    input  [NUM_OPERATIONS-1:0] Oper; // Operation type
    input                       invA; // Signal to invert A
    input                       invB; // Signal to invert B
    input                       sign; // Signal for signed operation
    output [OPERAND_WIDTH -1:0] Out ; // Result of computation
    output                      SF ; // Signal result is negative
    output                      OF ; // Signal if overflow occured
    output                      ZF; // Signal if Out is 0
    output                      CF;  // Signal if carry out

    wire [OPERAND_WIDTH -1:0] actA;
    wire [OPERAND_WIDTH -1:0] actB; //actual inputs after inversion if needed
    wire [OPERAND_WIDTH -1:0] out_shft;
    wire [OPERAND_WIDTH -1:0]out_add;
    wire [OPERAND_WIDTH -1:0] btr; 
    reg [OPERAND_WIDTH -1:0] setOut;

    //invert A if needed
    assign actA = invA ? ~InA : InA;
    //invert B if needed
    assign actB = invB ? ~InB : InB;

    //bit reverse
    assign btr[0] = InA[15];
    assign btr[1] = InA[14];
    assign btr[2] = InA[13];
    assign btr[3] = InA[12];
    assign btr[4] = InA[11];
    assign btr[5] = InA[10];
    assign btr[6] = InA[9];
    assign btr[7] = InA[8];
    assign btr[8] = InA[7];
    assign btr[9] = InA[6];
    assign btr[10] = InA[5];
    assign btr[11] = InA[4];
    assign btr[12] = InA[3];
    assign btr[13] = InA[2];
    assign btr[14] = InA[1];
    assign btr[15] = InA[0];

    shifter shift(.In(actA), .ShAmt(actB[3:0]), .Oper(Oper[1:0]), .Out(out_shft));

    add add(.a(actA), .b(actB), .cin(Cin), .out(out_add), .sign(sign), .overflow(OF), .cout(CF));

    always @(*) begin
        setOut = 0;
        casex (Oper)
            `RLL: setOut = out_shft; // shift or rotate
            `SLL: setOut = out_shft; // shift or rotate
            `RRL: setOut = out_shft; // shift or rotate
            `SRL: setOut = out_shft; // shift or rotate
            `ADD: setOut = out_add; // adder
            `AND: setOut = actA & actB; // and
            `OR: setOut = actA | actB; // or
            `XOR: setOut = actA ^ actB; // xor
            `BTR: setOut = btr; // bit reverse
            `RTB: setOut = InB; // return source b
            `RTA: setOut = InA; // return source a
            default: setOut = 0;
        endcase
    end

    assign Out = setOut;
    assign ZF = (Out == 0);
    assign SF = Out[OPERAND_WIDTH -1];

endmodule

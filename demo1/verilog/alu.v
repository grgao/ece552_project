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
module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, Zero, Ofl, CF);
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
    output                      Ofl ; // Signal if overflow occured
    output                      Zero; // Signal if Out is 0
    output                      CF;  // Signal if carry out

    wire [OPERAND_WIDTH -1:0] actA;
    wire [OPERAND_WIDTH -1:0] actB; //actual inputs after inversion if needed
    wire [OPERAND_WIDTH -1:0] out_shft;
    wire [OPERAND_WIDTH -1:0]out_add;
    wire [OPERAND_WIDTH -1:0] btr; 

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

    add add(.a(actA), .b(actB), .cin(Cin), .out(out_add), .sign(sign), .overflow(Ofl), .cout(CF));

    assign Out = Oper[3] ? (Oper[0] ? InB : btr) : (Oper[2] ? (Oper[1] ? (Oper[0] ? actA^actB : actA|actB) : (Oper[0] ? actA&actB : out_add)): out_shft);

    assign Zero = (Out == 0);

endmodule

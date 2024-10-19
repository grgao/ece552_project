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
module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, Zero, Ofl);
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

    wire [OPERAND_WIDTH -1:0] actA;
    wire [OPERAND_WIDTH -1:0] actB; //actual inputs after inversion if needed
    wire [OPERAND_WIDTH -1:0] out_shft;
    wire [OPERAND_WIDTH -1:0]out_add;
    wire [OPERAND_WIDTH -1:0]out1;

    //invert A if needed
    assign actA = invA ? ~InA : InA;
    //invert B if needed
    assign actB = invB ? ~InB : InB;

    shifter shift(.In(actA), .ShAmt(actB[3:0]), .Oper(Oper[1:0]), .Out(out_shft));

    add add(.a(actA), .b(actB), .cin(Cin), .out(out_add), .sign(sign), .overflow(Ofl));

    assign Out = Oper[2] ? (Oper[1] ? (Oper[0] ? actA^actB : actA|actB) : (Oper[0] ? actA&actB : out_add)): out_shft;

    assign Zero = (Out == 0);

endmodule

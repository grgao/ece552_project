/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 1
    
    a 1-bit full adder
*/
module fullAdder_1b(s, c_out, a, b, c_in);
    output s;
    output c_out;
	input  a, b;
    input  c_in;

    wire aXorB;
    wire cNandAB;
    wire aNandB;

    xor2 xor1 (.in1(a), .in2(b), .out(aXorB));
    xor2 xor2 (.in1(aXorB), .in2(c_in), .out(s));
    
    nand2 nand1 (.in1(c_in), .in2(aXorB), .out(cNandAB));
    nand2 nand2 (.in1(a), .in2(b), .out(aNandB));
    nand2 nand3 (.in1(cNandAB), .in2(aNandB), .out(c_out));

endmodule

/*
    CS/ECE 552 FALL'22
    Homework #2, Problem 1
    
    a 4-bit CLA module
*/
module cla_4b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    output [N-1:0] sum;
    output         c_out;
    input [N-1: 0] a, b;
    input          c_in;

    wire c1, c2, c3;

    assign c1 = (a[0]&b[0])|((a[0]^b[0])&c_in);
    assign c2 = (a[1]&b[1])|((a[1]^b[1])&c1);
    assign c3 = (a[2]&b[2])|((a[2]^b[2])&c2);
    assign c_out = (a[3]&b[3])|((a[3]^b[3])&c3);

    fullAdder_1b fa1(.s(sum[0]), .c_out(), .a(a[0]), .b(b[0]), .c_in(c_in));
    fullAdder_1b fa2(.s(sum[1]), .c_out(), .a(a[1]), .b(b[1]), .c_in(c1));
    fullAdder_1b fa3(.s(sum[2]), .c_out(), .a(a[2]), .b(b[2]), .c_in(c2));
    fullAdder_1b fa4(.s(sum[3]), .c_out(), .a(a[3]), .b(b[3]), .c_in(c3));

endmodule

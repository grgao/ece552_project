/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 1
    
    a 16-bit CLA module
*/
module cla_16b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 16;

    output [N-1:0] sum;
    output         c_out;
    input [N-1: 0] a, b;
    input          c_in;

    // YOUR CODE HERE
    wire c1, c2, c3;

    assign c1 = ((a[0]&b[0])&(a[1]|b[1])&(a[2]|b[2])&(a[3]|b[3]))|((a[1]&b[1])&(a[2]|b[2])&(a[3]|b[3]))|((a[2]&b[2])&(a[3]|b[3]))|((a[3]&b[3]))|((a[0]|b[0])&(a[1]|b[1])&(a[2]|b[2])&(a[3]|b[3])&c_in);
    assign c2 = ((a[4]&b[4])&(a[5]|b[5])&(a[6]|b[6])&(a[7]|b[7]))|((a[5]&b[5])&(a[6]|b[6])&(a[7]|b[7]))|((a[6]&b[6])&(a[7]|b[7]))|((a[7]&b[7]))|((a[4]|b[4])&(a[5]|b[5])&(a[6]|b[6])&(a[7]|b[7])&c1);
    assign c3 = ((a[8]&b[8])&(a[9]|b[9])&(a[10]|b[10])&(a[11]|b[11]))|((a[9]&b[9])&(a[10]|b[10])&(a[11]|b[11]))|((a[10]&b[10])&(a[11]|b[11]))|((a[11]&b[11]))|((a[8]|b[8])&(a[9]|b[9])&(a[10]|b[10])&(a[11]|b[11])&c2);
    assign c_out = ((a[12]&b[12])&(a[13]|b[13])&(a[14]|b[14])&(a[15]|b[15]))|((a[13]&b[13])&(a[14]|b[14])&(a[15]|b[15]))|((a[14]&b[14])&(a[15]|b[15]))|((a[15]&b[15]))|((a[12]|b[12])&(a[13]|b[13])&(a[14]|b[14])&(a[15]|b[15])&c3);
    cla_4b fa1(.sum(sum[3:0]), .c_out(), .a(a[3:0]), .b(b[3:0]), .c_in(c_in));
    cla_4b fa2(.sum(sum[7:4]), .c_out(), .a(a[7:4]), .b(b[7:4]), .c_in(c1));
    cla_4b fa3(.sum(sum[11:8]), .c_out(), .a(a[11:8]), .b(b[11:8]), .c_in(c2));
    cla_4b fa4(.sum(sum[15:12]), .c_out(), .a(a[15:12]), .b(b[15:12]), .c_in(c3));

endmodule

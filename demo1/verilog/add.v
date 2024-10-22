module add(a, b, out, cin, sign, overflow, cout);
    input [15:0] a;
    input [15:0] b;
    output [15:0] out;
    output overflow;
    input cin;
    input sign;

    output cout;

    cla_16b adder(.sum(out), .c_out(cout), .a(a), .b(b), .c_in(cin));
    assign overflow = sign ? (a[15]^b[15]) ? 0: (out[15]^a[15]) : cout;
endmodule
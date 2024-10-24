module add(a, b, out, cin, sign, overflow, cout);
    input [15:0] a;
    input [15:0] b;
    output [15:0] out;
    output overflow;
    input cin;
    input sign;

    output cout;
    wire  [16:0] srca, srcb, outWire;

    assign srca = {1'b0, a};
    assign srcb = {1'b0, b};
    assign outWire = a+b +cin;
    assign cout = outWire[16];
    assign out = outWire[15:0];
    assign overflow = sign ? (a[15]^b[15]) ? 0: (out[15]^a[15]) : cout;
endmodule
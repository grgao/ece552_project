module register(in, clk, out, rst, writeEn, err);
parameter WIDTH = 16;
input [WIDTH-1:0] in; 
input clk;
input rst;
input writeEn;
output [WIDTH-1:0] out;
output err;
wire [WIDTH-1:0] d;
wire [WIDTH-1:0] q;

assign d = writeEn ? in : q;

dff dff[WIDTH-1:0] (.q(q), .d(d), .clk(clk), .rst(rst));

assign out = q;
assign err = (^({in, writeEn, clk, rst}))===1'bx;
endmodule
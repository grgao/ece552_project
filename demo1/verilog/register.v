/**
 * Parametrizable register module
 *
 */
module register (in, out, clk, rst);
    parameter WIDTH = 16;
    // declare parametrized width input, output and clock, reset signals
    input [WIDTH-1:0] in;
    input clk, rst;
    output [WIDTH-1:0] out;
    // vector instantiation of DFFs
    dff ffs[WIDTH-1:0] (.q(out), .d(in), .clk(clk), .rst(rst));
endmodule
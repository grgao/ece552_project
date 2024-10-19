module mux4_1(in0, in1, in2, in3, sel, out);
    parameter WIDTH = 16;
    input [WIDTH-1:0] in0;
    input [WIDTH-1:0] in1;
    input [WIDTH-1:0] in2;
    input [WIDTH-1:0] in3;
    input [1:0] sel;
    output [WIDTH-1:0] out;

    assign out = (sel == 2'b00) ? in0 :
                 (sel == 2'b01) ? in1 :
                 (sel == 2'b10) ? in2 :
                 in3;
endmodule
module mux8_1 (out, in0, in1, in2, in3, in4, in5, in6, in7, sel, err);
   parameter WIDTH = 16;
   output [WIDTH-1:0] out;
   input [WIDTH-1:0] in0;
   input [WIDTH-1:0] in1;
   input [WIDTH-1:0] in2;
   input [WIDTH-1:0] in3;
   input [WIDTH-1:0] in4;
   input [WIDTH-1:0] in5;
   input [WIDTH-1:0] in6;
   input [WIDTH-1:0] in7;
   input [2:0]sel;
   output err;

   assign out = (sel == 3'b000) ? in0 :
                (sel == 3'b001) ? in1 :
                (sel == 3'b010) ? in2 :
                (sel == 3'b011) ? in3 :
                (sel == 3'b100) ? in4 :
                (sel == 3'b101) ? in5 :
                (sel == 3'b110) ? in6 :
                in7;
   
   assign err = (^({in0, in1, in2, in3, in4, in5, in6, in7, sel}))===1'bx;
endmodule
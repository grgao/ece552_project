module pc(clk, rst, pc_in, pc_out);
    input clk;
    input rst;
    input [15:0] pc_in;
    output [15:0] pc_out;
    wire [15:0] sum;

    cla_16b pcAdder(.sum(sum), .c_out(), .a(pc_in), .b(16'h1), .c_in(1'b0));
    dff dff1[15:0](.d(sum), .clk(clk), .rst(rst), .q(pc_out));
endmodule
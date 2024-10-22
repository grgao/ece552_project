module pc(clk, rst, pc_in, pc_out);
    input clk;
    input rst;
    input [15:0] pc_in;
    output [15:0] pc_out;

    dff dff1[15:0](.d(pc_in), .clk(clk), .rst(rst), .q(pc_out));
endmodule
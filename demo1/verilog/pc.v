module pc(clk, rst, pc_in, pc_out);
    input clk;
    input rst;
    input [15:0] pc_in; // current PC
    output [15:0] pc_out; // next PC

    wire [15:0] pc_ff; // flip-floped current PC

    cla_16b pcAdder(.sum(pc_out), .c_out(), .a(pc_ff), .b(16'h0002), .c_in(1'b0)); // 2 bytes per instruction
    dff dff1[15:0](.d(pc_in), .clk(clk), .rst(rst), .q(pc_ff));
endmodule
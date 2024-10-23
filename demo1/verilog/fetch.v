/*
   CS/ECE 552 Spring '22
  
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
`default_nettype none
module fetch (instruction, branch_pc, pc, clk, rst);
   input wire [15:0] pc;
   input wire clk;
   input wire rst;
   output wire [15:0] instruction;
   output wire [15:0] branch_pc;
   wire [15:0] pc_out;

   pc pc1(.clk(clk), .rst(rst), .pc_out(pc_out), .pc_in(pc));
   add pcAdder(.out(branch_pc), .overflow(), .a(pc_out), .b(16'h2), .cin(1'b0), .sign(1'b0));
   memory2c instructionMem(.data_out(instruction), .addr(pc_out), .enable(1'b1), .wr(1'b0), .data_in(), .clk(clk), .rst(rst), .createdump(1'b1));
   
endmodule
`default_nettype wire

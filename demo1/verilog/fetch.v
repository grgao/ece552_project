/*
   CS/ECE 552 Spring '22
  
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
`default_nettype none
module fetch (instruction, pc_in, pc_out, clk, rst);
   input clk;
   input rst;
   input [15:0] pc_in; // current PC
   output [15:0] pc_out; // next PC
   output [15:0] instruction; // instruction to be fetched

   wire [15:0] pc_ff; // flip-floped current PC

   cla_16b pcAdder(.sum(pc_out), .c_out(), .a(pc_ff), .b(16'h0002), .c_in(1'b0)); // 2 bytes per instruction
   dff dff1[15:0](.d(pc_in), .clk(clk), .rst(rst), .q(pc_ff));
   memory2c instructionMem(.data_out(instruction), .addr(pc_ff), .enable(1'b1), .wr(1'b0), .data_in(), .clk(clk), .rst(rst), .createdump(1'b0));
   
endmodule
`default_nettype wire

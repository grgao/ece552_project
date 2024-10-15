/*
   CS/ECE 552 Spring '22
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
`default_nettype none
module memory (data_in, addr, enable, wr, clk, rst, createdump, data_out);
   input [15:0] data_in;
   input [15:0] addr;
   input enable;
   input wr;
   input clk;
   input rst;
   input createdump;
   output [15:0] data_out;
   reg setDataOut;
   
   memory2c memory(.data_in(data_in), .data_out(data_out), .addr(addr), .enable(enable), .wr(wr), .clk(clk), .rst(rst), .createdump(createdump));
endmodule
`default_nettype wire

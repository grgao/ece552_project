/*
   CS/ECE 552 Spring '22
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
`default_nettype none
module memory (data_in, addr, wb_in, wb_out, clk, rst, data_out, PC_in, regsrc_in,
               jmpSource, brchcnd, alujmp, setrd_in, PC_reg, PC_out, setrd_out, alu_out, regsrc_out, memwrt);
   
   // data mamory
   input [15:0] data_in;
   input [15:0] addr;
   input clk;
   input rst;
   output [15:0] data_out;
   input wb_in;
   output wb_out;

   // jmp
   input [15:0] PC_in;
   input [15:0] jmpSource;
   input setrd_in;
   output [15:0] PC_reg;
   output [15:0] PC_out;
   output alu_out;
   output setrd_out;

   // Decode
   input alujmp;
   input brchcnd;
   input regsrc_in;
   output regsrc_out;
   input memwrt;



   // wires
   wire [15:0]jmpAddr;
   wire [15:0]branchMux;

   add add1(.a(PC_in), .b(jmpSource), .out(jmpAddr), .cin(1'b0), .sign(1'b1), .overflow() .cout());
   mux2_1 mux1(.in0(PC_in), .in1(jmpAddr), .sel(brchcnd), .out(branchMux));
   mux2_1 mux2(.in0(branchMux), in1(addr), .sel(alujmp), .out(PC_out));
   memory2c memory(.data_in(data_in), .data_out(data_out), .addr(addr), .enable(1'b1), .wr(memwrt), .clk(clk), .rst(rst), .createdump(1'b1));

   assign PC_reg = PC_in;
   assign setrd_out = setrd_in;
   assign alu_out = addr;
   assign wb_out = wb_in;
   assign regsrc_out = regsrc_in;


endmodule
`default_nettype wire

/*
   CS/ECE 552 Spring '22
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
`default_nettype none
module memory (data_in, addr, enable, wr, clk, rst, createdump, data_out, PC_in, regsrc_in,
               jmpSource, brchcnd, alujmp, setrd_in, PC_reg, PC_out, setrd_out, alu_out, regsrc_out);
   
   // data mamory
   input [15:0] data_in;
   input [15:0] addr;
   input enable;
   input wr;
   input clk;
   input rst;
   input createdump;
   output [15:0] data_out;

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



   // wires
   wire [15:0]jmpAddr;
   wire [15:0]branchMux;

   add add1(.a(PC_in), .b(jmpSource), .out(jmpAddr), .cin(1'b0), .sign(), .overflow());
   mux2_1 mux1(.in0(PC_in), .in1(jmpAddr), .sel(brchcnd), .out(branchMux));
   mux2_1 mux2(.in0(branchMux), in1(addr), .sel(alujmp), .out(PC_out));
   memory2c memory(.data_in(data_in), .data_out(data_out), .addr(addr), .enable(enable), .wr(wr), .clk(clk), .rst(rst), .createdump(createdump));

   assign PC_reg = PC_in;
   assign setrd_out = setrd_in;
   assign alu_out = addr;

endmodule
`default_nettype wire

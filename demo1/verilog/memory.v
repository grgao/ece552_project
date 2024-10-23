/*
   CS/ECE 552 Spring '22
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
`default_nettype none
module memory (data_in, addr, wb_in, wb_out, clk, rst, data_out, PC_in, regsrc_in,
               jmpSource, brchcnd, alujmp, setrd_in, PC_reg, PC_out, setrd_out, alu_out, regsrc_out, memwrt, memread, dmp);
   
   // data mamory
   input wire [15:0] data_in;
   input wire [15:0] addr;
   input wire clk;
   input wire rst;
   output wire [15:0] data_out;
   input wire [15:0]wb_in;
   output wire [15:0]wb_out;

   // jmp
   input wire [15:0] PC_in;
   input wire [15:0] jmpSource;
   input wire setrd_in;
   output wire [15:0] PC_reg;
   output wire [15:0] PC_out;
   output wire [15:0]alu_out;
   output wire setrd_out;

   // Decode
   input wire alujmp;
   input wire brchcnd;
   input wire [1:0]regsrc_in;
   output wire [1:0]regsrc_out;
   input wire memwrt;
   input wire dmp;
   input wire memread;



   // wires
   wire [15:0]jmpAddr;
   wire [15:0]branchMux;

   add add1(.a(PC_in), .b(jmpSource), .out(jmpAddr), .cin(1'b0), .sign(1'b1), .overflow(),.cout());
   mux2_1 mux1(.in0(PC_in), .in1(jmpAddr), .sel(brchcnd), .out(branchMux));
   mux2_1 mux2(.in0(branchMux), .in1(addr), .sel(alujmp), .out(PC_out));
   memory2c memory(.data_in(data_in), .data_out(data_out), .addr(addr), .enable(memread), .wr(memwrt), .clk(clk), .rst(rst), .createdump(dmp));

   assign PC_reg = PC_in;
   assign setrd_out = setrd_in;
   assign alu_out = addr;
   assign wb_out = wb_in;
   assign regsrc_out = regsrc_in;


endmodule
`default_nettype wire

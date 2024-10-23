/*
   CS/ECE 552 Spring '22
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
`default_nettype none
module wb (PC_reg, mem_data, alu_out, setrd, regsrc, wb_data);

   input wire [15:0] PC_reg;
   input wire [15:0] mem_data;
   input wire [15:0] alu_out; 
   input wire setrd;
   input wire regsrc;
   output wire wb_data;
   // TODO: Your code here

   mux4_1 mux1(.in0(PC_reg), .in1(mem_data), .in2(alu_out), .in3(setrd), .out(wb_data), .sel(regsrc));
   
endmodule
`default_nettype wire

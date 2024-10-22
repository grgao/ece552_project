/*
   CS/ECE 552 Spring '22
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
`default_nettype none
module memory (halt, data_in, addr, adderSrc, inPC, brchCnd, alujmp, enable, wr, clk, rst, data_out, outPC);
    input wire [15:0] data_in;
    input wire [15:0] addr;
    input wire [15:0] adderSrc;
    input wire [15:0] inPC;
    input wire brchCnd;
    input wire alujmp;
    input wire enable;
    input wire wr;
    input wire clk;
    input wire rst;
    input wire createdump;
    input wire halt;
    output wire [15:0] data_out;
    output wire [15:0] outPC;

    wire [15:0] brchPC;
    wire [15:0] AddedPC;
    cla_16b pcAdder(.sum(AddedPC), .c_out(), .a(inPC), .b(adderSrc), .c_in(1'b0));
    mux2_1 mux1(.in0(inPC), .in1(AddedPC), .sel(brchCnd), .out(brchPC));
    mux2_1 mux2(.in0(brchPC), .in1(addr), .sel(alujmp), .out(outPC));
    memory2c memory(.data_in(data_in), .data_out(data_out), .addr(addr), .enable(enable), .wr(wr), .clk(clk), .rst(rst), .createdump(halt));
endmodule
`default_nettype wire
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
   //65536 word  by 8 bit memory
   reg [7:0] mem [0:65535];

   initial begin
		$readmemh("loadfile_all.img",mem);
	end

   always @(posedge clk, negedge wr) begin
      case({enable, wr})
         2'b0x: begin //no operation
            setDataOut <= 1'b0;
         end
         2'b10: begin //read
            setDataOut <= 1'b1;
         end
         2'b11: begin //write
            setDataOut <= 1'b0;
         end
         default: begin //default
            setDataOut <= 1'b0;
         end
      endcase
   end

   assign data_out = setDataOut ? mem[addr] : 16'b0;
   
endmodule
`default_nettype wire

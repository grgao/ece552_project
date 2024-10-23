/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
`default_nettype none
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input wire clk;
   input wire rst;

   output reg err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here -- should include instantiations of fetch, decode, execute, mem and wb modules */
   wire [15:0]instruction_f_d, branch_pc, pc_d_f;
   fetch f(.instruction(instruction_f_d), .branch_pc(branch_pc), .pc(pc_d_f), .clk(clk), .rst(rst));

   wire [15:0]wbdata_x_d, nextPC_x_d, pc_d_x, srca, srcb, eightBits, elevenBits;
   wire [1:0]instruct, regsrc;
   wire err1, immsrc, memwrt, inva, invb, alujmp, memread, dmp;
   wire [3:0] aluopr;
   wire [3:0]branch;
   decode d(.clk(clk), .rst(rst), .err(err1), .PC_in(branch_pc), .instruction(instruction_f_d), .wb_data(wbdata_x_d),
            .next_PC_in(nextPC_x_d), .PC_out(pc_d_x), .next_PC_out(pc_d_f), .srca(srca), .srcb(srcb), .eightBits(eightBits),
            .elevenBits(elevenBits), .instruct(instruct), .regsrc(regsrc), .immsrc(immsrc), .memwrt(memwrt), .inva(inva), 
            .invb(invb), .branch(branch), .alujmp(alujmp), .aluopr(aluopr), .memread(memread), .dmp(dmp));
   wire [15:0]nextPC_m_x, wb_m_x, pc_x_m, jmpSource, alu_x_m, srcb_out;
   wire [1:0]regsrc_out;
   wire setrd, alujmp_out, brchcnd, memwrt_out, memread_out, dmp_out;
   execute x(.PC_in(pc_d_x), .eightBits(eightBits), .elevenBits(elevenBits), .asrc(srca), .bsrc(srcb), .next_PC_in(nextPC_m_x), 
            .instruct(instruct), .wb_in(wb_m_x), .regsrc(regsrc), .immsrc(immsrc), .memwrt(memwrt), .inva(inva), 
            .invb(invb), .branch(branch), .alujmp(alujmp), .aluopr(aluopr), .PC_out(pc_x_m), .jmpSource(jmpSource), 
            .alu_out(alu_x_m), .srcb_out(srcb_out), .next_PC_out(nextPC_x_d), .wb_out(wbdata_x_d), .setrd(setrd), 
            .regsrc_out(regsrc_out), .alujmp_out(alujmp_out), .brchcnd(brchcnd), .memwrt_out(memwrt_out),
            .dmp(dmp), .memread(memread), .dmp_out(dmp_out), .memread_out(memread_out));
   
   wire[15:0] wb_w_m, mem_data, PC_reg, alu_out_m_w;
   wire setrd_out;
   wire [1:0]regsrc2;
   memory m(.data_in(srcb_out), .addr(alu_x_m), .wb_in(wb_w_m), .wb_out(wb_m_x), .clk(clk), .rst(rst), .data_out(mem_data),
            .PC_in(pc_x_m), .regsrc_in(regsrc_out), .jmpSource(jmpSource), .brchcnd(brchcnd), .alujmp(alujmp_out), 
            .setrd_in(setrd), .PC_reg(PC_reg), .PC_out(nextPC_m_x), .setrd_out(setrd_out), .alu_out(alu_out_m_w), 
            .regsrc_out(regsrc2), .memwrt(memwrt_out), .memread(memread_out), .dmp(dmp_out));
   wb w(.PC_reg(PC_reg), .mem_data(mem_data), .alu_out(alu_out_m_w), .setrd(setrd_out), .regsrc(regsrc2), .wb_data(wb_w_m));
endmodule // proc
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :0:

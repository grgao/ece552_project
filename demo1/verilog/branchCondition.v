
module branchCondition(branch, SF, ZF, OF, CF, brchcnd, setrd);
    `include "opcodes.v"  
    input wire [3:0] branch;
    input wire SF;
    input wire ZF;
    input wire OF;
    input wire CF;
    output wire brchcnd;
    output wire setrd;

    wire beqz, bnez, bltz, bgez, jump, seq, slt, sle, sco;

    assign beqz = (branch === `BEQZ) && ZF;
    assign bnez = (branch === `BNEZ) && ~ZF;
    assign bltz = (branch === `BLTZ) && SF;
    assign bgez = (branch === `BGEZ) && (ZF |(~SF));
    assign seq = (branch === `SEQ) && ZF;
    assign slt = (branch === `SLT) && SF;
    assign sle = (branch === `SLE) && (SF|ZF);
    assign sco = (branch === `SCO) && CF;

    assign brchcnd = (branch === `JUMP) | beqz | bnez | bltz| bgez;
    assign setrd = seq | slt | sle | sco;

endmodule

`include "opcodes.v"
module branchCondition (flags, branch, brchCnd, setRd);
    input [3:0] flags; // SF, ZF, OF, CF from bit 3 to 0
    input [3:0] branch;
    output brchCnd;
    output setRd;

    wire SF, ZF, OF, CF;
    reg setSetRd, setBrchCnd;
    assign {SF, ZF, OF, CF} = flags;
    assign brchCnd = setBrchCnd;
    assign setRd = setSetRd;

    always @(*) begin
        setSetRd = 0;
        setBrchCnd = 0;
        case (branch)
            `BEQZ: setBrchCnd = ZF; // BEQZ
            `BNEZ: setBrchCnd = ~ZF; // BNEZ
            `BLTZ: setBrchCnd = SF; // BLTZ
            `JUMP: setBrchCnd = 1; // JUMP
            `SEQ: setSetRd = ZF;// SEQ
            `SLT: setSetRd = SF; // SLT
            `SLE: setSetRd = SF | ZF; // SLE
            `SCO: setSetRd = ~SF & ~ZF; // SCO
            default: begin 
                setBrchCnd = 1'b0;
                setSetRd = 1'b0;
            end
        endcase
    end
endmodule
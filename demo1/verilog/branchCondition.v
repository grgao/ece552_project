`include "opcodes.v"
module branchCondition (flags, branch, brchCnd, setRd, genCout);
    input [3:0] flags; // SF, ZF, OF, CF from bit 3 to 0
    input [3:0] branch;
    output brchCnd;
    output setRd;
    output genCout;

    wire SF, ZF, OF, CF;
    reg setSetRd, setBrchCnd, setGenCout;
    assign SF = flags[3];
    assign ZF = flags[2];
    assign OF = flags[1];
    assign CF = flags[0];
    assign brchCnd = setBrchCnd;
    assign setRd = setSetRd;
    assign genCout = setGenCout;

    always @(*) begin
        setSetRd = 0;
        setBrchCnd = 0;
        setGenCout = 0;
        case (branch)
            `BEQZ: setBrchCnd = ZF; // BEQZ
            `BNEZ: setBrchCnd = ~ZF; // BNEZ
            `BLTZ: setBrchCnd = SF; // BLTZ
            `BGEZ: setBrchCnd = ~SF; // BGEZ
            `JUMP: setBrchCnd = 1; // JUMP
            `SEQ: setSetRd = ZF;// SEQ
            `SLT: setSetRd = SF ^ OF; // SLT
            `SLE: setSetRd = (SF ^ OF) | ZF ; // SLE
            `SCO: setSetRd = CF; // SCO
            default: begin 
                setBrchCnd = 1'b0;
                setSetRd = 1'b0;
                setGenCout = 1'b0;
            end
        endcase
    end
endmodule
module branchCondition(branch, SF, ZF, OF, CF, brchcnd, setrd);
    `include "opcodes.v"  
    input [3:0] branch;
    input SF;
    input ZF;
    input OF;
    input CF;
    output brchcnd;
    output setrd;

    reg setbrchcnd, setSetRd;

    assign brchcnd = setbrchcnd;
    assign setrd = setSetRd;

    always @(*) begin
        setSetRd = 0;
        setbrchcnd = 0;

        case(branch)
            `BEQZ: setbrchcnd = ZF;
            `BNEZ: setbrchcnd = ~ZF;
            `BLTZ: setbrchcnd = SF;
            `BGEZ: setbrchcnd = ZF | (~SF);
            `JUMP: setbrchcnd = 1'b1;
            `SEQ: setSetRd = ZF;
            `SLT: setSetRd = SF;
            `SLE: setSetRd = SF | ZF;
            `SCO: setSetRd = CO;
            default: begin
                setSetRd = 0;
                setbrchcnd = 0;
            end
        endcase
    end
endmodule

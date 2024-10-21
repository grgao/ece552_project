module branchCondition();
    input [2:0] branch;
    input SF;
    input ZF;
    input OF;
    input CF;
    output brchcnd;
    output setrd;

    wire setBEQZ;
    wire setBNEZ;
    wire setBLTZ;
    wire setBGEZ;
    wire setBSCO;

    assign setBEQZ = (branch === BEQZ) && ZF;
    assign setBNEZ = (branch === BNEZ) && ~ZF;
    assign setBLTZ = (branch === BLTZ) && SF;
    assign setBGEZ = (branch === BEQZ) && (~SF | ZF);
    assign setBSCO = (branch == BEQZ) && CF;
   
    assign brchcnd = (branch == JUMP) | setBEQZ | setBNEZ | setBLTZ | setBGEZ;
    assign setrd = setBEQZ | setBLTZ | setBGEZ | setBSCO;

endmodule

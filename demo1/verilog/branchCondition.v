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
    assign setBGEZ = (branch === BGEZ) && (~SF | ZF);
    assign setBSCO = (branch == BSCO) && CF;
   
    assign brchcnd = (|branch) ? ((branch == JUMP) | setBEQZ | setBNEZ | setBLTZ | setBGEZ) : 0;
    assign setrd = (|branch) ? (setBEQZ | setBLTZ | setBGEZ | setBSCO) : 0;

endmodule

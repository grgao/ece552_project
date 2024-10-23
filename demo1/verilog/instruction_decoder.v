`include "opcodes.v"
module instruction_decoder(instruction, regdst, ext, regwrt, bsource, branch, aluop, alujmp, invb, inva, memwrt, immsrc, asource, regsrc);
    `include "opcodes.v"  
    input wire [4:0] instruction;
    output wire [1:0]regdst;
    output wire ext;
    output wire regwrt;
    output wire [1:0] bsource;
    output wire [2:0] branch;
    output wire [2:0] aluop;
    output wire alujmp;
    output wire invb;
    output wire inva;
    output wire memwrt;
    output wire immsrc;
    output wire asource;
    output wire regsrc;

    reg [1:0]setregdst;
    reg set0ext;
    reg setregwrt;
    reg [1:0]setbsource;
    reg [2:0]setbranch;
    reg [2:0]setaluop;
    reg setalujmp;
    reg setinvb;
    reg setinva;
    reg setmemwrt;
    reg setimmsrc;
    reg setasource;
    reg setregsrc;
    reg setdmp;

    assign regdst = setregdst;
    assign ext = set0ext;
    assign regwrt = setregwrt;
    assign bsource = setbsource;
    assign branch = setbranch;
    assign aluop = setaluop;
    assign alujmp = setalujmp;
    assign invb = setinvb;
    assign inva = setinva;
    assign memwrt = setmemwrt;
    assign immsrc = setimmsrc;
    assign asource = setasource;
    assign regsrc = setregsrc;
    assign dmp = setdmp;

    always @(*) begin
        //default values
        setdmp = 0;
        setregdst = 2'b00;
        set0ext = 0;
        setregwrt = 0;
        setbsource = 2'b00;
        setbranch = 3'b000;
        setaluop = 3'b000;
        setalujmp = 0;
        setinvb = 0;
        setinva = 0;
        setmemwrt = 0;
        setimmsrc = 0;
        setasource = 0;
        setregsrc = 0;

        casex(instruction)
            5'b00000: begin //halt
                setdmp = 1;
            end
            5'b00001: begin//Nop
            end
            5'b00010: begin // siic RS
            end
            5'b00011: begin // NOP / RTI
            end
            5'b00100: begin // J displacement
                setimmsrc = 1;
                setbranch = `JUMP;
            end
            5'b00101: begin // JR
                setbranch = `JUMP;
                setalujmp = 1;
            end
            5'b00110: begin // JAL
                setimmsrc = 1;
                setbranch = `JUMP;
                setregdst = 2'b11;
                setregwrt = 1;
            end
            5'b00111: begin // JALR
                setregdst = 2'b11;
                setregwrt = 1;
                setbranch = `JUMP;
                setalujmp = 1;
            end
            5'b01000: begin//ADDI Rd, Rs, immediate
                setregdst = 2'b00;
                setbsource = 2'b01;
                setregwrt = 1;
                setaluop = `ADD;
                setregsrc = 2'b10;
            end
            5'b01001: begin//SUBI Rd, Rs, immediate
                setregdst = 2'b00;
                setbsource = 2'b01;
                setregwrt = 1;
                setinva = 1;
                setaluop = `ADD;
            end
            5'b01010: begin//XORI Rd, Rs, immediate 
                setregdst = 2'b00;
                setbsource = 2'b01;
                set0ext = 1;
                setregwrt = 1;
                setaluop = `XOR;
            end
            5'b01011: begin//ANDNI Rd, Rs, immediate
                setregdst = 2'b00;
                setbsource = 2'b01;
                set0ext = 1;
                setregwrt = 1;
                setinvb = 1; 
                setaluop = `AND;
            end
            5'b01100: begin // BEQZ Rs, immediate
                setbranch = `BEQZ;
            end
            5'b01101: begin // BNEZ Rs, immediate
                setbranch = `BNEZ;
            end
            5'b01110: begin // BGEZ Rs, immediate
                setbranch = `BGEZ;
            end
            5'b01111: begin // BLTZ Rs, immediate
                setbranch = `BLTZ;
            end
            5'b10000: begin //ST Rd, Rs, immediate
                setbsource = 2'b01;
                setmemwrt = 1;
                setaluop = `ADD;
            end
            5'b10001: begin //LD Rd, Rs, immediate
                setregdst = 2'b00;
                setbsource = 2'b01;
                setregwrt = 1;
                setregdst = 2'b00;
                setaluop = `ADD;
            end
            5'b10010: begin // SLBI Rs, immediate
                setasource = 1;
                setaluop = `OR;
                set0ext = 1;
                setbsource = 2'b10;
                setregwrt = 1;
                setregsrc = 2'b10;
                setregdst = 2'b01;
            end
            5'b10011: begin//STU Rd, Rs, immediate
                setbsource = 2'b01;
                setregdst = 2'b01;
                setmemwrt = 1;
                setregwrt = 1;
                setaluop = `ADD;
            end
            5'b10100: begin //ROLI Rd, Rs, immediate
                setregdst = 2'b00;
                setbsource = 2'b01;
                setregwrt = 1;
                setaluop = `RLL;
            end
            5'b10101: begin //SLLI Rd, Rs, immediate 
                setregdst = 2'b00;
                setbsource = 2'b01;
                setregwrt = 1;
                setaluop = `SLL;
            end
            5'b10110: begin //RORI Rd, Rs, immediate
                setregdst = 2'b00;
                setbsource = 2'b01;
                setregwrt = 1;
                setaluop = `RRL;
            end
            5'b10111: begin//SRLI Rd, Rs, immediate
                setregdst = 2'b00;
                setbsource = 2'b01;
                setregwrt = 1;
                setaluop = `SRL;
            end
            5'b11000: begin // LBI Rs, immediate
                setregwrt = 1;
                setbsource = 2'b10;
                setregsrc = 2'b10;
                setregdst = 2'b01;
                setaluop = `RTB;
            end
            5'b11001: begin //BTR Rd, Rs
                setregdst = 2'b00;
                setregwrt = 1;
                setaluop = `BTR;
            end
            5'b11010: begin // ROL, SLL, ROR, SRL : Rtype
                setregwrt = 1;
                setregdst = 2'b10;
                setbsource = 2'b00;
                setaluop = `OP;
                setregsrc = 2'b10;
            end
            5'b11011: begin //ADD Rd, Rs, Rt
                setregdst = 2'b10;
                setbsource = 2'b00;
                setregwrt = 1;
                setaluop = `OP;
                setregsrc = 2'b10;
            end
            5'b11100: begin // SEQ Rd, Rs, Rt
                setregdst = 2'b10;
                setbsource = 2'b00;
                setregwrt = 1;
                setbranch = `BEQZ;
                setregsrc = 2'b11;
                setaluop = `ADD;
                setinvb = 1;
            end
            5'b11101: begin // SLT, Rd, Rs, Rt
                setregdst = 2'b10;
                setbsource = 2'b00;
                setregwrt = 1;
                setaluop = `ADD;
                setbranch = `BLTZ;
                setinvb = 1;
                setregsrc = 2'b11;
            end
            5'b11110: begin  // SLE Rd, Rs, Rt
                setregdst = 2'b10;
                setbsource = 2'b00;
                setregwrt = 1;
                setaluop = `ADD;
                setbranch = `BGEZ;
                setinva = 1;
                setregsrc = 2'b11;
            end
            5'b11111: begin // SCO Rd, Rs, Rt
                setregdst = 2'b10;
                setbsource = 2'b00;
                setregwrt = 1;
                setaluop = `ADD;
                setbranch = `BSCO;
                setregsrc = 2'b11;
            end
            default: begin
            end
        endcase
    end

endmodule
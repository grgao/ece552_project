module instruction_decoder(instruction, regdst, 0ext, regwrt, bsource, branch, aluop, alujmp, invb, inva, memwrt, immsrc, asource, regsrc);
    input [4:0] instruction;
    output [1:0]regdst;
    output 0ext;
    output regwrt;
    output [1:0] bsource;
    output branch;
    output [1:0] aluop;
    output alujmp;
    output invb;
    output inva;
    output memwrt;
    output immsrc;
    output asource;
    output regsrc;
    output dmp;

    reg [1:0]setregdst;
    reg set0ext;
    reg setregwrt;
    reg [1:0]setbsource;
    reg setbranch;
    reg [1:0]setaluop;
    reg setalujmp;
    reg setinvb;
    reg setinva;
    reg setmemwrt;
    reg setimmsrc;
    reg setasource;
    reg setregsrc;
    reg setdmp;

    always @(*) begin
        //default values
        setdmp = 0;
        setregdst = 2'b00;
        set0ext = 0;
        setregwrt = 0;
        setbsource = 2'b00;
        setbranch = 0;
        setaluop = 2'b00;
        setalujmp = 0;
        setinvb = 0;
        setinva = 0;
        setmemwrt = 0;
        setimmsrc = 0;
        setasource = 0;
        setregsrc = 0;

        case(instruction)
            5'b00000: begin //halt
                setdmp = 1;
            end
            5'b00001: begin//Nop
            end
            5'b00010: begin
            end
            5'b00011: begin
            end
            5'b00100: begin
            end
            5'b00101: begin
            end
            5'b00110: begin
            end
            5'b00111: begin
            end
            5'b01000: begin//ADDI Rd, Rs, immediate
                setregdst = 2'b01;
                setbsource = 2'b01;
                setregwrt = 1;
            end
            5'b01001: begin//SUBI Rd, Rs, immediate
                setregdst = 2'b01;
                setbsource = 2'b01;
                setregwrt = 1;
                setinva = 1;
            end
            5'b01010: begin
            end
            5'b01011: begin
            end
            5'b01100: begin
            end
            5'b01101: begin
            end
            5'b01110: begin
            end
            5'b01111: begin
            end
            5'b10000: begin
            end
            5'b10001: begin
            end
            5'b10010: begin
            end
            5'b10011: begin
            end
            5'b10100: begin
            end
            5'b10101: begin
            end
            5'b10110: begin
            end
            5'b10111: begin
            end
            5'b11000: begin
            end
            5'b11001: begin
            end
            5'b11010: begin
            end
            5'b11011: begin
            end
            5'b11100: begin
            end
            5'b11101: begin
            end
            5'b11110: begin
            end
            5'b11111: begin
            end
            default: begin
            end
        endcase
    end




endmodule
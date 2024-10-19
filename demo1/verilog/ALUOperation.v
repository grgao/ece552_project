`include "opcodes.v"
module ALUOperation(ALUOpr, instruction2bits, ALUOp, invA, invB);
    input [3:0] ALUOpr;
    input [1:0] instruction2bits;
    output [3:0] ALUOp;
    output invA;
    output invB;

    reg [3:0] ALUOpVal; // value of ALUOp
    reg setInvA; // set invA    
    reg setInvB; // set invB
    always @(*) begin
        ALUOpVal = ALUOpr;
        setInvA = 1'b0;
        setInvB = 1'b0;
        case(ALUOpr)
            `ROS: ALUOpVal = (instruction2bits[0]) ? ((instruction2bits[1]) ?  `SRL : `SLL) : ((instruction2bits[1]) ?  `RRL : `RLL); // R-type
            `LOA: begin
                ALUOpVal = (instruction2bits[1]) ? ((instruction2bits[0]) ?  `AND : `XOR) : `ADD;  // I-type
                setInvA = instruction2bits[0] & ~instruction2bits[1]; // SUB invert Rs
                setInvB = instruction2bits[0] & instruction2bits[1]; // ANDN invert Rt
            end
            default: ALUOpVal = ALUOpr;
        endcase
    end
    assign invA = setInvA;
    assign invB = setInvB;
    assign ALUOp = ALUOpVal;
endmodule
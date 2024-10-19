`define RLL 4'b0000
`define SLL 4'b0001
`define RRL 4'b0010
`define SRL 4'b0011
`define ADD 4'b0100
`define AND 4'b0101
`define OR  4'b0110
`define XOR 4'b0111
`define BTR 4'b1000
`define RTB 4'b1001 // return source b.
// Note that ROS and LOA do not appear in ALU instantiation and will be determined as one of an actual operations
`define ROS 4'b1010 // rotate or shift
`define LOA 4'b1011 // logical or arithmetic


// branch bits
`define BEQZ 4'b0001
`define BNEZ 4'b0010
`define BLTZ 4'b0011
`define BGEZ 4'b0100
`define JUMP 4'b0101
`define SEQ 4'b0110
`define SLT 4'b0111
`define SLE 4'b1000
`define SCO 4'b1001

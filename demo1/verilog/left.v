module left (In, Out, Shft_Rot, ShAmt);
    input [15:0] In;
    input Shft_Rot;
    input [3:0] ShAmt;
    output [15:0] Out;

    wire [15:0] mux1;
    wire [15:0] mux2;
    wire [15:0] mux3;

    assign mux1 = Shft_Rot ? (ShAmt[0] ? In << 1 : In) : (ShAmt[0] ? ((In<<1)|(In>>15)) : In);
    assign mux2 = Shft_Rot ? (ShAmt[1] ? mux1 << 2 : mux1) : (ShAmt[1] ? ((mux1<<2)|(mux1>>14)) : mux1);
    assign mux3 = Shft_Rot ? (ShAmt[2] ? mux2 << 4 : mux2) : (ShAmt[2] ? ((mux2<<4)|(mux2>>12)) : mux2);
    assign Out = Shft_Rot ? (ShAmt[3] ? mux3 << 8 : mux3) : (ShAmt[3] ? ((mux3<<8)|(mux3>>8)) : mux3);


endmodule
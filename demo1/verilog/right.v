module right (In, Out, Arith_Log, ShAmt);
    input [15:0] In;
    input Arith_Log;
    input [3:0] ShAmt;
    output [15:0] Out;

    wire [15:0] mux1, mux2, mux3;

    wire [15:0] shft1, shft2, shft4, shft8;

    assign shft1 = In >> 1;

    assign mux1 = Arith_Log ? (ShAmt[0] ? In >> 1 : In) : (ShAmt[0] ? {{1{In[15]}}, shft1[14:0]} : In);
    assign shft2 = mux1 >> 2;

    assign mux2 = Arith_Log ? (ShAmt[1] ? mux1 >> 2 : mux1) : (ShAmt[1] ? {{2{mux1[15]}}, shft2[13:0]} : mux1);
    assign shft4 = mux2 >> 4;
    
    assign mux3 = Arith_Log ? (ShAmt[2] ? mux2 >> 4 : mux2) : (ShAmt[2] ? {{4{mux2[15]}}, shft4[11:0]} : mux2);
    assign shft8 = mux3 >> 8;

    assign Out = Arith_Log ? (ShAmt[3] ? mux3 >> 8 : mux3) : (ShAmt[3] ? {{8{mux3[15]}}, shft8[7:0]} : mux3);

endmodule
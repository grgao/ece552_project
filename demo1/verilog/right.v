module right (In, Out, Shft_Rot, ShAmt);
    input [15:0] In;
    input Shft_Rot;
    input [3:0] ShAmt;
    output [15:0] Out;

    wire [15:0] mux1, mux2, mux3;

    assign mux1 = Shft_Rot ? (ShAmt[0] ? In >> 1 : In) : (ShAmt[0] ? {In[0], In[15:1]} : In);
    assign mux2 = Shft_Rot ? (ShAmt[1] ? mux1 >> 2 : mux1) : (ShAmt[1] ? {mux1[1:0], mux1[15:2]} : mux1);
    assign mux3 = Shft_Rot ? (ShAmt[2] ? mux2 >> 4 : mux2) : (ShAmt[2] ? {mux2[3:0], mux2[15:4]} : mux2);
    assign Out = Shft_Rot ? (ShAmt[3] ? mux3 >> 8 : mux3) : (ShAmt[3] ? {mux3[7:0], mux3[15:8]} : mux3);

endmodule
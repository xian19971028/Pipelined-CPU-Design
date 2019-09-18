module Shifter_3( data, control, dataOut );
// 2^3的位移量(左移8bit)

input [31:0] data;
input [4:0] control;
output [31:0] dataOut ;

assign dataOut[0] = ( control[3] == 1 ) ? 1'b0 : data[0];
assign dataOut[1] = ( control[3] == 1 ) ? 1'b0 : data[1];
assign dataOut[2] = ( control[3] == 1 ) ? 1'b0 : data[2];
assign dataOut[3] = ( control[3] == 1 ) ? 1'b0 : data[3];
assign dataOut[4] = ( control[3] == 1 ) ? 1'b0 : data[4];
assign dataOut[5] = ( control[3] == 1 ) ? 1'b0 : data[5];
assign dataOut[6] = ( control[3] == 1 ) ? 1'b0 : data[6];
assign dataOut[7] = ( control[3] == 1 ) ? 1'b0 : data[7];
assign dataOut[8] = ( control[3] == 1 ) ? data[0] : data[8];
assign dataOut[9] = ( control[3] == 1 ) ? data[1] : data[9];
assign dataOut[10] = ( control[3] == 1 ) ? data[2] : data[10];
assign dataOut[11] = ( control[3] == 1 ) ? data[3] : data[11];
assign dataOut[12] = ( control[3] == 1 ) ? data[4] : data[12];
assign dataOut[13] = ( control[3] == 1 ) ? data[5] : data[13];
assign dataOut[14] = ( control[3] == 1 ) ? data[6] : data[14];
assign dataOut[15] = ( control[3] == 1 ) ? data[7] : data[15];
assign dataOut[16] = ( control[3] == 1 ) ? data[8] : data[16];
assign dataOut[17] = ( control[3] == 1 ) ? data[9] : data[17];
assign dataOut[18] = ( control[3] == 1 ) ? data[10] : data[18];
assign dataOut[19] = ( control[3] == 1 ) ? data[11] : data[19];
assign dataOut[20] = ( control[3] == 1 ) ? data[12] : data[20];
assign dataOut[21] = ( control[3] == 1 ) ? data[13] : data[21];
assign dataOut[22] = ( control[3] == 1 ) ? data[14] : data[22];
assign dataOut[23] = ( control[3] == 1 ) ? data[15] : data[23];
assign dataOut[24] = ( control[3] == 1 ) ? data[16] : data[24];
assign dataOut[25] = ( control[3] == 1 ) ? data[17] : data[25];
assign dataOut[26] = ( control[3] == 1 ) ? data[18] : data[26];
assign dataOut[27] = ( control[3] == 1 ) ? data[19] : data[27];
assign dataOut[28] = ( control[3] == 1 ) ? data[20] : data[28];
assign dataOut[29] = ( control[3] == 1 ) ? data[21] : data[29];
assign dataOut[30] = ( control[3] == 1 ) ? data[22] : data[30];
assign dataOut[31] = ( control[3] == 1 ) ? data[23] : data[31];

endmodule

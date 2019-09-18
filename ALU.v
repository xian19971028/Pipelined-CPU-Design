module alu( dataA, dataB, Signal, dataOut, zero );

input [31:0] dataA;  // a
input [31:0] dataB;  // b
input [2:0] Signal;  // ctl (ctrl signal from alu_ctl)
output [31:0] dataOut;  // result
output zero;

//   Signal ( 3-bits )
//   AND  : 000
//   OR   : 001
//   ADD  : 010
//   SUB  : 110
//   SLT  : 111

wire [31:0] temp;
wire [31:0] sum;
wire [31:0] Less;
wire invertB;
wire zero;

parameter AND = 3'b000;
parameter OR  = 3'b001;
parameter ADD = 3'b010;
parameter SUB = 3'b110;
parameter SLT = 3'b111;

assign invertB = ( Signal == SUB || Signal == SLT ) ? 1 : 0;

ALU_1bit ALU_1bit1( .dataA( dataA[0] ), .dataB( dataB[0] ), .Signal( Signal ), .cin( invertB ), .sum( sum[0] ), .cout( temp[0] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit2( .dataA( dataA[1] ), .dataB( dataB[1] ), .Signal( Signal ), .cin( temp[0] ), .sum( sum[1] ), .cout( temp[1] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit3( .dataA( dataA[2] ), .dataB( dataB[2] ), .Signal( Signal ), .cin( temp[1] ), .sum( sum[2] ), .cout( temp[2] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit4( .dataA( dataA[3] ), .dataB( dataB[3] ), .Signal( Signal ), .cin( temp[2] ), .sum( sum[3] ), .cout( temp[3] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit5( .dataA( dataA[4] ), .dataB( dataB[4] ), .Signal( Signal ), .cin( temp[3] ), .sum( sum[4] ), .cout( temp[4] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit6( .dataA( dataA[5] ), .dataB( dataB[5] ), .Signal( Signal ), .cin( temp[4] ), .sum( sum[5] ), .cout( temp[5] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit7( .dataA( dataA[6] ), .dataB( dataB[6] ), .Signal( Signal ), .cin( temp[5] ), .sum( sum[6] ), .cout( temp[6] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit8( .dataA( dataA[7] ), .dataB( dataB[7] ), .Signal( Signal ), .cin( temp[6] ), .sum( sum[7] ), .cout( temp[7] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit9( .dataA( dataA[8] ), .dataB( dataB[8] ), .Signal( Signal ), .cin( temp[7] ), .sum( sum[8] ), .cout( temp[8] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit10( .dataA( dataA[9] ), .dataB( dataB[9] ), .Signal( Signal ), .cin( temp[8] ), .sum( sum[9] ), .cout( temp[9] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit11( .dataA( dataA[10] ), .dataB( dataB[10] ), .Signal( Signal ), .cin( temp[9] ), .sum( sum[10] ), .cout( temp[10] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit12( .dataA( dataA[11] ), .dataB( dataB[11] ), .Signal( Signal ), .cin( temp[10] ), .sum( sum[11] ), .cout( temp[11] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit13( .dataA( dataA[12] ), .dataB( dataB[12] ), .Signal( Signal ), .cin( temp[11] ), .sum( sum[12] ), .cout( temp[12] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit14( .dataA( dataA[13] ), .dataB( dataB[13] ), .Signal( Signal ), .cin( temp[12] ), .sum( sum[13] ), .cout( temp[13] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit15( .dataA( dataA[14] ), .dataB( dataB[14] ), .Signal( Signal ), .cin( temp[13] ), .sum( sum[14] ), .cout( temp[14] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit16( .dataA( dataA[15] ), .dataB( dataB[15] ), .Signal( Signal ), .cin( temp[14] ), .sum( sum[15] ), .cout( temp[15] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit17( .dataA( dataA[16] ), .dataB( dataB[16] ), .Signal( Signal ), .cin( temp[15] ), .sum( sum[16] ), .cout( temp[16] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit18( .dataA( dataA[17] ), .dataB( dataB[17] ), .Signal( Signal ), .cin( temp[16] ), .sum( sum[17] ), .cout( temp[17] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit19( .dataA( dataA[18] ), .dataB( dataB[18] ), .Signal( Signal ), .cin( temp[17] ), .sum( sum[18] ), .cout( temp[18] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit20( .dataA( dataA[19] ), .dataB( dataB[19] ), .Signal( Signal ), .cin( temp[18] ), .sum( sum[19] ), .cout( temp[19] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit21( .dataA( dataA[20] ), .dataB( dataB[20] ), .Signal( Signal ), .cin( temp[19] ), .sum( sum[20] ), .cout( temp[20] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit22( .dataA( dataA[21] ), .dataB( dataB[21] ), .Signal( Signal ), .cin( temp[20] ), .sum( sum[21] ), .cout( temp[21] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit23( .dataA( dataA[22] ), .dataB( dataB[22] ), .Signal( Signal ), .cin( temp[21] ), .sum( sum[22] ), .cout( temp[22] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit24( .dataA( dataA[23] ), .dataB( dataB[23] ), .Signal( Signal ), .cin( temp[22] ), .sum( sum[23] ), .cout( temp[23] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit25( .dataA( dataA[24] ), .dataB( dataB[24] ), .Signal( Signal ), .cin( temp[23] ), .sum( sum[24] ), .cout( temp[24] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit26( .dataA( dataA[25] ), .dataB( dataB[25] ), .Signal( Signal ), .cin( temp[24] ), .sum( sum[25] ), .cout( temp[25] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit27( .dataA( dataA[26] ), .dataB( dataB[26] ), .Signal( Signal ), .cin( temp[25] ), .sum( sum[26] ), .cout( temp[26] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit28( .dataA( dataA[27] ), .dataB( dataB[27] ), .Signal( Signal ), .cin( temp[26] ), .sum( sum[27] ), .cout( temp[27] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit29( .dataA( dataA[28] ), .dataB( dataB[28] ), .Signal( Signal ), .cin( temp[27] ), .sum( sum[28] ), .cout( temp[28] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit30( .dataA( dataA[29] ), .dataB( dataB[29] ), .Signal( Signal ), .cin( temp[28] ), .sum( sum[29] ), .cout( temp[29] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit31( .dataA( dataA[30] ), .dataB( dataB[30] ), .Signal( Signal ), .cin( temp[29] ), .sum( sum[30] ), .cout( temp[30] ), .Less( 0 ), .invertB( invertB ) );
ALU_1bit ALU_1bit32( .dataA( dataA[31] ), .dataB( dataB[31] ), .Signal( Signal ), .cin( temp[30] ), .sum( sum[31] ), .cout( temp[31] ), .Less( 0 ), .invertB( invertB ) );

assign Less = { 31'b0, sum[31] };
assign dataOut = ( Signal == SLT ) ? Less : sum;
assign zero = ( sum == 32'b0 ) ? 1 : 0;

endmodule

module Shifter( dataA, dataB, dataOut );
input [31:0] dataA;
input [4:0] dataB;
output [31:0] dataOut;

wire [31:0] ansOfShifter_0;
wire [31:0] ansOfShifter_1;
wire [31:0] ansOfShifter_2;
wire [31:0] ansOfShifter_3;
wire [31:0] ansOfShifter_4;

parameter SLL = 6'b000000;

Shifter_0 Shifter_0( .data( dataA ), .control( dataB ), .dataOut( ansOfShifter_0 ) );
Shifter_1 Shifter_1( .data( ansOfShifter_0 ), .control( dataB ), .dataOut( ansOfShifter_1 ) );
Shifter_2 Shifter_2( .data( ansOfShifter_1 ), .control( dataB ), .dataOut( ansOfShifter_2 ) );
Shifter_3 Shifter_3( .data( ansOfShifter_2 ), .control( dataB ), .dataOut( ansOfShifter_3 ) );
Shifter_4 Shifter_4( .data( ansOfShifter_3 ), .control( dataB ), .dataOut( ansOfShifter_4 ) );

assign dataOut = ansOfShifter_4;

endmodule

module ALU_1bit( dataA, dataB, Signal, invertB, Less, cin, sum, cout );

input dataA;
input dataB;
input cin;
input [2:0] Signal;
input invertB;
input Less;
output sum;
output cout;

//   Signal ( 3-bits )
//   AND  : 000
//   OR   : 001
//   ADD  : 010
//   SUB  : 110
//   SLT  : 111

parameter AND = 3'b000;
parameter OR  = 3'b001;
parameter ADD = 3'b010;
parameter SUB = 3'b110;
parameter SLT = 3'b111;

wire AND_ans;
wire OR_ans;
wire ADD_ans;
wire invertDataB;

xor xor1( invertDataB, dataB, invertB );

Adder_1bit Adder_1bit( .dataA( dataA ), .dataB( invertDataB ), .cin( cin ), .sum( ADD_ans ), .cout( cout ) );
or or1( OR_ans, dataA, dataB );
and and1( AND_ans, dataA, dataB );

assign sum = ( Signal == AND ) ? AND_ans : ( Signal == OR ) ? OR_ans : ADD_ans;

endmodule

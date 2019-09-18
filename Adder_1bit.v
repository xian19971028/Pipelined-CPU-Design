module Adder_1bit( dataA, dataB, cin, sum, cout );

input dataA, dataB, cin;
output sum, cout;

wire e1, e2, e3, e4;

// get sum
xor xor1( e1, dataA, dataB );
xor xor2( sum, e1, cin );

// get cout
or or1( e2, dataA, dataB );
and and1( e3, e2, cin );
and and2( e4, dataA, dataB );
or or2( cout, e3, e4 );

endmodule

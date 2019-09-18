module HiLo( clk, DivAns, reset, MFHI, MFLO, HiLo_out );
	input clk, reset;
	input MFHI, MFLO;
	input [63:0] DivAns ;
	output [31:0] HiLo_out;

	reg [63:0] HiLo ;

	always@( posedge clk or reset )	begin
	  if ( reset ) begin
		HiLo = 64'b0;
	  end
	
	  else begin
		HiLo = DivAns;
	  end
	end
	
	// 如果非MFHI or MFLO，HiLo_out的結果無所謂，所以只用MFHI判斷
	assign HiLo_out = ( MFHI == 1 ) ? HiLo[63:32] : HiLo[31:0];

endmodule

module Divider( clk, dataA, dataB, Signal, dataOut, reset );
	input clk ;
	input reset ;
	input [31:0] dataA ;
	input [31:0] dataB ;
	input [5:0] Signal ;
	output reg [63:0] dataOut ;

	//   Signal ( 6-bits)?
	//   DIVU  : 27
	//   OUT   : 63

	parameter DIVU = 6'b011011;
	parameter OUT = 6'b111111;

	reg [63:0] REM = 64'b0;  // dataA : 32'b0 被除數
	reg [31:0] DIVR;  // dataB 除數
	reg [31:0] count = 32'b0;

	// 歸零
	always @ ( reset ) begin
		if ( reset == 1 ) 
		begin
			REM[63:32] = 32'b0;
			REM[31:0] = dataA;
			DIVR = dataB;
			REM = REM << 1;
			count = count + 1;
		end
	end		
	
	
	always@( posedge clk or reset )
	begin
		case ( Signal )
		DIVU:
		begin
			/*if ( count == 0 ) 
			begin
				REM[31:0] = dataA;
				DIVR = dataB;
				REM = REM << 1;
				count = count + 1;
			end*/
		
			// 做32次
			REM[63:32] = REM[63:32] - DIVR;
			
			if ( REM[63] == 1'b0 )
			begin
				REM = REM << 1;
				REM[0] = 1;  // LSB = 1
			end
			else  // REM < 0
			begin
				REM[63:32] = REM[63:32] + DIVR;
				REM = REM << 1;
				REM[0] = 0;  // LSB = 0
			end
		
		end
		
		OUT:
		begin
			// 開HiLo	

		end
		endcase

	/*
	除法運算
	OUT的部分是要等control給你指令你才能夠把答案輸出到HILO暫存器
	*/
	end

	always@( Signal )
	begin
		if ( Signal == OUT )
		begin
			REM[63:32] = REM[63:32] >> 1;
			dataOut = REM;
		end
	end

endmodule

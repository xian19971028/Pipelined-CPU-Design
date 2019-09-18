module DividerControl( clk, startCount, SignaltoDIV );
	input clk, startCount;
	output reg [5:0] SignaltoDIV;
	
	reg [5:0] temp;
	reg [6:0] counter;
	
	always @ ( startCount ) begin
		if ( startCount == 1 ) 
			counter = 0;
	end		
		
	always @ ( posedge clk ) begin
		if ( startCount == 1 ) begin
			temp = 6'd27;
			counter = counter + 1;
			if ( counter == 32 ) begin
				temp = 6'b111111;
				counter = 0;
			end
		end
	end
	
	always @ ( temp ) begin
		SignaltoDIV = temp ;
	end
endmodule

module IF_ID( clk, pc_in, instruction_in, pc_out, instruction_out );
	input clk;
	input [31:0] pc_in;
	input [31:0] instruction_in;
	output reg [31:0] pc_out;
	output reg [31:0] instruction_out;
	
	always @ ( posedge clk ) begin
		pc_out = pc_in;
		instruction_out = instruction_in;
	end	
endmodule

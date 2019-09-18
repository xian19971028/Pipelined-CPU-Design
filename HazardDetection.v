module HazardDetection( clk, instr, Jump_in, Jump_out, PCSrc_in, PCSrc_out, jump_addr_in, jump_addr_out, b_tgt_in, b_tgt_out, preJump );
	input clk;
	
	// control signal
	input Jump_in, PCSrc_in;
	output Jump_out, PCSrc_out, preJump;
	
	// data
	input [31:0] instr, jump_addr_in, b_tgt_in;
	output [31:0] jump_addr_out, b_tgt_out;

	// storage
	reg Jump_store = 1'b0, PCSrc_store = 1'b0;
	reg [31:0] jump_addr_store, b_tgt_store, preInstr;
	
	wire preJump;
	assign preJump = ( preInstr[31:26] == 6'd2 || preInstr[31:26] == 6'd3 ) ? 1 : 0;
	
	assign Jump_out = Jump_in;
	
	assign jump_addr_out = ( instr == 32'b0 && preJump == 1 ) ? jump_addr_store : jump_addr_in;
	assign PCSrc_out = ( instr == 32'b0 && preJump == 1 ) ? PCSrc_store : PCSrc_in;
	assign b_tgt_out = ( instr == 32'b0 && preJump == 1 ) ? b_tgt_store : b_tgt_in;
	
	always @ ( instr or Jump_in or jump_addr_in or PCSrc_in or b_tgt_in ) begin
		if ( instr[31:26] == 6'd2 || instr[31:26] == 6'd3 ) begin
			Jump_store = Jump_in;
			jump_addr_store = jump_addr_in;
			PCSrc_store = PCSrc_in;
			b_tgt_store = b_tgt_in;
		end
	end
	
	always @ ( posedge clk ) begin 
		preInstr = instr;
	end
	
endmodule


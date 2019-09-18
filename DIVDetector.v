module DIVDetector( clk, instr_in, instr_src_out, instr_src_in, pc_out, pc_in, pc_next_out, pc_next_in, startCount, preJump );
	input clk, preJump;
	
	input [31:0] instr_src_in, pc_in, pc_next_in, instr_in;
	output reg [31:0] instr_src_out, pc_out, pc_next_out;
	output reg startCount = 0;
	
	wire dividerCtrl;
	reg [31:0] pc_store, pc_next_store;
	reg [5:0] counter = 6'b0;
	
	parameter DIV = 6'd27;
	
	// 若instr_src_in是DIV，將pc和pc_next存起來，數32個cycle再回復
	// 傳送訊號給DividerControl，告知要開始數32個cycle並開HiLo
	always @ ( posedge clk ) begin
		if ( startCount == 1 ) begin
			counter = counter + 1;
			
			if ( counter == 6'd32 ) begin
				pc_out = pc_store;
				pc_next_out = pc_next_store;
				instr_src_out = instr_src_in;
				counter = 0;
				startCount = 0;
			end
			else if ( counter != 6'd32 ) begin
				// pc_out = 32'b0;
				// pc_next_out = 32'b0;
				instr_src_out = 32'b0;
			end			
		end
	end
	
	always @ ( counter or instr_src_in or pc_in or pc_next_in or instr_in ) begin
		if ( instr_in[5:0] == DIV && preJump != 1 ) begin
			// 如果訊號改變成除法，開始數cycle
			// 並把目前的pc和pc_next存起來
			// 目前的訊號不改變，直接傳送出去
			// 接下來的32個都傳32'b0出去
			pc_store = pc_in;
			pc_next_store = pc_next_in;
			
			instr_src_out = 32'b0;
			startCount = 1;
		end
		else if ( startCount == 0 ) begin
			instr_src_out = instr_src_in;
			pc_out = pc_in;
			pc_next_out = pc_next_in;
		end
	end	
endmodule


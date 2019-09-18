module EX_MEM( clk, MemRead_out, MemRead_in, MemWrite_out, MemWrite_in, Branch_out, Branch_in, JalSignal_out, JalSignal_in, RegWrite_out, 
				RegWrite_in, MemtoReg_out, MemtoReg_in, Slti_out, Slti_in, Zero_out, Zero_in, b_tgt_out, b_tgt_in, alu_out_out, alu_out_in,
				rfile_rd2_out,rfile_rd2_in, rfile_wn_out, rfile_wn_in, pc_incr_in, pc_incr_out, Shifter_out, Shifter_in, ShifterOut_out, ShifterOut_in,
				MFHI_out, MFHI_in, MFLO_out, MFLO_in );

	input clk;
	
	// M signal
	input MemRead_in, MemWrite_in, Branch_in;
	output reg MemRead_out, MemWrite_out, Branch_out = 1'b0;
	
	// WB signal
	input RegWrite_in, MemtoReg_in, Slti_in, JalSignal_in, Shifter_in, MFHI_in, MFLO_in;
	output reg RegWrite_out, MemtoReg_out, Slti_out, JalSignal_out, Shifter_out, MFHI_out, MFLO_out;
	
	// data
	input Zero_in;
	output reg Zero_out = 1'b0;
	input [4:0] rfile_wn_in;
	output reg [4:0] rfile_wn_out;
	input [31:0] b_tgt_in, alu_out_in, rfile_rd2_in, pc_incr_in, ShifterOut_in;
	output reg [31:0] b_tgt_out, alu_out_out, rfile_rd2_out, pc_incr_out, ShifterOut_out;
	
	
	always @ ( posedge clk ) begin
		MemRead_out = MemRead_in;
		MemWrite_out = MemWrite_in;
		Branch_out = Branch_in;
		RegWrite_out = RegWrite_in;
		MemtoReg_out = MemtoReg_in;
		Slti_out = Slti_in;
		JalSignal_out = JalSignal_in;
		Shifter_out = Shifter_in;
		MFHI_out = MFHI_in;
		MFLO_out = MFLO_in;
		
		Zero_out = Zero_in;
		b_tgt_out = b_tgt_in;
		alu_out_out = alu_out_in;
		rfile_rd2_out = rfile_rd2_in;
		rfile_wn_out = rfile_wn_in;
		pc_incr_out = pc_incr_in;
		ShifterOut_out = ShifterOut_in;
	end	
endmodule

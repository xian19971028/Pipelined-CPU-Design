module ID_EX( clk, RegDst_out, RegDst_in, ALUSrc_out, ALUSrc_in, ALUOp_out, ALUOp_in, MemRead_out, MemRead_in, MemWrite_out, MemWrite_in, 
				Branch_out, Branch_in, JalSignal_out, JalSignal_in, RegWrite_out, RegWrite_in, MemtoReg_out, MemtoReg_in, Slti_out, Slti_in, 
				rfile_rd1_out, rfile_rd1_in, rfile_rd2_out, rfile_rd2_in, extend_immed_out, extend_immed_in, rt_out, rt_in, rd_out, rd_in,
				funct_out, funct_in, pc_incr_out, pc_incr_in, Shifter_out, Shifter_in, shamt_out, shamt_in, MFHI_out, MFHI_in, MFLO_out, MFLO_in );

	input clk;
	
	// EX signal
	input RegDst_in, ALUSrc_in;
	input [1:0] ALUOp_in;
	output reg RegDst_out, ALUSrc_out;
	output reg [1:0] ALUOp_out;
	
	// M signal
	input MemRead_in, MemWrite_in, Branch_in;
	output reg MemRead_out, MemWrite_out, Branch_out = 1'b0;
	
	// WB signal
	input RegWrite_in, MemtoReg_in, Slti_in, JalSignal_in, Shifter_in, MFHI_in, MFLO_in;
	output reg RegWrite_out, MemtoReg_out, Slti_out, JalSignal_out, Shifter_out, MFHI_out, MFLO_out;

	// data
	input [31:0] rfile_rd1_in, rfile_rd2_in, extend_immed_in, pc_incr_in;
	input [4:0] rt_in, rd_in, shamt_in;
	input [5:0] funct_in;
	output reg [31:0] rfile_rd1_out, rfile_rd2_out, extend_immed_out, pc_incr_out;
	output reg [4:0] rt_out, rd_out, shamt_out;
	output reg [5:0] funct_out;
	
	
	always @ ( posedge clk ) begin
		RegDst_out = RegDst_in;
		ALUSrc_out = ALUSrc_in;
		ALUOp_out = ALUOp_in;
		MemRead_out = MemRead_in;
		MemWrite_out = MemWrite_in;
		Branch_out = Branch_in;
		JalSignal_out = JalSignal_in;
		RegWrite_out = RegWrite_in;
		MemtoReg_out = MemtoReg_in;
		Slti_out = Slti_in;
		Shifter_out = Shifter_in;
		MFHI_out = MFHI_in;
		MFLO_out = MFLO_in;

		rfile_rd1_out = rfile_rd1_in;
		rfile_rd2_out = rfile_rd2_in;
		extend_immed_out = extend_immed_in;
		rt_out = rt_in;
		rd_out = rd_in;
		funct_out = funct_in;
		pc_incr_out = pc_incr_in;
		shamt_out = shamt_in;
	end	
endmodule		

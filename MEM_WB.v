module MEM_WB( clk, JalSignal_out, JalSignal_in, RegWrite_out, RegWrite_in, MemtoReg_out, MemtoReg_in, Slti_out, Slti_in, alu_out_out, alu_out_in,
				rfile_wn_out, rfile_wn_in, pc_incr_out, pc_incr_in, dmem_rdata_out, dmem_rdata_in, Shifter_out, Shifter_in, ShifterOut_out, ShifterOut_in,
				MFHI_out, MFHI_in, MFLO_out, MFLO_in );

	input clk;
	
	// WB signal
	input RegWrite_in, MemtoReg_in, Slti_in, JalSignal_in, Shifter_in, MFHI_in, MFLO_in;
	output reg RegWrite_out, MemtoReg_out, Slti_out, JalSignal_out, Shifter_out, MFHI_out, MFLO_out;
	
	// data
	input [4:0] rfile_wn_in;
	output reg [4:0] rfile_wn_out;
	input [31:0] dmem_rdata_in, alu_out_in, pc_incr_in, ShifterOut_in;
	output reg [31:0] dmem_rdata_out, alu_out_out, pc_incr_out, ShifterOut_out;
	
	
	always @ ( posedge clk ) begin
		RegWrite_out = RegWrite_in;
		MemtoReg_out = MemtoReg_in;
		Slti_out = Slti_in;
		JalSignal_out = JalSignal_in;
		Shifter_out = Shifter_in;
		MFHI_out = MFHI_in;
		MFLO_out = MFLO_in;

		dmem_rdata_out = dmem_rdata_in;
		alu_out_out = alu_out_in;
		rfile_wn_out = rfile_wn_in;
		pc_incr_out = pc_incr_in;
		ShifterOut_out = ShifterOut_in;
	end	
endmodule

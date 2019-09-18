//	Title: MIPS Single-Cycle Processor
//	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
module mips_single( clk, rst );
	input clk, rst;
	
	// instruction bus
	wire[31:0] instr, instr_src, instr_src2;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct, funct_src;
    wire [4:0] rs, rt, rd, shamt, shamt_src;
    wire [4:0] rt_src, rd_src;
    wire [15:0] immed;
    wire [31:0] extend_immed, extend_immed_src, b_offset; 
    wire [25:0] jumpoffset;
	
	// datapath signals
    wire [4:0] rfile_wn, rfile_wn_src, rfile_wn_src2, RFMUXResult;
    wire [31:0] rfile_rd1, rfile_rd1_src, rfile_rd2, rfile_rd2_src, rfile_rd2_src2, rfile_wd, alu_b, alu_out, alu_out_src, alu_out_src2, b_tgt, b_tgt_src, b_tgt_src2,
				pc_next, pc_next_src, pc, pc_src, pc_incr, pc_incr_src, pc_incr_src2, pc_incr_src3, pc_incr_src4, dmem_rdata, dmem_rdata_src, jump_addr, jump_addr_src, branch_addr,
				memtoRegResult, SLTI_WDResult, ShifterOut, ShifterOut_src, ShifterOut_src2, SLL_WDResult, HiLo_WDMUXResult, HiLo_out;
	wire [63:0] DivAns;
	
	// control signals -- EX signal
	wire RegDst, RegDst_src, ALUSrc, ALUSrc_src; 
	wire [1:0] ALUOp, ALUOp_src;
	
	// control signals -- M signal
	wire Branch, Branch_src, Branch_src2, MemWrite, MemWrite_src, MemWrite_src2, MemRead, MemRead_src, MemRead_src2;
	
	// control signals -- WB signal
	wire RegWrite, RegWrite_src, RegWrite_src2, RegWrite_src3, MemtoReg, MemtoReg_src, MemtoReg_src2, MemtoReg_src3, 
		Jal, Jal_src, Jal_src2, Jal_src3, Slti, Slti_src, Slti_src2, Slti_src3, Shifter, Shifter_src, Shifter_src2, Shifter_src3,
		MFHI, MFHI_src, MFHI_src2, MFHI_src3, MFLO, MFLO_src, MFLO_src2, MFLO_src3;
	
	// control signals -- others
	wire PCSrc, PCSrc_src, Jump, Jump_src, Zero, Zero_src, startCount, HiLo, preJump; 
    wire [2:0] Operation;
	wire [5:0] SignaltoDIV;
	
    assign opcode = instr[31:26];
    assign rs = instr[25:21];
    assign rt_src = instr[20:16];
    assign rd_src = instr[15:11];
    assign shamt_src = instr[10:6];
    assign funct_src = instr[5:0];
    assign immed = instr[15:0];
    assign jumpoffset = instr[25:0];
	
	// branch offset shifter
    assign b_offset = extend_immed << 2;
	
	// jump offset shifter & concatenation
	assign jump_addr_src = { pc_incr_src3[31:28], jumpoffset << 2 };
		
	// module instantiations
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc_src) );
	
	// sign-extender
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed_src) );
	
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr_src4) );

    add32 BRADD( .a(pc_incr_src2), .b(b_offset), .result(b_tgt_src2) );

    alu ALU( .Signal(Operation), .dataA(rfile_rd1), .dataB(alu_b), .dataOut(alu_out_src2), .zero(Zero_src) );

    and BR_AND( PCSrc_src, Branch, Zero );
	
	or HiLo_OR( HiLo, MFHI, MFLO );

    mux2 #(5) RFMUX( .sel(RegDst), .a(rt), .b(rd), .y(RFMUXResult) );

    mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr_src4), .b(b_tgt), .y(branch_addr) );
	
	mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next_src) );
	
    mux2 #(32) ALUMUX( .sel(ALUSrc), .a(rfile_rd2_src), .b(extend_immed), .y(alu_b) );

    mux2 #(32) WRMUX( .sel(MemtoReg), .a(alu_out), .b(dmem_rdata), .y(memtoRegResult) );
	
	mux2 #(32) SLL_WDMUX( .sel(Shifter), .a(memtoRegResult), .b(ShifterOut), .y(SLL_WDResult) );  // WDMUX, for SLL
	
	mux2 #(32) HiLo_WDMUX( .sel(HiLo), .a(SLL_WDResult), .b(HiLo_out), .y(HiLo_WDMUXResult) );  // WDMUX, for MFHI or MFLO
	
	mux2 #(32) SLIT_WDMUX( .sel(Slti), .a(HiLo_WDMUXResult), .b({31'b0, HiLo_WDMUXResult[31]}), .y(SLTI_WDResult) );  // WDMUX, for SLTI

	mux2 #(32) JAL_WDMUX( .sel(Jal), .a(SLTI_WDResult), .b(pc_incr), .y(rfile_wd) );  // WDMUX, for JAL 
	
	mux2 #(5) JAL_WNMUX( .sel(Jal_src2), .a(RFMUXResult), .b(32'b11111), .y(rfile_wn_src2) );  // WNMUX, for JAL
	
    control_single CTL( .opcode(opcode), .funct(funct_src), .RegDst(RegDst_src), .ALUSrc(ALUSrc_src), .MemtoReg(MemtoReg_src3), 
						.RegWrite(RegWrite_src3), .MemRead(MemRead_src2), .MemWrite(MemWrite_src2), .Branch(Branch_src2), 
						.Jump(Jump_src), .ALUOp(ALUOp_src), .writeBackSrc(Slti_src3), .JalSignal(Jal_src3), .Shifter(Shifter_src3),
						.MFHI(MFHI_src3), .MFLO(MFLO_src3) );

    alu_ctl ALUCTL( .ALUOp(ALUOp), .Funct(funct), .ALUOperation(Operation) );
	

	reg_file RegFile( .clk(clk), .RegWrite(RegWrite), .RN1(rs), .RN2(rt_src), .WN(rfile_wn), 
					  .WD(rfile_wd), .RD1(rfile_rd1_src), .RD2(rfile_rd2_src2) );

	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr_src2) );
	
	memory DatMem( .clk(clk), .MemRead(MemRead), .MemWrite(MemWrite), .wd(rfile_rd2), 
				   .addr(alu_out_src), .rd(dmem_rdata_src) );	   	
	
	DIVDetector DIVDetector( .clk(clk), .instr_in(instr), .instr_src_out(instr_src), .instr_src_in(instr_src2), .pc_out(pc), .pc_in(pc_src), .pc_next_out(pc_next), .pc_next_in(pc_next_src), .startCount(startCount), .preJump(preJump) );
	
	DividerControl DividerControl( .clk(clk), .startCount(startCount), .SignaltoDIV(SignaltoDIV) );
	
	Divider Divider( .clk(clk), .dataA(rfile_rd1_src), .dataB(rfile_rd2_src2), .Signal(SignaltoDIV), .dataOut(DivAns), .reset(startCount) );  // dataA : 被除數、dataB : 除數
	
	HiLo HiLoUnit( .clk(clk), .DivAns(DivAns), .reset(reset), .MFHI(MFHI), .MFLO(MFLO), .HiLo_out(HiLo_out) );
	
	Shifter ShifterUnit( .dataA(alu_b), .dataB(shamt), .dataOut(ShifterOut_src2) );
	
	HazardDetection HD( .clk(clk), .instr(instr), .Jump_in(Jump_src), .Jump_out(Jump), .PCSrc_in(PCSrc_src), .PCSrc_out(PCSrc), 
						.jump_addr_in(jump_addr_src), .jump_addr_out(jump_addr), .b_tgt_in(b_tgt_src), .b_tgt_out(b_tgt), .preJump(preJump) );
							
	IF_ID IF_IDReg( .clk(clk), .pc_in(pc_incr_src4), .instruction_in(instr_src), .pc_out(pc_incr_src3), .instruction_out(instr) );
	
	ID_EX ID_EXReg( .clk(clk), .RegDst_out(RegDst), .RegDst_in(RegDst_src), .ALUSrc_out(ALUSrc), .ALUSrc_in(ALUSrc_src), .ALUOp_out(ALUOp), .ALUOp_in(ALUOp_src), 
				.MemRead_out(MemRead_src), .MemRead_in(MemRead_src2), .MemWrite_out(MemWrite_src), .MemWrite_in(MemWrite_src2), 
				.Branch_out(Branch_src), .Branch_in(Branch_src2), .JalSignal_out(Jal_src2), .JalSignal_in(Jal_src3), .RegWrite_out(RegWrite_src2), .RegWrite_in(RegWrite_src3),
				.MemtoReg_out(MemtoReg_src2), .MemtoReg_in(MemtoReg_src3), .Slti_out(Slti_src2), .Slti_in(Slti_src3), .rfile_rd1_out(rfile_rd1), .rfile_rd1_in(rfile_rd1_src), 
				.rfile_rd2_out(rfile_rd2_src), .rfile_rd2_in(rfile_rd2_src2), .extend_immed_in(extend_immed_src), .extend_immed_out(extend_immed), .rt_in(rt_src), 
				.rt_out(rt), .rd_in(rd_src), .rd_out(rd), .funct_in(funct_src), .funct_out(funct), .pc_incr_out(pc_incr_src2), .pc_incr_in(pc_incr_src3),
				.Shifter_out(Shifter_src2), .Shifter_in(Shifter_src3), .shamt_out(shamt), .shamt_in(shamt_src), .MFHI_out(MFHI_src2), .MFHI_in(MFHI_src3), .MFLO_out(MFLO_src2), .MFLO_in(MFLO_src3) );
				
	EX_MEM EX_MEMReg( .clk(clk), .MemRead_out(MemRead), .MemRead_in(MemRead_src), .MemWrite_out(MemWrite), .MemWrite_in(MemWrite_src), .Branch_out(Branch), .Branch_in(Branch_src), 
				.JalSignal_out(Jal_src), .JalSignal_in(Jal_src2), .RegWrite_out(RegWrite_src), .RegWrite_in(RegWrite_src2), .MemtoReg_out(MemtoReg_src), .MemtoReg_in(MemtoReg_src2), 
				.Slti_out(Slti_src), .Slti_in(Slti_src2), .Zero_out(Zero), .Zero_in(Zero_src), .b_tgt_out(b_tgt_src), .b_tgt_in(b_tgt_src2), .alu_out_out(alu_out_src), .alu_out_in(alu_out_src2),
				.rfile_rd2_out(rfile_rd2), .rfile_rd2_in(rfile_rd2_src), .rfile_wn_out(rfile_wn_src), .rfile_wn_in(rfile_wn_src2), .pc_incr_in(pc_incr_src2), .pc_incr_out(pc_incr_src),
				.Shifter_out(Shifter_src), .Shifter_in(Shifter_src2), .ShifterOut_out(ShifterOut_src), .ShifterOut_in(ShifterOut_src2), .MFHI_out(MFHI_src), .MFHI_in(MFHI_src2), .MFLO_out(MFLO_src), .MFLO_in(MFLO_src2) );

	MEM_WB MEM_WBReg( .clk(clk), .JalSignal_out(Jal), .JalSignal_in(Jal_src), .RegWrite_out(RegWrite), .RegWrite_in(RegWrite_src), 
				.MemtoReg_out(MemtoReg), .MemtoReg_in(MemtoReg_src), .Slti_out(Slti), .Slti_in(Slti_src), .alu_out_out(alu_out), .alu_out_in(alu_out_src), 
				.rfile_wn_out(rfile_wn), .rfile_wn_in(rfile_wn_src), .pc_incr_out(pc_incr), .pc_incr_in(pc_incr_src), .dmem_rdata_out(dmem_rdata), .dmem_rdata_in(dmem_rdata_src),
				.Shifter_out(Shifter), .Shifter_in(Shifter_src), .ShifterOut_out(ShifterOut), .ShifterOut_in(ShifterOut_src), .MFHI_out(MFHI), .MFHI_in(MFHI_src), .MFLO_out(MFLO), .MFLO_in(MFLO_src) );
endmodule

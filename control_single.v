/*
	Title: MIPS Single-Cycle Control Unit
	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
	
	Input Port
		1. opcode: 輸入的指令代號，據此產生對應的控制訊號
	Input Port
		1. RegDst: 控制RFMUX
		2. ALUSrc: 控制ALUMUX
		3. MemtoReg: 控制WRMUX
		4. RegWrite: 控制暫存器是否可寫入
		5. MemRead:  控制記憶體是否可讀出
		6. MemWrite: 控制記憶體是否可寫入
		7. Branch: 與ALU輸出的zero訊號做AND運算控制PCMUX
		8. ALUOp: 輸出至ALU Control
*/
module control_single( opcode, funct, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, 
						Branch, Jump, ALUOp, writeBackSrc, JalSignal, Shifter, MFHI, MFLO );
    input[5:0] opcode, funct;
    output reg RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, writeBackSrc, JalSignal, Shifter, MFHI, MFLO;
    output reg [1:0] ALUOp;

    parameter R_FORMAT = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ = 6'd4;
	parameter J = 6'd2;
	parameter SLTI = 6'd10;
	parameter JAL = 6'd3;
	
	initial begin 
		RegDst = 1'b0; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b0; MemRead = 1'b0; 
		MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; writeBackSrc = 1'b0;
		JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b0;
	end
	
    always @( opcode or funct ) begin
        case ( opcode )
          R_FORMAT : 
          begin
				case ( funct ) 
				  6'b0 :
				  begin
						// Shifter signal
						RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
						MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b10; writeBackSrc = 1'b0;
						JalSignal = 1'b0; Shifter = 1'b1; MFHI = 1'b0; MFLO = 1'b0;				  
				  end
				  6'd16 :
				  begin
						// MFHI signal
						RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
						MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b10; writeBackSrc = 1'b0;
						JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b1; MFLO = 1'b0;	
				  end
				  6'd18 :
				  begin
						// MFLO signal
						RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
						MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b10; writeBackSrc = 1'b0;
						JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b1;	
				  end
				  default
				  begin
						RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
						MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b10; writeBackSrc = 1'b0;
						JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b0;
				  end
				endcase
				
          end
          LW :
          begin
				RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b1; RegWrite = 1'b1; MemRead = 1'b1; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; writeBackSrc = 1'b0;
				JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b0;
          end
          SW :
          begin
				RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b0; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b1; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; writeBackSrc = 1'b0;
				JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b0;
          end
          BEQ :
          begin
				RegDst = 1'b0; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b0; ALUOp = 2'b01; writeBackSrc = 1'b0;
				JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b0;
          end
		  J :
		  begin
				RegDst = 1'b0; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b1; ALUOp = 2'b01; writeBackSrc = 1'b0;
				JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b0;
		  end
		  JAL :
		  begin
				RegDst = 1'b0; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b1; ALUOp = 2'b01; writeBackSrc = 1'b0;
				JalSignal = 1'b1; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b0;
		  end
		  SLTI :
		  begin
				RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b01; writeBackSrc = 1'b1;
				JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b0;
		  end
          default
          begin
				$display("control_single unimplemented opcode %d", opcode);
				RegDst = 1'b0; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; writeBackSrc = 1'b0;
				JalSignal = 1'b0; Shifter = 1'b0; MFHI = 1'b0; MFLO = 1'b0;
				
          end

        endcase
    end
endmodule


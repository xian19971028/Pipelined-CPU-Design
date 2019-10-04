# Pipelined-CPU-Design
利用Verilog語言與Modelsim模擬器，設計一個可以完成16道MIPS指令(add、sub、and、or、sll、stli、lw、sw、beq、j、jal、divu、mfhi、mflo、nop)的CPU，且須遵守5-Stage Pipelined CPU執行指令之行為。

# ALU
須完成add, sub, and, or, sll, slt, slti指令。

# divu
除法器(第三版)，需執行32-bit無號數除法。

# Datapath
所設計之CPU須為Pipelined MIPS-Lite CPU，且所有指令須遵守5-Stage Pipelined CPU執行指令之行為。

# Testbench
測試以上撰寫的verilog結果的正確與否，讀取data_mem.txt的內容並至data memory中、讀取reg.txt的內容並存至register file中、讀取instr_mem.txt的內容並存至instruction memory中。

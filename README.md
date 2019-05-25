# MIPS CPU

This is a MIPS32 CPU implemented in Verilog.

Under developing

## Features

- 5-stage pipline
- forwarding & stalling
- branch delay slot

## Instruction Set

- MIPS32 instructions
  - CPU Arithmetic Instructions 14
    - ADD
    - ADDI
    - ADDIU
    - ADDU
    - DIV
    - DIVU
    - MULT
    - MULTU
    - SLT
    - SLTI
    - SLTIU
    - SLTU
    - SUB
    - SUBU
  - CPU Branch and Jump Instructions 10
    - BEQ
    - BGEZ
    - BGTZ
    - BLEZ
    - BLTZ
    - BNE
    - J
    - JAL
    - JALR
    - JR
  - CPU Instruction Control Instructions 1
    - NOP
  - CPU Load, Store, and Memory Control Instructions 8
    - LB
    - LBU
    - LH
    - LHU
    - LW
    - SB
    - SH
    - SW
  - CPU Logical Instructions 8
    - AND
    - ANDI
    - OR
    - ORI
    - XOR
    - XORI
    - NOR
    - LUI
  - CPU Insert/Extract Instructions 0
  - CPU Move Instructions 4
    - MFHI
    - MFLO
    - MTHI 
    - MTLO
  - CPU Shift Instructions 6
    - SLL
    - SRL
    - SRA
    - SLLV
    - SRLV
    - SRAV
  - CPU Trap Instructions 0
  - Obsolete1 CPU Branch Instructions 0
  - FPU and cop2 not included
  - Privileged Instructions 0
  - EJTAG Instructions 0

stay tuned...
MOV AX, 12H
MOV BX, 34H
MOV BYTE PTR [100H], 56H            
           
; reg, reg
XCHG AX, BX
XCHG BX, [100H]
XCHG [100H], AX
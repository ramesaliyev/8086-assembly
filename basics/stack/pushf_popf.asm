MOV AX, 3H
MOV BX, 7H
CMP AX, BX
PUSHF
CMP BX, AX
POPF
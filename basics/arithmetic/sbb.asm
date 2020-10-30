; has same arguments as ADD
; 32bit subtraction example

; A = 100000H
; B =  10001H
; - =  EFFFFH
                 
MOV AX, 0010H
MOV CX, 0000H

MOV BX, 0001H
MOV DX, 0001H
                  
SUB CX, DX ; CX -> FFFFH
SBB AX, BX ; AX -> 000EH 
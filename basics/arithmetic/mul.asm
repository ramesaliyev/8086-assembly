MOV AX, 0H

; 8 bit, byte
MOV AL, 2H
MOV BL, 10H
MUL BL; [AX <- AL x BL] AX=0020H

; 16 bit, word
MOV AX, 200H
MOV BX, 300H
MUL BX ; [DX:AX <- AX x BX] => DX=0006H AX=0000H

; square
MOV AX, 100H
MUL AX ; DX=0001H AX=0000H

; unsigned
MOV AL, 2H
MOV BL, 5H
NEG BL ; signed=-5, unsigned=251
MUL BL ; AX=502
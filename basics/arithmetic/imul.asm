MOV AX, 0H

; 8 bit, byte
MOV AL, 2H
MOV BL, 10H
IMUL BL; [AX <- AL x BL] AX=0020H

; 16 bit, word
MOV AX, 200H
MOV BX, 300H
IMUL BX; [DX:AX <- AX x BX] => DX=0006H AX=0000H

; signed
MOV AL, 2H
MOV BL, 5H
NEG BL ; signed=-5, unsigned=251
IMUL BL ; AX=-10
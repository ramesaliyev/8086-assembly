; 8 bit, byte
MOV AX, 29H
MOV BL, 3H
DIV BL ; [AL <- AX/SRC] and [AH <- AX % SRC]
; AL = 29H / 3H, AH = 29H % 3H
; AL = 0DH (quotient) AH=02H (remainder)               
              
; 16 bit, word
MOV DX, 0003H
MOV AX, 0907H
MOV BX, 0300H
DIV BX ; [AX <- DX:AX / SRC] and [DX <- DX:AX % SRC]
; AX = 00030907H / 0300H, DX = 00030907H % 0300H
; AX = 0103H (quotient), DX = 0007H (remainder)
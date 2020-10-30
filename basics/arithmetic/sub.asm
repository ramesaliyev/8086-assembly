; works by two's complement rules.
; has same arguments as ADD

MOV AL, 0BH ; 0000 1011 = 11
MOV BL, 0FFH ; 1111 1111 = -1
SUB AL, BL; ; 11 - (-1) = 12 = C


; has same arguments as ADD
; 32bit addition example

; A = 1010 FFFFH
; B = 2020 FFFFH
; + = 3031 FFFEH
                 
MOV AX, 01010H
MOV CX, 0FFFFH

MOV BX, 02020H
MOV DX, 0FFFFH
                  
ADD CX, DX ; CX -> FFFE
ADC AX, BX ; AX -> 3031 
; reg, idata
MOV AX, 1H
ADD AX, 0FFH

MOV CH, 'A' ; 41
ADD CH, 'B' ; 42
                    
; mem, reg
MOV CX, 1234H
MOV WORD PTR [150H], 1H
MOV BYTE PTR [160H], 1H
ADD [150H], CX ; Dont need PTR since CX is known as WORD
ADD [160H], CL ; Dont need PTR since CL is known as BYTE
                 
; reg, mem                    
MOV WORD PTR [170H], 1989H 
MOV BX, 1H
ADD BX, [170H] ; Auto: WORD PTR [170H] since BX is WORD
MOV BX, 0H
ADD BL, [170H] ; Auto: BYTE PTR [170H] since BL is BYTE  

; mem, idata
; PTR REQUIRED    
MOV BYTE PTR [180H], 0FEH
ADD BYTE PTR [180H], 1H ; FFH
ADD BYTE PTR [180H], 1H ; 00H, CF=1

MOV WORD PTR [190H], 90FEH
ADD WORD PTR [190H], 1H ; 190H = FFH, 191H=90H
ADD WORD PTR [190H], 1H ; 190H = 00H, 191H=91H    
   
; reg, reg   
MOV AH, 5H
MOV AL, 3H
ADD AH, AL
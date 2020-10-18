; reg, idata
MOV DL, 1
MOV BX, 0ABCDH ; 0 added to distinguish from label
MOV AL, 01010101B
MOV AH, 'A'

; mem, idata
MOV BYTE PTR [100H], 12H
; [DSx10H+100H] <- 12H
MOV WORD PTR [100H], 12H; 0012H
;[DSx10H+100H] <- 12H
;[DSx10H+101H] <- 00H
MOV WORD PTR [103H], 1234H

; reg, reg
MOV AX, BX

; for [data ofsseting] only availables
; [BX, SI, DI]

; reg, mem
; mem, reg
; absolute offset
MOV AX, [100H]
; relative offset
MOV [131H], 17H
MOV BX, 131H
MOV AX, [BX]
; index offset
MOV SI, 131H 
MOV [SI], BX
MOV AX, [SI]

MOV BX, 140H
MOV SI, 20H
MOV WORD PTR [170H], 1989H
MOV AX, [BX+SI+10H] ; MOV AX, [170H]                        

MOV SI, 12H
SHL SI, 1 ; shift left 1 bit =  multiply with 2  

; auto size detection
MOV AH, 0ABH
MOV AL, 0CDH
MOV [200H], AX ; word
;[DSx10H+200H] <- CDH
;[DSx10H+201H] <- ABH
MOV [204H], AH ; byte
;[DSx10H+204H] <- ABH
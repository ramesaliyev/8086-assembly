STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    MSG DB 'YOUR INPUT: ', 0, '$'
DATASG ENDS

CODESG SEGMENT PARA 'CODE'
    ASSUME CS:CODESG, DS:DATASG, SS:STACKSG
    
    ; main procedure
    MAIN PROC FAR
        ; for successful return
        PUSH DS
        XOR AX, AX
        PUSH AX
        
        ; define data segment
        MOV AX, DATASG
        MOV DS, AX
        
        ; scan
        MOV AH, 01H
        INT 21H
        MOV MSG[12], AL

        ; print
        LEA DX, MSG
        MOV AH, 09H
        INT 21H
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

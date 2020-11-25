STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DB -101,-20,3,4,5,6,7,8
    LEN DB 8
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
        
        ; our code
        XOR AX, AX
        XOR CX, CX
        MOV CL, LEN
        MOV SI, 0
     L1:
        MOV AL, ARR[SI]
        CMP AL, ARR[SI+1]
        JG FALSE
        INC SI
        LOOP L1
        MOV BX, 1
        JMP END
  FALSE:
        MOV BX, 0
    END:    
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

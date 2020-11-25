STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR1 DB 11,12,13,14,15,16,17,18
    ARR2 DB 21,22,23,24,25,26,27,28
    LEN  DB 8
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
        XOR CX, CX
        MOV CL, LEN
        MOV SI, 0
        XOR AX, AX
     L1:
        MOV AL, ARR1[SI]
        XCHG [ARR2 + SI], AL
        MOV [ARR1 + SI], AL
        
        INC SI
        LOOP L1    
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR1 DB 1,2,3,4,5,6,7,8
    ARR2 DB 8 DUP (?)
    LEN  DW 8
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
        PUSH ES
        MOV ES, AX
        LEA SI, ARR1
        LEA DI, ARR2
        CLD ; direction: from 0 to n
        XOR AX, AX
        MOV CX, LEN
        REP MOVSB ; ARR2[i] <- ARR1[i]
        POP ES
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

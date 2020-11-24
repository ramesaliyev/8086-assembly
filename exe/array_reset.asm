STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DB 1,2,3,4,5,6,7,8
    LEN DW 8
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
        LEA DI, ARR
        CLD ; direction: from 0 to n
        XOR AX, AX
        MOV CX, LEN
        REP STOSB ; ARR[i] <- AL
        POP ES
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

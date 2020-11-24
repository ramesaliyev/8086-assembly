STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DB 1,2,3,4,5,6
    LEN DB 6
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
        XOR BX, BX
        MOV AL, LEN
        MOV BL, 2
        DIV BL

        XOR CX, CX
        MOV CL, AL
        MOV SI, 0
        XOR AX, AX
        MOV AL, LEN
        MOV DI, AX
        DEC DI
     L1:
        XOR AX, AX
        MOV AL, ARR[SI]
        XCHG AL, ARR[DI]
        MOV ARR[SI], AL
        
        INC SI
        DEC DI
        LOOP L1
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

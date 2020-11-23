STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DW 1,2,3,4,5,6
    LEN DW 6
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
        MOV AX, LEN
        MOV BX, 2
        DIV BL

        XOR CX, CX
        MOV CL, AL
        
        MOV SI, 0
        MOV DI, LEN
        ADD DI, DI
        SUB DI, 2
     L1:
        MOV AX, ARR[SI]
        XCHG AX, ARR[DI]
        MOV ARR[SI], AX
        
        ADD SI, 2
        SUB DI, 2
        LOOP L1
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR1 DB 1,2,3,4,5,6,7,8
    ARR2 DW 9,10,11,12,13,14,15,16
    LEN  DW 8
    ARRC DW 16 DUP (0)
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
        MOV DI, 0
        
        MOV CX, LEN
        MOV SI, 0
     L1:
        MOV AL, ARR1[SI]
        MOV [ARRC + DI], AX
        INC SI
        ADD DI, 2
        LOOP L1
        MOV CX, LEN
        MOV SI, 0
     L2:
        MOV AX, ARR2[SI]
        MOV [ARRC + DI], AX
        ADD SI, 2
        ADD DI, 2
        LOOP L2
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

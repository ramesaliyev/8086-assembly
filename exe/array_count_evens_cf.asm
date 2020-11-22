STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR  DW 10, 11, 'A', 01110101B, 0E3H, 2, 3, 101, 230, 11
    LEN  DW 10
    C_EVEN DW 0
    C_ODD  DW 0
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
        MOV CX, LEN
        XOR SI, SI
     L1:
        MOV AX, ARR[SI]
        SHR AX, 1
        JNC EVEN
        INC C_ODD
    EVEN:
        ADD SI, 2
        LOOP L1
        
        MOV BX, LEN
        SUB BX, C_ODD
        MOV C_EVEN, BX
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN
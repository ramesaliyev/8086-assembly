STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DW 1234H, 2345H, 0ABCDH, 0DEDEH, 0BABAH
    ;      4321H, 5432H, 0DCBAH, 0EDEDH, 0ABABH
    LEN DW 5 
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
        MOV SI, 0
     L1:
        PUSH CX
        
        MOV AX, ARR[SI]
        XCHG AH, AL
        MOV CL, 4
        ROR AH, CL
        ROR AL, CL
        MOV ARR[SI], AX
        
        ADD SI, 2
        POP CX
        LOOP L1
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN
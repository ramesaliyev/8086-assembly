STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DB 0, 1, 3, 7, 15, 31, 63, 127
    ONE DB 8 DUP (0}
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
        MOV CX, LEN
        MOV SI, 0
     L1:
        PUSH CX
        MOV CX, 8
        XOR AX, AX
        MOV AH, ARR[SI]
     L2:       
        RCR AH, 1
        ADC AL, 0
        LOOP L2
        
        MOV ONE[SI], AL              
        INC SI
        POP CX
        LOOP L1
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

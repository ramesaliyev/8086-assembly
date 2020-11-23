STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DW 3, -5, 10, 20, -3, 7, -8, 4
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
        CMP WORD PTR ARR[SI], 0
        JGE NEXT
        NEG WORD PTR ARR[SI]
   NEXT:
        ADD SI, 2
        LOOP L1
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

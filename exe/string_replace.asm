STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ; Variable definitions.
    STRING  DB 'H', 'E', 'L', 'L', 'O', 'T', 'H', 'E', 'R', 'E'
    LEN     DB 10
    FIND    DB 'E'
    REPLACE DB 'I'
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
        XOR BX, BX
        XOR CX, CX
        MOV BL, REPLACE
        MOV CL, LEN
        MOV SI, 0
     L1:
        XOR AX, AX
        MOV AL, STRING[SI]
        CMP AL, FIND
        JNZ NEXT
        MOV STRING[SI], BL  
   NEXT:
        INC SI
        LOOP L1
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

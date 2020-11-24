STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DW 89, 17, 7, 37, 128, 57, 3, 93
    LEN DW 8
    MIN DW 0
    MAX DW 0
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
        LEA BX, ARR
        MOV AX, [BX]
        MOV MAX, AX
        MOV MIN, AX
        
        MOV CX, LEN
        DEC CX
        MOV DI, 2
     
   FIND:
        MOV AX, [BX + DI]
        CMP AX, MAX 
        JNA C1
        MOV MAX, AX
        JMP NEXT
     C1:
        CMP AX, MIN
        JAE NEXT
        MOV MIN, AX
   NEXT:
        ADD DI, 2
        LOOP FIND
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

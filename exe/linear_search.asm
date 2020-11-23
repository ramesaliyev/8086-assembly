STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR   DW 17, 89, 93, 27, 30, 11, 20
    LEN   DW 7
    FIND  DW 27
    INDEX DW -1
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
        MOV AX, FIND
        MOV BX, 0
        MOV CX, LEN
        MOV SI, 0
     L1:
        CMP AX, ARR[SI]
        JE FOUND
        INC BX
        ADD SI, 2
        LOOP L1
        JMP EXIT
  FOUND:
        MOV INDEX, BX
   EXIT:

        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

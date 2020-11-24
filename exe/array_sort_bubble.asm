STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DB 123, 12, 13, 5, 45, 61, 31, 67, 99, 117, 17, 89, 23, 93, 127, 11
    LEN DB 16
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
        XOR CX, CX
        MOV CL, LEN
        DEC CL
        MOV BX, CX
  OUTER:
        PUSH CX
        MOV SI, 0
        MOV CX, BX
        SUB CX, DI
  
  INNER:
        XOR AX, AX
        MOV AL, ARR[SI]
        CMP AL, ARR[SI + 1]
        JNA NEXT
        XCHG AL, ARR[SI + 1]
        MOV ARR[SI], AL
   NEXT:
        INC SI
        LOOP INNER
   
        INC DI
        POP CX
        LOOP OUTER
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

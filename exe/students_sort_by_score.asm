STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    STUDENTS DW 107,102,108,106,105,104,101,103
    SCORES   DB 25,74,13,37,42,55,87,63
    LEN      DB 8
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
        XOR DX, DX
        XOR CX, CX
        MOV CL, LEN
        DEC CL
        MOV BX, CX
        MOV DL, 0
  OUTER:
        PUSH CX
        MOV SI, 0
        MOV DI, 0
        MOV CX, BX
        SUB CL, DL
        
  INNER:
        XOR AX, AX
        MOV AL, SCORES[SI]
        CMP AL, SCORES[SI+1]
        JNB CONT
        XCHG AL, SCORES[SI+1]
        MOV SCORES[SI], AL
        MOV AX, STUDENTS[DI]
        XCHG AX, STUDENTS[DI+2]
        MOV STUDENTS[DI], AX
        
   CONT:    
        INC SI
        ADD DI, 2
        LOOP INNER    
        
        INC DL
        POP CX
        LOOP OUTER
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

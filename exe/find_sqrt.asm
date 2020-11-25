STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR   DB 4, 9, 16, 25, 36, 49, 64, 81
    ROOTS DB 8 DUP (0)
    LEN   DB 8
    INDEX DB 0
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
        MOV SI, 0
        MOV DI, 0
        
  OUTER:
        PUSH CX
        XOR AX, AX
        MOV AL, ARR[SI]
        MOV CX, AX
        SHR CX, 1
        MOV BX, 2
        
  INNER:
        PUSH AX
        DIV BL
        MOV DX, AX
        POP AX
        CMP DH, 0
        JNE CONT
        CMP DL, BL
        JNE CONT
        MOV ROOTS[DI], BL
        INC DI
        JMP NEXT
        
   CONT:
        INC BL     
        LOOP INNER    
   
   NEXT:     
        INC SI
        POP CX
        LOOP OUTER    
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

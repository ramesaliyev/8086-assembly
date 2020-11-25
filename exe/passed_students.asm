STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    STUDENTS DW 1, 2, 3, 4, 5, 6, 7, 8
    SCORES   DW 10, 20, 30, 40, 50, 60, 70, 80
    LEN      DW 8
    AVERAGE  DW 0
    PASSED   DW 8 DUP (0)
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
        ; calculate average score
        XOR AX, AX
        MOV CX, LEN
        MOV SI, 0 
     L1:
        ADD AX, SCORES[SI]
        ADD SI, 2
        LOOP L1
        MOV BX, LEN
        DIV BX
        MOV AVERAGE, AX
        
        MOV CX, LEN
        MOV SI, 0
        MOV DI, 0
     L2:
        CMP SCORES[SI], AX
        JB CONT
        MOV BX, STUDENTS[SI]
        MOV PASSED[DI], BX
        ADD DI, 2
        
   CONT:
        ADD SI, 2
        LOOP L2
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

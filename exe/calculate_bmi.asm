STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
  HEIGHTS    DB 5, 11, 19, 29, 42  
  WEIGHTS    DW 4, 5, 6, 7, 8
  SCORES     DW 5 DUP (?)
  LEN        DB 5        
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
        LEA BX, SCORES
        LEA SI, HEIGHTS
        LEA DI, WEIGHTS
        
        XOR CX, CX
        MOV CL, LEN
     L1:
        XOR AX, AX
        XOR DX, DX
        MOV AL, [SI] 
        DIV WORD PTR [DI] 
        MOV [BX], AX
        
        ADD SI, 1
        ADD DI, 2
        ADD BX, 2
        LOOP L1
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN
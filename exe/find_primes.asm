STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR    DB 2, 4, 7, 9, 15, 19, 31, 32, 41, 53, 55, 61, 75, 91, 101, 111
    PRIMES DB 16 DUP(0)
    INDEX  DB 0
    LEN    DB 16
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
         
        ; 2 is prime
        CMP AL, 2
        JNE CONT
        MOV PRIMES[DI], AL 
        INC DI
        JMP NEXT
                            
   CONT: 
        ; evens are not prime
        TEST AL, 1
        JZ NEXT
        
        ; will look only odd numbers
        MOV CL, AL
        SUB CL, 3
        XOR BX, BX
        MOV BL, 3 
  INNER:
        PUSH AX    
        DIV BL
        CMP AH, 0
        POP AX
        JE NEXT
        ADD BL, 2
        SUB CX, 2
        JCXZ INNER
        
        MOV PRIMES[DI], AL
        INC DI    
   NEXT:
        INC SI
        POP CX
        LOOP OUTER
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

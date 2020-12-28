STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    m DW 8191
    a DW 884
    c DW 1
    SEED DW 0
    RANDOM DW -1
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
        
        ; get seed
        MOV BX, CS:[23]
        MOV SEED, BX
        MOV SEED, 15
        
    WHL:
        ; exit if random number between 0-255
        CMP RANDOM, 0
        JL INIT
        CMP RANDOM, 255
        JG INIT
        JMP FOUND 
         
   INIT:
        ; in first run, use seed as initial random number (x0)
        CMP RANDOM, -1
        JNE CONT
        MOV AX, SEED
        MOV RANDOM, AX
        
   CONT:
        ; calculate next random number
        XOR DX, DX
        MOV AX, RANDOM
        IMUL WORD PTR a
        ADD AX, c
        ADC DX, 0
        IDIV WORD PTR m
        MOV RANDOM, DX         
                
        JMP WHL    
    
  FOUND:
    
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    A DB 4
    B DB 3
    C DB 5
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
        XOR AX, AX
        XOR BX, BX
        XOR CX, CX
        MOV AL, A
        MOV BL, B
        MOV CL, C
        
        CMP AL, BL
        JE L1
        CMP BL, CL
        JE TYPE2
        CMP AL, CL
        JE TYPE2
        JMP TYPE3
     L1:
        CMP AL, CL
        JE TYPE1
        JMP TYPE2
                
  TYPE1:; Equilateral
        MOV DX, 1
        JMP DONE
        
  TYPE2:; Isosceles
        MOV DX, 2
        JMP DONE
        
  TYPE3:; Scalene
        MOV DX, 3
   DONE:
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

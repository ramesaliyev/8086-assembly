STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
  NUM1 DD 0FFFFFFFFH
  NUM2 DD 3H         ; 1 0000 0002
  NUM3 DD 0FEDCBA98H
  NUM4 DD 0EDCBA987H ; 1 ECA8 641F
  SUM  DQ 0      
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
        
        ; get
        LEA BX, SUM
        LEA SI, NUM1
        LEA DI, NUM2
        
        ; add least-significant-word
        MOV AX, [SI]
        ADD AX, [DI]
        MOV [BX], AX
        
        ; add most-significant-word
        MOV AX, [SI+2]
        ADC AX, [DI+2]
        MOV [BX+2], AX
        
        ; add cf
        ADC WORD PTR [BX+4], 0
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN
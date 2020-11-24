STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DB 'A','B','C','D','E','F','G','H'
    LEN DW 8
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
        PUSH ES
        MOV AX, DS
        MOV ES, AX ;SCAS uses ES:DI, so copy DS to ES
        LEA DI, ARR
        CLD ; Scan in the forward direction
        XOR AX, AX
        XOR BX, BX
        MOV AL, 'B'
        MOV CX, LEN
        REPNE SCASB ; scan till end (CX=0) or there is a match (ZF=1) for 'A', 
        JNE NFOUND ; The Zero Flag will be set (EQUAL==1) if we found a match, (ZF=1 match) (ZF=0 no match)
        DEC DI; Back up DI so it points to the first matching
        MOV BL, 1 ; found action
        JMP FINISH
 NFOUND:
        MOV BL, 3 ; not found action
 FINISH: 
        POP ES
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

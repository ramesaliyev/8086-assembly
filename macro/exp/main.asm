include EXP.M

STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    POWER1	DW 3
    BASE1	DW 2
    RESULT1	DD ?
    ;
    POWER2	DW 2
    BASE2	DW 3
    RESULT2	DD ?
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
        EXP_MACRO POWER1, BASE1, RESULT1
        EXP_MACRO POWER2, BASE2, RESULT2
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

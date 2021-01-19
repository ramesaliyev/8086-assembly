EXTRN ARR_MAX_F:NEAR, ARR_MIN_F:NEAR, ARR_AVG_F:NEAR
PUBLIC ARR, LEN

STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR DW 13, 12, 14, 25, 14, 12, 11, 4, 2, 12
    LEN DW 10
    MIN DW ?
    AVG DW ?
    MAX DW ?
DATASG ENDS

CODESG SEGMENT PARA PUBLIC 'CODE'
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
        
        ; call functions
        CALL ARR_MAX_F
        MOV MAX, AX

        CALL ARR_AVG_F
        MOV AVG, AX

        CALL ARR_MIN_F
        MOV MIN, AX
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

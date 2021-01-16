EXTRN GCD_PROC:FAR

STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    A   DW 21
    B   DW 14
    GCD DW ?
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
        PUSH A
        PUSH B
        CALL GCD_PROC
        POP GCD; response of GCD_PROC

        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

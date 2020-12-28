STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    RATE DW 0
    LEN DW 2392
    ACCOUNT DW 2392 DUP(?)
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
        
        ; sum positive balances
        XOR DX, DX
        XOR AX, AX
        XOR SI, SI
        MOV CX, LEN
     L1:
        CMP ACCOUNT[SI], 0
        JLE NEXT
        ADD AX, ACCOUNT[SI]
        ADC DX, 0
   NEXT:
        ADD SI, 2
        LOOP L1
        
        ; find tax cuts
        MOV BX, 5
        DIV BX
        
        ; find rate of cuts
        XOR DX, DX
        MOV BX, LEN
        DIV BX
        
        MOV RATE, AX
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

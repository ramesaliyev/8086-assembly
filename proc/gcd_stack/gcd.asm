PUBLIC GCD_PROC

CODESG SEGMENT PARA 'CODE'
    ASSUME CS:CODESG
    
    ; GCD procedure
    GCD_PROC PROC FAR
        PUSH BP
        MOV BP, SP ; store SP since SP could change because of interrupts or other things
        PUSH AX
        PUSH BX
        PUSH DX

        MOV BX, [BP+6] ; B
        MOV AX, [BP+8] ; A
        
        CMP AX, BX
        JAE CONT
        XCHG AX, BX
        
        CONT:
        CMP BX, 0
        JA NEXT
        JMP EXIT 
        
        NEXT:
        XOR DX, DX
        DIV BX
        MOV AX, BX
        MOV BX, DX
        JMP CONT   

        EXIT:
        MOV [BP+8], AX
        POP DX
        POP BX
        POP AX
        POP BP
        RETF 2 ; increase SP by 2 after return completed, (SP+2)
        ; last entry in stack will be our AX

    GCD_PROC ENDP
CODESG ENDS
END

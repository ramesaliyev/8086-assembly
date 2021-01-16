PUBLIC GCD_PROC

CODESG SEGMENT PARA 'CODE'
    ASSUME CS:CODESG
    
    ; GCD procedure
    ; input: AX, DX
    ; output: AX
    GCD_PROC PROC FAR
        CMP AX, DX
        JAE CONT
        XCHG AX,DX
  
        CONT:
        CMP DX, 0
        JA RECUR
        JMP EXIT
 
        RECUR:
        MOV BX, DX
        XOR DX, DX
        DIV BX
        MOV AX, BX
        CALL GCD_PROC  

        EXIT:
        RETF
    GCD_PROC ENDP
CODESG ENDS
END

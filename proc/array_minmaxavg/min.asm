PUBLIC ARR_MIN_F
EXTRN ARR:WORD, LEN:WORD

CODESG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CODESG
    
    ; main procedure
    ARR_MIN_F PROC NEAR
        PUSH CX
	    PUSH SI

        LEA SI, ARR
        MOV CX, LEN
        MOV AX, [SI]
        DEC CX

        NEXT: 
        ADD SI,2
        CMP AX, [SI]
        JB CONT
        MOV AX, [SI]
        
        CONT:
        LOOP NEXT

        ; return
        POP SI
	    POP CX
        RET
    ARR_MIN_F ENDP
CODESG ENDS
END

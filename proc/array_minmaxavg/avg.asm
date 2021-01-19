PUBLIC ARR_AVG_F
EXTRN ARR:WORD, LEN:WORD

CODESG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CODESG
    
    ; main procedure
    ARR_AVG_F PROC NEAR
        PUSH CX
	    PUSH BX
	    PUSH SI
	    PUSH DX
        
        LEA SI, ARR
        MOV CX, LEN
        MOV BX, CX
        XOR AX, AX
        XOR DX, DX
        
        NEXT:
        ADD AX, [SI]
        ADC DX, 0
        ADD SI,2
        LOOP NEXT
        
        DIV BX

        ; return
	    POP DX
	    POP SI
	    POP BX
	    POP CX
        RET
    ARR_AVG_F ENDP
CODESG ENDS
END

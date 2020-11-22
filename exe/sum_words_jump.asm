STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    NUM1 DW 0ABCDH ; DS:[0,1] = [LSB,MSB] 
    NUM2 DW 0CDEFH ; DS:[2,3] = [LSB,MSB] 
    SUM  DD 0      ; DS:[4,5,6,7] = [LSB...MSB]
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
        LEA BX, SUM ; BX has offset of LSB of SUM variable.
        
        MOV AX, NUM1
        ADD AX, NUM2
        
        MOV [BX], AX ; LSB of SUM = AX
        
        JNC NOCARRY
        INC WORD PTR [BX+2] ; MSB of SUM = 1
        NOCARRY:
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN
STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    RAKIMLAR DW 257 DUP (?) 
    LEN      DW 257
    DUORT    DW 0 ; deniz ustundekilerin ortalamasi
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
        XOR AX, AX
        XOR BX, BX ; deniz ustundekilerin oksijen toplami
        XOR DX, DX ; toplam deniz ustunduklerin sayisi
        MOV CX, LEN
        MOV SI, 0
     L1:
        PUSH CX
        XOR CX, CX
        
        MOV AX, RAKIMLAR[SI]
        CMP AX, 0
        JLE NEXT ; deniz alti
        MOV CL, 4
        DIV CL
        MOV AH, 0
        ADD BX, AX
        INC DX 
        
   NEXT:
        ADD SI, 2
        POP CX    
        LOOP L1
        
        MOV AX, BX
        MOV CX, DX
        XOR DX, DX
        DIV CX
        MOV DUORT, AX
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

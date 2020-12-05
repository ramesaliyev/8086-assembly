CODESG SEGMENT PARA 'CODE'
    ORG 100H
    ASSUME CS:CODESG, DS:CODESG, SS:CODESG
    
    ; initial jump
    START: JMP MAIN
    
    ; data segment variable definitions
    ARR DW 0FFFFH, 100, 28, 1, 0, 495 DUP(256)
    LEN DW 500
    AVG DW 0
    
    ; main procedure
    MAIN PROC NEAR
        ; our code
        LEA SI, ARR
        MOV CX, LEN
        XOR AX, AX
        XOR DX, DX
     L1:
        ; sum all numbers on DX:AX
        ADD AX, [SI]
        ADC DX, 0
        
        ADD SI, 2
        LOOP L1
        
        ; calculate average
        MOV BX, LEN
        DIV BX ; AX<-DX:AX/BX DX<-DX:AX%BX 
        MOV AVG, AX
        
        ; return
        RET
    MAIN ENDP
CODESG ENDS

END START
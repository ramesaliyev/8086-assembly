CODESG SEGMENT PARA 'CODE'
    ORG 100H
    ASSUME CS:CODESG, DS:CODESG, SS:CODESG
    
    ; initial jump
    START: JMP MAIN
    
    ; data segment variable definitions
    X    DW 28, 0FFFFH, 1, 100, 511
    Y    DW 12, 0FFFH, 28, 25, 3
    LEN  DW 5
    GCD  DW 5 DUP(0)
    
    ; main procedure
    MAIN PROC NEAR
        ; our code
        ; logic: GCD(X,Y) = GCD(Y, X%Y)
        
        XOR SI, SI
        MOV CX, LEN
     L1:
        MOV AX, X[SI]
        MOV DX, Y[SI}
        ; make X>Y, AX > DX
        CMP AX, DX
        JAE L2
        XCHG AX, DX
     L2:
        CMP DX, 0
        JE L3
        MOV BX, DX
        XOR DX, DX
        DIV BX  ; BX=DX, DX=0, AX<-0:AX/BX, DX<-0:AX%BX
        MOV AX, BX
        JMP L2      
     L3:            
        MOV GCD[SI], AX
        ADD SI, 2
        LOOP L1
        
        ; return
        RET
    MAIN ENDP
CODESG ENDS

END START
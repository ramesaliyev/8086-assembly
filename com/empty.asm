CODESG SEGMENT PARA 'CODE'
    ORG 100H
    ASSUME CS:CODESG, DS:CODESG, SS:CODESG
    
    ; initial jump
    START: JMP MAIN
    
    ; data segment variable definitions
    ; ...
    
    ; main procedure
    MAIN PROC NEAR
        ; our code
        ; ...
        
        ; return
        RET
    MAIN ENDP
CODESG ENDS

END START
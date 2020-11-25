STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    A   DW 16
    B   DW 24
    GCD DW 1   
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
        MOV AX, A
        MOV BX, B
        CMP AX, BX
        JNA SORTED ; make AX smaller one
        XCHG AX, BX
 SORTED:
        MOV CX, 2
  LOOP1:
        MOV SI, 0
        
        ; exit early if both of numbers is 1
        CMP AX, BX
        JNE CONT0
        CMP AX, 1
        JE EXIT
  CONT0:
        
        ; try to div smaller
        PUSH AX
        XOR DX, DX
        DIV CX
        CMP DX, 0
        JNE CONT1 ; go CONT1 if divided with remainder
        ADD SP, 2 ; remove last pushed AX        
        INC SI ; first one is ok
        ; AX has quotient as new value
        JMP CONT2
  CONT1:
        POP AX       
  CONT2:
        ; try to div bigger
        PUSH AX
        XOR DX, DX
        MOV AX, BX
        DIV CX
        CMP DX, 0
        JNE CONT3 ; go CONT3 if divided with remainder
        INC SI ; second one is ok
        MOV BX, AX ; BX has quotient as new value
  CONT3:
        POP AX
        
        ; are they both not ok?
        CMP SI, 0
        JE NOTOK ; change divider, continue looping
        
        ; is even only one of them ok, register divider?
        PUSH AX
        XOR DX, DX
        MOV AX, GCD
        MUL CX
        MOV GCD, AX
        POP AX
        JMP NEXT
  NOTOK: 
        INC CX
   NEXT:    
        JMP LOOP1  
   EXIT:
    
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

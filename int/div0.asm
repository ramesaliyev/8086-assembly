STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ARR1     DW 1, 2, 3
    ARR2     DW 1, 0, 3
    LEN      DW 7
    INTDIV0_IP DW 0 ; IP of original DIV0 handler
    INTDIV0_CS DW 0 ; CS of original DIV0 handler
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
        
        ; get and backup original address of initial DIV0 handler.
        ; which is sits at 00:00H - 00:04H (first 2 bytes IP, second 2 bytes CS)
        XOR AX, AX
        MOV ES, AX
        MOV AX, ES:[0] ; get IP (offset) to AX
        MOV INTDIV0_IP, AX ; store
        MOV AX, ES:[2] ; get CS (segment) to AX
        MOV INTDIV0_CS, AX ; store
        
        ; set our DIV0 handler.
        LEA AX, DIV0
        MOV ES:[0], AX
        MOV AX, CS
        MOV ES:[2], AX

        ; set interrupt flag as 1 to allow interrupts.
        STI

        ; do arr1/arr2
        XOR SI, SI
        MOV CX, LEN
        NEXT:      
        XOR DX, DX
        MOV AX, ARR1[SI]
        MOV BX, ARR2[SI]
        DIV BX
        ADD SI, 2
        LOOP NEXT

        ; set original DIV0 handler back
        XOR AX, AX
        MOV ES, AX
        MOV AX, INTDIV0_IP
        MOV ES:[0], AX
        MOV AX, INTDIV0_CS
        MOV ES:[2], AX

        ; return
        RETF
    MAIN ENDP

    ; DIV0 interrupt handler
    DIV0 PROC FAR
        PUSH BP
        MOV BP, SP

        ; change return point by increasing IP of main proc by 2
        ADD WORD PTR [BP+2], 2

        ; change result 
        MOV AX, 0FFFFH

        POP BP
        IRET
    DIV0 ENDP
CODESG ENDS

END MAIN

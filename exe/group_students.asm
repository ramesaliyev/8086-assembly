STACKSG SEGMENT PARA STACK 'STACK'
    DW 32 DUP(?)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    ;           1      3      1      3      1      3      1      1      4      4      2      4      2      4      2      2      
    STUDENTS DW 11123, 12134, 13145, 14156, 15167, 16178, 17189, 18291, 19212, 20234, 21245, 22256, 23267, 24278, 25289, 26333
    GROUP1   DW 16 DUP (0)
    GROUP2   DW 16 DUP (0)
    GROUP3   DW 16 DUP (0)
    GROUP4   DW 16 DUP (0)
    LENTOTAL DW 16
    GROUP1I  DW 0
    GROUP2I  DW 0
    GROUP3I  DW 0
    GROUP4I  DW 0
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
        MOV CX, LENTOTAL
        XOR SI, SI
     L1:
        PUSH CX
        XOR CX, CX
        XOR DI, DI

        ; get rid of digits after hundreds
        MOV AX, STUDENTS[SI]
        MOV BX, 1000
        DIV BX
        MOV AX, DX

        ; add digit of the hunderds
        MOV BX, 100
        DIV BL
        ADD CL, AL

        ; get remainder
        MOV AL, AH
        MOV AH, 0

        ; add digit of the tens and ones
        MOV BX, 10
        DIV BL
        ADD CL, AL
        ADD CL, AH

        ; CL now have sum of last 3 digits
        XOR DX, DX

        MOV AX, STUDENTS[SI]
        TEST AX, 01H
        JZ ISEVEN
        ; number is odd

          TEST CL, 01H
          JZ ODD_SUMISEVEN
            ; sum is odd
            MOV DI, GROUP2I
            MOV GROUP2[DI], AX
            ADD GROUP1I, 2
          JMP NEXT
          ODD_SUMISEVEN:
            ; sum is even
            MOV DI, GROUP1I
            MOV GROUP1[DI], AX
            ADD GROUP1I, 2

        JMP NEXT
 ISEVEN:
        ; number is even

          TEST CL, 01H
          JZ EVEN_SUMISEVEN
            ; sum is odd
            MOV DI, GROUP4I
            MOV GROUP4[DI], AX
            ADD GROUP1I, 2
          JMP NEXT
          EVEN_SUMISEVEN:
            ; sum is even
            MOV DI, GROUP3I
            MOV GROUP3[DI], AX
            ADD GROUP1I, 2

   NEXT:
        ADD SI, 2
        POP CX
        LOOP L1
        
        ; return
        RETF
    MAIN ENDP
CODESG ENDS

END MAIN

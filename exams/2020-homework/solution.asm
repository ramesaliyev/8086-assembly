; Aciklama;
; - Programda hem ozyinelemeli calisan "CONWAY" hem de dinamik calisan "DCONWAY"
;   olmak uzere iki farkli hesaplama yordami gelistirilmistir. 
;
; - Menuden 1. secenek secildiginde ozyinelemeli calisan CONWAY alt yordami
;   calisacak ve girilen n degeri icin a(n) hesaplanarak ekrana yazilacaktir.
;
; - Menuden 2. secenek secildiginde ise, dinamik calisan DCONWAY alt yordami calisacak
;   ve 0 ila girilen n degeri arasindaki tum a(n) degerleri hesaplanarak ekrana
;   sirasiyla yanyana yazilacaktir.
;
; - Ekrana yazdirma ve kullanicidan girdi alma fonksiyonlari gelistirilirken 
;   Yrd. Doc. Dr. Ahmet Tevfik Inan tarafindan yazilan "80x86 Assembly Dili"
;   kitabindaki orneklerden faydalanilmistir.
;
; - Kullanicidan girdi beklenen anlarda kullanicinin dogru formatta deger
;   girecegi varsayilmis olup herhangi bir hata kontrolu yapilmamistir.

; Stack Segment
STACKSG SEGMENT PARA STACK 'STACK'
    DW 512 DUP(?)
STACKSG ENDS

; Data Segment
DATASG SEGMENT PARA 'DATA'
    ; Constants.
    CR EQU 13
	LF EQU 10
    SPACE EQU 32

    ; Menu strings.
    NEW_LINE DB CR, LF, "$"
    MENU_TITLE DB "Choose an action:", "$"
    MENU_ITEM1 DB "[1] Calculate a(n) for given n (Recursive method will be used.)", "$"
    MENU_ITEM2 DB "[2] Calculate a(k) for all k in range 0 to n, (Dynamic method will be used.)", "$"
    MENU_ENTER_M DB "Enter action number 1 or 2: ", "$"
    MENU_ENTER_N DB "Enter n: ", "$"
    ECHO_ACTION DB "Selected action: ", "$"
    ECHO_RUNNING DB "Running for n: ", "$"
    ECHO_RESULT DB "Result: ", "$"

    ; Other values.
    CONWAYS DW 1024 DUP(0) ; Cached Conway Sequence
    MAXN    DW -1 ; Maximum cached n of a(n)
    RESULT  DW 0 
DATASG ENDS

; Main Code Segment
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

        ; Show menu.
        CALL MENU

        ; After menu completed.
        ; BX = Selected action.
        ; AX = n

        ; Check user input.
        CMP BX, 1
        JNE ACTION2

        ; Action #1 selected.
        PUSH AX
        CALL FAR PTR CONWAY
        CALL PRINTINT
        POP RESULT
        JMP EXITMAIN

        ACTION2:
        ; Action #2 selected.
        CALL CONWAYRANGE

        ; exit
        EXITMAIN:

        RETF
    MAIN ENDP

    ; Recursive Conway Sequences Conway
    CONWAY PROC FAR
        PUSH BP
        MOV BP, SP
        PUSH AX
        PUSH BX
        PUSH CX

        MOV AX, [BP+6] ; Get n from stack.
        
        ; n==0
        CMP AX, 0
        JNE NONZERO
        XOR AX, AX
        JMP EXITC

        ; n is not zero
        NONZERO:
        ; n==1 or n==2
        CMP AX, 2
        JA CALCULATE
        MOV AX, 1
        JMP EXITC

        ; n is not less than or equal to 2
        CALCULATE: ; a(a(n-1)) + a(n-a(n-1))

        ; a(n-1)
        MOV BX, AX
        DEC BX ; n-1
        PUSH BX
        CALL CONWAY ; stack has a(n-1) now.
        POP CX ; get a(n-1) to CX to use.

        ; a(a(n-1))
        PUSH CX ; push to use as n.
        CALL CONWAY; stack has a(a(n-1)) now.

        ; a(n-a(n-1))
        SUB AX, CX ; n - a(n-1)
        PUSH AX
        CALL CONWAY; stack has a(n-a(n-1)) now.

        ; a(a(n-1)) + a(n-a(n-1))
        POP AX ; a(n-a(n-1))
        POP BX ; a(a(n-1))
        ADD AX, BX

        EXITC:
        MOV [BP+6], AX ; Store result in stack.

        ; return
        POP CX
        POP BX
        POP AX
        POP BP
        RETF
    CONWAY ENDP

    ; Dynamic Conway Sequences Calculator
    DCONWAY PROC FAR
        PUSH BP
        MOV BP, SP
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH SI

        MOV AX, [BP+6] ; Get n from stack.
        MOV SI, AX

        ; n==0
        CMP AX, 0
        JNE DNONZERO
        XOR AX, AX
        JMP EXITDC

        ; n is not zero
        DNONZERO:
        ; n==1 or n==2
        CMP AX, 2
        JA DCACHECHECK
        MOV AX, 1
        JMP EXITDC

        ; check for cached calculations
        DCACHECHECK:
        CMP AX, MAXN
        JG DCALCULATE
        SHL SI, 1
        MOV AX, CONWAYS[SI]
        JMP EXITDC

        ; n is not less than or equal to 2
        ; and not calculated before
        DCALCULATE: ; a(a(n-1)) + a(n-a(n-1))

        ; a(n-1)
        MOV BX, AX
        DEC BX ; n-1
        PUSH BX
        CALL DCONWAY ; stack has a(n-1) now.
        POP CX ; get a(n-1) to CX to use.

        ; a(a(n-1))
        PUSH CX ; push to use as n.
        CALL DCONWAY; stack has a(a(n-1)) now.

        ; a(n-a(n-1))
        SUB AX, CX ; n - a(n-1)
        PUSH AX
        CALL DCONWAY; stack has a(n-a(n-1)) now.

        ; a(a(n-1)) + a(n-a(n-1))
        POP AX ; a(n-a(n-1))
        POP BX ; a(a(n-1))
        ADD AX, BX

        ; Cache
        MOV MAXN, SI
        SHL SI, 1
        MOV CONWAYS[SI], AX

        EXITDC:
        MOV [BP+6], AX ; Store result in stack.

        ; return
        POP SI
        POP CX
        POP BX
        POP AX
        POP BP
        RETF
    DCONWAY ENDP

    ; Calculate Conway sequence from 0 to range defined by AX.
    CONWAYRANGE PROC NEAR
        PUSH AX
        PUSH CX
        PUSH SI
        MOV CX, AX
        INC CX
        MOV SI, 0

        RANGELOOP:
        PUSH SI

        CALL FAR PTR DCONWAY ; calculate
        CALL PRINTINT ; print result
        POP RESULT
        
        MOV AL, SPACE ; print a space after result
        CALL PRINTC
        
        INC SI
        LOOP RANGELOOP
        
        POP SI
        POP CX
        POP AX
        RET
    CONWAYRANGE ENDP

    ; Show menu and get user input.
    MENU PROC NEAR
        CALL PRINTNL
        LEA AX, MENU_TITLE
        CALL PRINTLSTR
        LEA AX, MENU_ITEM1
        CALL PRINTLSTR
        LEA AX, MENU_ITEM2
        CALL PRINTLSTR
        
        LEA AX, MENU_ENTER_M
        CALL PRINTSTR
        CALL SCANINT
        MOV BX, AX ; BX = Action

        LEA AX, MENU_ENTER_N
        CALL PRINTSTR
        CALL SCANINT ; AX = n

        CALL PRINTNL

        PUSH AX
        LEA AX, ECHO_ACTION
        CALL PRINTSTR
        PUSH BX
        CALL PRINTINT
        POP BX
        POP AX
        CALL PRINTNL

        PUSH AX
        LEA AX, ECHO_RUNNING
        CALL PRINTSTR
        POP AX
        PUSH AX
        CALL PRINTINT
        POP AX
        CALL PRINTNL

        CALL PRINTNL
        RET
    MENU ENDP

    ; Scan Functions
    ; Scan single char to AL
    SCANC PROC NEAR
        MOV AH, 1H
        INT 21H
        RET
    SCANC ENDP
    ; Scan full integer up to enter key.
    SCANINT PROC NEAR
        PUSH BX
        PUSH CX
        PUSH DX

        MOV DX, 1
        XOR BX, BX
        XOR CX, CX

        READ:
        CALL SCANC
        CMP AL, CR ; Is it enter?
        JE EXITSI ; Finish reading if enter received.

        SUB AL, '0'
        MOV BL, AL
        MOV AX, 10
        MUL CX
        MOV CX, AX
        ADD CX, BX
        JMP READ

        EXITSI:
        MOV AX, CX
        POP DX
        POP CX
        POP BX
        RET
    SCANINT ENDP

    ; Print Functions
    ; Print String from offset pointed by AX ended by new line.
    PRINTLSTR PROC NEAR
        CALL PRINTSTR
        CALL PRINTNL 
        RET    
    PRINTLSTR ENDP
    ; Print new line.
    PRINTNL PROC NEAR
        PUSH AX
        LEA AX, NEW_LINE
        CALL PRINTSTR
        POP AX
        RET
    PRINTNL ENDP
    ; Print String from offset pointed by AX
    PRINTSTR PROC NEAR
        PUSH AX
        PUSH DX
        MOV DX, AX
        MOV AH, 09H
        INT 21H
        POP DX
        POP AX
        RET  
    PRINTSTR ENDP
    ; Print a Single Char from AL
    PRINTC PROC NEAR
        PUSH AX
        PUSH DX
        MOV DL, AL
        MOV AH, 2
        INT 21H
        POP DX
        POP AX
        RET
    PRINTC ENDP
    ; Print Int
    PRINTINT PROC NEAR
        PUSH BP
        MOV BP, SP
        PUSH AX
        PUSH CX
        PUSH DX

        MOV AX, [BP+4] ; Get integer to print.
        XOR DX, DX
        PUSH DX ; 0 as ASCII is terminating char for our int.
        MOV CX, 10 ; We will divide by 10 to findout digits.

        PARSE: ; parse digits one by one and store as ASCII chars.
        DIV CX ; DX:AX / CX --> AX=quotient  DX=remainder
        ADD DX, '0' ; Convert remainder to ASCII.
        PUSH DX
        XOR DX, DX
        CMP AX, 0 ; Is there any digit left?
        JNE PARSE ; There is more.
        ; All digits are parsed and stored in stack

        DISPLAY:
        POP AX
        CMP AX, 0 ; Are we done?
        JE EXITPI
        CALL PRINTC ; Print single char stored in AL.
        JMP DISPLAY
        ; All digits are displayed.

        EXITPI:
        POP DX
        POP CX
        POP AX
        POP BP
        RET
    PRINTINT ENDP
CODESG ENDS
END MAIN

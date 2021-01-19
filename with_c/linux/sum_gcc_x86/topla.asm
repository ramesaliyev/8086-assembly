section .data

section .text

global Topla

Topla:
    	PUSH EBP
	PUSH EDI
	PUSH ECX
    	MOV EBP, ESP

    	MOV  EDI, [EBP+16]
    	MOV  ECX, [EBP+20]
	XOR EAX, EAX
L1:	ADD EAX, [EDI]
	ADD EDI, 4
	LOOP L1
	
	POP ECX
	POP EDI
    	POP EBP
    	RET

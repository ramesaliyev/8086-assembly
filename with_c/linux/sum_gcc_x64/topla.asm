section .data

section .text

global Topla

Topla:
	PUSH RCX
; for the 64-bit assembler, the first 6 parameters are passed by register
; and the rest are placed on the Stack
; While for the x86 assembler, all the parameters are placed on the Stack.	
; RDI 	1st argument
; RSI 	2nd argument
; RDX 	3rd argument
; RCX 	4th argument
; R8 	5th argument
; R9 	6th argument	
    MOV  RCX, RSI
	XOR RAX, RAX
L1:	ADD RAX, [RDI]
	ADD RDI, 4
	LOOP L1
	
	POP RCX
    RET

XOR AX, AX
MOV SI, 2

L1:
ADD AX, SI
ADD SI, 2
CMP SI, 10
JBE L1

MOV BX, 1
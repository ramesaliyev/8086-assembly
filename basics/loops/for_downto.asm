XOR AX, AX
MOV CX, 10

L1:
ADD AX, CX
SUB CX, 2
JCXZ L2
JMP L1

L2:
MOV BX, 1
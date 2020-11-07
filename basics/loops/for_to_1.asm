XOR AX, AX ; Same with "MOV AX, 0" but in 3 cycle instead of 4.
MOV SI, 1
MOV CX, 10

L1:
ADD AX, SI
INC SI
LOOP L1

MOV BX, 1
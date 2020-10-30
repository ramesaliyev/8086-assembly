CMP AX, 0H
JNE else

MOV BX, 2
JMP finally 
 
else:
MOV BX, 1

finally:
MOV CX, 5 
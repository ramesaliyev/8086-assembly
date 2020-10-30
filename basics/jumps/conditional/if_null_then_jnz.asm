CMP AX, 0H
JNZ then
JMP finally

then:
MOV BX, 1

finally:
MOV CX, 5

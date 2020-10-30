CMP AX, 0H ; if AX=0H
JE then    ; then jump to label named "then"
JMP else   ; if not continue from label named "else"

then:
MOV BX, 2
JMP finally 
 
else:
MOV BX, 1

finally:
MOV CX, 5 
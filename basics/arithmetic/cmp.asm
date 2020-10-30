; examples to understand CF
MOV DL, 005H ; signed= 5 unsigned= 5 
MOV DH, 0FBH ; signed=-5 unsigned= 251  
          
MOV CL, 0H          
ADD CL, DH
ADD CL, DL ; CF=1, OF=0

; CMP examples
MOV AL, 40H
MOV BL, 20H
MOV CL, 80H

              
CMP AL, BL ; AL - BL = 32
; ZF=0(no zero)
; CF=0(no borrow)
; SF=0(positive, for SIGNED result)
; OF=0(no overflow, we can represent SIGNED result with BYTE, -128~127)
; PF=0(odd, odd number of 1 bits in result)
                           
CMP BL, AL ; BL - AL = -32
; ZF=0(no zero)
; CF=1(borrow)
; SF=1(negative, for SIGNED result)
; OF=0(no overflow, we can represent SIGNED result with BYTE, -128~127)
; PF=0(odd, odd number of 1 bits in result)

CMP AL, AL ; AL - AL = 0
; ZF=1(zero)
; CF=0(no borrow)
; SF=0(positive, for SIGNED result)
; OF=0(no overflow, we can represent SIGNED result with BYTE, -128~127)
; PF=1(even, even number of 1 bits in result)

CMP AL, CL ; AL - CL = 64-(-128) = 192
; ZF=0(no zero)  
; CF=1(borrowed for UNSIGNED operation 64-128)
; SF=1(negative, because of overflowed SIGNED result is negative)
; OF=1(overflowed, we cant represent SIGNED result 192 with BYTE > 127)
; PF=1

CMP CL, AL ; CL - AL = -128-64 = -192
; ZF=0(no zero)   
; CF=0(UNSIGNED operation dont need to borrow, 128-64=64)
; SF=0(positive, because of overflowed SIGNED result)
; OF=1(overflowed, we cant represent SIGNED result -192 with BYTE < -128)
; PF=0

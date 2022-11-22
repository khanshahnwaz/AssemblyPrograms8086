.model small
.386
.data
msg1 DB 10,13,"Enter the first 8 digit number.$"
msg2 DB 10,13,"Enter the second 8 digit number.$"
msg3 DB 10,13,"BCD addition is: $"
firstNum DD ?
secondNum DD ?
result DD ?
.CODE

MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX

    MOV AH,09
    MOV DX,OFFSET msg1
    INT 21H

    MOV EBX,0
    MOV CX,8
    L1:MOV AH,01
      INT 21H
      CMP AL,'A'
      JGE J1
      SUB AL,30H
      JMP K1
      J1:SUB AL,37H
      K1:SHL EBX,4
         ADD BL,AL
         LOOP L1
        MOV firstNum,EBX
    
    MOV AH,09
    LEA DX,msg2
    INT 21H

    ;INPUT SECOND NUMBER
     MOV EBX,0
    MOV CX,8
    L2:MOV AH,01
      INT 21H
      CMP AL,'A'
      JGE J2
      SUB AL,30H
      JMP K2
      J2:SUB AL,37H
      K2:SHL EBX,4
         ADD BL,AL
         LOOP L2
        MOV secondNum,EBX
    
    MOV EAX,0
    MOV EDX,0
    MOV AX,word ptr firstNum
    MOV DX,word ptr secondNum

    adc al,DL
    daa
    mov bl,al

    mov al,ah
    adc al,dh
    daa
    mov bh,al

    mov word ptr result,bx

     MOV AX,word ptr firstNum+2
    MOV DX,word ptr secondNum+2

    adc al,DL
    daa
    mov bl,al

    mov al,ah
    adc al,dh
    daa
    mov bh,al

    mov word ptr result+2,bx
    MOV EBX,result
    MOV DX,OFFSET msg3
    MOV AH,09
    INT 21H
    JNC L4
    MOV AH,02
    MOV DL,'1'
    INT 21H

    ;PRINT THE RESULT 
    L4:MOV CX,8
    L3:ROL EBX,4
       MOV DL,BL
       AND DL,0FH
       CMP DL,'A'
       JGE J3
       ADD DL,30H
       JMP K3
       J3: ADD DL,37H
       K3:MOV AH,02
         INT 21H
        LOOP L3
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN

    
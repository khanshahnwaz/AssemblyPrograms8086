.model small
.386
.data
msg1 DB 10,13,"Enter first 8 digit number.$"
msg2 DB 10,13,"Enter second 8 digit number.$"
msg3 DB 10,13,"Subraction is: $"
firstNum DD ?
secondNum DD ?
result DD ?

.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV DX,OFFSET msg1
    MOV AH,09
    INT 21H

    ;input first number
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
          ADD BL,al
          LOOP L1
    MOV firstNum,EBX

    MOV AH,09
    LEA DX,msg2
    INT 21H

;input SECOND number
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
          ADD BL,al
          LOOP L2
    MOV secondNum,EBX

    mov ax,WORD PTR firstNum
    mov dx,word ptr secondNum

    sbb al,dl
    das
    mov bl,al

    mov al,ah
    sbb al,dh
    mov bh,al

    mov word ptr result,bx

     mov ax,WORD PTR firstNum+2
    mov dx,word ptr secondNum+2

    sbb al,dl
    das
    mov bl,al

    mov al,ah
    sbb al,dh
    das
    mov bh,al

    mov word ptr result+2,bx
    mov ebx,result
    mov ah,09
    lea dx,msg3
    INT 21H

    JNC L3
    MOV AH,02
    MOV DL,'1'
    INT 21H

    L3:MOV CX,8
    L4:ROL EBX,4
       MOV DL,BL
       AND DL,0FH
       CMP DL,'A'
       JGE J4
       ADD DL,30H
       JMP K4
       J4: ADD DL,37H
       K4:MOV AH,02
         INT 21H
        LOOP L4
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN


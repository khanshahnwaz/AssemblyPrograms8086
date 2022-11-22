.model SMALL
.stack 100h
.data
msg1 DB 10,13,"Enter binary number.$"
msg2 DB 10,13,"Ascii conversion is: $"
.code

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

MOV AH,09
LEA DX,msg1
INT 21H
    MOV BL,0
    MOV CX,8
    L1:MOV AH,01
       INT 21H
       SUB AL,30H
       SHL BL,1
       ADD BL,AL
    LOOP L1

    MOV AH,09
    LEA DX,msg2
    INT 21H
   
  
   MOV DL,BL
   MOV AH,02
    INT 21H
    
MOV AH,4CH
INT 21H

MAIN ENDP

END MAIN
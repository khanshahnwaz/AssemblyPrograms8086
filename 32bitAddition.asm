.MODEL small  
.386
.data
msg1 DB 10,13,"Enter first 8 digit number.$"
msg2 DB 10,13,"Enter second 8 digit number.$"
msg3 DB 10,13,"Addition is:$"
firstNum DD ?
secondNum DD ?
result DD ?
.code

MAIN PROC
;Mov ax,@data is way of loading starting address of data segment in ax. then by using mov ds,ax data segment gets initialized. 
MOV AX,@DATA
MOV DS,AX

;prompt message to enter first number
MOV DX, offset msg1
MOV AH,09
INT 21H

;input first number
MOV CX,8
MOV EBX,0
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
;STORE FIRST 8 DIGIT NUMBER
MOV firstNum,EBX

;prompt message to enter second 8 digit number
MOV DX, offset msg2
MOV AH,09
INT 21H

;input second number 
MOV CX,8
MOV EBX,0
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

      ;store second number
      MOV secondNum,EBX
     

      MOV EBX,0
      MOV EAX,0
      MOV EDX,0

      MOV EAX,firstNum
      MOV EDX,secondNum

      ADD EAX,EDX

      MOV EBX,EAX
      ;display the result  
      MOV AH,09
      LEA DX,msg3
      INT 21H

      ;DISPLAY ADDITION
      MOV CX,8
      L3:ROL EBX,4
         MOV DL,BL
         AND DL,0FH
         CMP DL,'A'
         JGE J4
         ADD DL,30H
         JMP K4
         J4: ADD DL,37H
         K4:MOV AH,02
            INT 21H
        LOOP L3
 MOV AH,4CH
      INT 21H
      MAIN ENDP
END MAIN
  


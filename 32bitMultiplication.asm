.MODEL small
.386
.data
    msg1      DB 10,13,"Enter 8 digit multiplicand.$"
    msg2      DB 10,13,"Enter 8 digit multiplier.$"
    msg3      DB 10,13,"Multiplication result is: $"
    firstNum  DD ?
    secondNUM DD ?
    result1   DD ?
    result2   DD ?
.CODE

MAIN PROC
         MOV  AX,@DATA
         MOV  DS,AX

    ;PROMPT USER TO ENTER MULTIPLICAND
         MOV  DX,OFFSET msg1
         MOV  AH,09
         INT  21H

    ;INPUT MULTIPLICAND
         MOV  CX,8
         MOV  EBX,0
    L1:  MOV  AH,01
         INT  21H
         CMP  AL,'A'
         JGE  J1
         SUB  AL,30H
         JMP  K1
    J1:  SUB  AL,37H
    K1:  SHL  EBX,4
         ADD  BL,AL
         LOOP L1
    ;STORE MULTIPLICAND
         MOV  firstNum,EBX

    ;prompt user to enter multiplier
         MOV  DX,offset msg2
         MOV  AH,09
         INT  21H

    ;INPUT SECOND 8 DIGIT NUMBER
         MOV  EBX,0
         MOV  CX,8
    L2:  MOV  AH,01
         INT  21H
         CMP  AL,'A'
         JGE  J2
         SUB  AL,30H
         JMP  K2
    J2:  SUB  AL,37H
    K2:  SHL  EBX,4
         ADD  BL,AL
         LOOP L2
    ;STORE MULTIPLIER
         MOV  secondNum,EBX

         MOV  EAX,0
         MOV  EBX,0
         MOV  EDX,0

         MOV  EAX,firstNum
         MOV  EBX,secondNum

         MUL  EBX
    ;now first result is stored in EDX AND second in EAX
         MOV  result2,EAX
         MOV  result1,EDX

;show result message
MOV AH,09
MOV DX,offset msg3
INT 21H
    ;print first part

         MOV  EBX,result1
         MOV  CX,8
    L3:  ROL  EBX,4
         MOV  DL,BL
         AND  DL,0FH
         CMP  DL,'A'
         JGE  J3
         ADD  DL,30H
         JMP  K3
    J3:  ADD  DL,37H
    K3:  MOV  AH,02
         INT  21H
         LOOP L3

    ;print second part
    MOV EBX,0
         MOV  EBX,result2
         MOV  CX,8
    L4:  ROL  EBX,4
         MOV  DL,BL
         AND  DL,0FH
         CMP  DL,'A'
         JGE  J4
         ADD  DL,30H
         JMP  K4
    J4:  ADD  DL,37H
    K4:  MOV  AH,02
         INT  21H
         LOOP L4

         MOV  AH,4CH
         INT  21H

MAIN ENDP
END MAIN


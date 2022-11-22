.MODEL SMALL
.DATA
msg1 DB 10,13,"Enter size of the array.$"
arrSize DW ?
msg2 DB 10,13,"Enter elements of the first array.$"
arr1 DW 20 DUP(?)
msg3 DB 10,13,"Enter elements of the second array.$"
arr2 DW 20 DUP(?)
msg4 DB 10,13,"Addition of the array is: $"
.code

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV AH,09
    LEA DX,msg1
    INT 21H

    ;INPUT SIZE OF THE ARRAY.
    MOV AH,01
    INT 21H
    CMP AL,'A'
    JGE J1
    SUB AL,30H
    JMP J2
    J1:SUB AL,37H
    J2:MOV AH,0
       MOV arrSize,AX
    
    MOV DX,OFFSET msg2
    MOV AH,09
    INT 21H
    ;INPUT ELEMENTS OF THE FIRST ARRAY.
    MOV CX,arrSize
    MOV BX,offset arr1
    MOV SI,0
    L1:MOV AH,01
    INT 21H
       CMP AL,'A'
       JGE L2
       SUB AL,30H
       JMP L3
       L2:SUB AL,37H
       L3:MOV [BX+SI],AL
       INC SI
        MOV DL,' '
      MOV AH,02
      INT 21H
    LOOP L1

MOV DX,OFFSET msg3
    MOV AH,09
    INT 21H
    ;INPUT ELEMENTS OF THE SECOND ARRAY
    MOV CX,arrSize
    MOV BX,offset arr2
    MOV SI,0
    L4:MOV AH,01
       INT 21H
      CMP AL,'A'
      JGE L5
      SUB AL,30H
      JMP L6
      L5:SUB AL,37H
      L6:MOV [BX+SI],AL
      INC SI
      MOV DL,' '
      MOV AH,02
      INT 21H
    LOOP L4

    ;PRINT FIRST ARRAY ELEMENTS
    MOV BX,OFFSET arr1
    MOV CX,arrSize
    MOV SI,0
    L7:MOV DL,[BX+SI]
       CMP DL,'A'
       JGE L8
       ADD DL,30H
       JMP L9
       L8: ADD DL,37h
       L9:INC SI
       MOV AH,02
       INT 21H
        MOV DL,' '
      MOV AH,02
      INT 21H
       LOOP L7


        ;PRINT FIRST ARRAY ELEMENTS
    MOV BX,OFFSET arr2
    MOV CX,arrSize
    MOV SI,0
    L10:MOV DL,[BX+SI]
       CMP DL,'A'
       JGE L11
       ADD DL,30H
       JMP L12
       L11: ADD DL,37h
       L12:INC SI
       MOV AH,02
       INT 21H
        MOV DL,' '
      MOV AH,02
      INT 21H
       LOOP L10

     
     ; add array
     LEA SI,arr1
     LEA DI,arr2
     MOV CX,arrSize
     S1:MOV AL,[SI]
      ADD AL,[DI]
      MOV [SI],AL
      INC SI
      INC DI
      LOOP S1
    
    MOV AH,09
    LEA DX,msg4
    INT 21H

    ;PRINT ADDED ARRAY
MOV BX,OFFSET arr1
    MOV CX,arrSize
    MOV SI,0
    A7:MOV DL,[BX+SI]
       CMP DL,'A'
       JGE A8
       ADD DL,30H
       JMP A9
       A8: ADD DL,37h
       A9:INC SI
       MOV AH,02
       INT 21H
        MOV DL,' '
      MOV AH,02
      INT 21H
       LOOP A7
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
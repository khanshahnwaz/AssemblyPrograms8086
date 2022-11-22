.MODEL SMALL
.DATA
     msg1    DB 10,13,"Enter size of the array.$"
     arrSize DW ?
     msg2    DB 10,13,"Enter elements of the array.$"
     arr     DW 20 DUP(?)
     msg3    DB 10,13,"Sorted array is: $"
     i       DW ?
.code
MAIN PROC
          mov  ax,@DATA
          MOV  DS,ax

          MOV  AH,09
          LEA  DX,msg1
          INT  21H

     ;INPUT SIZE OF THE ARR
          MOV  AH,01
          INT  21H
          SUB  AL,30H
          MOV  AH,0
          mov  arrSize,ax

     ;PRINT SECOND MESSAGE
          MOV  AH,09
          LEA  DX,msg2
          INT  21H

          MOV  CX,arrSize
          MOV  BX,offset arr
          MOV  SI,0
     L1:  MOV  AH,02
          MOV  DL,' '
          INT  21H
          MOV  AH,01
          INT  21H
          CMP  AL,'A'
          JGE  J1
          SUB  AL,30H
          JMP  K1
     J1:  SUB  AL,37H
     K1:  MOV  [BX+SI],AL
          INC  SI
          loop L1

     ;NOW IT;s time to sort the array
          mov  bx,offset arr
          MOV  DI,arrSize
     L2:  MOV  CX,arrSize
          mov  i,CX
          DEC  i
          mov  cx,i
          MOV  SI,0
     l3:  mov  al,[bx+si]
          cmp  al,[bx+si+1]
          jl   l4
          xchg al,[bx+si+1]
          mov  [bx+si],AL
     l4:  inc  si
          LOOP l3
          dec  DI
          jnz  L2
    
     ;now print the sorted array
          mov  AH,09
          LEA  DX,msg3
          INT  21H
          mov  bx,offset arr
          mov  si,0
          mov  cx,arrSize
     l5:  mov  dl,[bx+si]
     ;   and dl, 0FH
          cmp  dl,'A'
          jge  j5
          add  dl,30H
          jmp  k5
     j5:  add  dl,37h
     k5:  mov  ah,02
          int  21H
          inc  si
          loop l5




          MOV  AH,4CH
          INT  21H

MAIN ENDP
END MAIN
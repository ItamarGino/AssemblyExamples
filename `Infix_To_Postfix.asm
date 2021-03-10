; Targil_2 :

    .MODEL SMALL
    .STACK 100h
    .DATA
postfix DB 'postfix : ','$'	
infix   DB 1 DUP('4','+','6','/','5','+','2','/','3')
flag    DB 0
     .CODE
Start:
     MOV AX,@DATA                ; Set DS to point ...
     MOV DS,AX                   ; ... to data segment
	 MOV DX,OFFSET postfix
	 MOV AH,9
	 INT 21h
	 MOV DI,0
	 
infix_to_postfix:
     CMP infix[DI],'0'                ;step 1 : check if [DI] is a number
     JB Operator
     CMP infix[DI],'9'
     JA Operator
	 
     ; just a number             ; if number : 1.1
     MOV AH,2
	 MOV DX,0
	 MOV DL,infix[DI]
	 INT 21h
	 INC DI                      ; break condition - end of string
	 CMP DI,9
	 JE End_Asm
	 JMP infix_to_postfix        ; again
	 
	 Operator:                   ; if operator : 1.2
	 
	 CMP infix[DI],'+'                ; CMP the operator
	 JE PUSH_OP
	 CMP infix[DI],'-'
	 JE PUSH_OP
	 
	 class:
	 
     MOV AH,2
	 MOV DX,0
	 MOV DL,infix[DI+1]
	 INT 21h	
	 
     MOV AH,2
	 MOV DX,0
	 MOV DL,infix[DI]
	 INT 21h	
	 	 
	 MOV AX,0
	 POP AX
	 MOV BP,OFFSET SP
	 INC BP
	 INC BP
	 
     MOV AH,2
	 MOV DX,AX
	 INT 21h	 
	 
	 INC DI
	 INC DI
	 CMP DI,9
	 JE End_Asm
	 JMP infix_to_postfix
	 
  	 PUSH_OP:
	 MOV AX,0
	 MOV AL,infix[DI]
	 PUSH AX
	 MOV BP,OFFSET SP
	 DEC BP
	 DEC BP
	 INC DI
	 CMP DI,9
	 JE End_Asm
	 JMP infix_to_postfix
	 
End_Asm :
     MOV AH,4Ch                     ; Set terminate option for int 21h
     INT 21h                        ; Return to DOS (terminate program)
     END Start
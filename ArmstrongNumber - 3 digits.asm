;* Armstrong Number - 3 digits *;
 
    .MODEL SMALL
    .STACK 100h
    .DATA
QuestionMessage      DB 'Please enter 3 digits number: ',13,10,'$'
AnswerMessage        DB 13,10,'Armstrong number !',13,10,'$'
NotAnswerMessage     DB 13,10,'Is not an Armstrong number.',13,10,'$'
InputErrorMessage    DB 13,10,'Input Error',13,10,'$'
sum                  DW 0
number               DW 0
TEN                  DB 10
TEMP                 DB ?
     .CODE
ProgStart:
     MOV AX,@DATA             ; DS can be written to only through a register
     MOV DS,AX                ; Set DS to point to data segment
	 
     MOV AH,9              
     MOV DX,OFFSET QuestionMessage 
     INT 21h   
	 
	 MOV CX,3
	 MOV DX,0
input_loop:
; the 3 digits input + checking :
	 MOV AH,1
	 INT 21h
	 CMP AL,'0'               
     JB  ErrorMessage           
     CMP AL,'9'                
     JA  ErrorMessage
     CMP AL,'0'
	 JE CHECK_DX
	 INC DX
; create number ((digit1*100)+(digit2*10)+(digit3)) : 
	 MOV AH,0
	 SUB AL,'0'
	 MOV BX,CX
	 DEC BX
	 MOV TEMP,AL
	 CMP BX,0
	 JE NEXT
	 SUB_LOOP:
	 MUL TEN
	 CMP BX,1
	 JBE NEXT
	 DEC BX	 
	 JMP SUB_LOOP
	 NEXT:
	 ADD number,AX
; create sum (digit1^3 + digit2^3 + digit3^3) :
	 MOV AX,0
	 MOV AL,TEMP
	 MUL TEMP
	 MUL TEMP
	 ADD sum,AX
	 JMP NEXT_LOOP
	 CHECK_DX:
	 CMP DX,0
	 JE ErrorMessage
	 NEXT_LOOP:
	 LOOP input_loop
     
	 MOV AX,number
	 CMP AX,sum
	 JNE BAD
GOOD:
	 MOV AH,9              
     MOV DX,OFFSET AnswerMessage 
     INT 21h 
	 JMP DisplayGreeting
BAD:	 
	 MOV AH,9              
     MOV DX,OFFSET NotAnswerMessage 
     INT 21h
	 JMP DisplayGreeting
ErrorMessage :
	 MOV AH,9      
	 MOV DX,OFFSET InputErrorMessage   ; Point display message to error
	 INT 21h
DisplayGreeting:
     MOV AH,4Ch               ; Set terminate option for int 21h
     INT 21h                  ; Return to DOS (terminate program)
    END ProgStart
  

    .MODEL SMALL
    .STACK 100h
    .DATA
QuestionMessage      DB 'Please enter 3 digits number: ',13,10,'$'
AnswerMessage        DB 13,10,'Your number is: ',13,10,'$'
InputErrorMessage    DB 13,10,'Input Error',13,10,'$'
input                DB 4 DUP(?)
     .CODE
ProgStart:
     MOV AX,@DATA             ; DS can be written to only through a register
     MOV DS,AX                ; Set DS to point to data segment
	 
     MOV AH,9              
     MOV DX,OFFSET QuestionMessage 
     INT 21h        
	 
	 MOV CX,3
	 MOV SI,0
	 MOV DX,0
INPUT_LOOP:	 
     MOV AH,1
     INT 21h
     CMP AL,'0'               
     JB  ErrorMessage           
     CMP AL,'9'                
     JA  ErrorMessage
     CMP AL,'0'               
     JE TRY
	 JMP INPUT_DIGIT
	 TRY:
	 CMP DX,0
	 JE DontPut
	 INPUT_DIGIT:
	 MOV DX,1
	 MOV input[SI],AL
	 INC SI
	 DontPut:
	 LOOP INPUT_LOOP
	 
	 CMP DX,0
	 JE INPUT_ZERO
	 MOV input[4],'$'
	 JMP DONE
	 INPUT_ZERO:
	 MOV input[0],'0'
	 MOV input[1],'$'
DONE:
	 MOV AH,9              
     MOV DX,OFFSET AnswerMessage 
     INT 21h
	 MOV AH,9              
     MOV DX,OFFSET Input
     INT 21h	 
	 JMP DisplayGreeting
	 
ErrorMessage :
	 MOV  DX,OFFSET InputErrorMessage   ; Point display message to error
	 
DisplayGreeting:
     MOV AH,4Ch               ; Set terminate option for int 21h
     INT 21h                  ; Return to DOS (terminate program)
    END ProgStart
  

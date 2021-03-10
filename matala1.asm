; Targil_Bait :

    .MODEL SMALL
    .STACK 100h
    .DATA
question_output          DB 'Please enter 4 digit number (hexadecimal):',13,10,'$'
answer_output            DB 'sqrt ( xxxx ) = xx ',13,10,'$'
new_line                 DB 13,10,'$'
digit1                   DB ?
digit2                   DB ?
digit3                   DB ?
digit4                   DB ?
Sixteen                  DW 16
new_digit1               DB ?
new_digit2               DB ?
NUMBER                   DW 0
     .CODE
	 .386
ProgStart:
     MOV AX,@DATA                   ; DS can be written to only through a register
     MOV DS,AX                      ; Set DS to point to data segment
	 
     MOV AH,9                       ; Set print option for int 21h
     MOV DX,OFFSET question_output  ; Set  DS:DX to point to question_output
     INT 21h                        ; Print question_output
	 
	 MOV AH, 1h                     ; input digit 1
     INT 21h                        ;
     MOV digit1, AL                 ;
	 
	 MOV AH, 1h                     ; input digit 2
     INT 21h                        ;
     MOV digit2, AL                 ;
	 
	 MOV AH, 1h                     ; input digit 3
     INT 21h                        ;
     MOV digit3, AL                 ;

	 MOV AH, 1h                     ; input digit 4
     INT 21h                        ;
     MOV digit4, AL                 ;
	 
digit1_C:
	 
	 CMP digit1,'9'
	 JBE zeroTOnine1
	 SUB digit1,'A'
	 ADD digit1,10
	 JMP digit2_C
	     zeroTOnine1:
		 SUB digit1,'0'
	
digit2_C:     	
	 
	 CMP digit2,'9'
	 JBE zeroTOnine2
	 SUB digit2,'A'	
	 ADD digit2,10	 
	 JMP digit3_C
	     zeroTOnine2:
		 SUB digit2,'0'
	
digit3_C:
	 
	 CMP digit3,'9'
	 JBE zeroTOnine3
	 SUB digit3,'A'	
	 ADD digit3,10	 
	 JMP digit4_C
	     zeroTOnine3:
		 SUB digit3,'0'

digit4_C:
	 
	 CMP digit4,'9'
	 JBE zeroTOnine4
	 SUB digit4,'A'
	 ADD digit4,10	 
	 JMP Number_C
	     zeroTOnine4:
		 SUB digit4,'0'
	
Number_C:
	
	MOV EBX,0
	MOV EAX,0
	MOV AL,digit1
	MUL Sixteen
	MUL Sixteen
	MUL Sixteen
	MOV EBX,EAX
	
	MOV EAX,0
	MOV AL,digit1
	MUL Sixteen
	MUL Sixteen
	ADD EBX,EAX

	MOV EAX,0
	MOV AL,digit1
	MUL Sixteen
	ADD EBX,EAX

    CMP digit4,0
	JNE add_one_hex
	JMP Sqrt_C
	   add_one_hex:
	   MOV EAX,0
	   MOV AL,digit4
	   ADD EBX,EAX

	   ;;;;;;;;;;;;;

Sqrt_C:

	MOV ECX,EBX ; bx=num cx=sqrt
	MOV NUMBER,BX
	MOV EBX,2
	
	MOV AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0	
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0	
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV ECX,EAX
	MOV DX,0
	
	MOV EAX,0
	ADD AX,NUMBER
	DIV ECX
	MOV DX,0
	ADD EAX,ECX
	DIV BX
	MOV DX,0

	
;Div_number_to_Hex:
	
	DIV Sixteen
	MOV BX,DX
	MOV new_digit1,BL
	CMP new_digit1,9
	JBE zeroTOnine_new1
    SUB new_digit1,10	
	ADD new_digit1,'A'
	JMP new_digit2_C
	zeroTOnine_new1:
		 ADD new_digit1,'0'

new_digit2_C:
	MOV BX,AX
	MOV new_digit2,BL
	CMP new_digit2,9
	JBE zeroTOnine_new2
    SUB new_digit2,10	
	ADD new_digit2,'A'
	JMP End_Asm
	zeroTOnine_new2:
		 ADD new_digit2,'0'
	
End_Asm :
     MOV AL,digit1
	 CMP AL,9
	 JA LETTER1
	 ADD AL,'0'
     MOV answer_output[7],AL
	 JMP case2
	 LETTER1:
	 SUB AL,10
	 ADD AL,'A'
     MOV answer_output[7],AL
case2:	 
     MOV AL,digit2
	 CMP AL,9
	 JA LETTER2
	 ADD AL,'0'
     MOV answer_output[8],AL
	 JMP case3
	 LETTER2:
	 SUB AL,10	 
	 ADD AL,'A'
     MOV answer_output[8],AL
case3:	
     MOV AL,digit3
	 CMP AL,9
	 JA LETTER3
	 ADD AL,'0'
     MOV answer_output[9],AL
	 JMP case4
	 LETTER3:
	 SUB AL,10	 
	 ADD AL,'A'
     MOV answer_output[9],AL
case4:	
     MOV AL,digit4
	 CMP AL,9
	 JA LETTER4
	 ADD AL,'0'
     MOV answer_output[10],AL
	 JMP case2_new
	 LETTER4:
	 SUB AL,10	 
	 ADD AL,'A'
     MOV answer_output[10],AL
case2_new:	
	 
     MOV AL,new_digit2
     MOV answer_output[16],AL
	 
     MOV AL,new_digit1
     MOV answer_output[17],AL

     MOV AH,9                       ; Set print option for int 21h
     MOV DX,OFFSET new_line       ; Set  DS:DX to point to question_output
     INT 21h                        ; Print question_output
	 
     MOV AH,9                       ; Set print option for int 21h
     MOV DX,OFFSET answer_output  ; Set  DS:DX to point to question_output
     INT 21h                        ; Print question_output
	 
     MOV AH,4Ch                     ; Set terminate option for int 21h
     INT 21h                        ; Return to DOS (terminate program)
     END ProgStart
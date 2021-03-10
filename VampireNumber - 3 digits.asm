; Targil_2 :

    .MODEL SMALL
    .STACK 100h
    .DATA
question_output          DB 'Please enter 3 digit number (from 100 up to 999):',13,10,'$'
error_output             DB 13,10,'Wrong input',13,10,'$'
Pseudo_vampire           DB 13,10,'Pseudo vampire number',13,10,'$'
Not_Pseudo_vampire       DB 13,10,'Is not a Pseudo vammpire number',13,10,'$'
digit1                   DB ?
digit2                   DB ?
digit3                   DB ?
arr                      DB 3 DUP(0)
TEN                      DB 10
NUMBER                   DW 0
INDEX                    DW 2
FLAG                     DB 0
FLAG2                    DB 0
TEMP                     DW ?

     .CODE
	 .386
ProgStart:
     MOV AX,@DATA                   ; DS can be written to only through a register
     MOV DS,AX                      ; Set DS to point to data segment
	 
     MOV AH,9                       ; Set print option for int 21h
     MOV DX,OFFSET question_output  ; Set  DS:DX to point to question_output
     INT 21h                        ; Print question_output
	 
; get input :
	 MOV AH, 1h                     ; input digit 1
     INT 21h                        ;
     MOV digit1, AL                 ; 
	 MOV AH, 1h                     ; input digit 2
     INT 21h                        ;
     MOV digit2, AL                 ;
	 MOV AH, 1h                     ; input digit 3
     INT 21h                        ;
     MOV digit3, AL                 ;
	 
; Input_Correct?
     CMP digit1,'1'                 ;
	 JB error_Mes                   ;
     CMP digit1,'9'                ;
	 JA error_Mes                   ;
     CMP digit2,'0'                 ;
	 JB error_Mes                   ;
     CMP digit2,'9'                ;
	 JA error_Mes                   ;
	 CMP digit3,'0'                 ;
	 JB error_Mes                   ;
     CMP digit3,'9'                ;
	 JA error_Mes                   ;	 
	 SUB digit1,'0'	
	 SUB digit2,'0'	
	 SUB digit3,'0'	
;Build the array (for help)	 
	 MOV AX,0
	 MOV AL,digit1
	 MOV arr[0],AL
	 MOV AL,digit2
	 MOV arr[1],AL
	 MOV AL,digit3
	 MOV arr[2],AL	 
;Build_the_number
     MOV AX,0
	 MOV AL,digit1
	 MUL TEN
	 MUL TEN
	 MOV NUMBER,AX
	 MOV AX,0
	 MOV AL,digit2
	 MUL TEN
	 ADD NUMBER,AX
	 MOV AX,0
	 MOV AL,digit3
	 ADD NUMBER,AX 
;does it a Pseudo vampire number ?
     MOV BX,0
	 MOV BX,OFFSET arr  ; pointing to arr[]
	 MOV SI,0
	 MOV DI,1
;LOOP - try all the combinations for vampire number
Loop_vampire:
     MOV AX,0;
     MOV AL,[BX+SI]
	 MUL TEN
	 ADD AL,[BX+DI]
	 XCHG DI,INDEX
	 MOV CX,0
	 MOV CL,[BX+DI]
	 MUL CX
	 CMP AX,NUMBER
	 JE Pseudo_vampire_number
	 INC FLAG
	 CMP FLAG,2
	 JB Loop_vampire
	 INC FLAG2
	 XCHG DI,SI
	 MOV FLAG,0
	 CMP FLAG2,2
	 JBE Loop_vampire
	 
;NOT_a_Pseudo_vampire_number:
     MOV AH,9                       ; Set print option for int 21h
     MOV DX,OFFSET Not_Pseudo_vampire ; Set  DS:DX to point to question_output
     INT 21h 
     JMP End_Asm	 
error_Mes:
     MOV AH,9                       ; Set print option for int 21h
     MOV DX,OFFSET error_output     ; Set  DS:DX to point to question_output
     INT 21h                        ; Print question_output
	 JMP End_Asm
Pseudo_vampire_number:
     MOV AH,9                       ; Set print option for int 21h
     MOV DX,OFFSET Pseudo_vampire   ; Set  DS:DX to point to question_output
     INT 21h   
End_Asm :
     MOV AH,4Ch                     ; Set terminate option for int 21h
     INT 21h                        ; Return to DOS (terminate program)
     END ProgStart
; Oiler function

    .MODEL SMALL
    .STACK 100h
    .DATA
	first_sentens     DB 'Please enter number (from 1 up to 4294967295):',13,10,'$'
	perfect           DB 'A perfect totient number',13,10,'$'	
	Not_perfect       DB 'Not a perfect totient number',13,10,'$'		
    TEN               DD 10
	NUMBER            DD 0
	counter           DD 1
	flag              DB 0
	d                 DD 0
	SUM               DD 0
	INDEX             DD 2
	temp              DD ?
	.CODE
	.386
START:

     MOV AX,@DATA                ; Set DS to point ...
     MOV DS,AX                   ; ... to data segment
	 MOV DX,OFFSET first_sentens
	 MOV AH,9
	 INT 21h
	 CALL getN
	 CALL FPTN
	 CMP flag,0
     JE Not_perfect_number
     
	 MOV DX,OFFSET perfect
	 MOV AH,9
	 INT 21h     	 
     JMP End_Asm
	 
Not_perfect_number:

     MOV DX,OFFSET Not_perfect
	 MOV AH,9
	 INT 21h	 
     JMP End_Asm
 
;------- getN ---------------------------------------------
	 getN  PROC  NEAR
     	 MOV DX,0
	 get_the_number:
	 
	 MOV AH,1
	 INT 21h
	 CMP AL,13
	 JE get_out1
	 
	 MOV BL,AL
	 SUB BL,'0'
	 MOV EAX,NUMBER
	 MUL TEN
	 MOV NUMBER,EAX 
	 MOV AX,0
	 MOV DX,0
	 MOV AL,BL
	 ADD NUMBER,EAX
	 JMP get_the_number
	 
	 get_out1: 
	 MOV AX,0
	 MOV DX,0
	 MOV BL,0
     RET
     getN  ENDP 
;------- return number ----------------------------------------

;------- FCoprime ---------------------------------------------
;------- get => number and d ----------------------------------
; get 2 number: return 1 if stranger ; else - 0.
	 FCoprime  PROC  NEAR
	 MOV INDEX,2
	 MOV EDX,0
	 MOV EAX,0
	 LOOP_till_d:
	 
	 MOV EAX,NUMBER
	 DIV INDEX
	 CMP EDX,0
	 JE  case1
	 JMP inc_index
	 
	 case1:
	 MOV EAX,d
	 DIV INDEX
	 CMP EDX,0
	 JE not_starnger
	 
	 inc_index:
	 MOV EDX,0
	 INC INDEX
	 MOV EAX,INDEX
	 CMP EAX,d
	 JA stranger
	 JMP LOOP_till_d
	 
	 not_starnger:
	 MOV AX,0
	 JMP get_out2
	 
	 stranger:
	 MOV AX,1
	 
	 get_out2:
     RET
     FCoprime ENDP
;------- return ax => 1 or 0 ---------------------------------	 

;------- FEuler  ---------------------------------------------
;------- get => number ---------------------------------------
	 FEuler   PROC  NEAR
     MOV ECX,2
	 MOV d,ECX
	 MOV counter,1
	 Euler_loop:
	 CALL FCoprime
	 INC d
	 INC ECX	 
	 CMP AX,1
	 JNE not_starnger2
	 INC counter
	 CMP ECX,NUMBER
	 JE get_out3
	 JMP Euler_loop
	 
	 not_starnger2:
	 
	 CMP ECX,NUMBER
	 JB Euler_loop	 
	 
	 get_out3:
	 MOV CX,0
     RET
     FEuler  ENDP
;------- return => counter (how much stranger numbers) ----
	 
;------- FPTN ---------------------------------------------
;------- get => number ------------------------------------
	 FPTN  PROC  NEAR
	 CMP number,1
	 JE return_1
     MOV EBX,number
	 MOV temp,EBX
	 sum_loop:
	 CALL FEuler
	 MOV EAX,counter
	 ADD SUM,EAX
	 MOV NUMBER,EAX
	 CMP counter,1
	 JE get_out4
	 JMP sum_loop
	 
	 get_out4:
	 MOV EBX,temp
	 CMP sum,EBX
	 JE return_1
	 MOV flag,0
	 JMP exit_FPTN
	 
	 return_1:
	 MOV flag,1
	 
	 exit_FPTN:
     RET
     FPTN  ENDP	 
;-------- return => flag = 0 or 1 --------------------------	 
	 
End_Asm:

     MOV AH,4Ch                  ; DOS terminate program function #
     INT 21h                     ; Terminate the program
     END START	 
     
	 
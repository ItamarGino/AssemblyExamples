.MODEL SMALL
.DATA
	f DD ?
	g DD ?
	str DW ?
	e DW ?
	e1 DW ?
	pos1 DW 0
	i DW ?
	digit DW ?
	len DW ?
	Ten DD 10.0
	One DD 1.0
.CODE
	.386
	.387
;void ftoa(float f, char str[])
;          [BP+4]     [BP+8]
PUBLIC _ftoa
_ftoa PROC NEAR
  PUSH BP
  MOV BP,SP
  PUSH SI
  PUSH DI
;
  MOV EAX,[BP+4]
  MOV f,EAX
  MOV AX,[BP+8]
  MOV str,AX
  MOV DI,str
  MOV e,0
;
  FLD f
  FTST ; TEST FOR ZERO
  FSTSW AX
  SAHF 
  JNB Skip1 
; NEGATIVE  
  MOV BYTE PTR [DI],'-'
  INC DI
  FABS
  FST f
; POSITIVE  
Skip1:
If1:
  FCOM Ten
  FSTSW AX
  SAHF
  JNA Skip2
; BIGGER THAN 10 (MORE DIV) :  
While1:
   FCOM Ten
   FSTSW AX
   SAHF
   JNA EndWhile1
   INC e
   FDIV Ten   
  JMP While1
EndWhile1:   
   JMP Skip3
; SMALLER THAN 1 :   
Skip2: 
While2:
   FCOM One
   FSTSW AX
   SAHF
   JNB EndWhile2
   DEC e
   FMUL Ten   
  JMP While2
EndWhile2:   
; THE REST :
Skip3:
  MOV BYTE PTR[DI+1],'.'
  MOV pos1,DI
  INC pos1

  MOV CX,5
For1:
  FLD One
  FSTP g
  MOV digit,0
While3:
  FCOM g
  FSTSW AX
  SAHF
  JNA EndWhile3
   INC digit
   FLD One
   FADD g
   FSTP g
  JMP While3
EndWhile3:  
   CMP DI,pos1
   JNE Skip4
    INC DI
Skip4:
   ADD digit,'0'
   MOV AX,digit
   MOV BYTE PTR [DI],AL
   INC DI
   FADD One
   FSUB g
   FMUL Ten
   LOOP For1
EndFor1:
   MOV BYTE PTR [DI],'e'
   INC DI
   MOV BYTE PTR [DI],'+'
   INC DI
   CMP e,0
   JNL Skip5
     MOV AX,e
     SUB e,AX
     SUB e,AX
     MOV BYTE PTR [DI-1],'-'
Skip5:
     MOV BYTE PTR [DI+2],0
     MOV AX,e
     MOV DX,0
     MOV CX,10
     DIV CX
     ADD DL,'0'
     MOV BYTE PTR [DI+1],DL
     MOV DX,0
     DIV CX
     ADD DL,'0'
     MOV BYTE PTR [DI],DL
;
 POP DI
 POP SI
 POP BP
 RET
_ftoa  ENDP
END
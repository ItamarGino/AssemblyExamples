;
; acfc.asm
;
.MODEL SMALL
.DATA
code DD ?
n DD ?
k DD ?
m DD ?
index DW ?
.CODE
.386
;
; unsigned long int compute_fibo_code(unsigned int n)
;                                      [BP+4]
;
PUBLIC _compute_fibo_code
EXTRN _find_largest_fibo:NEAR
_compute_fibo_code  PROC NEAR
   PUSH BP
   MOV BP,SP
   PUSH SI
   PUSH DI
   MOV code,0
   MOV EAX,[BP+4]
   MOV n,EAX
;
While1:
   CMP n,0
   JNA EndWhile1
   PUSH OFFSET index
   PUSH n
   CALL _find_largest_fibo
   ADD SP,6
   PUSH DX
   PUSH AX
   POP EAX
   MOV m,1
   MOV CX,index
   SHL m,CL
   MOV EBX,m
   ADD code,EBX
   SUB n,EAX
   JMP While1
EndWhile1: 
;
 PUSH code
 POP AX
 POP DX

 POP DI
 POP SI
 POP BP
 RET
_compute_fibo_code ENDP
END

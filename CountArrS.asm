;
; amods.asm
;
.MODEL SMALL
.DATA
arr DW ?
n DW ?
denom DD ?
count_arr DW ?
i DW ?
rem DW ?
.CODE
.386
;extern void mod_count(
;long int arr[], int n,
;  [BP+4]        [BP+6]
;long int denom,  int count_arr[]);
; [BP+8]           [BP+12]
PUBLIC _mod_count
_mod_count  PROC NEAR
  PUSH BP
  MOV BP,SP
  PUSH SI
  PUSH DI
;
  MOV AX,[BP+4]
  MOV arr,AX
  MOV AX,[BP+6]
  MOV n,AX
  MOV EAX,[BP+8]
  MOV denom,EAX
  MOV AX,[BP+12]
  MOV count_arr,AX
;
  MOV i,0
  MOV SI,count_arr
For1:
  MOV EAX,0
  MOV AX,i
  CMP EAX,denom
  JNB EndFor1
  MOV WORD PTR [SI],0
  ADD SI,2
  INC i
  JMP For1
EndFor1:
;  
  MOV i,0
  MOV SI,arr
For2:
  MOV AX,i
  CMP AX,n
  JNL EndFor2
  MOV EAX,[SI]
  MOV EDX,0
  DIV denom
  SHL DX,1
  MOV DI,count_arr
  ADD DI,DX
  INC WORD PTR [DI]
  ADD SI,4
  INC i
  JMP For2
EndFor2:
;
;
 POP DI
 POP SI
 POP BP
 RET
_mod_count  ENDP
END



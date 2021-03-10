.MODEL LARGE
.DATA
arr DD ?
n DW ?
denom DD ?
count_arr DD ?
i DW ?
rem DW ?
.CODE
.386
;extern void mod_count(
;long int arr[], int n,
;  [BP+6]        [BP+10]
;long int denom,  int count_arr[]);
; [BP+12]           [BP+16]
PUBLIC _mod_count
_mod_count  PROC FAR
  PUSH BP
  MOV BP,SP
  PUSH SI
  PUSH DI
  PUSH ES
  PUSH FS
  PUSH GS
;
  MOV EAX,[BP+6]
  MOV arr,EAX
  MOV AX,[BP+10]
  MOV n,AX
  MOV EAX,[BP+12]
  MOV denom,EAX
  MOV EAX,[BP+16]
  MOV count_arr,EAX
;
  MOV i,0
  MOV SI,WORD PTR count_arr
  MOV ES,WORD PTR count_arr[2]
For1:
  MOV EAX,0
  MOV AX,i
  CMP EAX,denom
  JNB EndFor1
  MOV WORD PTR ES:[SI],0
  ADD SI,2
  INC i
  JMP For1
EndFor1:
;  
  MOV i,0
  MOV SI,WORD PTR arr
  MOV ES,WORD PTR arr[2]
  MOV FS,WORD PTR count_arr[2]
For2:
  MOV AX,i
  CMP AX,n
  JNB EndFor2
  MOV EAX,ES:[SI]
  MOV EDX,0
  DIV denom
  SHL DX,1
  MOV DI,WORD PTR count_arr
  ADD DI,DX
  INC WORD PTR FS:[DI]
  ADD SI,4
  INC i
  JMP For2
EndFor2:
;
;
 POP GS
 POP FS
 POP ES
 POP DI
 POP SI
 POP BP
 RET
_mod_count  ENDP
END



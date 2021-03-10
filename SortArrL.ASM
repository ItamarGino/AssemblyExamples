.MODEL LARGE
.DATA
arr DD ?
n DW ?
denom DD ?
count_arr DD ?
pos_arr DD ?
mod_sorted DD ?
i DW ?
rem DW ?
.CODE
.386
;extern void mod_count(long int arr[], int n,
;                       [BP+6]        [BP+10]
;long int denom,  int count_arr[], int pos_arr[],
; [BP+12]           [BP+16]            [BP+20] 
;long int mod_sorted[]);
;  [BP+24]
;
PUBLIC _mod_sort
_mod_sort  PROC FAR
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
  MOV EAX,[BP+20]
  MOV pos_arr,EAX
  MOV EAX,[BP+24]
  MOV mod_sorted,EAX
;
;
  MOV BX,WORD PTR pos_arr
  MOV ES,WORD PTR pos_arr[2] 
  MOV WORD PTR ES:[BX],0
  MOV FS, WORD PTR count_arr[2]
  MOV GS, WORD PTR mod_sorted[2]
  MOV i,1
;  
For3:
  MOV EAX,0
  MOV AX,i
  CMP EAX,denom
  JNB EndFor3
  MOV DI,i
  SHL DI,1
  MOV SI,DI
  ADD DI,WORD PTR pos_arr  
  ADD SI,WORD PTR count_arr
   
  MOV AX,ES:[DI-2]
  ADD AX,FS:[SI-2]
  MOV ES:[DI],AX
  INC i
  JMP For3
EndFor3:
;  
 MOV i,0
 MOV ES,WORD PTR arr[2]
 MOV FS,WORD PTR pos_arr[2]
 MOV GS,WORD PTR mod_sorted[2]
For4:
  MOV AX,i
  CMP AX,n
  JNL EndFor4
  MOV SI,AX
  SHL SI,2
  ADD SI,WORD PTR arr
  MOV EAX,ES:[SI]
  MOV EBX,EAX
  MOV EDX,0
  DIV denom
  MOV SI,DX
  SHL SI,1
  ADD SI,WORD PTR pos_arr
  MOV DI,FS:[SI]
  INC WORD PTR FS:[SI]
  SHL DI,2
  ADD DI,WORD PTR mod_sorted
  MOV GS:[DI],EBX   
  INC i
  JMP For4 
EndFor4:

;
 POP GS
 POP FS
 POP ES
 POP DI
 POP SI
 POP BP
 RET
_mod_sort  ENDP
END



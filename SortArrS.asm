;
; amods.asm
;
.MODEL SMALL
.DATA
arr DW ?
n DW ?
denom DD ?
count_arr DW ?
pos_arr DW ?
mod_sorted DW ?
i DW ?
rem DW ?
.CODE
.386
;extern void mod_count(long int arr[], int n,
;                       [BP+4]        [BP+6]
;long int denom,  int count_arr[], int pos_arr[],
; [BP+8]           [BP+12]            [BP+14] 
;long int mod_sorted[]);
;  [BP+16]
;
PUBLIC _mod_sort
_mod_sort  PROC NEAR
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
  MOV AX,[BP+14]
  MOV pos_arr,AX
  MOV AX,[BP+16]
  MOV mod_sorted,AX
;
;
  MOV BX,pos_arr
  MOV WORD PTR [BX],0
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
  ADD DI,pos_arr  
  ADD SI,count_arr  
  MOV AX,[DI-2]
  ADD AX,[SI-2]
  MOV [DI],AX
  INC i
  JMP For3
EndFor3:
;  
 MOV i,0
For4:
  MOV AX,i
  CMP AX,n
  JNL EndFor4
  MOV SI,AX
  SHL SI,2
  ADD SI,arr
  MOV EAX,[SI]
  MOV EBX,EAX
  MOV EDX,0
  DIV denom
  MOV SI,DX
  SHL SI,1
  ADD SI,pos_arr
  MOV DI,[SI]
  INC WORD PTR [SI]
  SHL DI,2
  ADD DI,mod_sorted
  MOV [DI],EBX   
  INC i
  JMP For4 
EndFor4:

;
 POP DI
 POP SI
 POP BP
 RET
_mod_sort  ENDP
END



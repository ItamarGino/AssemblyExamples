    .MODEL LARGE
    .CODE
; int merge(long arr1[] , int size1,  long arr2[] , int size2, long mergeArr[]);
;               +6            +10          +12          +16         +18
    .386
	 size1 DW 0
	 size2 DW 0
	 size3 DW 0
	 arr1_size DW ?
	 arr2_size DW ?
PUBLIC _merge
_merge  PROC FAR
	 PUSH BP        ; Preserve BP
	 MOV BP,SP      ; Set BP to point to Parameter area
	 PUSH SI
	 PUSH DI
	 PUSH ES
	 
	 MOV SI,WORD PTR[BP+6]
	 MOV ES,WORD PTR[BP+8]
	 MOV SI,WORD PTR[ES:SI]
	 
	 MOV DI,WORD PTR[BP+12]
	 MOV ES,WORD PTR[BP+14]
	 MOV DI,WORD PTR[ES:DI]
	 
	 MOV BX,WORD PTR[BP+18]
	 
	 MOV AX,[BP+10]
	 MOV arr1_size,AX
	 MOV AX,[BP+16]
	 MOV arr2_size,AX

Comparetion:
	 MOV AX,0
	 MOV DX,0
	 MOV ES,WORD PTR[BP+8]
	 MOV EAX,DWORD PTR[ES:SI]
	 
	 MOV ES,WORD PTR[BP+14]
     CMP EAX,DWORD PTR[ES:DI]
	 
	 JB ARR1_TO_ARR3
	 JE EQUAL
	 MOV EAX,DWORD PTR[ES:DI]
	 MOV ES,WORD PTR[BP+20]
	 MOV DWORD PTR[ES:BX],EAX
	 ADD DI,4
	 INC size2
	 JMP NEXT
	 ARR1_TO_ARR3:
	 MOV ES,WORD PTR[BP+20]
	 MOV DWORD PTR[ES:BX],EAX
	 ADD SI,4
	 INC size1
	 JMP NEXT
	 EQUAL:
	 MOV EAX,DWORD PTR[ES:DI]
	 MOV ES,WORD PTR[BP+20]
	 MOV DWORD PTR[ES:BX],EAX
	 ADD DI,4
	 ADD SI,4
	 INC size1
	 INC size2
	 NEXT:
	 ADD BX,4
	 INC size3
	 
	 MOV AX,size1
	 CMP AX,arr1_size
	 JE FINISH_ARR2
	 MOV AX,size2
	 CMP AX,arr2_size
	 JE FINISH_ARR1
	 JMP Comparetion
FINISH_ARR2:
	 MOV ES,WORD PTR[BP+14]
	 MOV EAX,DWORD PTR[ES:DI]
	 MOV ES,WORD PTR[BP+20] 
	 MOV DWORD PTR[ES:BX],EAX
	 ADD BX,4
	 ADD DI,4
	 INC size2
	 INC size3
	 MOV AX,size2
	 CMP AX,arr2_size
	 JE done
	 JMP FINISH_ARR2
FINISH_ARR1:
	 MOV ES,WORD PTR[BP+8]
	 MOV EAX,DWORD PTR[ES:SI]
	 MOV ES,WORD PTR[BP+20]	 
	 MOV DWORD PTR[ES:BX],EAX
	 ADD BX,4
	 ADD SI,4
	 INC size1
	 INC size3
	 MOV AX,size1
	 CMP AX,arr1_size
	 JE done
	 JMP FINISH_ARR1	 
done:
	 POP ES
	 POP DI
	 POP SI
	 MOV AX,size3
	 POP BP
     RET	 
_merge  ENDP
     END
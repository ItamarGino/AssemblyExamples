;long int find_closest_pair(long int arr1[], long int arr2[], int n, int *i_index, int *j_index);
;								[BP+4]			[BP+6]		 [BP+8]	   [BP+10]		 [BP+12]
.MODEL SMALL
.386
.DATA
arr_size DW ?
index1   DW ?
index2   DW ?
temp     DD ?
temp2    DD ?
.CODE
PUBLIC _find_closest_pair
_find_closest_pair PROC NEAR

PUSH BP
MOV BP,SP
PUSH SI
PUSH DI

MOV SI,[BP+4]
MOV DI,[BP+6]
MOV AX,[BP+8]
CMP AX,0
JBE done
MOV arr_size,AX

MOV EAX,DWORD PTR[SI]
CMP EAX,DWORD PTR[DI]
JA next0
MOV temp2,EAX
MOV EAX,DWORD PTR[DI]
SUB EAX,temp2
jmp next01
next0:
SUB EAX,DWORD PTR[DI]
next01:
MOV temp,DWORD PTR EAX
MOV AX,0
CWDE
MOV index1,AX
MOV index2,AX
MOV CX,arr_size
FIRST_LOOP:
	MOV arr_size,CX
	MOV DI,[BP+6]
	MOV AX,0
	MOV index2,AX
	MOV CX,[BP+8]
	SECOND_LOOP:
		 MOV EAX,DWORD PTR[SI]
		 CMP EAX,DWORD PTR[DI]
		 JA next11
		 MOV temp2,EAX
		 MOV EAX,DWORD PTR[DI]
		 SUB EAX,temp2
		 JMP next12
		 next11:
		 SUB EAX,DWORD PTR[DI]
		 next12:
		 CMP temp,DWORD PTR EAX
		 JB next2
		 PUSH EAX
		 MOV BX,[BP+10]
		 MOV AX,index1
		 MOV [BX],AX
		 MOV BX,[BP+12]
		 MOV AX,index2
		 MOV [BX],AX
		 POP EAX
		 MOV temp,DWORD PTR EAX
		 next2:
		 INC index2
		 ADD DI,4
		 LOOP SECOND_LOOP
	MOV CX,arr_size
	INC index1
	ADD SI,4
	LOOP FIRST_LOOP
	
done:
MOV EAX,temp
POP DI
POP SI
POP BP
RET
_find_closest_pair ENDP
END
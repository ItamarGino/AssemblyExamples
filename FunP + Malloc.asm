    .MODEL SMALL
    .CODE
;int* compareValues(int(*f)(void *, void *), void ** arr1, void ** arr2, int size);
;                                +4               +6             +8        +10
    .386
	 ReturnAddress DW ?
     ErrorOutput DB 13,10,'Dynamic allocation error !',13,10,'$'
	 EXTRN _malloc : NEAR
     PUBLIC _compareValues
_compareValues  PROC NEAR
	 PUSH BP        ; Preserve BP
	 MOV BP,SP      ; Set BP to point to Parameter area
	 PUSH SI
	 PUSH DI
	 
	 MOV SI,[BP+6] ; **ARR1
	 MOV DI,[BP+8] ; **ARR2
	 
	 PUSH WORD PTR [BP+10]
	 CALL _malloc
	 ADD SP,2
	 MOV ReturnAddress,AX
	 CMP AX,0 ; if(null==0)
	 JE Error_Msg
	 
	 MOV BX,ReturnAddress
	 MOV CX,[BP+10]
BuildResult:
	 PUSH WORD PTR[DI]
	 PUSH WORD PTR[SI]
	 CALL WORD PTR[BP+4]
	 ADD SP,4
	 MOV [BX],AX
	 ADD SI,2
	 ADD DI,2
	 ADD BX,2
	 LOOP BuildResult
	 JMP done	 
	 
Error_Msg:
	 MOV AH,9      
	 MOV DX,OFFSET ErrorOutput
	 INT 21h	 
done:
	 POP DI
	 POP SI
	 MOV AX,ReturnAddress
	 POP BP
     RET	 
_compareValues  ENDP
     END
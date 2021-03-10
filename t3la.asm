.MODEL LARGE
.DATA
;-----------variabels----------------
    help DD 0
    I DD 0       ;------index for modolo_countarr--------------
    J DW 0       ;--------------help us to pass on the arr for each modolo---------------
    n DW 0
.CODE
.386
 
    PUBLIC _mod_count
    _mod_count PROC FAR                      ;because it is modle large
;-------we need to push all the pointers to the stack for not loos their values
    PUSH BP
    MOV BP,SP                                 ;help us for the stack
    PUSH DI
    PUSH SI
	PUSH ES
	PUSH FS
   
    MOV SI,[BP+6]                            ;pointer to arr
	MOV ES,[BP+8]                            ;Save the CS of array 1 in ES register
    MOV AX, [BP+10]                           ;size of arr
    MOV n,AX
    MOV EBX,DWORD PTR [BP+12]                 ;size of denom
    MOV help,EBX
   
;------------fill in the count_arr with zeroes----------------------
    MOV DI,[BP+16]                                 ;pointer to count_arr
	MOV FS,[BP+18]                                 ;Save the CS of array 1 in ES register
    MOV CX,WORD PTR help                        
fillzeros:
    MOV WORD PTR FS:[DI],0
    ADD DI,2
    LOOP fillzeros
    MOV DI,[BP+16]                               ;we initalliazing the pointer for count_arr after we put zeros
   
dividingloop:
    MOV ECX,I
    CMP ECX,help                             ;if ecx is bigger or equal to denom (7) ,so we arrived to the end and it meen that we pass all over the arr
    JAE sof
    MOV J,0                                  ;we need to zero him every time for each modolo from 0 to 6
j_loop:
    MOV CX,n
    CMP J,CX                                ;when j will be equal to the size of arr we will move to the next modolo
    JAE inc_i
   
    PUSH DWORD PTR ES:[SI]                    ;we push a value from arr to stack
    POP EAX                                 ;we get him out from the stack
    MOV EDX,0                               ;we promise that edx is zero
    DIV help                                 ;we div the number from arr in 7
    CMP EDX,I                               ;we check which number from 0 to 6 we have in edx
    JNE nextnum                             
    ADD WORD PTR FS:[DI],1                   ;fill in just when the modolo is equal to i
nextnum:
    INC J
    ADD SI,4
    JMP j_loop
inc_i:
    INC I
    MOV SI,[BP+6]
	MOV ES,[BP+8]
    ADD DI,2
    JMP dividingloop
sof:                           ;end of func
 ;-----------------------we need to free what we push -------------------
    POP DI
    POP SI
	POP FS
	POP ES
    POP BP
    RET
    _mod_count ENDP
	
	PUBLIC _mod_sort
    _mod_sort PROC FAR
;-------we need to push all the pointers to the stack for not loos their values
    PUSH BP
	MOV BP,SP                                ;help us for the stack
	
	PUSH SI
	PUSH DI
	PUSH ES
	PUSH FS
	PUSH GS
	
	MOV FS,[BP+18]	                                ;Save the CS of count_arr  in fS register
	MOV DI,[BP+16]	                                       ;pinter for count_arr 
	MOV ES,[BP+22]                                     ;Save the CS of pos_arr in ES register
	MOV SI,[BP+20]	                                   ;pointer for POS_arr
	MOV [ES:SI],WORD PTR 0
	MOV ECX,[BP+12]                                    ;the size of denom
	MOV help,ECX                                       ;preserv the value of denom
	MOV BX,[BP+10]                                     ;the size off arr
	MOV n,BX
	MOV CX,1
fillpos_arr:
    CMP CX,WORD PTR help                        ;index for know that we got all the modolo from 1 to 6 for pos_arr
    JAE backarr
	MOV AX,ES:[SI]
	ADD SI,2
	ADD AX,[FS:DI]
	MOV ES:[SI],AX                                     ;fill in the pos_arr with pos_arr[i] = pos_arr[i-1] + count_arr[i-1] (from ilya instructations)
	ADD DI,2
	INC CX
	JMP fillpos_arr
backarr:	
	MOV ES,[BP+8]                                      ;Save the CS of arr in ES register
	MOV DI,[BP+6]                                      ;pointer for arr ,so we can fill in the mod_sorted
	MOV CX,0                                     
fillmod_sorted:
    CMP CX,n                                       ;when cx bigger or equal to the size of arr we arrived to the end
    JAE sof1
	MOV FS,[BP+22]                                     ;Save the CS of pos_arr in fS register
	MOV SI,[BP+20]                                     ;pointer to pos_arr
	MOV GS,[BP+26]                                     ;Save the CS of mod_sorted in gS register
	MOV BX,[BP+24]
	MOV EDX,0
	MOV EAX,ES:[DI]                                   ;the number from arr that we want to div
	DIV DWORD PTR [BP+12]                               ;we need to div with denom(7) to get the modolo
	SHL EDX,1                                           ;we mul with 2
	ADD ESI,EDX
	MOV EDX,FS:[SI]
	SHL EDX,2                                           ;we mul with 4
	ADD EBX,EDX
	MOV EAX,ES:[DI]
	MOV GS:[BX],EAX                                    ;we put the value of arr in place i in mod_sorted 
	ADD DI,4
	INC WORD PTR FS:[SI]
	INC CX
	JMP fillmod_sorted
sof1:                                                 ;end of func
;-----------------------we need to free what we push -------------------
	POP DI
	POP SI
	POP ES
	POP GS
	POP FS
	POP BP
	RET
	_mod_sort ENDP
   
END
	

.MODEL SMALL
.DATA
;-----------variabels----------------
    help DD 0
    I DD 0       ;------index for modolo_countarr--------------
    J DW 0       ;--------------help us to pass on the arr for each modolo---------------
    n DW 0
.CODE
.386
 
 PUBLIC _mod_count
 _mod_count PROC NEAR
;-------we need to push all the pointers to the stack for not loos their values
    PUSH BP
    MOV BP,SP                                 ;help us for the stack
    PUSH DI
    PUSH SI
   
    MOV SI,[BP+4]                            ;pointer to arr
    MOV AX, [BP+6]                           ;size of arr
    MOV n,AX
    MOV EBX,DWORD PTR [BP+8]                 ;size of denom
    MOV help,EBX
   
;------------fill in the count_arr with zeroes----------------------
    MOV DI,[BP+12]                                 ;pointer to count_arr
    MOV CX,WORD PTR help                        
fillzeros:
    MOV WORD PTR [DI],0
    ADD DI,2
    LOOP fillzeros
    MOV DI,[BP+12]                               ;we initalliazing the pointer for count_arr after we put zeros
   
dividingloop:
    MOV ECX,I
    CMP ECX,help                             ;if ecx is bigger or equal to denom (7) ,so we arrived to the end and it meen that we pass all over the arr
    JAE sof
    MOV J,0                                  ;we need to zero him every time for each modolo from 0 to 6
j_loop:
    MOV CX,n
    CMP J,CX                                ;when j will be equal to the size of arr we will move to the next modolo
    JAE inc_i
   
    PUSH DWORD PTR [SI]                    ;we push a value from arr to stack
    POP EAX                                 ;we get him out from the stack
    MOV EDX,0                               ;we promise that edx is zero
    DIV help                                 ;we div the number from arr in 7
    CMP EDX,I                               ;we check which number from 0 to 6 we have in edx
    JNE nextnum                             
    ADD WORD PTR [DI],1                   ;fill in just when the modolo is equal to i
nextnum:
    INC J
    ADD SI,4
    JMP j_loop
inc_i:
    INC I
    MOV SI,[BP+4]
    ADD DI,2
    JMP dividingloop
sof:                           ;end of func
 ;-----------------------we need to free what we push -------------------
    POP DI
    POP SI
    POP BP
    RET
    _mod_count ENDP
	
	
	
	PUBLIC _mod_sort
    _mod_sort PROC NEAR
	
;-------we need to push all the pointers to the stack for not loos their values
    PUSH BP
    MOV BP,SP                                 ;help us for the stack
    PUSH DI
    PUSH SI
	
    MOV AX,[BP+6]                                  ;size of arr
    MOV n,AX                                      ;preserve the size
 
    MOV EBX,DWORD PTR [BP+8]                      ;size of denom
    MOV help,EBX                                  ;preserve the size of denom
   
   
    MOV DI, [BP+14]                               ;pointer for pos_arr
    MOV WORD PTR [DI],0
    ADD DI,2
    MOV SI,[BP+12]                                ;pointer for count_arr
    ADD SI,2
       
    MOV CX,1
fillpos_arr:
    CMP CX,WORD PTR help                        ;index for know that we got all the modolo from 1 to 6 for pos_arr
    JAE backarr
    MOV AX,[DI-2]                                 
    ADD AX,[SI-2]
    MOV [DI], AX                                  ;fill in the pos_arr with pos_arr[i] = pos_arr[i-1] + count_arr[i-1] (from ilya instructations)
    INC CX
    ADD DI,2
    ADD SI,2
    JMP fillpos_arr
backarr:
    MOV DI,[BP+4]                                  ;pointer for arr ,so we can fill in the mod_sorted
    MOV CX,0                                       ;zero the index
fillmod_sorted:
    CMP CX,n                                       ;when cx bigger or equal to the size of arr we arrived to the end
    JAE sof1
    MOV EAX,DWORD PTR [DI]                         ;value from arr
    MOV EDX,0                                       
    DIV dword ptr help                                     ;we need to div with denom(7) to get the modolo
    MOV EBX,EDX                                    ;in EDX we have the modolo
    SHL EBX,1                                      ;we mul edx in 2
    MOV SI,[BP+14]                                 ;SI is pointer for pos_arr[]
    ADD SI,BX                   
    MOV BX,[SI]                
    ADD WORD PTR [SI],1         
    MOV SI,[BP+16]                                 ;SI is pointer for mod_sorted[]
    SHL BX,2                                       ;we mul BX with 4
    ADD SI,BX                   
    MOV EAX, DWORD PTR [DI]                        ;DI pointer for arr
    MOV DWORD PTR [SI],EAX                         ;we put the value of arr in place i in mod_sorted 
    ADD DI,4
    INC CX
    JMP fillmod_sorted
sof1:                                             ;end of func
 ;-----------------------we need to free what we push -------------------
    POP SI
    POP DI
    POP BP
    RET
    _mod_sort ENDP
END
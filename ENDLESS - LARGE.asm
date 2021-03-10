; apartl.asm
.Model LARGE
.DATA
arr1 DD ?
pair1 DD ?
n DW ?
i DW ?
j DW ?
ptr DD ?
prevptr DD ?
pptr DD ?
.CODE
.386
;
;void pair_sums(long int arr1[], 
;                [BP+6]
;  int n, long int pair1[],...)
;  [BP+10]  [BP+12]
;
PUBLIC _pair_sums
_pair_sums PROC FAR
    PUSH BP
    MOV BP,SP
    PUSH SI
    PUSH DI
    PUSH ES
    PUSH FS
    PUSH GS
;
    MOV EAX,[BP+6]
    MOV arr1,EAX
    MOV AX,[BP+10]
    MOV n,AX
    MOV EAX,[BP+12]
    MOV pair1,EAX
;
    MOV AX,BP
    ADD AX,12
    MOV WORD PTR pptr,AX
    MOV WORD PTR pptr[2],SS
    MOV EAX,arr1
    MOV prevptr,EAX
While1:
    CMP n,0
    JNG EndWhile1
      MOV SI,WORD PTR pptr
      MOV ES,WORD PTR pptr[2]
      MOV EAX,ES:[SI]
      MOV ptr,EAX
      MOV i,0
For1:
      MOV AX,n
      CMP i,AX
      JNL EndFor1
;
      MOV DI,WORD PTR ptr
      MOV FS,WORD PTR ptr[2]
      MOV SI,WORD PTR prevptr
      MOV GS,WORD PTR prevptr[2]

      MOV EAX,GS:[SI]
      ADD EAX,GS:[SI+4]
      MOV FS:[DI],EAX
      ADD WORD PTR ptr,4
      ADD WORD PTR prevptr,8
;
     ADD i,2
     JMP For1      
EndFor1:
    MOV BX,WORD PTR pptr
    MOV ES,WORD PTR pptr[2]
    MOV EAX,ES:[BX]
    MOV prevptr,EAX
    ADD WORD PTR pptr,4
    SHR n,1    ; n = n /2
    JMP While1
EndWhile1:
;
    POP GS
    POP FS
    POP ES
    POP DI
    POP SI
    POP BP
    RET
_pair_sums ENDP
END
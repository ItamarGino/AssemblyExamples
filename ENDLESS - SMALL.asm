; ENDLESS POINTERS TO ARRAYS. EVERY ARRS ARE : [N\(2K)] {K=1,2..}
.Model SMALL
.DATA
arr1 DW ?
pair1 DW ?
n DW ?
i DW ?
j DW ?
ptr DW ?
prevptr DW ?
pptr DW ?
.CODE
.386
;
;void pair_sums(long int arr1[], 
;                [BP+4]
;  int n, long int pair1[],...)
;  [BP+6]  [BP+8]
;
PUBLIC _pair_sums
_pair_sums PROC NEAR
    PUSH BP
    MOV BP,SP
    PUSH SI
    PUSH DI
;
    MOV AX,[BP+4]
    MOV arr1,AX
    MOV AX,[BP+6]
    MOV n,AX
    MOV AX,[BP+8]
    MOV pair1,AX
;
    MOV AX,BP
    ADD AX,8
    MOV pptr,AX
    MOV AX,arr1
    MOV prevptr,AX
While1:
    CMP n,1
    JNG EndWhile1
      MOV SI,pptr
      MOV AX,[SI]
      MOV ptr,AX
      MOV i,0
For1:
      MOV AX,n
      CMP i,AX
      JNL EndFor1
;
      MOV DI,ptr
      MOV SI,prevptr
      MOV EAX,[SI]
      ADD EAX,[SI+4]
      MOV [DI],EAX
      ADD ptr,4
      ADD prevptr,8
;
     ADD i,2
     JMP For1      
EndFor1:
    MOV BX,pptr
    MOV AX,[BX]
    MOV prevptr,AX
    ADD pptr,2
    SHR n,1    ; n = n /2
    JMP While1
EndWhile1:
;
    POP DI
    POP SI
    POP BP
    RET
_pair_sums ENDP
END
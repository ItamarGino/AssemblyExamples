.MODEL SMALL
.STACK 100h
.DATA
;--------variables----------------
x0 DQ ?
x DQ ?
help DQ ? 

.CODE
.386
.387

_compute_approx PROC NEAR
PUBLIC _compute_approx
PUSH BP
MOV BP,SP

FLD QWORD PTR [BP+16]              ; st(0)=x
FSUB QWORD PTR [BP+8]              ;st(0)=x-x0
FSTP help                          ;help=st(0)  and we did pop

 
PUSH QWORD PTR [BP+8]            ;we need to save the value
CALL [BP+4]                      ;we calling to func f from file c
ADD SP,8                         ;we need to free
FSTP x                          ;x=f(x0)=st(0)

PUSH QWORD PTR [BP+8]           ;we saving the value
CALL [BP+6]                     ;calling to func fd from file c
ADD SP,8                        ;we need to free and the return value in st(0) =fd(x0)

FMUL help                      ; st(0)=(x-x0)*fd(x0)

FLD x                          ;st(0) = f(x0) ,st(1)=(x-x0)*fd(x0)

FADD                          ;st(1)=st(0)+st(1) and we did pop
;-----------------------free the stack----------------
POP BP
RET
_compute_approx ENDP

END
















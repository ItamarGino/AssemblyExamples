;
; alarfb.asm
;
.MODEL SMALL
.DATA
fib0 DD ?
fib1 DD ?
fib2 DD ?
n DD ?
i DW ?
index DW ?
.CODE
.386
;extern unsigned long int 
; find_largest_fibo(unsigned long int n,
;                    [BP+4] 
; unsigned int *index);
;  [BP+8]
;
PUBLIC _find_largest_fibo
_find_largest_fibo PROC NEAR
    PUSH BP
    MOV BP,SP
;
    MOV EAX,[BP+4]
    MOV n,EAX
    MOV AX,[BP+8]
    MOV index,AX
    MOV fib0,1
    MOV fib1,1
    MOV fib2,1
    MOV i,0
    MOV ECX,n
While1:
    CMP ECX,fib2
    JNAE EndWhile1
    INC i
    MOV EAX,fib0
    ADD EAX,fib1
    MOV fib2,EAX
    MOV EAX,fib1
    MOV fib0,EAX
    MOV EAX,fib2
    MOV fib1,EAX
    JMP While1
EndWhile1: 
    MOV AX,i
    MOV BX,index
    MOV [BX],AX
    PUSH fib0
    POP AX
    POP DX 
;
    POP BP
    RET
_find_largest_fibo ENDP
    END
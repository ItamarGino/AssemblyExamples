;
; i64_div.asm
;
.MODEL SMALL
.DATA

.CODE
.386
;
;extern void i64_div(char result[], char x[],
;                     [BP+4]        [BP+6]
; unsigned long int denom, unsigned long int *rem);
;   [BP+8]                  [BP+12]
PUBLIC _i64_div
_i64_div PROC NEAR
  PUSH BP
  MOV BP,SP
  PUSH SI
  PUSH DI
;  
 MOV DI,[BP+4]
 MOV SI,[BP+6]
 MOV EDX,0
 MOV EAX,[SI+4]
 DIV DWORD PTR [BP+8]
 MOV [DI+4],EAX
 MOV EAX,[SI]
 DIV DWORD PTR [BP+8] 
 MOV [DI],EAX 
 MOV DI,[BP+12]
 MOV [DI],EDX
;
;
 POP DI
 POP SI
 POP BP
 RET
_i64_div ENDP
END
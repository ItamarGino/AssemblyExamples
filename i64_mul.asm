;
; i64_mul.asm
;
.MODEL SMALL
.DATA

.CODE
.386
;
;extern void i64_mul(char result[], unsigned long int x, unsigned long int y);
;                     [BP+4]        [BP+6]               [BP+10]
PUBLIC _i64_mul
_i64_mul PROC NEAR
 PUSH BP
 MOV BP,SP
;
 MOV EAX,[BP+6]
 MUL DWORD PTR [BP+10]
 MOV BX,[BP+4]
 MOV [BX],EAX
 MOV [BX+4],EDX
;
 POP BP
 RET
_i64_mul ENDP
END
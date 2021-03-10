;
; i64_add.asm
;
.MODEL SMALL
.DATA

.CODE
.386
;extern void i64_add(char result[], char x[], char y[]);
;                      [BP+4]       [BP+6]     [BP+8]
PUBLIC _i64_add
_i64_add PROC NEAR
  PUSH BP
  MOV BP,SP
  PUSH SI
  PUSH DI
;  
 MOV BX,[BP+6]
 MOV SI,[BP+8]
 MOV DI,[BP+4]
 MOV EAX,[BX]
 ADD EAX,[SI]
 MOV [DI],EAX
 MOV EAX,[BX+4]
 ADC EAX,[SI+4]
 MOV [DI+4],EAX
;
 POP DI
 POP SI
 POP BP
 RET
_i64_add ENDP
END
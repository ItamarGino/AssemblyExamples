    .MODEL SMALL
    .CODE
;extern double expPowM2x(double(*pf)(double c, int n), double x, double  c, double epsilon);
;                               BP+4                      BP+6     BP+14         BP+22 
    .386
	.387
	 element DQ ?
	 Sum     DQ ?
	 Azeret  DQ ?
	 xPow    DQ ?
	 ZEVEL   DQ ?
     PUBLIC _expPowM2x
_expPowM2x  PROC NEAR
	 PUSH BP        ; Preserve BP
	 MOV BP,SP      ; Set BP to point to Parameter area
	 MOV CX,0
	 FLD QWORD PTR [BP+6]
	 FSTP xPow				; for using more than once
	 FLD1					; calling again for the function
	 FST Azeret				; and initialize the values
	 FSTP Sum				;
LOOP_EPSILON:
	 PUSH CX
	 PUSH QWORD PTR [BP+14]
	 CALL [BP+4]
	 ADD SP,10
	 FDIV Azeret
	 FMUL xPow
	 FSTP element
	 TEST CX,1
	 JZ pluse
	 FLD element
	 FCHS               ; change sign
	 FSTP element
	 pluse:
	 FLD Sum
	 FADD element
	 FSTP Sum
	 ; next:
	 FLD xPow
	 FMUL xPow
	 FSTP xPow
	 FLD Azeret
	 FLD1
	 FADD
	 FMUL Azeret
	 FSTP Azeret
	 INC CX
	 FLD QWORD PTR [BP+22]
	 FLD element
	 FABS
	 FCOMP
	 FSTSW AX
	 SAHF
	 FSTP ZEVEL
	 JA LOOP_EPSILON
	 ; done
	 FLD Sum
	 POP BP
     RET	 
_expPowM2x  ENDP
     END
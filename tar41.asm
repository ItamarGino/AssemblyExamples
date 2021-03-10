.MODEL SMALL
.DATA
	X1 DQ 0
	X2 DQ 0
	mid DQ 0
	free DQ 0
	help1 DQ 0
	help DQ 0
.CODE
.386
.387
_approx_range PROC NEAR
PUBLIC _approx_range
EXTRN _compute_approx : NEAR
	;--CODE--;
	PUSH BP
	MOV BP,SP
	;extern double approx_range( double (*f)(double), double (*fd)(double),double x0, double epsilon1, double epsilon2);
								;[BP+4]				[BP+6]					[BP+8]	 	[BP+16]			[BP+24]
	FLD QWORD PTR[BP+8]	    ;ST(0)=X0
	FST X1					;X1 = X0
	FABS 					;|X0|
	FST ST(1)				;ST(1)=ST(0) // ST(1)=|X0|
	FADD					;ST(0)=2*|X0|
	FADD QWORD PTR[BP+8]	;ST(0)+=X0
	FLD1					;ST(1) = ST(0), ST(0) = 1.0
	FADD					;ST(0) = ST(1) + ST(0)
	FST  X2					;X2=x0+2*|x0|+1.0
	FSUB X1					;ST(0)=X2-X1
DO:
	FCOM QWORD PTR [BP+24]	;COM ST(0),EPSILON2
	FSTSW AX 				;MOVE ARITHMETIC FLAG TO AX
	SAHF					;MOV ARITHMETIC FLAG TO FLAG ACCUMULATOR
	JBE sof					;IF ST(0)<EPSILON2 END THE LOOP // IF (X2-X1)<EPSILON2 END
	FSTP free				;ST(0) IS EMPTY 
	FLD X1					;ST(0)=X1
	FADD X2					;ST(0)=X1+X2
	FLD1					
	FLD1
	FADD
	FDIV ST(1),ST			; ST(0) =  2	// ST(1) =(X1+X2)
	FSTP free
	FSTP mid				; MID = (X1 + X2)/ 2
	PUSH mid
	PUSH QWORD PTR [BP + 8]	;SENDING VALUES TO COMPUTE_APPROX
	PUSH WORD PTR [BP + 6]
	PUSH WORD PTR [BP + 4]
	CALL _compute_approx
	ADD SP,20
	FSTP help1				;SAVING PROC RETURN VALUE
	PUSH mid
	CALL [BP + 4]
	ADD SP,8
	FSTP help				;SAVING PROC f RETURN VALUE
	FLD help1				;ST(0) = COMPUTE_APPROX RET VALUE
	FSUB help				;ST(0) COMPUTE_APPROX - F(X0)
	FABS					;ST(0) = |ST(0)|
	FCOM QWORD PTR [BP+16]	;COM ST(0),EPSILON1
	FSTSW AX 				;MOVE ARITHMETIC FLAG TO AX
	SAHF					;MOV ARITHMETIC FLAG TO FLAG ACCUMULATOR
	JBE X1MID
	FSTP free				;X2 = MID
	FLD mid
	FSTP X2
	JMP CONTLOOP
X1MID:
	FSTP free
	FLD mid
	FSTP X1
CONTLOOP:					;ST(0) = X2 - X1
	FLD X2
	FSUB X1
	JMP DO
sof:
	FSTP free				;CLEANING SHIT
	FSTP free
	FSTP free
	FSTP free
	FSTP free
	FSTP free
    FSTP free
	FLD X1					;ST(0) = X1
	POP BP
	RET 
	_approx_range ENDP
	END 
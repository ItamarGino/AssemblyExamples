    .MODEL SMALL
    .CODE
;extern void leastSquares(double x[],double y[] ,int n ,double *a ,double *b);
;                              +4        +6       +8        +10      +12
    .386
	 xSum        DQ 0.0
	 ySum        DQ 0.0
	 xPow2Sum    DQ 0.0
	 xySum       DQ 0.0
	 denominator DQ 0.0
	 TEMP1       DQ 0.0
	 TEMP2       DQ 0.0
     PUBLIC _leastSquares
_leastSquares  PROC NEAR
	 PUSH BP        ; Preserve BP
	 MOV BP,SP      ; Set BP to point to Parameter area
	 PUSH SI
	 PUSH DI
	 
	 MOV SI,[BP+4] ; X[]
	 MOV DI,[BP+6] ; Y[]
	 MOV CX,[BP+8]
	 
MakeAPoint:
	 ; xSum += x[i];
	 FLD QWORD PTR [SI] ; ST = X[I]
	 FLD xSum ; ST = xSum , ST(1) = X[I]
	 FADD
	 FSTP xSum
	 ; ySum += y[i];
	 FLD QWORD PTR [DI]
	 FLD ySum
	 FADD
	 FSTP ySum	 
	 ; xySum += (x[i] * y[i]);
	 FLD QWORD PTR [SI]
	 FLD QWORD PTR [DI]
	 FMUL
	 FLD xySum
	 FADD
	 FSTP xySum
	 ; xPow2Sum += (x[i] * x[i]);
	 FLD QWORD PTR [SI]
	 FLD QWORD PTR [SI]
	 FMUL
	 FLD xPow2Sum
	 FADD
	 FSTP xPow2Sum
	 
	 ADD SI,8
	 ADD DI,8
	 LOOP MakeAPoint
	 ; denominator = n*xPow2Sum - (xSum*xSum);
	 FLD xPow2Sum
	 FIMUL WORD PTR [BP+8]
	 FSTP denominator
	 FLD xSum
	 FLD xSum
	 FMUL
	 FSTP TEMP1
	 FLD denominator
	 FSUB TEMP1
	 FSTP denominator
	 ; *b = (ySum*xPow2Sum - xSum*xySum) / denominator;
	 FLD ySum
	 FLD xPow2Sum
	 FMUL
	 FSTP TEMP2
	 FLD xSum
	 FLD xySum
	 FMUL
	 FSTP TEMP1
	 FLD TEMP2
	 FSUB TEMP1
	 FDIV denominator
	 MOV SI,[BP+12]
	 FSTP QWORD PTR [SI]
	 ; *a = (n*xySum- xSum*ySum) / denominator;
	 FLD xySum
	 FIMUL WORD PTR [BP+8]
	 FSTP TEMP1
	 FLD xSum
	 FLD ySum
	 FMUL
	 FSTP TEMP2
	 FLD TEMP1
	 FSUB TEMP2
	 FDIV denominator
	 MOV DI,[BP+10]
	 FSTP QWORD PTR [DI]
	 ; done
	 POP DI
	 POP SI
	 POP BP
     RET	 
_leastSquares  ENDP
     END
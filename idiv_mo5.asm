;  idiv_mo5.asm - Assembler implementation of 
;                         C-callable function idiv_mod.
;
    .MODEL SMALL
    .CODE
    ; Implementation of C callable function ...
    ;    ...  int idiv_mod(int Num, int Denom,  int *Q,  int *Rem)
    ;                      [BP+4]    [BP+6]     [BP+8]    [BP+10]
    ;  Compute Q := |_ Num / Denom _|  ,Rem := MOD(Num, Denom)
    ;  function  idiv_mod  returns 0 if Denom = 0 (illegal ..
    ;  ... division by zero), 1 otherwise
    ;
     PUBLIC _idiv_mod
_idiv_mod  PROC NEAR
     PUSH BP        ; Preserve BP
     MOV BP,SP      ; Set BP to point to Parameter area
     PUSH SI        ; Preserve register variables
     PUSH DI        ;
;
     MOV SI,[BP+6]  ; SI := Denom
     CMP SI,0     ; Denom = 0 ?
     JNE Cont       ; No, continue regular operation
	   ; Yes, Denom = 0
	 MOV AX,0    ; Return value := 0
	 JMP Done            ; Skip following code
Cont:      ; Denom <> 0
     MOV AX,[BP+4]       ; AX := Num
     CWD                 ; DX:AX := AX 
     IDIV SI             ; AX := DX:AX / SI,  DX := MOD(AX,SI)
     MOV  DI,[BP+8]      ; DI := Offset Q
     MOV  [DI],AX        ; *Q := AX
     MOV  DI,[BP+10]     ; DI := Offset Rem
     MOV  [DI],DX        ; *Rem := DX
     MOV  AX,1   ; Ensure return value := 1
Done:
;
     POP DI    ; Restore register variables
     POP SI    ;
     POP  BP             ; Restore BP register
     RET
_idiv_mod  ENDP
     END





